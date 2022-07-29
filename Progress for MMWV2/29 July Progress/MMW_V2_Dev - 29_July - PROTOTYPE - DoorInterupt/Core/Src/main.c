/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2022 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "string.h"
#include "stdio.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
 TIM_HandleTypeDef htim1;

UART_HandleTypeDef huart1;
UART_HandleTypeDef huart2;
DMA_HandleTypeDef hdma_usart1_rx;
DMA_HandleTypeDef hdma_usart1_tx;
DMA_HandleTypeDef hdma_usart2_rx;
DMA_HandleTypeDef hdma_usart2_tx;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_DMA_Init(void);
static void MX_USART1_UART_Init(void);
static void MX_USART2_UART_Init(void);
static void MX_TIM1_Init(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/**************************** Uart Buffers ****************************/

uint8_t RX_DATA_FROM_STC[5];
uint8_t RX_BUFF_FROM_DTU[7];

uint8_t *SPLIT_RX_BUFF_FROM_DTU[3];


/**************************** Drop & Door Sensors, Motor Status ****************************/

#define DOOR_SENSOR_PORT GPIOB
#define DOOR_SENSOR_PIN GPIO_PIN_9

int DROP_STATUS = 0; //  0 = Drop Fail, 1 = Drop Success
int DOOR_STATUS;     //  0 = Door Closed, 1 = Door Open
int MOTOR_STATUS = 0;// 0 = Motor Error, 1 = Motor Normal

/**************************** TEMPERATURE Sensor Value ****************************/

uint8_t Temp_byte1;
uint8_t Temp_byte2;
uint16_t TEMP;

float TEMPERATURE = 0; //TEMPERATURE value in Celcius
uint8_t Presence = 0;

/**************************** String and Hex Constant ****************************/

uint8_t SENSOR_REQUEST_STRING[3][7] = {{"tmpchck"}, {"dorchck"}, {"stachck"}};
uint8_t MOTOR_FIRST_STRING[2][3] = {{"sgl"}, {"tst"}};
uint8_t MOTOR_SECOND_STRING[6][1] = {{"A"}, {"B"}, {"C"}, {"D"}, {"E"}, {"F"}};
uint8_t MOTOR_THIRD_STRING[15][1] = {{"1"}, {"2"}, {"3"}, {"4"}, {"5"}, {"6"}, {"7"}, {"8"}, {"9"},
		{"A"}, {"B"}, {"C"}, {"D"}, {"E"}, {"F"}};

uint16_t STX = 0xFB; //start byte
uint16_t ENX = 0xFB; //end byte

uint16_t SINGLE_MOTOR_DISPENSING = 0x02;
uint16_t SINGLE_MOTOR_DISPENSING_MODE = 0x01;

uint16_t TEST_MOTOR_FUNCTION = 0x03;
uint16_t TEST_MOTOR_FUNCTION_MODE = 0x11;

uint16_t MOTOR_ROW[6] = {0x06, 0x05, 0x04, 0x03, 0x02, 0x01};
uint16_t MOTOR_COLUMN[10] = {0x0A, 0x09, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01};


/**************************** Single Motor Hex Return ****************************/

uint8_t DROP_SUCCESS[5] = {0xFB,  0x02,  0x05,  0x00,  0xFB};
uint8_t DROP_NOT_SUCCESS[5] = {0xFB,  0x02,  0x02,  0x00,  0xFB};
uint8_t MOTOR_ERROR[5] = {0xFB,  0x02,  0x00,  0x00,  0xFB};

/**************************** Test Motor Hex Return ****************************/

uint8_t TEST_MOTOR_NORMAL[5] = {0xFB,  0x03,  0x05,  0x00,  0xFB};
uint8_t TEST_MOTOR_ERROR[5] = {0xFB,  0x03,  0x00,  0x00,  0xFB};

/**************************** Milliseconds Delay Function ****************************/

void delay (uint32_t us)
{
    __HAL_TIM_SET_COUNTER(&htim1,0);
    while ((__HAL_TIM_GET_COUNTER(&htim1))<us);
}

/**************************** Set Pin as Input/Output for TEMPERATURE Sensor ****************************/

void Set_Pin_Output (GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin)
{
  GPIO_InitTypeDef GPIO_InitStruct = {0};
  GPIO_InitStruct.Pin = GPIO_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(GPIOx, &GPIO_InitStruct);
}

void Set_Pin_Input (GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin)
{
  GPIO_InitTypeDef GPIO_InitStruct = {0};
  GPIO_InitStruct.Pin = GPIO_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
}

/**************************** DS18B20/TEMPERATURE Sensor Functions ****************************/
#define DS18B20_PORT GPIOA
#define DS18B20_PIN GPIO_PIN_7

uint8_t DS18B20_Start (void)
{
	uint8_t Response = 0;
	Set_Pin_Output(DS18B20_PORT, DS18B20_PIN);   // set the pin as output
	HAL_GPIO_WritePin (DS18B20_PORT, DS18B20_PIN, 0);  // pull the pin low
	delay (480);   // delay according to datasheet

	Set_Pin_Input(DS18B20_PORT, DS18B20_PIN);    // set the pin as input
	delay (80);    // delay according to datasheet

	if (!(HAL_GPIO_ReadPin (DS18B20_PORT, DS18B20_PIN))) Response = 1;    // if the pin is low i.e the presence pulse is detected
	else Response = -1;

	delay (400); // 480 us delay totally.

	return Response;
}

void DS18B20_Write (uint8_t data)
{
	Set_Pin_Output(DS18B20_PORT, DS18B20_PIN);  // set as output

	for (int i=0; i<8; i++)
	{

		if ((data & (1<<i))!=0)  // if the bit is high
		{
			// write 1

			Set_Pin_Output(DS18B20_PORT, DS18B20_PIN);  // set as output
			HAL_GPIO_WritePin (DS18B20_PORT, DS18B20_PIN, 0);  // pull the pin LOW
			delay (1);  // wait for 1 us

			Set_Pin_Input(DS18B20_PORT, DS18B20_PIN);  // set as input
			delay (50);  // wait for 60 us
		}

		else  // if the bit is low
		{
			// write 0

			Set_Pin_Output(DS18B20_PORT, DS18B20_PIN);
			HAL_GPIO_WritePin (DS18B20_PORT, DS18B20_PIN, 0);  // pull the pin LOW
			delay (50);  // wait for 60 us

			Set_Pin_Input(DS18B20_PORT, DS18B20_PIN);
		}
	}
}

uint8_t DS18B20_Read (void)
{
	uint8_t value=0;
	Set_Pin_Input(DS18B20_PORT, DS18B20_PIN);

	for (int i=0;i<8;i++)
	{
		Set_Pin_Output(DS18B20_PORT, DS18B20_PIN);   // set as output

		HAL_GPIO_WritePin (DS18B20_PORT, DS18B20_PIN, 0);  // pull the data pin LOW
		delay (2);  // wait for 2 us

		Set_Pin_Input(DS18B20_PORT, DS18B20_PIN);  // set as input
		if (HAL_GPIO_ReadPin (DS18B20_PORT, DS18B20_PIN))  // if the pin is HIGH
		{
			value |= 1<<i;  // read = 1
		}
		delay (60);  // wait for 60 us
	}
	return value;
}

/**************************** UART CALLBACK FUNCTIONS ****************************/

int tx_to_DTU_enable = 0;
char TX_BUFF_TO_DTU[25]; //String from STM32 to DTU is sent using this buffer
uint16_t TX_COMMAND_TO_STC[6]; //Hex Command from STM32 to STC is sent using this buffer

void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)
{

}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart){
	if(huart->Instance==USART1)
	 {
  /**************************** UART Split ****************************/
		if(strncmp(RX_BUFF_FROM_DTU, SENSOR_REQUEST_STRING[0], 7) == 0 ||
					strncmp(RX_BUFF_FROM_DTU, SENSOR_REQUEST_STRING[1], 7) == 0 ||
					strncmp(RX_BUFF_FROM_DTU, SENSOR_REQUEST_STRING[2], 7) == 0){

			  tx_to_DTU_enable = 1;
		}
		else{
			  split_Command_from_DTU();
			  concat_Command_for_STC();
			/**************************** UART Transmit & Receive ****************************/
			  send_Command_to_STC();
		}
	 }

	if(huart->Instance==USART2)
	 {
		tx_to_DTU_enable = 1;
	 }

	HAL_UART_Receive_DMA(&huart2, RX_DATA_FROM_STC, 5); //restart the reception mode
	HAL_UART_Receive_IT(&huart1,RX_BUFF_FROM_DTU, 7);
}

/**************************** LOOPING FUNCTIONS ****************************/
/*-------WRITE & READ TEMPERATURE FUNCTION-------*/

void write_read_Temperature(){

	  Presence = DS18B20_Start();
	  HAL_Delay (1);
	  DS18B20_Write (0xCC);  // skip ROM
	  DS18B20_Write (0x44);  // convert t
	  HAL_Delay (800);

	  Presence = DS18B20_Start();
	  HAL_Delay(1);
	  DS18B20_Write (0xCC);  // skip ROM
	  DS18B20_Write (0xBE);  // Read Scratch-pad

	  Temp_byte1 = DS18B20_Read();
	  Temp_byte2 = DS18B20_Read();

	  TEMP = (Temp_byte2<<8)|Temp_byte1;
	  TEMPERATURE = (float)TEMP/16;
}

/*-------TRANSMITTING DATA TO DTU FUNCTION-------*/

void transmit_Data_to_DTU(){

	if (strcmp(RX_DATA_FROM_STC, DROP_SUCCESS) == 0){

		sprintf(TX_BUFF_TO_DTU, "sglsuccess_%.2f_%d_1_1", TEMPERATURE, DOOR_STATUS);
		for(int i = 0; i < sizeof(RX_DATA_FROM_STC); i++){
			RX_DATA_FROM_STC[i] = '\0';
		}
	}
	else if (strcmp(RX_DATA_FROM_STC, DROP_NOT_SUCCESS) == 0){

		sprintf(TX_BUFF_TO_DTU, "sglfail_%.2f_%d_0_1", TEMPERATURE, DOOR_STATUS);
		for(int i = 0; i < sizeof(RX_DATA_FROM_STC); i++){
			RX_DATA_FROM_STC[i] = '\0';
		}
	}
	else if (strcmp(RX_DATA_FROM_STC, MOTOR_ERROR) == 0){

		sprintf(TX_BUFF_TO_DTU, "sglmotorerror_%.2f_%d_0_0", TEMPERATURE, DOOR_STATUS);
		for(int i = 0; i < sizeof(RX_DATA_FROM_STC); i++){
			RX_DATA_FROM_STC[i] = '\0';
		}
	}
	else if (strcmp(RX_DATA_FROM_STC, TEST_MOTOR_NORMAL) == 0){

		sprintf(TX_BUFF_TO_DTU, "tstsuccess_%.2f_%d_0_1", TEMPERATURE, DOOR_STATUS);
		for(int i = 0; i < sizeof(RX_DATA_FROM_STC); i++){
			RX_DATA_FROM_STC[i] = '\0';
		}
	}
	else if (strcmp(RX_DATA_FROM_STC, TEST_MOTOR_ERROR) == 0){

		sprintf(TX_BUFF_TO_DTU, "tstmotorerror_%.2f_%d_0_0", TEMPERATURE, DOOR_STATUS);
		for(int i = 0; i < sizeof(RX_DATA_FROM_STC); i++){
			RX_DATA_FROM_STC[i] = '\0';
		}
	}
	else if (strncmp(RX_BUFF_FROM_DTU, SENSOR_REQUEST_STRING[0], 7) == 0){

		sprintf(TX_BUFF_TO_DTU, "tmpchck_%.2f_0_0_0", TEMPERATURE);
	}
	else if (strncmp(RX_BUFF_FROM_DTU, SENSOR_REQUEST_STRING[1], 7) == 0){

		sprintf(TX_BUFF_TO_DTU, "dorchck_0_%d_0_0", DOOR_STATUS);
	}
	else if (strncmp(RX_BUFF_FROM_DTU, SENSOR_REQUEST_STRING[2], 7) == 0){

		sprintf(TX_BUFF_TO_DTU, "stachck_%.2f_%d_0_0", TEMPERATURE, DOOR_STATUS);
	}
	else{

	}

	HAL_UART_Transmit_IT(&huart1, TX_BUFF_TO_DTU, sizeof(TX_BUFF_TO_DTU));

}

/**************************** FUNCTIONS THAT RUN IN UART CALLBACK FUNCTIONS ****************************/

void split_Command_from_DTU(){

	char *token;
	int j = 0;
	token = strtok(RX_BUFF_FROM_DTU, "_");

	while( token != NULL ) {
		printf( " %s\n", token );
		SPLIT_RX_BUFF_FROM_DTU[j++] = token;
		token = strtok(NULL, "_");
	}


}


void concat_Command_for_STC(){

	/************* Set First & End Hex Byte *************/
	TX_COMMAND_TO_STC[0] = STX;
	TX_COMMAND_TO_STC[5] = ENX;

	/************* Set Second & Fifth Hex Byte *************/

	if(strncmp(SPLIT_RX_BUFF_FROM_DTU[0], MOTOR_FIRST_STRING[0], 3) == 0){
		TX_COMMAND_TO_STC[1] = SINGLE_MOTOR_DISPENSING;// ------------------------>single motor dispensing = 0x02
		TX_COMMAND_TO_STC[4] = SINGLE_MOTOR_DISPENSING_MODE;// ------------------->spiral cargo mode with drop sensor = 0x01
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[0], MOTOR_FIRST_STRING[1], 3) == 0){
	    TX_COMMAND_TO_STC[1] = TEST_MOTOR_FUNCTION;// ---------------------------->test motor function = 0x03
	    TX_COMMAND_TO_STC[4] = TEST_MOTOR_FUNCTION_MODE;// ----------------------->test if spiral cargo motor not connected = 0x11
	}
	else{

	}

	/************* Set Third Hex Byte (Motor MOTOR_ROW)*************/
	if(strncmp(SPLIT_RX_BUFF_FROM_DTU[1], MOTOR_SECOND_STRING[0], 1) == 0){
		TX_COMMAND_TO_STC[2] = MOTOR_ROW[0];// ------------------------------------------>A = 0x06
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[1], MOTOR_SECOND_STRING[1], 1) == 0){
		TX_COMMAND_TO_STC[2] = MOTOR_ROW[1];// ------------------------------------------>B = 0x05
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[1], MOTOR_SECOND_STRING[2], 1) == 0){
		TX_COMMAND_TO_STC[2] = MOTOR_ROW[2];// ------------------------------------------>C = 0x04
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[1], MOTOR_SECOND_STRING[3], 1) == 0){
		TX_COMMAND_TO_STC[2] = MOTOR_ROW[3];// ------------------------------------------>D = 0x03
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[1], MOTOR_SECOND_STRING[4], 1) == 0){
		TX_COMMAND_TO_STC[2] = MOTOR_ROW[4];// ------------------------------------------>E = 0x02
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[1], MOTOR_SECOND_STRING[5], 1) == 0){
		TX_COMMAND_TO_STC[2] = MOTOR_ROW[5];// ------------------------------------------>F = 0x01
	}
	else{

	}

	/************* Set Fourth Hex Byte (Motor MOTOR_COLUMN)*************/

	if(strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[0], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[0];// ------------------------------------------>1 = 0x0A
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[1], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[1];// ------------------------------------------>2 = 0x09
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[2], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[2];// ------------------------------------------>3 = 0x08
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[3], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[3];// ------------------------------------------>4 = 0x07
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[4], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[4];// ------------------------------------------>5 = 0x06
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[5], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[5];// ------------------------------------------>6 = 0x05
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[6], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[6];// ------------------------------------------>7 = 0x04
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[7], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[7];// ------------------------------------------>8 = 0x03
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[8], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[8];// ------------------------------------------>9 = 0x02
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[9], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[9];// ------------------------------------------>A = 0x01 for AA / 10A
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[10], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[9];// ------------------------------------------>B = 0x01 for BB / 10B
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[11], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[9];// ------------------------------------------>C = 0x01 for CC / 10C
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[12], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[9];// ------------------------------------------>D = 0x01 for DD / 10D
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[13], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[9];// ------------------------------------------>E = 0x01 for EE / 10E
	}
	else if (strncmp(SPLIT_RX_BUFF_FROM_DTU[2], MOTOR_THIRD_STRING[14], 1) == 0){
		TX_COMMAND_TO_STC[3] = MOTOR_COLUMN[9];// ------------------------------------------>F = 0x01 for FF / 10F
	}
	else{

	}

}

void send_Command_to_STC(void){

	HAL_UART_Transmit_IT(&huart2, TX_COMMAND_TO_STC, 6);
}


/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_DMA_Init();
  MX_USART1_UART_Init();
  MX_USART2_UART_Init();
  MX_TIM1_Init();
  /* USER CODE BEGIN 2 */
  HAL_TIM_Base_Start(&htim1);
  HAL_UART_Receive_DMA(&huart2, RX_DATA_FROM_STC, 5);
  HAL_UART_Receive_IT(&huart1,RX_BUFF_FROM_DTU, 7);
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
    /* USER CODE END WHILE */
	  if(tx_to_DTU_enable == 1){
		  transmit_Data_to_DTU();
		  tx_to_DTU_enable = 0;
	  }
	  write_read_Temperature();
    /* USER CODE BEGIN 3 */
  }
  /* USER CODE END 3 */
}

// External Interrupt ISR Handler CallBackFun
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
    if(GPIO_Pin == DOOR_SENSOR_PIN) // INT Source is pin A9
    {
    	if(HAL_GPIO_ReadPin(DOOR_SENSOR_PORT, DOOR_SENSOR_PIN) == GPIO_PIN_RESET){
    		DOOR_STATUS = 1;
		}
		else{
			DOOR_STATUS = 0;
		}
    }
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }

  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    Error_Handler();
  }
}

/**
  * @brief TIM1 Initialization Function
  * @param None
  * @retval None
  */
static void MX_TIM1_Init(void)
{

  /* USER CODE BEGIN TIM1_Init 0 */

  /* USER CODE END TIM1_Init 0 */

  TIM_ClockConfigTypeDef sClockSourceConfig = {0};
  TIM_MasterConfigTypeDef sMasterConfig = {0};

  /* USER CODE BEGIN TIM1_Init 1 */

  /* USER CODE END TIM1_Init 1 */
  htim1.Instance = TIM1;
  htim1.Init.Prescaler = 72-1;
  htim1.Init.CounterMode = TIM_COUNTERMODE_UP;
  htim1.Init.Period = 0xffff-1;
  htim1.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
  htim1.Init.RepetitionCounter = 0;
  htim1.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
  if (HAL_TIM_Base_Init(&htim1) != HAL_OK)
  {
    Error_Handler();
  }
  sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;
  if (HAL_TIM_ConfigClockSource(&htim1, &sClockSourceConfig) != HAL_OK)
  {
    Error_Handler();
  }
  sMasterConfig.MasterOutputTrigger = TIM_TRGO_RESET;
  sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
  if (HAL_TIMEx_MasterConfigSynchronization(&htim1, &sMasterConfig) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN TIM1_Init 2 */

  /* USER CODE END TIM1_Init 2 */

}

/**
  * @brief USART1 Initialization Function
  * @param None
  * @retval None
  */
static void MX_USART1_UART_Init(void)
{

  /* USER CODE BEGIN USART1_Init 0 */

  /* USER CODE END USART1_Init 0 */

  /* USER CODE BEGIN USART1_Init 1 */

  /* USER CODE END USART1_Init 1 */
  huart1.Instance = USART1;
  huart1.Init.BaudRate = 115200;
  huart1.Init.WordLength = UART_WORDLENGTH_8B;
  huart1.Init.StopBits = UART_STOPBITS_1;
  huart1.Init.Parity = UART_PARITY_NONE;
  huart1.Init.Mode = UART_MODE_TX_RX;
  huart1.Init.HwFlowCtl = UART_HWCONTROL_NONE;
  huart1.Init.OverSampling = UART_OVERSAMPLING_16;
  if (HAL_UART_Init(&huart1) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN USART1_Init 2 */

  /* USER CODE END USART1_Init 2 */

}

/**
  * @brief USART2 Initialization Function
  * @param None
  * @retval None
  */
static void MX_USART2_UART_Init(void)
{

  /* USER CODE BEGIN USART2_Init 0 */

  /* USER CODE END USART2_Init 0 */

  /* USER CODE BEGIN USART2_Init 1 */

  /* USER CODE END USART2_Init 1 */
  huart2.Instance = USART2;
  huart2.Init.BaudRate = 9600;
  huart2.Init.WordLength = UART_WORDLENGTH_9B;
  huart2.Init.StopBits = UART_STOPBITS_1;
  huart2.Init.Parity = UART_PARITY_NONE;
  huart2.Init.Mode = UART_MODE_TX_RX;
  huart2.Init.HwFlowCtl = UART_HWCONTROL_NONE;
  huart2.Init.OverSampling = UART_OVERSAMPLING_16;
  if (HAL_UART_Init(&huart2) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN USART2_Init 2 */

  /* USER CODE END USART2_Init 2 */

}

/**
  * Enable DMA controller clock
  */
static void MX_DMA_Init(void)
{

  /* DMA controller clock enable */
  __HAL_RCC_DMA1_CLK_ENABLE();

  /* DMA interrupt init */
  /* DMA1_Channel4_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(DMA1_Channel4_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(DMA1_Channel4_IRQn);
  /* DMA1_Channel5_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(DMA1_Channel5_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(DMA1_Channel5_IRQn);
  /* DMA1_Channel6_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(DMA1_Channel6_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(DMA1_Channel6_IRQn);
  /* DMA1_Channel7_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(DMA1_Channel7_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(DMA1_Channel7_IRQn);

}

/**
  * @brief GPIO Initialization Function
  * @param None
  * @retval None
  */
static void MX_GPIO_Init(void)
{
  GPIO_InitTypeDef GPIO_InitStruct = {0};

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOD_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GPIOA, GPIO_PIN_7, GPIO_PIN_RESET);

  /*Configure GPIO pin : PA7 */
  GPIO_InitStruct.Pin = GPIO_PIN_7;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /*Configure GPIO pin : PB9 */
  GPIO_InitStruct.Pin = GPIO_PIN_9;
  GPIO_InitStruct.Mode = GPIO_MODE_IT_RISING_FALLING;
  GPIO_InitStruct.Pull = GPIO_PULLUP;
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);

  /* EXTI interrupt init*/
  HAL_NVIC_SetPriority(EXTI9_5_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(EXTI9_5_IRQn);

}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */
