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

local function first_indicator()
    uart.write(uartID, "MO\n")
    sys.wait(2000)
end

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
        -- local A1 = "\x01\x04\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA3\x49"
        local A1 = "\x01\x05\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB1\x48"
        -- local A1 = "\x01\x05\x06\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x32\xEA"
        local A2 = "\x01\x05\x0A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x37\xEF"
        local A3 = "\x01\x05\x14\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xBE\x47"
        local A4 = "\x01\x05\x1E\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x38\xE0"
        local A5 = "\x01\x05\x28\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAF\x56"
        local A6 = "\x01\x05\x32\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x24\x3D"
        local A7 = "\x01\x05\x3C\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA0\x59"
        local A8 = "\x01\x05\x46\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x1A"
        local A9 = "\x01\x05\x50\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8D\x74"
        local A10 = "\x01\x05\x5A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0B\xD3"

        -- ##### TRAY B #####
        local B1 = "\x01\x05\x01\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x70\xD8"
        local B2 = "\x01\x05\x0B\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF6\x7F"
        local B3 = "\x01\x05\x15\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7F\xD7"
        local B4 = "\x01\x05\x1F\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF9\x70"
        local B5 = "\x01\x05\x29\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6E\xC6"
        local B6 = "\x01\x05\x33\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE5\xAD"
        local B7 = "\x01\x05\x3D\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\xC9"
        local B8 = "\x01\x05\x47\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC2\x8A"
        local B9 = "\x01\x05\x51\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4C\xE4"
        local B10 = "\x01\x05\x5B\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xCA\x43"

        -- ##### TRAY C #####
        local C1 = "\x01\x05\x02\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x30\x29"
        local C2 = "\x01\x05\x0C\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB4\x4D"
        local C3 = "\x01\x05\x16\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3F\x26"
        local C4 = "\x01\x05\x20\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA8\x90"
        local C5 = "\x01\x05\x2A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2E\x37"
        local C6 = "\x01\x05\x34\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA7\x9F"
        local C7 = "\x01\x05\x3E\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x38"
        local C8 = "\x01\x05\x48\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x87\x7E"
        local C9 = "\x01\x05\x52\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0C\x15"
        local C10 = "\x01\x05\x5C\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x88\x71"

        -- ##### TRAY D #####
        local D1 = "\x01\x05\x03\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF1\xB9"
        local D2 = "\x01\x05\x0D\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x75\xDD"
        local D3 = "\x01\x05\x17\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFE\xB6"
        local D4 = "\x01\x05\x21\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x69\x00"
        local D5 = "\x01\x05\x2B\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xEF\xA7"
        local D6 = "\x01\x05\x35\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x66\x0F"
        local D7 = "\x01\x05\x3F\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE0\xA8"
        local D8 = "\x01\x05\x49\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x46\xEE"
        local D9 = "\x01\x05\x53\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xCD\x85"
        local D10 = "\x01\x05\x5D\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x49\xE1"

        -- ##### TRAY E #####
        local E1 = "\x01\x05\x04\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB3\x8B"
        local E2 = "\x01\x05\x0E\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x35\x2C"
        local E3 = "\x01\x05\x18\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xBB\x42"
        local E4 = "\x01\x05\x22\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x29\xF1"
        local E5 = "\x01\x05\x2C\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAD\x95"
        local E6 = "\x01\x05\x36\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x26\xFE"
        local E7 = "\x01\x05\x40\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\xB8"
        local E8 = "\x01\x05\x4A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x06\x1F"
        local E9 = "\x01\x05\x54\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8F\xB7"
        local E10 = "\x01\x05\x5E\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09\x10"

        -- ##### TRAY F #####
        local F1 = "\x01\x05\x05\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x72\x1B"
        local F2 = "\x01\x05\x0F\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF4\xBC"
        local F3 = "\x01\x05\x19\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7A\xD2"
        local F4 = "\x01\x05\x23\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE8\x61"
        local F5 = "\x01\x05\x2D\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6C\x05"
        local F6 = "\x01\x05\x37\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE7\x6E"
        local F7 = "\x01\x05\x41\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x41\x28"
        local F8 = "\x01\x05\x4B\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC7\x8F"
        local F9 = "\x01\x05\x55\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4E\x27"
        local F10 = "\x01\x05\x5F\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC8\x80"
        
        pm.wake("UART_SENT2MCU")
        uart.on(uartID)
        uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
        local InputDrop = uart.read(uartID, "*l")
        
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
            MQTTData = " "
            first_indicator()
            uart.write(uartID,A1)
            print("UART TX = A1")
            -- MQTTData = " "
            

        elseif string.match(InputData , "B1") then
            first_indicator()
            uart.write(uartID,B1)
            print("UART TX = B1")
            MQTTData = " "
        
        elseif string.match(InputData , "C1") then
            first_indicator()
            uart.write(uartID,C1)
            print ("UART TX = C1")
            MQTTData = " "
        
        elseif string.match(InputData , "D1") then
            first_indicator()
            uart.write(uartID,D1)
            print ("UART TX = D1")
            MQTTData = " "
        
        elseif string.match(InputData , "E1") then
            first_indicator()
            uart.write(uartID,E1)
            print ("UART TX = E1")
            MQTTData = " "
        
        elseif string.match(InputData , "F1") then
            first_indicator()
            uart.write(uartID,F1)
            print ("UART TX = F1")
            MQTTData = " "
        
    -- ===========================================================
        -- ########## COLOUM 2 / B ##########
    -- ===========================================================
        elseif string.match(InputData , "A2") then
            first_indicator()
            uart.write(uartID,A2)
            print ("UART TX = A2")
            MQTTData = " "
        
        elseif string.match(InputData , "B2") then
            first_indicator()
            uart.write(uartID,B2)
            print ("UART TX = B2")
            MQTTData = " "
        
        elseif string.match(InputData , "C2") then
            first_indicator()
            uart.write(uartID,C2)
            print ("UART TX = C2")
            MQTTData = " "
        
        elseif string.match(InputData , "D2") then
            first_indicator()
            uart.write(uartID,D2)
            print ("UART TX = D2")
            MQTTData = " "
        
        elseif string.match(InputData , "E2") then
            first_indicator()
            uart.write(uartID,E2)
            print ("UART TX = E5")
            MQTTData = " "
        
        elseif string.match(InputData , "F2") then
            first_indicator()
            uart.write(uartID,F2)
            print ("UART TX = F2")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 3 / C ##########
    -- ===========================================================
        elseif string.match(InputData , "A3") then
            first_indicator()
            uart.write(uartID,A3)
            print ("UART TX = A3")
            MQTTData = " "

        elseif string.match(InputData , "B3") then
            first_indicator()
            uart.write(uartID,B3)
            print ("UART TX = B3")
            MQTTData = " "

        elseif string.match(InputData , "C3") then
            first_indicator()
            uart.write(uartID,C3)
            print ("UART TX = C3")
            MQTTData = " "
            
        elseif string.match(InputData , "D3") then
            first_indicator()
            uart.write(uartID,D3)
            print ("UART TX = D3")
            MQTTData = " "
        
        elseif string.match(InputData , "E3") then
            first_indicator()
            uart.write(uartID,E3)
            print ("UART TX = E3")
            MQTTData = " "

        elseif string.match(InputData , "F3") then
            first_indicator()
            uart.write(uartID,F3)
            print ("UART TX = F3")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 4 / D ##########
    -- ===========================================================
        elseif string.match(InputData , "A4") then
            first_indicator()
            uart.write(uartID,A4)
            print ("UART TX = A4")
            MQTTData = " "

        elseif string.match(InputData , "B4") then
            first_indicator()
            uart.write(uartID,B4)
            print ("UART TX = B4")
            MQTTData = " "

        elseif string.match(InputData , "C4") then
            first_indicator()
            uart.write(uartID,C4)
            print ("UART TX = C4")
            MQTTData = " "
            
        elseif string.match(InputData , "D4") then
            first_indicator()
            uart.write(uartID,D4)
            print ("UART TX = D4")
            MQTTData = " "

        elseif string.match(InputData , "E4") then
            first_indicator()
            uart.write(uartID,E4)
            print ("UART TX = E4")
            MQTTData = " "

        elseif string.match(InputData , "F4") then
            first_indicator()
            uart.write(uartID,F4)
            print ("UART TX = F4")
            MQTTData = " "
        
    -- ===========================================================
        -- ########## COLOUM 5 / E ##########
    -- ===========================================================
        elseif string.match(InputData , "A5") then
            first_indicator()
            uart.write(uartID,A5)
            print ("UART TX = A5")
            MQTTData = " "
            
        elseif string.match(InputData , "B5") then
            first_indicator()
            uart.write(uartID,B5)
            print ("UART TX = B5")
            MQTTData = " "

        elseif string.match(InputData , "C5") then
            first_indicator()
            uart.write(uartID,C5)
            print ("UART TX = C5")
            MQTTData = " "

        elseif string.match(InputData , "D5") then
            first_indicator()
            uart.write(uartID,D5)
            print ("UART TX = D5")
            MQTTData = " "

        elseif string.match(InputData , "E5") then
            first_indicator()
            uart.write(uartID,E5)
            print ("UART TX = E5")
            MQTTData = " "

        elseif string.match(InputData , "F5") then
            first_indicator()
            uart.write(uartID,F5)
            print ("UART TX = F5")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 6 / F ##########
    -- ===========================================================
        elseif string.match(InputData , "A6") then
            first_indicator()
            uart.write(uartID,A6)
            print ("UART TX = A6")
            MQTTData = " "
        
        elseif string.match(InputData , "B6") then
            first_indicator()
            uart.write(uartID,B6)
            print ("UART TX = B6")
            MQTTData = " "

        elseif string.match(InputData , "C6") then
            first_indicator()
            uart.write(uartID,C6)
            print ("UART TX = C6")
            MQTTData = " "

        elseif string.match(InputData , "D6") then
            first_indicator()
            uart.write(uartID,D6)
            print ("UART TX = D6")
            MQTTData = " "
            
        elseif string.match(InputData , "E6") then
            first_indicator()
            uart.write(uartID,E6)
            print ("UART TX = E6")
            MQTTData = " "

        elseif string.match(InputData , "F6") then
            first_indicator()
            uart.write(uartID,F6)
            print ("UART TX = F6")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 7 / G ##########
    -- ===========================================================
        elseif string.match(InputData , "A7") then
            first_indicator()
            uart.write(uartID,A7)
            print ("UART TX = A7")
            MQTTData = " "

        elseif string.match(InputData , "B7") then
            first_indicator()
            uart.write(uartID,B7)
            print ("UART TX = B7")
            MQTTData = " "
            
        elseif string.match(InputData , "C7") then
            first_indicator()
            uart.write(uartID,C7)
            print ("UART TX = C7")
            MQTTData = " "
        
        elseif string.match(InputData , "D7") then
            first_indicator()
            uart.write(uartID,D7)
            print ("UART TX = D7")
            MQTTData = " "
        
        elseif string.match(InputData , "E7") then
            first_indicator()
            uart.write(uartID,E7)
            print ("UART TX = E7")
            MQTTData = " "
        
        elseif string.match(InputData , "F7") then
            first_indicator()
            uart.write(uartID,F7)
            print ("UART TX = F7")
            MQTTData = " "
            
    -- ===========================================================
        -- ########## COLOUM 8 / H ##########
    -- ===========================================================
        elseif string.match(InputData , "A8") then
            first_indicator()
            uart.write(uartID,A8)
            print ("UART TX = A8")
            MQTTData = " "

        elseif string.match(InputData , "B8") then
            first_indicator()
            uart.write(uartID,B8)
            print ("UART TX = B8")
            MQTTData = " "

        elseif string.match(InputData , "C8") then
            first_indicator()
            uart.write(uartID,C8)
            print ("UART TX = C8")
            MQTTData = " "

        elseif string.match(InputData , "D8") then
            first_indicator()
            uart.write(uartID,D8)
            print ("UART TX = D8")
            MQTTData = " "

        elseif string.match(InputData , "E8") then
            first_indicator()
            uart.write(uartID,E8)
            print ("UART TX = E8")
            MQTTData = " "

        elseif string.match(InputData , "F8") then
            first_indicator()
            uart.write(uartID,F8)
            print ("UART TX = F8")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 9 / I ##########
    -- ===========================================================
        elseif string.match(InputData , "A9") then
            first_indicator()
            uart.write(uartID,A9)
            print ("UART TX = A9")
            MQTTData = " "

        elseif string.match(InputData , "B9") then
            first_indicator()
            uart.write(uartID,B9)
            print ("UART TX = B9")
            MQTTData = " "

        elseif string.match(InputData , "C9") then
            first_indicator()
            uart.write(uartID,C9)
            print ("UART TX = C9")
            MQTTData = " "

        elseif string.match(InputData , "D9") then
            first_indicator()
            uart.write(uartID,D9)
            print ("UART TX = D9")
            MQTTData = " "
        
        elseif string.match(InputData , "E9") then
            first_indicator()
            uart.write(uartID,E9)
            print ("UART TX = E9")
            MQTTData = " "

        elseif string.match(InputData , "F9") then
            first_indicator()
            uart.write(uartID,F9)
            print ("UART TX = F9")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 10 / J ##########
    -- ===========================================================
        elseif string.match(InputData , "10A") then
            first_indicator()
            uart.write(uartID,A10)
            print ("UART TX = A10")
            MQTTData = " "

        elseif string.match(InputData , "10B") then
            first_indicator()
            uart.write(uartID,B10)
            print ("UART TX = B10")
            MQTTData = " "

        elseif string.match(InputData , "10C") then
            first_indicator()
            uart.write(uartID,C10)
            print ("UART TX = C10")
            MQTTData = " "

        elseif string.match(InputData , "10D") then
            first_indicator()
            uart.write(uartID,D10)
            print ("UART TX = D10")
            MQTTData = " "

        elseif string.match(InputData , "10E") then
            first_indicator()
            uart.write(uartID,E10)
            print ("UART TX = E10")
            MQTTData = " "

        elseif string.match(InputData , "10F") then
            first_indicator()
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
            -- test_timer()
            -- mqttOutMsg.PubQos0Temp(InputDrop)

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
            -- test_timer()
            -- mqttOutMsg.PubQos0Temp(InputDrop)

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
            -- test_timer()
            -- mqttOutMsg.PubQos0Temp(InputDrop)

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
            -- test_timer()
            -- mqttOutMsg.PubQos0Temp(InputDrop)

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
            -- test_timer()
            -- mqttOutMsg.PubQos0Temp(InputDrop)

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
            -- test_timer()
            -- mqttOutMsg.PubQos0Temp(InputDrop)

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
            -- test_timer()
            -- mqttOutMsg.PubQos0Temp(InputDrop)

        elseif string.match(InputData , "HI") then
            MQTTData = " "
            uart.write(uartID, "YO\n")
            -- mqttOutMsg.PubQos0Drop()

        else
            MQTTData = " "
            sys.wait(5)
        end
    end
end

pm.wake("UART_SENT2MCU")
uart.on(uartID)
uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
sys.taskInit(Run_All)