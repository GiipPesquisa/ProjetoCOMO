/**
 * oscP5message by andreas schlegel
 * example shows how to create osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress RemoteIP;

Btn BtnEye;

//Setting
int value = 0;
int mX;
int mY;
int bottonPosREX;
int bottonPosREY;
int bottonSizeREX;
int bottonSizeREY;

void settings() {
  //Canvas Size
  size(800, 600);
  BtnEye = new Btn(color(255,0,0),50,50); 
  //===============================================
}

void setup() {
  //Color Bg
  background(0);

  //ModeCalc
  rectMode(RADIUS);

  //BoxPosSize
  bottonPosREX = 400;
  bottonPosREY = 300;
  bottonSizeREX = 50;
  bottonSizeREY = 50;
}

void draw() {
  background(0);
  BtnEye.display();
  BtnEye.move();
  //===============================================

  //seg rectEye
  mX = mouseX;
  mY = mouseY;
  //===============================================

  //collision
  if (mX > bottonPosREX-bottonSizeREX && mX < bottonPosREX+bottonSizeREX
    && 
    mY > bottonPosREY-bottonSizeREY && mY < bottonPosREY+bottonSizeREY)
  {
    fill(255);
  } else {
    fill(0);
  }
  //==============================================

  //rectBotton
  rect(bottonPosREX, bottonPosREY, bottonSizeREX, bottonSizeREY);
  //==============================================

  //rectEye
  fill(127);
  //rect(mX, mY, 50, 50);
  //==============================================

  //void mouseMoved() {
  //  value = value + 5;
  //  if (value > 255) {
  //    value = 0;
  //  }
  //}
  //==============================================

  //Debug
  //println(mX, ">>>>", bottonPosREX-bottonSizeREX);
}
