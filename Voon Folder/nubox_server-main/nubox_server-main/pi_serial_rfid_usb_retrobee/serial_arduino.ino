#include "Adafruit_MCP23017.h"
#include <Wire.h>
#include <Adafruit_INA219.h>
#include <SoftwareSerial.h>
Adafruit_MCP23017 mcp1;

Adafruit_INA219 ina219;
//for ask temperature from compressor
//byte cmd[] = {0x45, 0x46, 0x47, 0x48, 0x49, 0xFB};

byte cmd[] = {0xFC, 0x03, 0x00, 0x00, 0x00, 0xFB};
int incomingByte = 0;
SoftwareSerial mySerial(A0, A1); // RX, TX
String station_Id = "01";
void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);

    uint32_t currentFrequency;

    mcp1.begin();

    for (int i = 0; i < 16; i++) {
      mcp1.pinMode(i, OUTPUT);
      //    Serial.println("initialized to OUTPUT");
    }
  
    if (!ina219.begin()) {
      //    Serial.println("Failed to find INA219 chip");
      while (1) {
        delay(10);
      }
    } else {
      //    Serial.println("ina219 begin...");
    }
}

int runSpiralMotorQuarter(int row, int column) {
  int i = 0;

  mcp1.digitalWrite(row, HIGH);
  mcp1.digitalWrite(column, HIGH);

  digitalWrite(LED_BUILTIN, HIGH);

  delay(500);

  mcp1.digitalWrite(row, LOW);
  mcp1.digitalWrite(column, LOW);

  digitalWrite(LED_BUILTIN, LOW);

  return 0;
}


int runSpiralMotor(int row, int column) {
  int i = 0;

  mcp1.digitalWrite(row, HIGH);
  mcp1.digitalWrite(column, HIGH);

  digitalWrite(LED_BUILTIN, HIGH);

  delay(300);

  while (ina219.getCurrent_mA() > 55) {
    i++;
  }

  delay(400);

  mcp1.digitalWrite(row, LOW);
  mcp1.digitalWrite(column, LOW);

  digitalWrite(LED_BUILTIN, LOW);

  return 0;
}

String getValue(String data, char separator, int index) {
  int found = 0;
  int strIndex[] = { 0, -1 };
  int maxIndex = data.length() - 1;

  for (int i = 0; i <= maxIndex && found <= index; i++) {
    if (data.charAt(i) == separator || i == maxIndex) {
      found++;
      strIndex[0] = strIndex[1] + 1;
      strIndex[1] = (i == maxIndex) ? i + 1 : i;
    }
  }
  return found > index ? data.substring(strIndex[0], strIndex[1]) : "";
}

void loop() {

  if (Serial.available() > 0) {

    String data = Serial.readStringUntil('\n');
    String station_Number = getValue(data, ' ', 0);

    String command = getValue(data, ' ', 0); // runSpiralMotor
  if (station_Number == station_Id) {
      if (command == "readTemp") {

        mySerial.write(cmd, sizeof(cmd));
        delay(200);
        int i = 0;
        String data = "";
        String temperature = "";
        while (mySerial.available() > 0) {

          // read the incoming byte:
          incomingByte =  mySerial.read();

          data = data + String(incomingByte, HEX);
          //        Serial.println(String(incomingByte, HEX));
          if (i == 2)
          {
            temperature = String(incomingByte, DEC);
            Serial.println(station_Id + " " + temperature);
            Serial.flush();
            mySerial.flush();
          }
          if (incomingByte == 0xFB) {


            break;
          }


          i++;

        }
        //      Serial.println(data);

      } else if (command == "runSpiralMotor") {
        int row = getValue(data, ' ', 1).toInt();
        int column = getValue(data, ' ', 2).toInt();

        runSpiralMotor(row, column);

        Serial.println(station_Id + " " + "done");
      } else if (command == "runSpiralMotorQuarter") {
        int row = getValue(data, ' ', 1).toInt();
        int column = getValue(data, ' ', 2).toInt();

        runSpiralMotorQuarter(row, column);

        Serial.println(station_Id + " " + "done");
      } else {
        Serial.println(station_Id + " " + "invalid");
      }
    }
  }

}