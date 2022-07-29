#include <OneWire.h>
#include <DallasTemperature.h>

#define Temperature_Pin 4

OneWire oneWire(Temperature_Pin);
DallasTemperature DS18B20(&oneWire);

#define Vpin 11
const byte door_pin = 3;
volatile byte doorstaate = LOW;

const byte drop_pin = 2;
volatile byte dropstaate = LOW;

int period = 4000; // 10 Second
unsigned long startMillis;

float tempC;
float tempF;
int dropstate = 0;
char buffer[20];

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  DS18B20.begin();
  pinMode(Vpin, INPUT);
  pinMode(door_pin, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(door_pin), door_status, CHANGE);
  pinMode(drop_pin, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(drop_pin), drop_status, RISING);
  
  Serial.println("Starting..");
  Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
  
}
void(* resetFunc)(void) = 0; //declare reset function @ address 0

void loop() {
  // put your main code here, to run repeatedly:
  // dropstate = digitalRead(Vpin);
  // time_now = millis();

  // Call sensors.requestTemperatures() to issue a global temperature and Requests to all devices on the bus
  DS18B20.requestTemperatures();
  // Why "byIndex"? You can have more than one IC on the same bus. 0 refers to the first IC on the wire
  tempC = DS18B20.getTempCByIndex(0);  // read temperature in °C
  tempF = tempC * 9 / 5 + 32; // convert °C to °F

  //  if (dropstate == HIGH)
  // {
  //   //delay(500);
  //   // Serial.write("Hi\n");
  //   // Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
  //   // Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
  //   // Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
  //   // Serial.println(tempC);
  //   // Serial.println(tempC);
  //   // delay(10);
  //   // Serial.write("Hi\n");
  //   // Serial.println(tempC);
  //   // Serial.println(tempC);
  //   //delay(1000);
  //   //Serial.write("Hi\n");
  //   //Serial.println(tempC);
  //   //Serial.println(tempC);
  // }
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
    // Serial.println(str.substring(0));
    // Serial.println(str);
    if (str.substring(0) == "MO\n")
    {
      // int Count = 0;
      // while (Count <= 10)
      // {
      //   delay(5);
      //   Serial.println(Count++);
      // }
      // motor_time_out();
      // Serial.write("Hi\n");
      Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
      Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
    }
    
    else if(str.substring(0) == "YO\n"){
      // delay(2000);
      Serial.write("Hi\n");
      // Serial.println(String("6") + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
      Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
      Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
      // Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
      // Serial.println(tempC);
      //  Serial.println(tempC);
      //  Serial.println(tempC);
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
}

void motor_time_out()
{
  int Count = 0;
  startMillis = millis();
  do {
    
    Serial.println(Count++);
  }
  while (millis() - startMillis <= period);
  // while (Count <= 10)
  // {
  //   delay(5);
  //   Serial.println(Count++);
  // }
}

void drop_status()
{
  Serial.write("Hi\n");
  Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + "1");
  Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + "1");
  // Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
}

// Later change to sending directly to API
void door_status()
{
  Serial.write("Hi\n");
  Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
  Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
  // Serial.println(String(tempC) + "_" + String(digitalRead(door_pin)) + "_" + String(digitalRead(Vpin)));
}