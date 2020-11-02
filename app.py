#GAZETRACKING DEP
import cv2
from gaze_tracking import GazeTracking

#OSC DEP
import argparse
import random
import time
from pythonosc import udp_client


gaze = GazeTracking()
webcam = cv2.VideoCapture(0)
#osc client setup
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--ip", default="192.168.0.4",
        help="The ip of the OSC server")
    parser.add_argument("--port", type=int, default=5005,
        help="The port the OSC server is listening on")
    args = parser.parse_args()

    client = udp_client.SimpleUDPClient(args.ip, args.port)
#finish osc setup
while True:
    # We get a new frame from the webcam
    _, frame = webcam.read()

    # We send this frame to GazeTracking to analyze it
    gaze.refresh(frame)

    frame = gaze.annotated_frame()
    text = ""

    if gaze.is_blinking():
        text = "blink"
    elif gaze.is_right():
        text = "right"
    elif gaze.is_left():
        text = "left"
    elif gaze.is_center():
        text = "center"

    client.send_message("/status", text)#osc
    
    cv2.putText(frame, text, (90, 60), cv2.FONT_HERSHEY_DUPLEX, 1.6, (147, 58, 31), 2)

    left_pupil = gaze.pupil_left_coords()
    right_pupil = gaze.pupil_right_coords()
    
    client.send_message("/lp", str(left_pupil))#osc
    client.send_message("/rp", str(right_pupil))#osc
    
    cv2.putText(frame, "Left pupil:  " + str(left_pupil), (90, 130), cv2.FONT_HERSHEY_DUPLEX, 0.9, (147, 58, 31), 1)
    cv2.putText(frame, "Right pupil: " + str(right_pupil), (90, 165), cv2.FONT_HERSHEY_DUPLEX, 0.9, (147, 58, 31), 1)

    cv2.imshow("Projeto COMO", frame)

    if cv2.waitKey(1) == 27:
        break
