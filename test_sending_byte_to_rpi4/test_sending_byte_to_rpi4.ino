#define MAX_BUFF_LEN 255

char c;
char str[MAX_BUFF_LEN];
uint8_t idx = 0;
byte DataA1 []= {0xFC,0x03,0x01,0x01,0x01,0xFB};

void setup( )  
{  
  Serial.begin(115200);
}  
void loop( ) // loop function that executes repeatedly  
{  
  if(Serial.available( ) > 0){ //  It will only send data when the received data is greater than 0.  
    c = Serial.read();  // It will read the incoming or arriving data byte  

    if(c != '\n'){
      str[idx++] = c;
    }
    else{
      str[idx] = '\0';
      idx = 0;

      Serial.print("Arduino: ");
      Serial.println(str);
    }
  }
} 
