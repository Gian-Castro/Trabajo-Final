#include <DHT.h>
#include <DHT_U.h>

#define pinsen 3
#define DHTTYPE DHT11
#define ledok 11
#define ledalar 12
#define buzz 8

DHT sens(pinsen, DHTTYPE);

float h;
float t;

void setup() {
  Serial.begin(9600);
  sens.begin();

  pinMode(ledok, OUTPUT);
  pinMode(ledalar, OUTPUT);
  pinMode(buzz, OUTPUT);
}

void loop() {
  h = sens.readHumidity();
  t = sens.readTemperature();

  Serial.print("Humedad: ");
  Serial.print(h);
  Serial.print(" %\t");
  Serial.print("Temperatura: ");
  Serial.print(t);
  Serial.print(" *C ");

}
