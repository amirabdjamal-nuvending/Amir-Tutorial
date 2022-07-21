#include <stdio.h>
#include <string.h>

char stc_command[6];

int startSplit = 0;
char str[15] = "single_A_1";
char * strData[3];

char motor_First_String[3][12]= {{"single"}, {"test"}, {"rw"}};
char motor_Second_String[6] = {'A', 'B', 'C', 'D', 'E', 'F'};
// printf("motor_Second_String[0]: %c\n", motor_Second_String[0]);
char motor_Third_String[15][1] = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"};

char STX = 0xFB; //start byte
char ENX = 0xFB; //end byte

char SINGLE_MOTOR_DISPENSING = 0x02;
char SINGLE_MOTOR_DISPENSING_MODE = 0x01;

char TEST_MOTOR_FUNCTION = 0x03;
char TEST_MOTOR_FUNCTION_MODE = 0x11;

char row[6] = {0x06, 0x05, 0x04, 0x03, 0x02, 0x01};
char column[10] = {0x0A, 0x09, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01};

void split(){
    printf("masukawal\n");
    char *token;
    char* rest = str;
    int j = 0;

    while ((token = strtok_r(rest, "_", &rest)))
    {
        printf("masuk\n");
        strData[j++] = token;
        
    }

    printf("strData[0]: %s\n", strData[0]);
    printf("strData[1]: %s\n", strData[1]);
    printf("strData[2]: %s\n\n", strData[2]);
  
    printf("str[0]: %c\n", str[0]);
    printf("str[1]: %c\n", str[1]);
    printf("str[2]: %c\n\n", str[2]);
    
    concate(strData);
      
    // for (int i = 0; i < sizeof(str) ; i++){
    //       str[i] = '\0';
    //       printf("masukFOR\n");
    // }
      
    int m = strcmp(strData[2], "1");
    printf("%d\n\n", m);
}

void concate(char * strDataConcate[]){
    
    printf("strDataConcate[0]: %s\n", strDataConcate[0]);
    printf("strDataConcate[1]: %s\n", strDataConcate[1]);
    printf("strDataConcate[2]: %s\n\n", strDataConcate[2]);
    
    printf("motor_First_String[0]: %s\n", motor_First_String[0]);
    printf("motor_First_String[1]: %s\n", motor_First_String[1]);
    printf("motor_First_String[2]: %s\n\n", motor_First_String[2]);
    
//     if(strcmp(strDataConcate[0], motor_First_String[0])==0){
// 	    stc_command[1] = SINGLE_MOTOR_DISPENSING;
//     	stc_command[4] = SINGLE_MOTOR_DISPENSING_MODE;  
// 	}
    
    /***********first, sixth byte************/
    stc_command[0] = STX;
	stc_command[5] = ENX;
	
	/***********second, fifth byte************/
	if(strcmp(strDataConcate[0], motor_First_String[0])==0){
	    stc_command[1] = SINGLE_MOTOR_DISPENSING;
    	stc_command[4] = SINGLE_MOTOR_DISPENSING_MODE;  
	}
	else if(strcmp(strDataConcate[0],motor_First_String[1])==0){
	    stc_command[1] = TEST_MOTOR_FUNCTION;
    	stc_command[4] = TEST_MOTOR_FUNCTION_MODE;  
	}
	else{}
	/***********third byte************/
// 	int h = strcmp(strDataConcate[1], motor_Second_String[0]);
// 	printf("%d", h);
// 	printf("%s", motor_Second_String[0]);
// 	if(strcmp(strDataConcate[1], motor_Second_String[0])==0){
// 	    stc_command[2] = row[0];
// 	}
// 	else if(strcmp(strDataConcate[1], motor_Second_String[1])==0){
// 	    stc_command[2] = row[1];
// 	}
// 	else if(strcmp(strDataConcate[1], motor_Second_String[2])==0){
// 	    stc_command[2] = row[2];
// 	}
// 	else if(strcmp(strDataConcate[1], motor_Second_String[3])==0){
// 	    stc_command[2] = row[3];
// 	}
// 	else if(strcmp(strDataConcate[1], motor_Second_String[4])==0){
// 	    stc_command[2] = row[4];
// 	}
// 	else if(strcmp(strDataConcate[1], motor_Second_String[5])==0){
// 	    stc_command[2] = row[5];
// 	}
// 	else{}
//     /***********fourth byte************/
//     if(strcmp(strDataConcate[2], motor_Third_String[0])==0){
// 	    stc_command[2] = column[0];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[1])==0){
// 	    stc_command[2] = column[1];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[2])==0){
// 	    stc_command[2] = column[2];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[3])==0){
// 	    stc_command[2] = column[3];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[4])==0){
// 	    stc_command[2] = column[4];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[5])==0){
// 	    stc_command[2] = column[5];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[6])==0){
// 	    stc_command[2] = column[6];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[7])==0){
// 	    stc_command[2] = column[7];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[8])==0){
// 	    stc_command[2] = column[8];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[9])==0){
// 	    stc_command[2] = column[9];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[10])==0){
// 	    stc_command[2] = column[10];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[11])==0){
// 	    stc_command[2] = column[11];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[12])==0){
// 	    stc_command[2] = column[12];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[13])==0){
// 	    stc_command[2] = column[13];
// 	}
// 	else if(strcmp(strDataConcate[2], motor_Third_String[14])==0){
// 	    stc_command[2] = column[14];
// 	}
// 	else{}
	
// 	printf("%X%X%X%X%X%X%X",stc_command[0],stc_command[1],stc_command[2],stc_command[3],stc_command[4],stc_command[5]);
	
	printf("%x\n", stc_command[0]);
	printf("%x\n", stc_command[1]);
	printf("%x\n", stc_command[2]);
	printf("%x\n", stc_command[3]);
	printf("%x\n", stc_command[4]);
	printf("%x\n", stc_command[5]);
}

int main()
{   

    while(1){
        split();
        // concate();
    }
    
    return 0;
}





