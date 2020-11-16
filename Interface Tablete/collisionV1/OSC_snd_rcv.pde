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
*/

//==============================================

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
//==============================================

void oscEvent(OscMessage theOscMessage) {
  //Verify tag
  if (theOscMessage.checkAddrPattern("/bang")==true) {
    
    //Verify type message
    if (theOscMessage.checkTypetag("s")) {
      
      //Select value
      String firstValue = theOscMessage.get(0).stringValue();
      
      //Value
      println(" values: "+firstValue);
      
      //Debug
      //println("fim");
      return;
    }
  }
}
