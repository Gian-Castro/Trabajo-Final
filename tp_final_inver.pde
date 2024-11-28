import processing.serial.*;
Serial myport;

float t=000.0;
float h=000.0;
float tmax=100;
float hmax=100;


String dat[];
String tlp;
String hlp;


void setup(){
  size(500, 360);
  
  printArray(Serial.list());
  String portName = Serial.list()[0];
  myport = new Serial(this, portName, 9600);
  tlp = "";
  hlp = "";
}

void draw(){
  background(153, 206, 94);
  fill(81, 133, 219);
  rect(80, 60, 100, 25);
  fill(37, 57, 239);
  textSize(18);
  text("Temp actual", 80, 50);
  fill(0, 0, 0);
  String ta = nf(t, 0, 2);
  text(ta, 105, 79);
  text("ºC", 150, 79);
  
  fill(244, 121, 134);
  rect(240, 60, 100, 25);
  fill(237, 39, 60);
  textSize(18);
  text("Temp límite", 240, 50);
  fill(0, 0, 0);
  String tl = nf(tmax, 0, 2);
  text(tl, 260, 79);
  text("ºC", 315, 79);
  
  
  fill(81, 133, 219);
  rect(80, 180, 100, 25);
  fill(37, 57, 239);
  textSize(18);
  text("Hum actual", 80, 170);
  fill(0, 0, 0);
  String ha = nf(h, 0, 2);
  text(ha, 105, 199);
  text("%", 150, 199);
  
  fill(244, 121, 134);
  rect(240, 180, 100, 25);
  fill(237, 39, 60);
  textSize(18);
  text("Hum límite", 240, 170);
  fill(0, 0, 0);
  String hl = nf(hmax, 0, 2);
  text(hl, 260, 199);
  text("%",315, 199);
  
  myport.write(tl);
  myport.write(hl);
  
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
      println(key);
    }
    else{
      if(key == 10){
        tlp = "";
        println("Enter");
        return;
      }
    }
    println(tlp);
    tmax = Float.parseFloat(tlp);
  }
  
  if((mouseX>=240 && mouseX<=340) && (mouseY>=180 && mouseY<=205)) {
    // The variable "key" always contains the value 
    // of the most recent key pressed.
    if ((key >= '0' && key <= '9') || key == 46) {
      hlp = hlp + key;
      println(key);
    }
    else{
      if(key == 10){
        hlp = "";
        println("Enter");
        return;
      }
    }
    println(hlp);
    hmax = Float.parseFloat(hlp);
  }
}
