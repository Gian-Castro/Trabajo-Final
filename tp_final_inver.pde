void setup(){
  size(500, 360);
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
  
  
}
