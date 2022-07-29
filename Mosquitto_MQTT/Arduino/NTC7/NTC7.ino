#include <OneWire.h>
#include <DallasTemperature.h>

#define Temperature_Pin 4

OneWire oneWire(Temperature_Pin);
DallasTemperature DS18B20(&oneWire);

#define Vpin 11

int period = 10;
unsigned long time_now = 0;

float tempC;
float tempF;
int dropstate = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  DS18B20.begin();
  pinMode(Vpin, INPUT);
  //pinMode(blah, OUTPUT);
  Serial.println("Starting..");
}
void(* resetFunc)(void) = 0; //declare reset function @ address 0

void loop() {
  // put your main code here, to run repeatedly:
  dropstate = digitalRead(Vpin);
  // time_now = millis();

  // Call sensors.requestTemperatures() to issue a global temperature and Requests to all devices on the bus
  DS18B20.requestTemperatures();
  // Why "byIndex"? You can have more than one IC on the same bus. 0 refers to the first IC on the wire
  tempC = DS18B20.getTempCByIndex(0);  // read temperature in °C
  tempF = tempC * 9 / 5 + 32; // convert °C to °F

   if (dropstate == HIGH)
  {
    //delay(500);
    Serial.write("Hi\n");
    Serial.println(String(tempC) + "_" + "1" + "_" + "1");
    Serial.println(String(tempC) + "_" + "1" + "_" + "1");
    // Serial.println(String(tempC) + "_" + "1" + "_" + "1");
    // Serial.println(tempC);
    // Serial.println(tempC);
    // Serial.println(tempC);
    // delay(10);
    // Serial.write("Hi\n");
    // Serial.println(tempC);
    // Serial.println(tempC);
    //delay(1000);
    //Serial.write("Hi\n");
    //Serial.println(tempC);
    //Serial.println(tempC);
  }
  //else
  //{
    //Serial.print((tempC)+String(" "));
    //Serial.println(tempC);
  //}

  
  // if (millis() >= time_now + period){
  //   time_now += period;
  //   //Serial.println(tempC);
  // }
  
  if (Serial.available()>0)
  {
    String str = Serial.readString();
    //Serial.println(str);
    if(str.substring(0) == "YO\n"){
      delay(2000);
      Serial.write("Hi\n");
      Serial.println(String(tempC) + "_" + "1" + "_" + "1");
      Serial.println(String(tempC) + "_" + "1" + "_" + "1");
      // Serial.println(String(tempC) + "_" + "1" + "_" + "1");
      //  Serial.println(tempC);
      //  Serial.println(tempC);
      //  Serial.println(tempC);
    }
    else if(str.substring(0) == "MO\n")
    {
      // delay(1000);
      // Serial.write("Hi\n");
      Serial.println(String(tempC) + "_" + "1" + "_" + "1");
      Serial.println(String(tempC) + "_" + "1" + "_" + "1");
      // Serial.println(String(tempC) + "_" + "1" + "_" + "1");
      // Serial.println(String(tempC) + "_" + "1" + "_" + "1");

    }
    else if (str.substring(0) == "RE\n")
    {
      resetFunc(); //call reset
    }
    else{
      //Serial.println(tempC);
      ;
    }
  }
  //delay(100);
}
