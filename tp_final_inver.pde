import processing.serial.*;
import java.io.FileWriter;             //libreria para escritura de archivo
import java.io.BufferedWriter;         //    "      "      "      "    "
Serial myport;

FileWriter fw;
BufferedWriter bw;

                          //variables temperatura y humedad de muestreo
String tlp;
String hlp;
float tmax=100;
float hmax=100;

                       //variables que reciben datos y guardan para distintos fines
float t=000;              
float h=000;
String tout;
String hout;
String ta;
String tl;
String ha;
String hl;

String time;     //cadena para tomar el tiempo

class TIEMPO{          //clase dedicada a guardar fecha y hora actual en el string que se le asigne
  private
    int d=0;
    int m=0;
    int a=0;
    int ho=0;
    int mi=0;
    int se=0;
    
    String t;
  
  public
    String actual(){
      d=day();
      m=month();
      a=year();
      ho=hour();
      mi=minute();
      se=second();
      
      t= String.valueOf(d) + "/" + String.valueOf(m) + "/" + String.valueOf(a) + " " + String.valueOf(ho) + ":" + String.valueOf(mi) + ":" + String.valueOf(se);
      //println(t);
      return t;
    }
};

TIEMPO tiempo1;
                                        //booleanos para la activacion/desactivacion de alarma
boolean alartempmode=false;        
boolean alarhummode=false;
                                     //tablas y strings para el guardado de datos
Table tabla;
Table tabalar;
String ds;
String dsa;


void setup(){
  size(500, 360);
                                                   //listado de puertos series y declaracion de cual usar
  printArray(Serial.list());
  String portName = Serial.list()[0];
  myport = new Serial(this, portName, 9600);
                      //inicializacion de strings
  tlp = "";
  hlp = "";
  ta= "";
  ha= "";
                                         //declaracion de nuevas tablas y seteo de columnas
  tabla = new Table();
  
  tabla.addColumn("Fecha y hora");
  tabla.addColumn("Temp");
  tabla.addColumn("Humedad");
  
  tabalar = new Table();
  
  tabalar.addColumn("Fecha y hora");
  tabalar.addColumn("Temp");
  tabalar.addColumn("Humedad");
  
  tiempo1 = new TIEMPO();
}

void draw(){
  background(153, 206, 94);
  
  fill(180, 178, 178);
  rect(40, 300, 90, 25);
  fill(0, 0, 0);
  textSize(14);
  text("Guardar logs", 47, 317);
  
  fill(180, 178, 178);
  rect(150, 300, 110, 25);
  fill(0, 0, 0);
  textSize(14);
  text("Guardar alarmas", 157, 317);
  
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
                               //salida de temperatura/humedad maxima, armadas segun protocolo
  tout = "t" + tmax + "E";
  //println (tout);
  hout = "h" + hmax + "E";
  
  
  myport.write(tout);
  myport.write(hout);
  
 time = tiempo1.actual();
 //println(time);
                                //lectura de puerto serie y guardado en variables
  delay(2000);
  while (myport.available()>0){
    String buffer = myport.readStringUntil(10); //caracter ascii del enter
    //print(buffer);
    
    if(buffer.startsWith("t")){
      ta = buffer.substring(4);
       t = Float.parseFloat(ta);
    }
    if(buffer.startsWith("h")){
      ha = buffer.substring(4);
      h = Float.parseFloat(ha);
    }
    
  }
  String taa = str(t);
  String haa = str(h);
                                                //guarado de datos recibidos en tabla
  TableRow newRow = tabla.addRow();
  newRow.setString("Fecha y hora", time);
  newRow.setString("Temp", taa);
  newRow.setString("Humedad", haa);
  
                                                 //comprobacion de modo alarma y muestreo de alerta
  if(t>=tmax){
    fill(247, 247, 0);
    triangle(350, 85, 374, 85, 362, 60);
    fill(0, 0, 0);
    textSize(16);
    text("!", 361, 82);
    alartempmode=true;
  }
  else{
  alartempmode=false;
  }
  
  if(h>=hmax){
    fill(247, 247, 0);
    triangle(350, 205, 374, 205, 362, 180);
    fill(0, 0, 0);
    textSize(16);
    text("!", 361, 202);
    alarhummode=true;
  }
  else{
  alarhummode=false;
  }
                                                         //guarado de momentos de alarma en tabla
  if(alartempmode==true || alarhummode==true){
    TableRow newRowalar = tabalar.addRow();
    newRowalar.setString("Fecha y hora", time);
    newRowalar.setString("Temp", taa);
    newRowalar.setString("Humedad", haa);
  }
}
                                    //funcion que lee el teclado para el guadado de variables y datos en archivos
void keyPressed(){
  if((mouseX>=240 && mouseX<=340) && (mouseY>=60 && mouseY<=85)) {
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
    }
    //println(tlp);
    tmax = Float.parseFloat(tlp);
  }
  
  if((mouseX>=240 && mouseX<=340) && (mouseY>=180 && mouseY<=205)) {
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
    }
    //println(hlp);
    hmax = Float.parseFloat(hlp);
  }
  
  if((mouseX>=40 && mouseX<=130) && (mouseY>=300 && mouseY<=325)) {
    if(key == 10){
      //println("EnterSave");
      try{
        File file =new File("D:/Documentos/tpfinalfiles/logs_historico.csv");

        if(!file.exists()){
          file.createNewFile();
          
        }

        FileWriter fw = new FileWriter(file,true);///true = append
        BufferedWriter bw = new BufferedWriter(fw);
        PrintWriter pw = new PrintWriter(bw);
        
        for(int x=0; x<tabla.getRowCount(); x++){
          TableRow row = tabla.getRow(x);
          ds = row.getString("Fecha y hora") + "," +row.getString("Temp") + "," + row.getString("Humedad") + "\n";
          pw.write(ds, 0, ds.length());
          //println(ds);
        }
  
        pw.close();
        
        fill(0,0,0);
        textSize(12);
        text("Guardado", 60, 295);

     }catch(IOException ioe){
           System.out.println("Exception ");
           ioe.printStackTrace();
      }
    }
   
  }
  
 if((mouseX>=150 && mouseX<=260) && (mouseY>=300 && mouseY<=325)) {
    if(key == 10){
        //println("EnterSave");
        try{
          File file =new File("D:/Documentos/tpfinalfiles/alarmas.csv");
          if(!file.exists()){
            file.createNewFile();
          }
  
          FileWriter fw = new FileWriter(file,true);///true = append
          BufferedWriter bw = new BufferedWriter(fw);
          PrintWriter pw = new PrintWriter(bw);
          
          for(int i=0; i<tabalar.getRowCount(); i++){
            TableRow rowalar = tabalar.getRow(i);
            dsa = rowalar.getString("Fecha y hora") + "," +rowalar.getString("Temp") + "," + rowalar.getString("Humedad") + "\n";
            pw.write(dsa, 0, dsa.length());
            //println(dsa);
          }
         pw.close();
  
         fill(0,0,0);
         textSize(12);
         text("Guardado", 170, 283);
  
       }catch(IOException ioe){
             System.out.println("Exception ");
             ioe.printStackTrace();
        }
      }
   
  }
  
}
