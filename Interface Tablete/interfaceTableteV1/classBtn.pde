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
  int vel;
  
  int state;
  int change;
  long change_time;

  // The Constructor is defined with arguments.
  Btn(color tempC, int tempxPos, int tempyPos, int tempxSize, int tempySize, int temp_vel) { 
    clor = tempC;
    xPos = tempxPos;
    yPos = tempyPos;
    xSize = tempxSize;
    ySize = tempySize;
    vel = temp_vel;
    state = 0;
    change = 0;
  }

  void move(int mode, String _commandWalk) {
    switch(mode) {
    case 0://Debug 
      xPos=mouseX;
      yPos=mouseY;
      break;
    case 1://Operation 
      switch(_commandWalk) {
      case "STOP":
        xPos = xPos+0;
        break;
      case "LEFT": 
        xPos = xPos - (1*vel);
        break;
      case "RIGHT": 
        xPos = xPos + (1*vel);
        break;
      case "Stop": 
        xPos = xPos + 0;
        break;
      }
    }
    
    xPos = constrain(xPos, 0 + (xSize/2), width - (xSize/2));

    //Debug
    //println(_commandWalk);
  }

  int collision(int objColdPX, int objColdPY, int objColdSX, int objColdSY/*, String tagOsc, String msgOsc/**/) {
    change = 0;
    //testCollision
    if (
      (objColdPX+objColdSX) > (xPos-xSize) && 
      (objColdPX-objColdSX) < (xPos+xSize)
      && 
      (objColdPY+objColdSY) > (yPos-ySize) && 
      (objColdPY-objColdSY) < (yPos+ySize) 
      ) {
      if (state == 0) {
        state = 1;
        change = 1;
        change_time = millis();

      } // state= 0
    } // collison check positive
    else {
      if (state ==1) {
        change = 1;
        change_time = millis();
      }
      state = 0;
    } // collison check negative

    return state;
  }

  void display() {
    stroke(0);
    fill(clor, 255-127*state);
    rect(xPos, yPos, xSize, ySize);
  }
}
