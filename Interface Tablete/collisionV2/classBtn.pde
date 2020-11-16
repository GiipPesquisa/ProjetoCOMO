/*
https://processing.org/tutorials/objects/
 */

// Even though there are multiple objects, we still only need one class. 
// No matter how many cookies we make, only one cookie cutter is needed.
class Btn { 
  color clor;
  int xPos;
  int yPos;
  int xSize;
  int ySize;

  // The Constructor is defined with arguments.
  Btn(color tempC, int tempxPos, int tempyPos, int tempxSize, int tempySize) { 
    clor = tempC;
    xPos = tempxPos;
    yPos = tempyPos;
    xSize = tempxSize;
    ySize = tempySize;
  }

  void move() {
    xPos=mouseX;
    yPos=mouseY;
  }

  void collision(int objColdPX, int objColdPY, int objColdSX, int objColdSY, String tagOsc, String msgOsc) {
    //testCollision
    if ((objColdPX+objColdSX) > (xPos-xSize) && 
      (objColdPX-objColdSX) < (xPos+xSize)
      && 
      (objColdPY+objColdSY) > (yPos-ySize) && 
      (objColdPY-objColdSY) < (yPos+ySize)) {

      //objetcOsc
      OscMessage msg = new OscMessage("/"+tagOsc);

      //message
      msg.add(msgOsc);

      //block send OSC
      oscP5.send(msg, RemoteIP);

      //Debug
      //println("Send msg");
    }
  }

  void display() {
    stroke(0);
    fill(clor);
    rect(xPos, yPos, xSize, ySize);
  }
}
