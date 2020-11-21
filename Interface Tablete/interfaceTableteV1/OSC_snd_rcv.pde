/*
 *
 * oscP5message by andreas schlegel
 * example shows how to create osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */


/*
//init code
 
 import oscP5.*;
 import netP5.*;
 
 OscP5 oscP5;
 NetAddress RemoteIP;
 
 void setup() {
 //portReceive
 oscP5 = new OscP5(this,12000);
 
 //portIpSend
 RemoteIP = new NetAddress("127.0.0.1",9999);
 }
 */
//==============================================
/*
void mousePressed() {
 //tag
 OscMessage msg = new OscMessage("/test");
 
 //message
 msg.add(123);
 
 //block send OSC
 oscP5.send(msg, RemoteIP); 
 
 //Debug
 //println("Send msg");
 }
 */
//==============================================

void oscEvent(OscMessage theOscMessage) {

  commandWalk = ""; 
  //Verify tag
  if (theOscMessage.checkAddrPattern("/status")==true) {

    //Verify type message
    if (theOscMessage.checkTypetag("s")) {

      //Select value
      commandWalk = theOscMessage.get(0).stringValue();
      debugger("Receive: " + theOscMessage.toString() + " " + commandWalk);
      return;
    }
  }

debugger("Receive: " + theOscMessage.toString() + " " + commandWalk);
}
