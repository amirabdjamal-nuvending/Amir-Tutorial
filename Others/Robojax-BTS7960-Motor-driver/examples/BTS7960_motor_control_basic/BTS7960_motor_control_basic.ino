#include <RobojaxBTS7960.h>
#include <util/atomic.h> // For the ATOMIC_BLOCK macro

#define ENCA 2 // YELLOW
#define ENCB 3 // WHITE

const int proximity_pin = 4;

#define RPWM 5 // define pin 5 for RPWM pin (output)
#define R_EN 6 // define pin 6 for R_EN pin (input)
#define R_IS 7 // define pin 7 for R_IS pin (output)

#define LPWM 9 // define pin 9 for LPWM pin (output)
#define L_EN 10 // define pin 10 for L_EN pin (input)
#define L_IS 11 // define pin 11 for L_IS pin (output)
#define CW 1 //do not change
#define CCW 0 //do not change
#define debug 1 //change to 0 to hide serial monitor debugging infornmation or set to 1 to view

RobojaxBTS7960 motor(R_EN,RPWM,R_IS, L_EN,LPWM,L_IS,debug);

bool min_speed_status = false;
bool max_speed_status = false;
bool motor_spin_status = false;

short usSpeed = 100;
int direct;
int pos = 0; 
int proximity_val;

volatile int posi = 0;

void setup()
{
  // BTS7960 Motor Control Code by Robojax.com 20190622
  Serial.begin(9600);// setup Serial Monitor to display information

  pinMode(ENCA,INPUT);
  pinMode(ENCB,INPUT);
  pinMode(proximity_pin, INPUT);
  attachInterrupt(digitalPinToInterrupt(ENCA),readEncoder,RISING);
  
  Serial.println("Begin motor control");
  Serial.println(); //Print function list for user selection
  Serial.println("Enter number for control option:");
  Serial.println("1. STOP");
  Serial.println("2. FORWARD");
  Serial.println("3. REVERSE");
  Serial.println("+. INCREASE SPEED");
  Serial.println("-. DECREASE SPEED");
  Serial.println();

  motor.begin();
}

void loop()
{
  char user_input;

  ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
    pos = posi;
  }

  while(Serial.available())
  {
    user_input = Serial.read(); //Read user input and trigger appropriate function

    
    if(usSpeed <= 100)
    {
     max_speed_status = false;
    }
    if(user_input =='1')
    {
      Stop();
    }
    if(user_input =='2')
    {
      Forward();
    }
    if(user_input =='3')
    {
      Reverse();
    }
    if(user_input =='+')
    {
      IncreaseSpeed();
    }
    if(user_input =='-')
    {
      DecreaseSpeed();
    }
  }

   while(digitalRead(proximity_pin) == 0 && motor_spin_status == true){
    proximityDetection();
    motor_spin_status = false;
 }
}

void Stop(){
  motor.stop();// stop the motor
  Serial.print("Current motor position: ");
  Serial.print(pos);
  Serial.print(" (Speed: ");
  Serial.print(usSpeed);
  Serial.println(")");
  Serial.println();
  if(min_speed_status == true){
     Serial.println("Min/Zero speed reached!");
     Serial.println("Press 2. Forward or 3 . Reverse");
     Serial.println("Press \"+\" to increase speed of the motor");
     min_speed_status = false;
  }
}

void Forward(){
  motor_spin_status = true;
  direct = CW;
  motor.rotate(usSpeed,direct);// run motor with 100% speed in CW direction
  Serial.print("Mode: Forward, Current speed: ");
  Serial.println(usSpeed);
}

void Reverse(){
  motor_spin_status = true;
  direct = CCW;
  motor.rotate(usSpeed,direct);// run motor at 100% speed in CCW direction
  Serial.print("Mode: Reverse, Current speed: ");
  Serial.println(usSpeed);
}

void IncreaseSpeed(){
  usSpeed = usSpeed + 10;
  if(usSpeed > 100 && max_speed_status == false)
  {
    usSpeed = 100;
    Serial.println("Max speed reached!");
    max_speed_status = true;
  }
  motor.rotate(usSpeed,CCW);// run motor at 100% speed in CCW direction
}

void DecreaseSpeed(){
  usSpeed = usSpeed - 10;
  if(usSpeed < 0)
  {
    usSpeed = 0;
    direct = 0; 
    min_speed_status = true;
    Stop();
  }
  motor.rotate(usSpeed,CCW);// run motor at 100% speed in CCW direction
}

void proximityDetection(){
    proximity_val = digitalRead(proximity_pin);
    if(proximity_val==HIGH){ 
        
    }
    else{
        Serial.println();
        Serial.println("Object Detected");
        Stop();
    }
}

void readEncoder(){
  int b = digitalRead(ENCB);
  if(b > 0){
    posi++;
  }
  else{
    posi--;
  }
}
