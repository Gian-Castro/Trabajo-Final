import processing.serial.*;
Serial myport;

float t=0;
float h=0;
float tmax=100;
float hmax=100;

void setup(){
  size(500, 360);
  
  printArray(Serial.list());
  String portName = Serial.list()[0];
  myport = new Serial(this, "COM1", 9600);
}

void draw(){
  background(153, 206, 94);
  fill(81, 133, 219);
  rect(80, 60, 100, 25);
  fill(37, 57, 239);
  textSize(18);
  text("Temp actual", 80, 50);
  fill(0, 0, 0);
  text("00.0 ºC", 105, 79);
  
  fill(244, 121, 134);
  rect(240, 60, 100, 25);
  fill(237, 39, 60);
  textSize(18);
  text("Temp límite", 240, 50);
  fill(0, 0, 0);
  text("00.0 ºC", 265, 79);
  
  
  fill(81, 133, 219);
  rect(80, 180, 100, 25);
  fill(37, 57, 239);
  textSize(18);
  text("Hum actual", 80, 170);
  fill(0, 0, 0);
  text("00.0 ºC", 105, 199);
  
  fill(244, 121, 134);
  rect(240, 180, 100, 25);
  fill(237, 39, 60);
  textSize(18);
  text("Hum límite", 240, 170);
  fill(0, 0, 0);
  text("00.0 ºC", 265, 199);
  
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
