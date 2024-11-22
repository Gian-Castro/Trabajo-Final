#include <DHT.h>
#include <DHT_U.h>
#include <EasyBuzzer.h>

#define pinsen 3
#define DHTTYPE DHT11
#define boton 5
#define ledtemok 9
#define ledtemalar 10
#define ledhumok 11
#define ledhumalar 12


DHT sens(pinsen, DHTTYPE);

float t;
float h;
float tmax;
float hmax;
int buzzmodo = 1;


void setup() {
  Serial.begin(9600);
  sens.begin();

  pinMode(ledtemok, OUTPUT);
  pinMode(ledtemalar, OUTPUT);
  pinMode(ledhumok, OUTPUT);
  pinMode(ledhumalar, OUTPUT);
  EasyBuzzer.setPin(8);
  
}

void loop() {
  delay(5000);
                          //recibe los valores maximos desde processing
  tmax = Serial.read();  
  hmax = Serial.read();
                                 //recibe las mediciones desde el sensor, las guarda y envia a processing para mostrar
  t = sens.readTemperature();
  h = sens.readHumidity();
  if (isnan(h) || isnan(t)) {    
    Serial.println("Error obteniendo los datos del sensor DHT11");
    return;
  }
  Serial.print(t);
  Serial.print(h);
  /*                             //Muestreo por monitor serial de arduino
  Serial.print("Humedad: ");
  Serial.print(h);
  Serial.print(" %\t");
  Serial.print("Temperatura: ");
  Serial.print(t);
  Serial.println(" *C ");*/
  
                                       //Comprobacion de temperatura y/o humedad máxima, en cuyo caso suena una alarma mientras se enciende led rojo
  if(t>=tmax||h>=hmax){
    if(t>=tmax){
      digitalWrite(ledtemalar, HIGH);
    }
    if(h>=hmax){
      digitalWrite(ledhumalar, HIGH);
    }
    if(buzzmodo==1){
      EasyBuzzer.singleBeep(700, 1500);
      EasyBuzzer.stopBeep();
      delay(1000);
      EasyBuzzer.singleBeep(700, 1500);
      EasyBuzzer.stopBeep();
      delay(500);
    }
    
  }                                    
                                      //Si la temperaura y/o humedad está dentro del rango, solo se prende un led verde
  if(t<tmax){
    digitalWrite(ledtemok, HIGH);
  }
  if(h<hmax){
    digitalWrite(ledhumok, HIGH);
  }
  
                                  //Prendido/apagado del sonido del buzzer alarma
  if(digitalRead(boton)==HIGH){
    if(buzzmodo==0){
      buzzmodo=1;
    }
    else{
      buzzmodo=0;
    }
  }

  delay(1000);
                                 //Apagado de leds
  digitalWrite(ledtemok, LOW);
  digitalWrite(ledhumok, LOW);
  digitalWrite(ledtemalar, LOW);
  digitalWrite(ledhumalar, LOW);
}
