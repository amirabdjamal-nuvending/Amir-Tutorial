--[[This code purpose to Run All Motor]]

module(...,package.seeall)

require"utils"
require"pm"
require"mqttOutMsg"

local uartID = 1



local function test_timer()
    sys.wait(3000)
end

local MQTTData = " "
local InputData = " "

function Run(RecData)
    print(RecData)
    MQTTData = RecData
    print(MQTTData)
end

local function Run_All()
    while true do

        --pm.wake("UART_SENT2MCU")
        --uart.on(uartID)
        --uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
        local SINGLE_MOTOR_DISPENSE = "single_"
        local TEST_MOTOR = "test_"
        -- ##### TRAY A #####
        local A1 = "A_1" --FC 02 Row Column xx FB where xx is mode
        local A2 = "A_2"
        local A3 = "A_3"
        local A4 = "A_4"
        local A5 = "A_5"
        local A6 = "A_6"
        local A7 = "A_7"
        local A8 = "A_8"
        local A9 = "A_9"
        local A10 ="A_A"
        
        -- ##### TRAY B #####
        local B1 = "B_1" 
        local B2 = "B_2"
        local B3 = "B_3"
        local B4 = "B_4"
        local B5 = "B_5"
        local B6 = "B_6"
        local B7 = "B_7"
        local B8 = "B_8"
        local B9 = "B_9"
        local B10 ="B_B"
        
        -- ##### TRAY C #####
        local C1 = "C_1" 
        local C2 = "C_2"
        local C3 = "C_3"
        local C4 = "C_4"
        local C5 = "C_5"
        local C6 = "C_6"
        local C7 = "C_7"
        local C8 = "C_8"
        local C9 = "C_9"
        local C10 ="C_C"
        
        -- ##### TRAY D #####
        local D1 = "D_1" 
        local D2 = "D_2"
        local D3 = "D_3"
        local D4 = "D_4"
        local D5 = "D_5"
        local D6 = "D_6"
        local D7 = "D_7"
        local D8 = "D_8"
        local D9 = "D_9"
        local D10 ="D_D"
        
        -- ##### TRAY E #####
        local E1 = "E_1" 
        local E2 = "E_2"
        local E3 = "E_3"
        local E4 = "E_4"
        local E5 = "E_5"
        local E6 = "E_6"
        local E7 = "E_7"
        local E8 = "E_8"
        local E9 = "E_9"
        local E10 ="E_E"
        
        -- ##### TRAY F #####
        local F1 = "F_1"
        local F2 = "F_2"
        local F3 = "F_3"
        local F4 = "F_4"
        local F5 = "F_5"
        local F6 = "F_6"
        local F7 = "F_7"
        local F8 = "F_8"
        local F9 = "F_9"
        local F10 ="F_F"
        
        pm.wake("UART_SENT2MCU")
        uart.on(uartID)
        uart.setup(uartID,115200,8,uart.PAR_NONE,uart.STOP_1,nil,1)
        --uart.set_buffer(uartID,255)
        local InputDrop = uart.read(uartID, "*l")
        --local InputTemp = uart.read(uartID, "*l")
        --uart.close(uartID)
        --print("DROP --->  " ..InputDrop)
        --print("TEMPERATURE --->  " ..InputDrop)
        local Temp = InputDrop
        
        InputData = MQTTData
        --print("INPUT MQTT --->  "..InputData)
        --print("-----------------------------------")
        
        if(InputDrop == "Hi\n") then
            print("Input "..InputDrop)
            -- Calling function to sending data to DB
            mqttOutMsg.PubQos0Drop()
            print("--> Drop <-- ")
    
        
        elseif string.match(InputData , "A1") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..A1)
            print("UART TX = A1")
            MQTTData = " "
            

        elseif string.match(InputData , "B1") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..B1)
            print("UART TX = B1")
            MQTTData = " "
        
        elseif string.match(InputData , "C1") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..C1)
            print ("UART TX = C1")
            MQTTData = " "
        
        elseif string.match(InputData , "D1") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..D1)
            print ("UART TX = D1")
            MQTTData = " "
        
        elseif string.match(InputData , "E1") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..E1)
            print ("UART TX = E1")
            MQTTData = " "
        
        elseif string.match(InputData , "F1") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..F1)
            print ("UART TX = F1")
            MQTTData = " "
        
    -- ===========================================================
        -- ########## COLOUM 2 / B ##########
    -- ===========================================================
        elseif string.match(InputData , "A2") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..A2)
            print ("UART TX = A2")
            MQTTData = " "
        
        elseif string.match(InputData , "B2") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..B2)
            print ("UART TX = B2")
            MQTTData = " "
        
        elseif string.match(InputData , "C2") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..C2)
            print ("UART TX = C2")
            MQTTData = " "
        
        elseif string.match(InputData , "D2") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..D2)
            print ("UART TX = D2")
            MQTTData = " "
        
        elseif string.match(InputData , "E2") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..E2)
            print ("UART TX = E5")
            MQTTData = " "
        
        elseif string.match(InputData , "F2") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..F2)
            print ("UART TX = F2")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 3 / C ##########
    -- ===========================================================
        elseif string.match(InputData , "A3") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..A3)
            print ("UART TX = A3")
            MQTTData = " "

        elseif string.match(InputData , "B3") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..B3)
            print ("UART TX = B3")
            MQTTData = " "

        elseif string.match(InputData , "C3") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..C3)
            print ("UART TX = C3")
            MQTTData = " "
            
        elseif string.match(InputData , "D3") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..D3)
            print ("UART TX = D3")
            MQTTData = " "
        
        elseif string.match(InputData , "E3") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..E3)
            print ("UART TX = E3")
            MQTTData = " "

        elseif string.match(InputData , "F3") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..F3)
            print ("UART TX = F3")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 4 / D ##########
    -- ===========================================================
        elseif string.match(InputData , "A4") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..A4)
            print ("UART TX = A4")
            MQTTData = " "

        elseif string.match(InputData , "B4") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..B4)
            print ("UART TX = B4")
            MQTTData = " "

        elseif string.match(InputData , "C4") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..C4)
            print ("UART TX = C4")
            MQTTData = " "
            
        elseif string.match(InputData , "D4") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..D4)
            print ("UART TX = D4")
            MQTTData = " "

        elseif string.match(InputData , "E4") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..E4)
            print ("UART TX = E4")
            MQTTData = " "

        elseif string.match(InputData , "F4") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..F4)
            print ("UART TX = F4")
            MQTTData = " "
        
    -- ===========================================================
        -- ########## COLOUM 5 / E ##########
    -- ===========================================================
        elseif string.match(InputData , "A5") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..A5)
            print ("UART TX = A5")
            MQTTData = " "
            
        elseif string.match(InputData , "B5") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..B5)
            print ("UART TX = B5")
            MQTTData = " "

        elseif string.match(InputData , "C5") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..C5)
            print ("UART TX = C5")
            MQTTData = " "

        elseif string.match(InputData , "D5") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..D5)
            print ("UART TX = D5")
            MQTTData = " "

        elseif string.match(InputData , "E5") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..E5)
            print ("UART TX = E5")
            MQTTData = " "

        elseif string.match(InputData , "F5") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..F5)
            print ("UART TX = F5")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 6 / F ##########
    -- ===========================================================
        elseif string.match(InputData , "A6") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..A6)
            print ("UART TX = A6")
            MQTTData = " "
        
        elseif string.match(InputData , "B6") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..B6)
            print ("UART TX = B6")
            MQTTData = " "

        elseif string.match(InputData , "C6") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..C6)
            print ("UART TX = C6")
            MQTTData = " "

        elseif string.match(InputData , "D6") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..D6)
            print ("UART TX = D6")
            MQTTData = " "
            
        elseif string.match(InputData , "E6") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..E6)
            print ("UART TX = E6")
            MQTTData = " "

        elseif string.match(InputData , "F6") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..F6)
            print ("UART TX = F6")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 7 / G ##########
    -- ===========================================================
        elseif string.match(InputData , "A7") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..A7)
            print ("UART TX = A7")
            MQTTData = " "

        elseif string.match(InputData , "B7") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..B7)
            print ("UART TX = B7")
            MQTTData = " "
            
        elseif string.match(InputData , "C7") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..C7)
            print ("UART TX = C7")
            MQTTData = " "
        
        elseif string.match(InputData , "D7") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..D7)
            print ("UART TX = D7")
            MQTTData = " "
        
        elseif string.match(InputData , "E7") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..E7)
            print ("UART TX = E7")
            MQTTData = " "
        
        elseif string.match(InputData , "F7") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..F7)
            print ("UART TX = F7")
            MQTTData = " "
            
    -- ===========================================================
        -- ########## COLOUM 8 / H ##########
    -- ===========================================================
        elseif string.match(InputData , "A8") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..A8)
            print ("UART TX = A8")
            MQTTData = " "

        elseif string.match(InputData , "B8") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..B8)
            print ("UART TX = B8")
            MQTTData = " "

        elseif string.match(InputData , "C8") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..C8)
            print ("UART TX = C8")
            MQTTData = " "

        elseif string.match(InputData , "D8") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..D8)
            print ("UART TX = D8")
            MQTTData = " "

        elseif string.match(InputData , "E8") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..E8)
            print ("UART TX = E8")
            MQTTData = " "

        elseif string.match(InputData , "F8") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..F8)
            print ("UART TX = F8")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 9 / I ##########
    -- ===========================================================
        elseif string.match(InputData , "A9") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..A9)
            print ("UART TX = A9")
            MQTTData = " "

        elseif string.match(InputData , "B9") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..B9)
            print ("UART TX = B9")
            MQTTData = " "

        elseif string.match(InputData , "C9") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..C9)
            print ("UART TX = C9")
            MQTTData = " "

        elseif string.match(InputData , "D9") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..D9)
            print ("UART TX = D9")
            MQTTData = " "
        
        elseif string.match(InputData , "E9") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..E9)
            print ("UART TX = E9")
            MQTTData = " "

        elseif string.match(InputData , "F9") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..F9)
            print ("UART TX = F9")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 10 / J ##########
    -- ===========================================================
        elseif string.match(InputData , "10A") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..A10)
            print ("UART TX = A10")
            MQTTData = " "

        elseif string.match(InputData , "10B") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..B10)
            print ("UART TX = B10")
            MQTTData = " "

        elseif string.match(InputData , "10C") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..C10)
            print ("UART TX = C10")
            MQTTData = " "

        elseif string.match(InputData , "10D") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..D10)
            print ("UART TX = D10")
            MQTTData = " "

        elseif string.match(InputData , "10E") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..E10)
            print ("UART TX = E10")
            MQTTData = " "

        elseif string.match(InputData , "10F") then
            uart.write(uartID,SINGLE_MOTOR_DISPENSE..F10)
            print ("UART TX = F10")
            MQTTData = " "

        elseif string.match(InputData , "test") then

            MQTTData = " "

            -- ######### TRAY A ##########
            uart.write(uartID, TEST_MOTOR..A1)
            test_timer()
            uart.write(uartID, TEST_MOTOR..A2)
            test_timer()
            uart.write(uartID, TEST_MOTOR..A3)
            test_timer()
            uart.write(uartID, TEST_MOTOR..A4)
            test_timer()
            uart.write(uartID, TEST_MOTOR..A5)
            test_timer()
            uart.write(uartID, TEST_MOTOR..A6)
            test_timer()
            uart.write(uartID, TEST_MOTOR..A7)
            test_timer()
            uart.write(uartID, TEST_MOTOR..A8)
            test_timer()
            uart.write(uartID, TEST_MOTOR..A9)
            test_timer()
            uart.write(uartID, TEST_MOTOR..A10)
            test_timer()
        
            -- ######## TRAY B ##########
            uart.write(uartID, TEST_MOTOR..B1)
            test_timer()
            uart.write(uartID, TEST_MOTOR..B2)
            test_timer()
            uart.write(uartID, TEST_MOTOR..B3)
            test_timer()
            uart.write(uartID, TEST_MOTOR..B4)
            test_timer()
            uart.write(uartID, TEST_MOTOR..B5)
            test_timer()
            uart.write(uartID, TEST_MOTOR..B6)
            test_timer()
            uart.write(uartID, TEST_MOTOR..B7)
            test_timer()
            uart.write(uartID, TEST_MOTOR..B8)
            test_timer()
            uart.write(uartID, TEST_MOTOR..B9)
            test_timer()
            uart.write(uartID, TEST_MOTOR..B10)
            test_timer()
        
            -- ######### TRAY C ##########
            uart.write(uartID, TEST_MOTOR..C1)
            test_timer()
            uart.write(uartID, TEST_MOTOR..C2)
            test_timer()
            uart.write(uartID, TEST_MOTOR..C3)
            test_timer()
            uart.write(uartID, TEST_MOTOR..C4)
            test_timer()
            uart.write(uartID, TEST_MOTOR..C5)
            test_timer()
            uart.write(uartID, TEST_MOTOR..C6)
            test_timer()
            uart.write(uartID, TEST_MOTOR..C7)
            test_timer()
            uart.write(uartID, TEST_MOTOR..C8)
            test_timer()
            uart.write(uartID, TEST_MOTOR..C9)
            test_timer()
            uart.write(uartID, TEST_MOTOR..C10)
            test_timer()
        
            -- ########## TRAY D #############
            uart.write(uartID, TEST_MOTOR..D1)
            test_timer()
            uart.write(uartID, TEST_MOTOR..D2)
            test_timer()
            uart.write(uartID, TEST_MOTOR..D3)
            test_timer()
            uart.write(uartID, TEST_MOTOR..D4)
            test_timer()
            uart.write(uartID, TEST_MOTOR..D5)
            test_timer()
            uart.write(uartID, TEST_MOTOR..D6)
            test_timer()
            uart.write(uartID, TEST_MOTOR..D7)
            test_timer()
            uart.write(uartID, TEST_MOTOR..D8)
            test_timer()
            uart.write(uartID, TEST_MOTOR..D9)
            test_timer()
            uart.write(uartID, TEST_MOTOR..D10)
            test_timer()
        
            -- ######### TRAY E ###########
            uart.write(uartID, TEST_MOTOR..E1)
            test_timer()
            uart.write(uartID, TEST_MOTOR..E2)
            test_timer()
            uart.write(uartID, TEST_MOTOR..E3)
            test_timer()
            uart.write(uartID, TEST_MOTOR..E4)
            test_timer()
            uart.write(uartID, TEST_MOTOR..E5)
            test_timer()
            uart.write(uartID, TEST_MOTOR..E6)
            test_timer()
            uart.write(uartID, TEST_MOTOR..E7)
            test_timer()
            uart.write(uartID, TEST_MOTOR..E8)
            test_timer()
            uart.write(uartID, TEST_MOTOR..E9)
            test_timer()
            uart.write(uartID, TEST_MOTOR..E10)
            test_timer()
        
            -- ########### TRAY F ##########
            uart.write(uartID, TEST_MOTOR..F1)
            test_timer()
            uart.write(uartID, TEST_MOTOR..F2)
            test_timer()
            uart.write(uartID, TEST_MOTOR..F3)
            test_timer()
            uart.write(uartID, TEST_MOTOR..F4)
            test_timer()
            uart.write(uartID, TEST_MOTOR..F5)
            test_timer()
            uart.write(uartID, TEST_MOTOR..F6)
            test_timer()
            uart.write(uartID, TEST_MOTOR..F7)
            test_timer()
            uart.write(uartID, TEST_MOTOR..F8)
            test_timer()
            uart.write(uartID, TEST_MOTOR..F9)
            test_timer()
            uart.write(uartID, TEST_MOTOR..F10)

            print("Complete Running All Motor")
            test_timer()
            mqttOutMsg.PubQos0Temp(InputDrop)

        --[[ ########## INSTRUCTION FOR RUN BASED ON TRAY ONLY ########## ]]
        -- ######### RUN ONLY TRAY A ##########
        elseif string.match(InputData , "RWA") then
            MQTTData = " "

            uart.write(uartID, A1)
            test_timer()
            uart.write(uartID, A2)
            test_timer()
            uart.write(uartID, A3)
            test_timer()
            uart.write(uartID, A4)
            test_timer()
            uart.write(uartID, A5)
            test_timer()
            uart.write(uartID, A6)
            test_timer()
            uart.write(uartID, A7)
            test_timer()
            uart.write(uartID, A8)
            test_timer()
            uart.write(uartID, A9)
            test_timer()
            uart.write(uartID, A10)
            test_timer()
            mqttOutMsg.PubQos0Temp(InputDrop)

        -- ######## RUN ONLY TRAY B ##########
        elseif string.match(InputData , "RWB") then
            MQTTData = " "

            uart.write(uartID, B1)
            test_timer()
            uart.write(uartID, B2)
            test_timer()
            uart.write(uartID, B3)
            test_timer()
            uart.write(uartID, B4)
            test_timer()
            uart.write(uartID, B5)
            test_timer()
            uart.write(uartID, B6)
            test_timer()
            uart.write(uartID, B7)
            test_timer()
            uart.write(uartID, B8)
            test_timer()
            uart.write(uartID, B9)
            test_timer()
            uart.write(uartID, B10)
            test_timer()
            mqttOutMsg.PubQos0Temp(InputDrop)

        -- ######### RUN ONLY TRAY C ##########
        elseif string.match(InputData , "RWC") then
            MQTTData = " "

            uart.write(uartID, C1)
            test_timer()
            uart.write(uartID, C2)
            test_timer()
            uart.write(uartID, C3)
            test_timer()
            uart.write(uartID, C4)
            test_timer()
            uart.write(uartID, C5)
            test_timer()
            uart.write(uartID, C6)
            test_timer()
            uart.write(uartID, C7)
            test_timer()
            uart.write(uartID, C8)
            test_timer()
            uart.write(uartID, C9)
            test_timer()
            uart.write(uartID, C10)
            test_timer()
            mqttOutMsg.PubQos0Temp(InputDrop)

        -- ########## RUN ONLY TRAY D #############
        elseif string.match(InputData , "RWD") then
            MQTTData = " "

            uart.write(uartID, D1)
            test_timer()
            uart.write(uartID, D2)
            test_timer()
            uart.write(uartID, D3)
            test_timer()
            uart.write(uartID, D4)
            test_timer()
            uart.write(uartID, D5)
            test_timer()
            uart.write(uartID, D6)
            test_timer()
            uart.write(uartID, D7)
            test_timer()
            uart.write(uartID, D8)
            test_timer()
            uart.write(uartID, D9)
            test_timer()
            uart.write(uartID, D10)
            test_timer()
            mqttOutMsg.PubQos0Temp(InputDrop)

        -- ######### RUN ONLY TRAY E ###########
        elseif string.match(InputData , "RWE") then
            MQTTData = " "

            uart.write(uartID, E1)
            test_timer()
            uart.write(uartID, E2)
            test_timer()
            uart.write(uartID, E3)
            test_timer()
            uart.write(uartID, E4)
            test_timer()
            uart.write(uartID, E5)
            test_timer()
            uart.write(uartID, E6)
            test_timer()
            uart.write(uartID, E7)
            test_timer()
            uart.write(uartID, E8)
            test_timer()
            uart.write(uartID, E9)
            test_timer()
            uart.write(uartID, E10)
            test_timer()
            mqttOutMsg.PubQos0Temp(InputDrop)

        -- ########### RUN ONLY TRAY F ##########
        elseif string.match(InputData , "RWF") then
            MQTTData = " "

            uart.write(uartID, F1)
            test_timer()
            uart.write(uartID, F2)
            test_timer()
            uart.write(uartID, F3)
            test_timer()
            uart.write(uartID, F4)
            test_timer()
            uart.write(uartID, F5)
            test_timer()
            uart.write(uartID, F6)
            test_timer()
            uart.write(uartID, F7)
            test_timer()
            uart.write(uartID, F8)
            test_timer()
            uart.write(uartID, F9)
            test_timer()
            uart.write(uartID, F10)
            test_timer()
            mqttOutMsg.PubQos0Temp(InputDrop)

        elseif string.match(InputData , "HI") then
            
            --mqttOutMsg.PubQos0Drop()
            --print("--> AYUNI <-- ")
            -----mqttOutMsg.PubQos0Temp()
            uart.write(uartID, "YO\n")
            --local Arduino = uart.read(uartID, "*s")
            --mqttOutMsg.PubQos0Temp(Arduino)
            MQTTData = " "
            --mqttOutMsg.PubQos0Drop()
            --sys.wait(10)

        elseif string.match(InputData , "RE") then
            uart.write(uartID, "RE\n")
            MQTTData = " "
            
        else
            --print("Else")
            MQTTData = " "
            sys.wait(5)
        end
    end
end

pm.wake("UART_SENT2MCU")
uart.on(uartID)
uart.setup(uartID,115200,8,uart.PAR_NONE,uart.STOP_1,nil,1)
sys.taskInit(Run_All)