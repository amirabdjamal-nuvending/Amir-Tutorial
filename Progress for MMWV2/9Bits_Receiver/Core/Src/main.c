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
#include "stdlib.h"
#include "string.h"

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
 UART_HandleTypeDef huart1;
UART_HandleTypeDef huart2;
DMA_HandleTypeDef hdma_usart2_rx;
DMA_HandleTypeDef hdma_usart2_tx;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_DMA_Init(void);
static void MX_USART2_UART_Init(void);
static void MX_USART1_UART_Init(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

uint8_t Rx_data_from_stc[5];
uint8_t receivedData4G[2];
uint8_t Transmit_To_DTU;

uint8_t Drop_Success[5] = {0x0FB,  0x002,  0x005,  0x000,  0x0FB};
uint8_t Drop_Not_Success[5] = {0x0FB,  0x002,  0x002,  0x000,  0x0FB};
uint8_t Motor_Error[5] = {0x0FB,  0x002,  0x000,  0x000,  0x0FB};

uint8_t dapat[2];


uint16_t A1[6] = {0x1FB,  0x102,  0x106,  0x10A,  0x101,  0x1FB};
uint16_t A2[6] = {0x1FB,  0x102,  0x106,  0x109,  0x101,  0x1FB};
uint16_t A3[6] = {0x1FB,  0x102,  0x106,  0x108,  0x101,  0x1FB};
uint16_t A4[6] = {0x1FB,  0x102,  0x106,  0x107,  0x101,  0x1FB};
uint16_t A5[6] = {0x1FB,  0x102,  0x106,  0x106,  0x101,  0x1FB};
uint16_t A6[6] = {0x1FB,  0x102,  0x106,  0x105,  0x101,  0x1FB};
uint16_t A7[6] = {0x1FB,  0x102,  0x106,  0x104,  0x101,  0x1FB};
uint16_t A8[6] = {0x1FB,  0x102,  0x106,  0x103,  0x101,  0x1FB};
uint16_t A9[6] = {0x1FB,  0x102,  0x106,  0x102,  0x101,  0x1FB};
uint16_t A10[6] ={0x1FB,  0x102,  0x106,  0x101,  0x101,  0x1FB};
uint16_t B1[6] = {0x1FB,  0x102,  0x105,  0x10A,  0x101,  0x1FB};
uint16_t B2[6] = {0x1FB,  0x102,  0x105,  0x109,  0x101,  0x1FB};
uint16_t B3[6] = {0x1FB,  0x102,  0x105,  0x108,  0x101,  0x1FB};
uint16_t B4[6] = {0x1FB,  0x102,  0x105,  0x107,  0x101,  0x1FB};
uint16_t B5[6] = {0x1FB,  0x102,  0x105,  0x106,  0x101,  0x1FB};
uint16_t B6[6] = {0x1FB,  0x102,  0x105,  0x105,  0x101,  0x1FB};
uint16_t B7[6] = {0x1FB,  0x102,  0x105,  0x104,  0x101,  0x1FB};
uint16_t B8[6] = {0x1FB,  0x102,  0x105,  0x103,  0x101,  0x1FB};
uint16_t B9[6] = {0x1FB,  0x102,  0x105,  0x102,  0x101,  0x1FB};
uint16_t B10[6] ={0x1FB,  0x102,  0x105,  0x101,  0x101,  0x1FB};
uint16_t C1[6] = {0x1FB,  0x102,  0x104,  0x10A,  0x101,  0x1FB};
uint16_t C2[6] = {0x1FB,  0x102,  0x104,  0x109,  0x101,  0x1FB};
uint16_t C3[6] = {0x1FB,  0x102,  0x104,  0x108,  0x101,  0x1FB};
uint16_t C4[6] = {0x1FB,  0x102,  0x104,  0x107,  0x101,  0x1FB};
uint16_t C5[6] = {0x1FB,  0x102,  0x104,  0x106,  0x101,  0x1FB};
uint16_t C6[6] = {0x1FB,  0x102,  0x104,  0x105,  0x101,  0x1FB};
uint16_t C7[6] = {0x1FB,  0x102,  0x104,  0x104,  0x101,  0x1FB};
uint16_t C8[6] = {0x1FB,  0x102,  0x104,  0x103,  0x101,  0x1FB};
uint16_t C9[6] = {0x1FB,  0x102,  0x104,  0x102,  0x101,  0x1FB};
uint16_t C10[6] ={0x1FB,  0x102,  0x104,  0x101,  0x101,  0x1FB};
uint16_t D1[6] = {0x1FB,  0x102,  0x103,  0x10A,  0x101,  0x1FB};
uint16_t D2[6] = {0x1FB,  0x102,  0x103,  0x109,  0x101,  0x1FB};
uint16_t D3[6] = {0x1FB,  0x102,  0x103,  0x108,  0x101,  0x1FB};
uint16_t D4[6] = {0x1FB,  0x102,  0x103,  0x107,  0x101,  0x1FB};
uint16_t D5[6] = {0x1FB,  0x102,  0x103,  0x106,  0x101,  0x1FB};
uint16_t D6[6] = {0x1FB,  0x102,  0x103,  0x105,  0x101,  0x1FB};
uint16_t D7[6] = {0x1FB,  0x102,  0x103,  0x104,  0x101,  0x1FB};
uint16_t D8[6] = {0x1FB,  0x102,  0x103,  0x103,  0x101,  0x1FB};
uint16_t D9[6] = {0x1FB,  0x102,  0x103,  0x102,  0x101,  0x1FB};
uint16_t D10[6] ={0x1FB,  0x102,  0x103,  0x101,  0x101,  0x1FB};
uint16_t E1[6] = {0x1FB,  0x102,  0x102,  0x10A,  0x101,  0x1FB};
uint16_t E2[6] = {0x1FB,  0x102,  0x102,  0x109,  0x101,  0x1FB};
uint16_t E3[6] = {0x1FB,  0x102,  0x102,  0x108,  0x101,  0x1FB};
uint16_t E4[6] = {0x1FB,  0x102,  0x102,  0x107,  0x101,  0x1FB};
uint16_t E5[6] = {0x1FB,  0x102,  0x102,  0x106,  0x101,  0x1FB};
uint16_t E6[6] = {0x1FB,  0x102,  0x102,  0x105,  0x101,  0x1FB};
uint16_t E7[6] = {0x1FB,  0x102,  0x102,  0x104,  0x101,  0x1FB};
uint16_t E8[6] = {0x1FB,  0x102,  0x102,  0x103,  0x101,  0x1FB};
uint16_t E9[6] = {0x1FB,  0x102,  0x102,  0x102,  0x101,  0x1FB};
uint16_t E10[6] ={0x1FB,  0x102,  0x102,  0x101,  0x101,  0x1FB};
uint16_t F1[6] = {0x1FB,  0x102,  0x101,  0x10A,  0x101,  0x1FB};
uint16_t F2[6] = {0x1FB,  0x102,  0x101,  0x109,  0x101,  0x1FB};
uint16_t F3[6] = {0x1FB,  0x102,  0x101,  0x108,  0x101,  0x1FB};
uint16_t F4[6] = {0x1FB,  0x102,  0x101,  0x107,  0x101,  0x1FB};
uint16_t F5[6] = {0x1FB,  0x102,  0x101,  0x106,  0x101,  0x1FB};
uint16_t F6[6] = {0x1FB,  0x102,  0x101,  0x105,  0x101,  0x1FB};
uint16_t F7[6] = {0x1FB,  0x102,  0x101,  0x104,  0x101,  0x1FB};
uint16_t F8[6] = {0x1FB,  0x102,  0x101,  0x103,  0x101,  0x1FB};
uint16_t F9[6] = {0x1FB,  0x102,  0x101,  0x102,  0x101,  0x1FB};
uint16_t F10[6] ={0x1FB,  0x102,  0x101,  0x101,  0x101,  0x1FB};

void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)
{
	//HAL_UART_Transmit_IT(&huart2, Tx_data, sizeof(Tx_data));
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{
	HAL_UART_Receive_DMA(&huart2, Rx_data_from_stc, 5); //restart the interupt reception mode
	if (strcmp(Rx_data_from_stc, Drop_Success) == 0){
		HAL_UART_Transmit_IT(&huart1, "Hi\n", sizeof("Hi\n"));
		dapat[0] = 2;
		dapat[1] = 2;
	}
	else if (strcmp(Rx_data_from_stc, Drop_Not_Success) == 0){
		HAL_UART_Transmit_IT(&huart1, "AAAAAAAAAAA", 5);
		dapat[0] = 3;
		dapat[1] = 3;
	}
	else if (strcmp(Rx_data_from_stc, Drop_Not_Success) == 0){
		HAL_UART_Transmit_IT(&huart1, "BBBBBB", 5);
		dapat[0] = 4;
		dapat[1] = 4;
	}
	else{

	}


}

void receive_transmit_command(void){

	HAL_UART_Receive_IT(&huart1,receivedData4G, 2);

	/////TRAY A/////
	if(strcmp(receivedData4G, "A1") == 0){       		//A1
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)A1, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	}

	 else if (strcmp(receivedData4G, "A2") == 0){       //A2
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)A2, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "A3") == 0){       //A3
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)A3, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "A4") == 0){       //A4
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)A4, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "A5") == 0){       //A5
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)A5, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "A6") == 0){       //A6
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)A6, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "A7") == 0){       //A7
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)A7, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "A8") == 0){       //A8
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)A8, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "A9") == 0){       //A9
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)A9, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "AA") == 0){       //A10
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)A10, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 /////TRAY B/////
	 else if (strcmp(receivedData4G, "B1") == 0){       //B1
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)B1, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "B2") == 0){       //B2
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)B2, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "B3") == 0){       //B3
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)B3, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "B4") == 0){       //B4
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)B4, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "B5") == 0){       //B5
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)B5, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "B6") == 0){       //B6
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)B6, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "B7") == 0){       //B7
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)B7, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "B8") == 0){       //B8
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)B8, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "B9") == 0){       //B9
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)B9, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "BB") == 0){       //B10
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)B10, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 /////TRAY C/////
	 else if (strcmp(receivedData4G, "C1") == 0){       //C1
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)C1, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "C2") == 0){       //C2
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)C2, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "C3") == 0){       //C3
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)C3, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "C4") == 0){       //C4
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)C4, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "C5") == 0){       //C5
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)C5, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "C6") == 0){       //C6
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)C6, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "C7") == 0){       //C7
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)C7, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "C8") == 0){       //C8
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)C8, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "C9") == 0){       //C9
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)C9, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "CC") == 0){       //C10
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)C10, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 /////TRAY D/////
	 else if (strcmp(receivedData4G, "D1") == 0){       //D1
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)D1, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "D2") == 0){       //D2
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)D2, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "D3") == 0){       //D3
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)D3, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "D4") == 0){       //D4
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)D4, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "D5") == 0){       //D5
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)D5, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "D6") == 0){       //D6
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)D6, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "D7") == 0){       //D7
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)D7, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "D8") == 0){       //D8
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)D8, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "D9") == 0){       //D9
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)D9, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "DD") == 0){       //D10
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)D10, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 /////TRAY E/////
	 else if (strcmp(receivedData4G, "E1") == 0){       //E1
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)E1, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "E2") == 0){       //E2
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)E2, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "E3") == 0){       //E3
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)E3, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "E4") == 0){       //E4
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)E4, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "E5") == 0){       //E5
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)E5, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "E6") == 0){       //E6
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)E6, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "E7") == 0){       //E7
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)E7, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "E8") == 0){       //E8
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)E8, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "E9") == 0){       //E9
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)E9, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "EE") == 0){       //E10
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)E10, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 /////TRAY F/////
	 else if (strcmp(receivedData4G, "F1") == 0){       //F1
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)F1, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "F2") == 0){       //F2
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)F2, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "F3") == 0){       //F3
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)F3, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "F4") == 0){       //F4
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)F4, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "F5") == 0){       //F5
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)F5, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "F6") == 0){       //F6
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)F6, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "F7") == 0){       //F7
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)F7, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "F8") == 0){       //F8
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)F8, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "F9") == 0){       //F9
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)F9, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }
	 else if (strcmp(receivedData4G, "FF") == 0){       //F10
	     HAL_UART_Transmit_IT(&huart2, (uint8_t *)F10, 6);
	     HAL_Delay(2000);
	     receivedData4G[0] = 0;
	     receivedData4G[1] = 0;
	  }

	 else {
//		 char buffer[16];
//		 HAL_UART_Transmit(&huart1, (uint8_t*)buffer, sprintf(buffer, "%s", invalidCommand), 500);
//		 receivedData4G[0] = 0;
//		 receivedData4G[1] = 0;
	 }

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
  MX_USART2_UART_Init();
  MX_USART1_UART_Init();
  /* USER CODE BEGIN 2 */
//  HAL_UART_Transmit_IT(&huart2, (uint8_t *)A1, 6);
//  HAL_Delay(2000);

//  HAL_UART_Receive_DMA(&huart2, Rx_data, 20);
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
    /* USER CODE END WHILE */
//	  HAL_UART_Receive_DMA(&huart2, Rx_data, 20);
	  receive_transmit_command();
    /* USER CODE BEGIN 3 */
  }
  /* USER CODE END 3 */
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

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOD_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();

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
