#include <DHT.h>
#include <DHT_U.h>

#define pinsen 3
#define DHTTYPE DHT11
#define ledtemok 9
#define ledtemalar 10
#define ledhumok 11
#define ledhumalar 12
#define buzz 8

DHT sens(pinsen, DHTTYPE);

float t;
float h;
float tmax;
float hmax;


void setup() {
  Serial.begin(9600);
  sens.begin();

  pinMode(ledtemok, OUTPUT);
  pinMode(ledtemalar, OUTPUT);
  pinMode(ledhumok, OUTPUT);
  pinMode(ledhumalar, OUTPUT);
  pinMode(buzz, OUTPUT);
}

void loop() {
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
  Serial.write(t);
  Serial.write(h);
  /*                             //muestreo por monitor serial de arduino
  Serial.print("Humedad: ");
  Serial.print(h);
  Serial.print(" %\t");
  Serial.print("Temperatura: ");
  Serial.print(t);
  Serial.println(" *C ");*/
                                       //Comprobacion de temperatura máxima, en cuyo caso suena una alarma mientras se enciende led rojo
  if(t>=tmax){
    digitalWrite(ledtemalar, HIGH);

    digitalWrite(buzz, HIGH);
    delay(500);
    digitalWrite(buzz, LOW);
    delay(250);
    digitalWrite(buzz, HIGH);
    delay(500);
    digitalWrite(buzz, LOW);
    delay(100);
  }                                    //Si la temperaura está dentro del rango, solo se prende un led verde
  else{
    digitalWrite(ledtemok, HIGH);
  }
                                       //Comprobacion de humedad máxima, en cuyo caso suena una alarma mientras se enciende led rojo
  if(h>=hmax){
    digitalWrite(ledhumalar, HIGH);

    digitalWrite(buzz, HIGH);
    delay(500);
    digitalWrite(buzz, LOW);
    delay(250);
    digitalWrite(buzz, HIGH);
    delay(500);
    digitalWrite(buzz, LOW);
    delay(100);
  }                                 //Si la humedad está dentro del rango, solo se prende un led verde
  else{
    digitalWrite(ledhumok, HIGH);
  }

                                 //Apagado de leds de temperatura y humedad normal
  digitalWrite(ledtemok, LOW);
  digitalWrite(ledhumok, LOW);
}
