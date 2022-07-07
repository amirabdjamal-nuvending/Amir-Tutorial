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
        
        -- ##### TRAY A #####
        local A1 = "A1" --FC 02 Row Column xx FB where xx is mode
        local A2 = "A2"
        local A3 = "A3"
        local A4 = "A4"
        local A5 = "A5"
        local A6 = "A6"
        local A7 = "A7"
        local A8 = "A8"
        local A9 = "A9"
        local A10 ="AA"
        
        -- ##### TRAY B #####
        local B1 = "B1" 
        local B2 = "B2"
        local B3 = "B3"
        local B4 = "B4"
        local B5 = "B5"
        local B6 = "B6"
        local B7 = "B7"
        local B8 = "B8"
        local B9 = "B9"
        local B10 ="BB"
        
        -- ##### TRAY C #####
        local C1 = "C1" 
        local C2 = "C2"
        local C3 = "C3"
        local C4 = "C4"
        local C5 = "C5"
        local C6 = "C6"
        local C7 = "C7"
        local C8 = "C8"
        local C9 = "C9"
        local C10 ="CC"
        
        -- ##### TRAY D #####
        local D1 = "D1" 
        local D2 = "D2"
        local D3 = "D3"
        local D4 = "D4"
        local D5 = "D5"
        local D6 = "D6"
        local D7 = "D7"
        local D8 = "D8"
        local D9 = "D9"
        local D10 ="DD"
        
        -- ##### TRAY E #####
        local E1 = "E1" 
        local E2 = "E2"
        local E3 = "E3"
        local E4 = "E4"
        local E5 = "E5"
        local E6 = "E6"
        local E7 = "E7"
        local E8 = "E8"
        local E9 = "E9"
        local E10 ="EE"
        
        -- ##### TRAY F #####
        local F1 = "F1"
        local F2 = "F2"
        local F3 = "F3"
        local F4 = "F4"
        local F5 = "F5"
        local F6 = "F6"
        local F7 = "F7"
        local F8 = "F8"
        local F9 = "F9"
        local F10 ="FF"
        
        pm.wake("UART_SENT2MCU")
        uart.on(uartID)
        uart.setup(uartID,115200,8,uart.PAR_NONE,uart.STOP_1,nil,1)
        --uart.set_buffer(uartID,255)
        local InputDrop = uart.read(uartID, "*l")
        print(InputDrop)
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
            uart.write(uartID,A1)
            print("UART TX = A1")
            MQTTData = " "
            

        elseif string.match(InputData , "B1") then
            uart.write(uartID,B1)
            print("UART TX = B1")
            MQTTData = " "
        
        elseif string.match(InputData , "C1") then
            uart.write(uartID,C1)
            print ("UART TX = C1")
            MQTTData = " "
        
        elseif string.match(InputData , "D1") then
            uart.write(uartID,D1)
            print ("UART TX = D1")
            MQTTData = " "
        
        elseif string.match(InputData , "E1") then
            uart.write(uartID,E1)
            print ("UART TX = E1")
            MQTTData = " "
        
        elseif string.match(InputData , "F1") then
            uart.write(uartID,F1)
            print ("UART TX = F1")
            MQTTData = " "
        
    -- ===========================================================
        -- ########## COLOUM 2 / B ##########
    -- ===========================================================
        elseif string.match(InputData , "A2") then
            uart.write(uartID,A2)
            print ("UART TX = A2")
            MQTTData = " "
        
        elseif string.match(InputData , "B2") then
            uart.write(uartID,B2)
            print ("UART TX = B2")
            MQTTData = " "
        
        elseif string.match(InputData , "C2") then
            uart.write(uartID,C2)
            print ("UART TX = C2")
            MQTTData = " "
        
        elseif string.match(InputData , "D2") then
            uart.write(uartID,D2)
            print ("UART TX = D2")
            MQTTData = " "
        
        elseif string.match(InputData , "E2") then
            uart.write(uartID,E2)
            print ("UART TX = E5")
            MQTTData = " "
        
        elseif string.match(InputData , "F2") then
            uart.write(uartID,F2)
            print ("UART TX = F2")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 3 / C ##########
    -- ===========================================================
        elseif string.match(InputData , "A3") then
            uart.write(uartID,A3)
            print ("UART TX = A3")
            MQTTData = " "

        elseif string.match(InputData , "B3") then
            uart.write(uartID,B3)
            print ("UART TX = B3")
            MQTTData = " "

        elseif string.match(InputData , "C3") then
            uart.write(uartID,C3)
            print ("UART TX = C3")
            MQTTData = " "
            
        elseif string.match(InputData , "D3") then
            uart.write(uartID,D3)
            print ("UART TX = D3")
            MQTTData = " "
        
        elseif string.match(InputData , "E3") then
            uart.write(uartID,E3)
            print ("UART TX = E3")
            MQTTData = " "

        elseif string.match(InputData , "F3") then
            uart.write(uartID,F3)
            print ("UART TX = F3")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 4 / D ##########
    -- ===========================================================
        elseif string.match(InputData , "A4") then
            uart.write(uartID,A4)
            print ("UART TX = A4")
            MQTTData = " "

        elseif string.match(InputData , "B4") then
            uart.write(uartID,B4)
            print ("UART TX = B4")
            MQTTData = " "

        elseif string.match(InputData , "C4") then
            uart.write(uartID,C4)
            print ("UART TX = C4")
            MQTTData = " "
            
        elseif string.match(InputData , "D4") then
            uart.write(uartID,D4)
            print ("UART TX = D4")
            MQTTData = " "

        elseif string.match(InputData , "E4") then
            uart.write(uartID,E4)
            print ("UART TX = E4")
            MQTTData = " "

        elseif string.match(InputData , "F4") then
            uart.write(uartID,F4)
            print ("UART TX = F4")
            MQTTData = " "
        
    -- ===========================================================
        -- ########## COLOUM 5 / E ##########
    -- ===========================================================
        elseif string.match(InputData , "A5") then
            uart.write(uartID,A5)
            print ("UART TX = A5")
            MQTTData = " "
            
        elseif string.match(InputData , "B5") then
            uart.write(uartID,B5)
            print ("UART TX = B5")
            MQTTData = " "

        elseif string.match(InputData , "C5") then
            uart.write(uartID,C5)
            print ("UART TX = C5")
            MQTTData = " "

        elseif string.match(InputData , "D5") then
            uart.write(uartID,D5)
            print ("UART TX = D5")
            MQTTData = " "

        elseif string.match(InputData , "E5") then
            uart.write(uartID,E5)
            print ("UART TX = E5")
            MQTTData = " "

        elseif string.match(InputData , "F5") then
            uart.write(uartID,F5)
            print ("UART TX = F5")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 6 / F ##########
    -- ===========================================================
        elseif string.match(InputData , "A6") then
            uart.write(uartID,A6)
            print ("UART TX = A6")
            MQTTData = " "
        
        elseif string.match(InputData , "B6") then
            uart.write(uartID,B6)
            print ("UART TX = B6")
            MQTTData = " "

        elseif string.match(InputData , "C6") then
            uart.write(uartID,C6)
            print ("UART TX = C6")
            MQTTData = " "

        elseif string.match(InputData , "D6") then
            uart.write(uartID,D6)
            print ("UART TX = D6")
            MQTTData = " "
            
        elseif string.match(InputData , "E6") then
            uart.write(uartID,E6)
            print ("UART TX = E6")
            MQTTData = " "

        elseif string.match(InputData , "F6") then
            uart.write(uartID,F6)
            print ("UART TX = F6")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 7 / G ##########
    -- ===========================================================
        elseif string.match(InputData , "A7") then
            uart.write(uartID,A7)
            print ("UART TX = A7")
            MQTTData = " "

        elseif string.match(InputData , "B7") then
            uart.write(uartID,B7)
            print ("UART TX = B7")
            MQTTData = " "
            
        elseif string.match(InputData , "C7") then
            uart.write(uartID,C7)
            print ("UART TX = C7")
            MQTTData = " "
        
        elseif string.match(InputData , "D7") then
            uart.write(uartID,D7)
            print ("UART TX = D7")
            MQTTData = " "
        
        elseif string.match(InputData , "E7") then
            uart.write(uartID,E7)
            print ("UART TX = E7")
            MQTTData = " "
        
        elseif string.match(InputData , "F7") then
            uart.write(uartID,F7)
            print ("UART TX = F7")
            MQTTData = " "
            
    -- ===========================================================
        -- ########## COLOUM 8 / H ##########
    -- ===========================================================
        elseif string.match(InputData , "A8") then
            uart.write(uartID,A8)
            print ("UART TX = A8")
            MQTTData = " "

        elseif string.match(InputData , "B8") then
            uart.write(uartID,B8)
            print ("UART TX = B8")
            MQTTData = " "

        elseif string.match(InputData , "C8") then
            uart.write(uartID,C8)
            print ("UART TX = C8")
            MQTTData = " "

        elseif string.match(InputData , "D8") then
            uart.write(uartID,D8)
            print ("UART TX = D8")
            MQTTData = " "

        elseif string.match(InputData , "E8") then
            uart.write(uartID,E8)
            print ("UART TX = E8")
            MQTTData = " "

        elseif string.match(InputData , "F8") then
            uart.write(uartID,F8)
            print ("UART TX = F8")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 9 / I ##########
    -- ===========================================================
        elseif string.match(InputData , "A9") then
            uart.write(uartID,A9)
            print ("UART TX = A9")
            MQTTData = " "

        elseif string.match(InputData , "B9") then
            uart.write(uartID,B9)
            print ("UART TX = B9")
            MQTTData = " "

        elseif string.match(InputData , "C9") then
            uart.write(uartID,C9)
            print ("UART TX = C9")
            MQTTData = " "

        elseif string.match(InputData , "D9") then
            uart.write(uartID,D9)
            print ("UART TX = D9")
            MQTTData = " "
        
        elseif string.match(InputData , "E9") then
            uart.write(uartID,E9)
            print ("UART TX = E9")
            MQTTData = " "

        elseif string.match(InputData , "F9") then
            uart.write(uartID,F9)
            print ("UART TX = F9")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 10 / J ##########
    -- ===========================================================
        elseif string.match(InputData , "10A") then
            uart.write(uartID,A10)
            print ("UART TX = A10")
            MQTTData = " "

        elseif string.match(InputData , "10B") then
            uart.write(uartID,B10)
            print ("UART TX = B10")
            MQTTData = " "

        elseif string.match(InputData , "10C") then
            uart.write(uartID,C10)
            print ("UART TX = C10")
            MQTTData = " "

        elseif string.match(InputData , "10D") then
            uart.write(uartID,D10)
            print ("UART TX = D10")
            MQTTData = " "

        elseif string.match(InputData , "10E") then
            uart.write(uartID,E10)
            print ("UART TX = E10")
            MQTTData = " "

        elseif string.match(InputData , "10F") then
            uart.write(uartID,F10)
            print ("UART TX = F10")
            MQTTData = " "

        elseif string.match(InputData , "TEST") then

            MQTTData = " "

            -- ######### TRAY A ##########
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
        
            -- ######## TRAY B ##########
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
        
            -- ######### TRAY C ##########
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
        
            -- ########## TRAY D #############
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
        
            -- ######### TRAY E ###########
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
        
            -- ########### TRAY F ##########
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