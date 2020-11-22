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

count = 0

#osc client setup
#if __name__ == "__main__":

client = udp_client.SimpleUDPClient("192.168.86.255", 12000, True)
 
#finish osc setup
while True:
    webcam.set(3, 480)
    webcam.set(4, 320)

    # We get a new frame from the webcam
    ret, frame = webcam.read()
    frame = cv2.rotate(frame, cv2.ROTATE_90_COUNTERCLOCKWISE)
    
    
    #cv2.imshow("live", frame)


    # We send this frame to GazeTracking to analyze it
    gaze.refresh(frame)
    
    count = count+1
    print(count)

    frame = gaze.annotated_frame()
    text = ""

#     if gaze.is_blinking():
#         text = "blink"
#     elif gaze.is_right():
    if gaze.is_right():
        text = "right"
    elif gaze.is_left():
        text = "left"
    elif gaze.is_center():
        text = "center"

    cv2.putText(frame, text, (10, 60), cv2.FONT_HERSHEY_DUPLEX, 1.6, (80, 255, 80), 2)
    cv2.putText(frame, "ratio: " + str(gaze.horizontal_ratio()), (10, 95), cv2.FONT_HERSHEY_DUPLEX, 0.9, (80, 255, 80), 1)
    cv2.putText(frame, "count: " + '%.2f' %(count), (10, 115), cv2.FONT_HERSHEY_DUPLEX, 0.9, (80, 255, 80), 1)

# 
    left_pupil = gaze.pupil_left_coords()
    right_pupil = gaze.pupil_right_coords()
    print (str(left_pupil) + " " + str(right_pupil))
    
    
#     cv2.putText(frame, "Left pupil:  " + str(left_pupil), (90, 130), cv2.FONT_HERSHEY_DUPLEX, 0.9, (147, 58, 31), 1)
#     cv2.putText(frame, "Right pupil: " + str(right_pupil), (90, 165), cv2.FONT_HERSHEY_DUPLEX, 0.9, (147, 58, 31), 1)


    cv2.imshow("Projeto COMO", frame)



    client.send_message("/status", text)#osc
#     client.send_message("/lp", str(left_pupil))#osc
#     client.send_message("/rp", str(right_pupil))#osc

    # tecla ESC
    if cv2.waitKey(1) == 27:
        break
    
    #time.sleep(1)

