/*
 Projeto COMO - https://sites.google.com/view/projetocomo/
 16/11/2020 - Rodrigo Rezende -> initial commit
 18/11/2020 - Mau Jabur -> code cleanup, debug & review
 */
//library
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress RemoteIP;

Btn BtnEye;
Btn BtnLeft;
Btn BtnRight;

static String commandWalk = "Stop";
static int vel;

int to_debug = 1;
int mode = 1;

ArrayList<String> log = new ArrayList<String>();
int max_log = 25;

void settings() {
  //canvasSize
  fullScreen();//Operation
  //size(800, 600);//Debug
}

void setup() {
  //portReceive
  oscP5 = new OscP5(this, 12000);

  //portIpSend
  RemoteIP = new NetAddress("192.168.86.255", 9999);
  //===============================================

  //modeCalc
  rectMode(RADIUS);

  //object
  BtnLeft =  new Btn(color(0, 0, 255), ((int(width/12))*1), ((int(height/2))*1), (int(width/12)), height, 0);
  BtnRight = new Btn(color(0, 0, 255), ((int(width/12))*11), ((int(height/2))*1), (int(width/12)), height, 0);
  BtnEye =   new Btn(color(255, 0, 0), ((int(width/2)) *1), ((int(height/2))*1), (int(width/12)), height, 3);
  //===============================================
}

void draw() {
  //colorBg
  background(0);
  //===============================================

  //moveObjetc
  BtnEye.move(mode, commandWalk);
  //===============================================

  //collision
  BtnLeft.collision (BtnEye.xPos, BtnEye.yPos, BtnEye.xSize, BtnEye.ySize);
  BtnRight.collision(BtnEye.xPos, BtnEye.yPos, BtnEye.xSize, BtnEye.ySize);
  //==============================================


  if (BtnLeft.change >0 ) {
    osc_message("collision", str(-BtnLeft.state));
  }
  if (BtnRight.change >0 ) {
    ////objetcOsc
    osc_message("collision", str(BtnRight.state));
  }


  if (millis() -max(BtnLeft.change_time, BtnRight.change_time)< 200) {
    background(150);
  }

  // check change and state put messages here
  // separate button from send message


  //viewObject
  BtnLeft.display();
  BtnRight.display();
  BtnEye.display();
  //==============================================

  //Debug
  if (to_debug ==1) {
    fill(0, 255, 100);
    textSize(20);
    for (int i = 0; i< log.size(); i++) {
      text (log.get(i), width/6+20, i*25+25);
    }
  }
}

void osc_message(String tagOsc, String msgOsc) {
  OscMessage msg = new OscMessage("/"+tagOsc);

  //message
  msg.add(msgOsc);

  //block send OSC
  oscP5.send(msg, RemoteIP);

  //Debug
  debugger("Send msg: "+"/"+tagOsc+"/"+msgOsc);
}

void debugger(String msg) {
  if (log.size() >= max_log) {
    log.remove(0);
  }
  log.add(millis()+": "+ msg);
  println(msg);
}


void keyPressed() {
  switch (key) {
  case '0':
    mode = 0;
    debugger( "mode: "+mode);
    break;
  case '1': 
    mode = 1;
    debugger( "mode: "+mode);
    break;
  case 'd': 
  case 'D': 
    to_debug = 1 - to_debug;
    break;
  }
}
