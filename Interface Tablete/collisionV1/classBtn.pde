/*
Car myCar1;

void setup() {
  size(200, 200);
  // Parameters go inside the parentheses when the object is constructed.
  myCar1 = new Car(color(255, 0, 0), 0, 100, 2); 
  myCar2 = new Car(color(0, 0, 255), 0, 10, 1);
}

void draw() {
  background(255);
  myCar1.drive();
  myCar1.display();
}
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

  void display() {
    stroke(0);
    fill(clor);
    rectMode(CENTER);
    rect(xPos, yPos, 20, 20);
  }

  void move() {
    xPos=mouseX;
    yPos=mouseY;
  }
}
