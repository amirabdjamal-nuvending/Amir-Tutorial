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
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */
uint16_t dropSensor[6] = {0x1FB,  0x104,  0x100,  0x100,  0x100,  0x1FB};
uint16_t dropSensor2[6] = {0x1FB,  0x106,  0x100,  0x100,  0x100,  0x1FB};
uint16_t dropSensor3[6] = {0x1FB,  0x154,  0x100,  0x100,  0x100,  0x1FB};
uint16_t dropSensor4[6] = {0x1FB,  0x155,  0x100,  0x100,  0x100,  0x1FB};

uint16_t A1_Drop[6] = {0x1FB,  0x102,  0x106,  0x10A,  0x101,  0x1FB};

uint16_t A1[6] = {0x1FB,  0x103,  0x106,  0x10A,  0x111,  0x1FB};
uint16_t A2[6] = {0x1FB,  0x103,  0x106,  0x109,  0x111,  0x1FB};
uint16_t A3[6] = {0x1FB,  0x103,  0x106,  0x108,  0x111,  0x1FB};
uint16_t A4[6] = {0x1FB,  0x103,  0x106,  0x107,  0x111,  0x1FB};
uint16_t A5[6] = {0x1FB,  0x103,  0x106,  0x106,  0x111,  0x1FB};
uint16_t A6[6] = {0x1FB,  0x103,  0x106,  0x105,  0x111,  0x1FB};
uint16_t A7[6] = {0x1FB,  0x103,  0x106,  0x104,  0x111,  0x1FB};
uint16_t A8[6] = {0x1FB,  0x103,  0x106,  0x103,  0x111,  0x1FB};
uint16_t A9[6] = {0x1FB,  0x103,  0x106,  0x102,  0x111,  0x1FB};
uint16_t A10[6] ={0x1FB,  0x103,  0x106,  0x101,  0x111,  0x1FB};
uint16_t B1[6] = {0x1FB,  0x103,  0x105,  0x10A,  0x111,  0x1FB};
uint16_t B2[6] = {0x1FB,  0x103,  0x105,  0x109,  0x111,  0x1FB};
uint16_t B3[6] = {0x1FB,  0x103,  0x105,  0x108,  0x111,  0x1FB};
uint16_t B4[6] = {0x1FB,  0x103,  0x105,  0x107,  0x111,  0x1FB};
uint16_t B5[6] = {0x1FB,  0x103,  0x105,  0x106,  0x111,  0x1FB};
uint16_t B6[6] = {0x1FB,  0x103,  0x105,  0x105,  0x111,  0x1FB};
uint16_t B7[6] = {0x1FB,  0x103,  0x105,  0x104,  0x111,  0x1FB};
uint16_t B8[6] = {0x1FB,  0x103,  0x105,  0x103,  0x111,  0x1FB};
uint16_t B9[6] = {0x1FB,  0x103,  0x105,  0x102,  0x111,  0x1FB};
uint16_t B10[6] ={0x1FB,  0x103,  0x105,  0x101,  0x111,  0x1FB};
uint16_t C1[6] = {0x1FB,  0x103,  0x104,  0x10A,  0x111,  0x1FB};
uint16_t C2[6] = {0x1FB,  0x103,  0x104,  0x109,  0x111,  0x1FB};
uint16_t C3[6] = {0x1FB,  0x103,  0x104,  0x108,  0x111,  0x1FB};
uint16_t C4[6] = {0x1FB,  0x103,  0x104,  0x107,  0x111,  0x1FB};
uint16_t C5[6] = {0x1FB,  0x103,  0x104,  0x106,  0x111,  0x1FB};
uint16_t C6[6] = {0x1FB,  0x103,  0x104,  0x105,  0x111,  0x1FB};
uint16_t C7[6] = {0x1FB,  0x103,  0x104,  0x104,  0x111,  0x1FB};
uint16_t C8[6] = {0x1FB,  0x103,  0x104,  0x103,  0x111,  0x1FB};
uint16_t C9[6] = {0x1FB,  0x103,  0x104,  0x102,  0x111,  0x1FB};
uint16_t C10[6] ={0x1FB,  0x103,  0x104,  0x101,  0x111,  0x1FB};
uint16_t D1[6] = {0x1FB,  0x103,  0x103,  0x10A,  0x111,  0x1FB};
uint16_t D2[6] = {0x1FB,  0x103,  0x103,  0x109,  0x111,  0x1FB};
uint16_t D3[6] = {0x1FB,  0x103,  0x103,  0x108,  0x111,  0x1FB};
uint16_t D4[6] = {0x1FB,  0x103,  0x103,  0x107,  0x111,  0x1FB};
uint16_t D5[6] = {0x1FB,  0x103,  0x103,  0x106,  0x111,  0x1FB};
uint16_t D6[6] = {0x1FB,  0x103,  0x103,  0x105,  0x111,  0x1FB};
uint16_t D7[6] = {0x1FB,  0x103,  0x103,  0x104,  0x111,  0x1FB};
uint16_t D8[6] = {0x1FB,  0x103,  0x103,  0x103,  0x111,  0x1FB};
uint16_t D9[6] = {0x1FB,  0x103,  0x103,  0x102,  0x111,  0x1FB};
uint16_t D10[6] ={0x1FB,  0x103,  0x103,  0x101,  0x111,  0x1FB};
uint16_t E1[6] = {0x1FB,  0x103,  0x102,  0x10A,  0x111,  0x1FB};
uint16_t E2[6] = {0x1FB,  0x103,  0x102,  0x109,  0x111,  0x1FB};
uint16_t E3[6] = {0x1FB,  0x103,  0x102,  0x108,  0x111,  0x1FB};
uint16_t E4[6] = {0x1FB,  0x103,  0x102,  0x107,  0x111,  0x1FB};
uint16_t E5[6] = {0x1FB,  0x103,  0x102,  0x106,  0x111,  0x1FB};
uint16_t E6[6] = {0x1FB,  0x103,  0x102,  0x105,  0x111,  0x1FB};
uint16_t E7[6] = {0x1FB,  0x103,  0x102,  0x104,  0x111,  0x1FB};
uint16_t E8[6] = {0x1FB,  0x103,  0x102,  0x103,  0x111,  0x1FB};
uint16_t E9[6] = {0x1FB,  0x103,  0x102,  0x102,  0x111,  0x1FB};
uint16_t E10[6] ={0x1FB,  0x103,  0x102,  0x101,  0x111,  0x1FB};
uint16_t F1[6] = {0x1FB,  0x103,  0x101,  0x10A,  0x111,  0x1FB};
uint16_t F2[6] = {0x1FB,  0x103,  0x101,  0x109,  0x111,  0x1FB};
uint16_t F3[6] = {0x1FB,  0x103,  0x101,  0x108,  0x111,  0x1FB};
uint16_t F4[6] = {0x1FB,  0x103,  0x101,  0x107,  0x111,  0x1FB};
uint16_t F5[6] = {0x1FB,  0x103,  0x101,  0x106,  0x111,  0x1FB};
uint16_t F6[6] = {0x1FB,  0x103,  0x101,  0x105,  0x111,  0x1FB};
uint16_t F7[6] = {0x1FB,  0x103,  0x101,  0x104,  0x111,  0x1FB};
uint16_t F8[6] = {0x1FB,  0x103,  0x101,  0x103,  0x111,  0x1FB};
uint16_t F9[6] = {0x1FB,  0x103,  0x101,  0x102,  0x111,  0x1FB};
uint16_t F10[6] ={0x1FB,  0x103,  0x101,  0x101,  0x111,  0x1FB};

void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)
{
	//HAL_UART_Transmit_IT(&huart2, Tx_data, sizeof(Tx_data));
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
  /* USER CODE BEGIN 2 */
  //HAL_UART_Receive_DMA(&huart2, Rx_data, 5);
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
    /* USER CODE END WHILE */
	  HAL_UART_Transmit_IT(&huart2, (uint8_t *)A1_NoDrop, 6);
	  HAL_Delay(10000);
//	  HAL_UART_Transmit_IT(&huart2, (uint8_t *)dropSensor, 6);
//	  HAL_Delay(2000);
//	  HAL_UART_Transmit_IT(&huart2, (uint8_t *)dropSensor2, 6);
//	  HAL_Delay(2000);
//	  HAL_UART_Transmit_IT(&huart2, (uint8_t *)dropSensor3, 6);
//	  HAL_Delay(2000);
	 // HAL_UART_Transmit_IT(&huart2, (uint8_t *)dropSensor4, 6);
	 // HAL_Delay(2000);
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
