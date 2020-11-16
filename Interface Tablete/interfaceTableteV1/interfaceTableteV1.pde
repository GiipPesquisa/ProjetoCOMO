/*
Projeto COMO - https://sites.google.com/view/projetocomo/
16/11/2020 - Rodrigo Rezende
*/
//library
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress RemoteIP;

Btn BtnEye;
Btn BtnLeft;
Btn BtnRight;

void settings() {
  //canvasSize
  size(800, 600);

  //object
  BtnEye = new Btn(color(255, 0, 0), ((width/2)*1),((height/2)*1), 50, 50);
  BtnLeft = new Btn(color(0, 0, 255), ((width/3)*1), ((height/2)*1), 50, 50);
  BtnRight = new Btn(color(0, 0, 255), ((width/3)*2),((height/2)*1), 50, 50);
  //===============================================
}

void setup() {
  //modeCalc
  rectMode(RADIUS);
  
  //portReceive
  oscP5 = new OscP5(this,12000);
  
  //portIpSend
  RemoteIP = new NetAddress("127.0.0.1",9999);
}

void draw() {
  //colorBg
  background(0);
  //===============================================

  //moveObjetc
  BtnEye.move();
  //===============================================

  //collision
    BtnLeft.collision(BtnEye.xPos, BtnEye.yPos, BtnEye.xSize, BtnEye.ySize, "collision", "-1");
    BtnRight.collision(BtnEye.xPos, BtnEye.yPos, BtnEye.xSize, BtnEye.ySize, "collision", "1");
  
  //==============================================

  //viewObject
  BtnEye.display();
  BtnLeft.display();
  BtnRight.display();
  
  //==============================================

  //Debug
  //println();
}
