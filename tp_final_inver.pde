import processing.serial.*;
Serial myport;

float t=000;
float h=000;
float tmax=100;
float hmax=100;


String tout;
String hout;
String tlp;
String hlp;

String ta;
String tl;
String ha;
String hl;


void setup(){
  size(500, 360);
  
  printArray(Serial.list());
  String portName = Serial.list()[1];
  myport = new Serial(this, portName, 9600);
  tlp = "";
  hlp = "";
  ta= "";
  ha= "";
}

void draw(){
  background(153, 206, 94);
  fill(81, 133, 219);
  rect(80, 60, 100, 25);
  fill(37, 57, 239);
  textSize(18);
  text("Temp actual", 80, 50);
  fill(0, 0, 0);
  text(ta, 105, 79);
  text("ºC", 150, 79);
  
  fill(244, 121, 134);
  rect(240, 60, 100, 25);
  fill(237, 39, 60);
  textSize(18);
  text("Temp límite", 240, 50);
  fill(0, 0, 0);
  tl = nf(tmax, 0, 2);
  text(tl, 260, 79);
  text("ºC", 315, 79);
  
  
  fill(81, 133, 219);
  rect(80, 180, 100, 25);
  fill(37, 57, 239);
  textSize(18);
  text("Hum actual", 80, 170);
  fill(0, 0, 0);
  text(ha, 105, 199);
  text("%", 150, 199);
  
  fill(244, 121, 134);
  rect(240, 180, 100, 25);
  fill(237, 39, 60);
  textSize(18);
  text("Hum límite", 240, 170);
  fill(0, 0, 0);
  hl = nf(hmax, 0, 2);
  text(hl, 260, 199);
  text("%",315, 199);
  
  tout = "t" + tmax + "E";
  println (tout);
  hout = "h" + hmax + "E";
  
  
  myport.write(tout);
  myport.write(hout);
  
  while (myport.available()>0){
    String buffer = myport.readStringUntil(10); //caracter ascii del enter
    //print(buffer);
    if(buffer.startsWith("t")){
      ta = buffer.substring(4);
    }
    if(buffer.startsWith("h")){
      ha = buffer.substring(4);
    }
  }
  
  if(t>=tmax){
    fill(247, 247, 0);
    triangle(350, 85, 374, 85, 362, 60);
    fill(0, 0, 0);
    textSize(16);
    text("!", 361, 82);
  }
  
  if(h>=hmax){
    fill(247, 247, 0);
    triangle(350, 205, 374, 205, 362, 180);
    fill(0, 0, 0);
    textSize(16);
    text("!", 361, 202);
  }
  

}

void keyPressed(){
  if((mouseX>=240 && mouseX<=340) && (mouseY>=60 && mouseY<=85)) {
    // The variable "key" always contains the value 
    // of the most recent key pressed.
    if ((key >= '0' && key <= '9') || key == 46) {
      tlp = tlp + key;
      //println(key);
    }
    else{
      if(key == 10){
        tlp = "";
        println("Enter");
        return;
      }
      //if(key == 8){}
    }
    //println(tlp);
    tmax = Float.parseFloat(tlp);
  }
  
  if((mouseX>=240 && mouseX<=340) && (mouseY>=180 && mouseY<=205)) {
    // The variable "key" always contains the value 
    // of the most recent key pressed.
    if ((key >= '0' && key <= '9') || key == 46) {
      hlp = hlp + key;
      //println(key);
    }
    else{
      if(key == 10){
        hlp = "";
        println("Enter");
        return;
      }
      //if(key == 8){}
    }
    //println(hlp);
    hmax = Float.parseFloat(hlp);
  }
}
