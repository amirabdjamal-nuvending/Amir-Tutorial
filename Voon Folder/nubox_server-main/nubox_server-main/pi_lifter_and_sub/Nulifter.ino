#include "Adafruit_MCP23017.h"
#include <TimedAction.h>
#include <Wire.h>
#include <Adafruit_INA219.h>
#include <SoftwareSerial.h>
Adafruit_MCP23017 mcp1;
Adafruit_INA219 ina219;
#include <RobojaxBTS7960.h>
// BTS7960
#define RPWM 3 // define pin 3 for RPWM pin (output)
#define R_EN 4 // define pin 2 for R_EN pin (input)
#define R_IS 5 // define pin 5 for R_IS pin (output)
#define LPWM 6 // define pin 6 for LPWM pin (output)
#define L_EN 7 // define pin 7 for L_EN pin (input)
#define L_IS 8 // define pin 8 for L_IS pin (output)
#define CW 1 //do not change
#define CCW 0 //do not change
#define DEBUG 1 //change to 0 to hide serial monitor debugging information or set to

// L298N
#define IN1 10
#define IN2 11
#define IN3 12
#define IN4 13

#define LED_PIN 13
#define ENCODER_PIN 9

#define PROXIMITY_PIN A2
#define LIMIT_SWITCH_PIN A3

int timer_delay_for_actuator = 4000;
int timer_delay_for_lock = 3000;
String dir = "";
int lifter_step = 0;
int lifter_step_counter = 0;
int lifter_motion = 0; // 0 = stop, 1 = moving up or down, 2 = moving to home
int lifter_protect = 0;
int lifter_protect_step = 0;
//bool actuator_flag = false; // false = actuator allow lifter goes up, true = actuator does not allow lifter goes up
bool lifter_arrive_position_flag = true;
bool previous_encoder_signal = true;

char serial_data_to_send = 'e';

RobojaxBTS7960 motor(R_EN, RPWM, R_IS, L_EN, LPWM, L_IS, DEBUG);

//code for get temp from compressor
byte cmd[] = {0xFC, 0x03, 0x00, 0x00, 0x00, 0xFB};
int incomingByte = 0;
SoftwareSerial mySerial(A0, A1); // RX, TX
String station_Id = "01";


// Open the actuator means let the actuator open so that lifter can go up and down
void openActuator() {
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, HIGH);
  //  for (int i = 0; i < 120; i++) {
  delay(timer_delay_for_actuator);
  //  }
  offDoorLockAndActuator();
}

// Close the actuator means let the actuator extend so that lifter can't go up and down
void closeActuator() {
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);
  //  for (int i = 0; i < 100; i++) {
  delay(timer_delay_for_actuator);
  //  }
  offDoorLockAndActuator();
}

void lockTheDoor() {
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, LOW);
  delay(timer_delay_for_lock);
  offDoorLockAndActuator();
}

void unlockTheDoor() {
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, LOW);
  delay(timer_delay_for_lock);
  offDoorLockAndActuator();
}

void offDoorLockAndActuator() {
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, LOW);
}



void resetLifterFlags() {
  lifter_step_counter = 0;
  lifter_arrive_position_flag = false;
}
//moveLifterMotor
void updateEncoderValue() {
  // Only when lifter need to move (after reset lifter flag) then only update encoder
  if (!lifter_arrive_position_flag && lifter_motion == 1) {
    bool temp_encoder_signal = digitalRead(ENCODER_PIN);
    if (temp_encoder_signal != previous_encoder_signal) {
      previous_encoder_signal = temp_encoder_signal;
      lifter_step_counter++;
    }
    lifter_protect++;
    //
    if (lifter_protect == 32300) {
      int range = lifter_step_counter - lifter_protect_step;
      if ((range) < 100 && range > -100) {
        Serial.println(lifter_step_counter);
        Serial.println(lifter_protect_step);
        if (dir != "H") {
          Serial.println(station_Id + " " + "jam");
        } else if (dir == "H" && digitalRead(LIMIT_SWITCH_PIN)) {
          Serial.println(station_Id + " " + "done");
          closeActuator();
          unlockTheDoor();
        } else if (dir == "H" && !digitalRead(LIMIT_SWITCH_PIN) ){
        Serial.println(station_Id + " " + "jam");
        }


        lifter_arrive_position_flag = true;
        motor.stop();
        lifter_protect = 0;
        


      }
      lifter_protect = 0;
      lifter_protect_step = lifter_step_counter;
    }
    else if (dir == "H" && digitalRead(LIMIT_SWITCH_PIN)) {
      Serial.println(station_Id + " " + "done");
      motor.stop();

      lifter_protect = 0;
      lifter_step = 0;
      lifter_motion = 0;

      lifter_arrive_position_flag = true;
      closeActuator();
      // 3. Unlock the door
      unlockTheDoor();
      // TODO: Tell RPi lifter reach position
      //      Serial.pri  ntln(station_Id + " " + "done");
    }
    else if (lifter_step_counter >= lifter_step) {
      motor.stop();
      lifter_protect = 0;
      lifter_step = 0;
      lifter_motion = 0;

      lifter_arrive_position_flag = true;
      // TODO: Tell RPi lifter reach position
      Serial.println(station_Id + " " + "done");
    }
  }
}

void lifterMovingUp() {
  if (lifter_step > 0) {
    resetLifterFlags();
    lifter_motion = 1;
    motor.rotate(40, CCW);
  }
}

void lifterMovingDown() {
  if (lifter_step > 0) {
    resetLifterFlags();
    lifter_motion = 1;
    motor.rotate(30, CW);
  }
}

void lifterMovingToHome() {
  resetLifterFlags();
  lifter_motion = 2;
  motor.rotate(30, CW);
}

void preDispenseItem() {
  // 1. Open Actuator (Let lifter goes up)
  //  openActuator();
  // 2. Lifter moves to specific position
  lifterMovingUp();
}

void postDispenseItem() {
  // 1. Lifter moves to home position
  lifterMovingToHome();
}

//void checkLimitSwitchToOffLifter() {
//  //  Serial.println("checkLimitSwitchToOffLifter");
//  if (!lifter_arrive_position_flag && lifter_motion == 2) {
//    if (digitalRead(LIMIT_SWITCH_PIN)) {
//      motor.stop();
//
//      lifter_step = 0;
//      lifter_motion = 0;
//
//      lifter_arrive_position_flag = true;
//
//      // 2. Close Actuator (To avoid lifter goes up)
//      closeActuator();
//      // 3. Unlock the door
//      unlockTheDoor();
//      // TODO: Tell RPi lifter reach home position
//      Serial.println(station_Id + " " + "done");
//    }
//  }
//}
//
//TimedAction limitSwitchEvent = TimedAction(1, checkLimitSwitchToOffLifter); // Fastest only can up to 7-8ms





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


int trackInspectionMotor(int row, int column) {
  int i = 0;

  mcp1.digitalWrite(row, HIGH);
  mcp1.digitalWrite(column, HIGH);

  digitalWrite(LED_BUILTIN, HIGH);
  delay(100);

  if (ina219.getCurrent_mA() > 55) {
    mcp1.digitalWrite(row, LOW);
    mcp1.digitalWrite(column, LOW);
    Serial.println(station_Id + " " + "done");
  } else {
    mcp1.digitalWrite(row, LOW);
    mcp1.digitalWrite(column, LOW);
    Serial.println(station_Id + " " + "error");
  }





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

void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);

  uint32_t currentFrequency;
  motor.begin();
  mcp1.begin();
  pinMode(LED_PIN, OUTPUT);
  pinMode(ENCODER_PIN, INPUT);
  pinMode(PROXIMITY_PIN, INPUT);
  pinMode(LIMIT_SWITCH_PIN, INPUT_PULLUP);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
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

void loop() {

  if (Serial.available() > 0) {

    String data = Serial.readStringUntil('\n');
    String station_Number = getValue(data, ' ', 0);
    String command = getValue(data, ' ', 1); // runSpiralMotor
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

      } else if (command == "trackInspectionMotor") {
        int row = getValue(data, ' ', 2).toInt();
        int column = getValue(data, ' ', 3).toInt();

        trackInspectionMotor(row, column);


      } else if (command == "runSpiralMotor") {
        int row = getValue(data, ' ', 2).toInt();
        int column = getValue(data, ' ', 3).toInt();

        runSpiralMotor(row, column);

        Serial.println(station_Id + " " + "done");
      } else if (command == "runSpiralMotorQuarter") {
        int row = getValue(data, ' ', 2).toInt();
        int column = getValue(data, ' ', 3).toInt();

        runSpiralMotorQuarter(row, column);

        Serial.println(station_Id + " " + "done");
        //      }  else if (command == "motorHome") {
        //        // Lifter to home position
        //        postDispenseItem();
        //        while (!lifter_arrive_position_flag) {
        //          limitSwitchEvent.check();
        //
        //        }

      }  else if (command == "unlockTheDoor") {
        // Lock the door
        unlockTheDoor();
        Serial.println(station_Id + " " + "done");
      } else if (command == "lockTheDoor") {
        // Unlock the door
        lockTheDoor();
        Serial.println(station_Id + " " + "done");
      } else if (command == "getInductiveSensor") {
        // Check inductive sensor
        if (digitalRead(PROXIMITY_PIN)) {

          Serial.println(station_Id + " " + "false");
        } else {
          Serial.println(station_Id + " " + "true");

        }
      } else if (command == "openActuator") {
        // Lock the door
        openActuator();
        Serial.println(station_Id + " " + "done");
      } else if (command == "closeActuator") {
        // Lock the door
        closeActuator();
        Serial.println(station_Id + " " + "done");
      } else if (command == "getLimitSensor") {
        // Check limit sensor
        if (digitalRead(LIMIT_SWITCH_PIN)) {
          Serial.println(station_Id + " " + "true");
        } else {
          Serial.println(station_Id + " " + "false");
        }
      } else if (command == "stopLifter") {
        offDoorLockAndActuator();
        motor.stop();
        Serial.println(station_Id + " " + "done");
      }//check is home?
      else if (command == "moveLifterMotor") {
        lifter_protect_step = 0;
        dir = getValue(data, ' ', 2);
        lifter_step = getValue(data, ' ', 3).toInt();
        int i = 0;
        if (dir == "F") { // motor forward

          preDispenseItem();
          while (!lifter_arrive_position_flag) {
            updateEncoderValue();

          }
        }
        else if (dir == "B") { // motor backward

          lifterMovingDown();
          while (!lifter_arrive_position_flag) {
            updateEncoderValue();

          }
        }
        else if (dir == "H") { // motor backward
          lifter_step = 3000;
          lifterMovingDown();
          while (!lifter_arrive_position_flag) {
            updateEncoderValue();

          }
        }
      }
      else {
        Serial.println(station_Id + " " + "invalid");
      }
    }
  }

}