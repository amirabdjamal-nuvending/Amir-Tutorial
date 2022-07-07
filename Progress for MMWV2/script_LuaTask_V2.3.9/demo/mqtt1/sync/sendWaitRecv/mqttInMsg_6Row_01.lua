 --- Module function: MQTT client data reception processing
-- @author openLuat
-- @module mqtt.mqttInMsg
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.28

module(...,package.seeall)

require"utils"
require"pm"

local uartID = 1

--- MQTT client data reception processing
-- @param mqttClient，MQTT client object
-- @return Processing successfully returns true，Processing error returns false
-- @usage mqttInMsg.proc(mqttClient)
function proc(mqttClient)
    local result,data
    while true do
        result,data = mqttClient:receive(60000,"APP_SOCKET_SEND_DATA")
        --The data was received
        if result then
            --log.info("mqttInMsg.proc",data.topic,string.toHex(data.payload))
            log.info("mqttInMsg.proc",data.topic,data.payload)
            
-- ===========================================================
            -- ########## COLOUM 1 / A ##########
-- ===========================================================
            if string.match(data.payload , "A1") then
                pm.wake("UART_SENT2MCU")
                local A1 = "\x01\x05\x00\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB1\x89"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A1)
                print(string.toHex(A1))
                print("UART TX = A1")
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "A2") then
                pm.wake("UART_SENT2MCU")
                local A2 = "\x01\x05\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x70\x19"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A2)
                print("UART TX = A2")
                print(string.toHex(A2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "A3") then
                pm.wake("UART_SENT2MCU")
                local A3 = "\x01\x05\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x30\xE8"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A3)
                print ("UART TX = A3")
                print(string.toHex(A3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "A4") then
                pm.wake("UART_SENT2MCU")
                local A4 = "\x01\x05\x03\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF1\x78"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A4)
                print ("UART TX = A4")
                print(string.toHex(A4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "A5") then
                pm.wake("UART_SENT2MCU")
                local A5 = "\x01\x05\x04\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB3\x4A"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A5)
                print ("UART TX = A5")
                print(string.toHex(A5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "A6") then
                pm.wake("UART_SENT2MCU")
                local A6 = "\x01\x05\x05\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x72\xDA"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A6)
                print ("UART TX = A6")
                print(string.toHex(A6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
-- ===========================================================
            -- ########## COLOUM 2 / B ##########
-- ===========================================================
            elseif string.match(data.payload , "B1") then
                pm.wake("UART_SENT2MCU")
                local B1 = "\x01\x05\x0A\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x37\x2E"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B1)
                print ("UART TX = B1")
                print(string.toHex(B1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B2") then
                pm.wake("UART_SENT2MCU")
                local B2 = "\x01\x05\x0B\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF6\xBE"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B2)
                print ("UART TX = B2")
                print(string.toHex(B2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B3") then
                pm.wake("UART_SENT2MCU")
                local B3 = "\x01\x05\x0C\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB4\x8C"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B3)
                print ("UART TX = A3")
                print(string.toHex(B3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B4") then
                pm.wake("UART_SENT2MCU")
                local B4 = "\x01\x05\x0D\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x75\x1C"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B4)
                print ("UART TX = B4")
                print(string.toHex(B4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B5") then
                pm.wake("UART_SENT2MCU")
                local B5 = "\x01\x05\x0E\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x35\xED"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B5)
                print ("UART TX = B5")
                print(string.toHex(B5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B6") then
                pm.wake("UART_SENT2MCU")
                local B6 = "\x01\x05\x0F\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF4\x7D"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B6)
                print ("UART TX = B6")
                print(string.toHex(B6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## COLOUM 3 / C ##########
-- ===========================================================
            elseif string.match(data.payload , "C1") then
                pm.wake("UART_SENT2MCU")
                local C1 = "\x01\x05\x14\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xBE\x86"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C1)
                print ("UART TX = C1")
                print(string.toHex(C1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C2") then
                pm.wake("UART_SENT2MCU")
                local C2 = "\x01\x05\x15\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7F\x16"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C2)
                print ("UART TX = C2")
                print(string.toHex(C2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C3") then
                pm.wake("UART_SENT2MCU")
                local C3 = "\x01\x05\x16\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3F\xE7"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C3)
                print ("UART TX = C3")
                print(string.toHex(C3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C4") then
                pm.wake("UART_SENT2MCU")
                local C4 = "\x01\x05\x17\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFE\x77"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C4)
                print ("UART TX = C4")
                print(string.toHex(C4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C5") then
                pm.wake("UART_SENT2MCU")
                local C5 = "\x01\x05\x18\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xBB\x83"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C5)
                print ("UART TX = C5")
                print(string.toHex(C5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C6") then
                pm.wake("UART_SENT2MCU")
                local C6 = "\x01\x05\x19\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7A\x13"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C6)
                print ("UART TX = C6")
                print(string.toHex(C6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## COLOUM 4 / D ##########
-- ===========================================================
            elseif string.match(data.payload , "D1") then
                pm.wake("UART_SENT2MCU")
                local D1 = "\x01\x05\x1E\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x38\x21"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D1)
                print ("UART TX = D1")
                print(string.toHex(D1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D2") then
                pm.wake("UART_SENT2MCU")
                local D2 = "\x01\x05\x1F\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF9\xB1"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D2)
                print ("UART TX = D2")
                print(string.toHex(D2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D3") then
                pm.wake("UART_SENT2MCU")
                local D3 = "\x01\x05\x20\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA8\x51"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D3)
                print ("UART TX = D3")
                print(string.toHex(D3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D4") then
                pm.wake("UART_SENT2MCU")
                local D4 = "\x01\x05\x21\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x69\xC1"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D4)
                print ("UART TX = D4")
                print(string.toHex(D4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D5") then
                pm.wake("UART_SENT2MCU")
                local D5 = "\x01\x05\x22\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x29\x30"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D5)
                print ("UART TX = D5")
                print(string.toHex(D5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D6") then
                pm.wake("UART_SENT2MCU")
                local D6 = "\x01\x05\x23\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE8\xA0"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D6)
                print ("UART TX = D6")
                print(string.toHex(D6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
-- ===========================================================
            -- ########## COLOUM 5 / E ##########
-- ===========================================================
            elseif string.match(data.payload , "E1") then
                pm.wake("UART_SENT2MCU")
                local E1 = "\x01\x05\x28\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAF\x97"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E1)
                print ("UART TX = E1")
                print(string.toHex(E1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E2") then
                pm.wake("UART_SENT2MCU")
                local E2 = "\x01\x05\x29\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6E\x07"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E2)
                print ("UART TX = E2")
                print(string.toHex(E2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E3") then
                pm.wake("UART_SENT2MCU")
                local E3 = "\x01\x05\x2A\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2E\xF6"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E3)
                print ("UART TX = E3")
                print(E3)
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E4") then
                pm.wake("UART_SENT2MCU")
                local E4 = "\x01\x05\x2B\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xEF\x66"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E4)
                print ("UART TX = E4")
                print(string.toHex(E4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E5") then
                pm.wake("UART_SENT2MCU")
                local E5 = "\x01\x05\x2C\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAD\x54"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E5)
                print ("UART TX = E5")
                print(string.toHex(E5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E6") then
                pm.wake("UART_SENT2MCU")
                local E6 = "\x01\x05\x2D\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6C\xC4"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E6)
                print ("UART TX = E6")
                print(string.toHex(E6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## COLOUM 6 / F ##########
-- ===========================================================
            elseif string.match(data.payload , "F1") then
                pm.wake("UART_SENT2MCU")
                local F1 = "\x01\x05\x32\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x24\xFC"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F1)
                print ("UART TX = F1")
                print(string.toHex(F1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F2") then
                pm.wake("UART_SENT2MCU")
                local F2 = "\x01\x05\x33\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE5\x6C"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F2)
                print ("UART TX = F2")
                print(string.toHex(F2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F3") then
                pm.wake("UART_SENT2MCU")
                local F3 = "\x01\x05\x34\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA7\x5E"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F3)
                print ("UART TX = F3")
                print(string.toHex(F3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F4") then
                pm.wake("UART_SENT2MCU")
                local F4 = "\x01\x05\x35\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x66\xCE"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F4)
                print ("UART TX = F4")
                print(string.toHex(F4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F5") then
                pm.wake("UART_SENT2MCU")
                local F5 = "\x01\x05\x36\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x26\x3F"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F5)
                print ("UART TX = F5")
                print(string.toHex(F5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F6") then
                pm.wake("UART_SENT2MCU")
                local F6 = "\x01\x05\x37\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE7\xAF"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F6)
                print ("UART TX = F6")
                print(string.toHex(F6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## COLOUM 7 / G ##########
-- ===========================================================
            elseif string.match(data.payload , "G1") then
                pm.wake("UART_SENT2MCU")
                local G1 = "\x01\x05\x3C\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE0\x98"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G1)
                print ("UART TX = G1")
                print(string.toHex(G1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "G2") then
                pm.wake("UART_SENT2MCU")
                local G2 = "\x01\x05\x3D\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x08"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G2)
                print ("UART TX = G2")
                print(string.toHex(G2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "G3") then
                pm.wake("UART_SENT2MCU")
                local G3 = "\x01\x05\x3E\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\xF9"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G3)
                print ("UART TX = G3")
                print(string.toHex(G3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "G4") then
                pm.wake("UART_SENT2MCU")
                local G4 = "\x01\x05\x3F\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE0\x69"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G4)
                print ("UART TX = G4")
                print(string.toHex(G4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "G5") then
                pm.wake("UART_SENT2MCU")
                local G5 = "\x01\x05\x40\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x79"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G5)
                print ("UART TX = G5")
                print(string.toHex(G5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "G6") then
                pm.wake("UART_SENT2MCU")
                local G6 = "\x01\x05\x41\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x41\xE9"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G6)
                print ("UART TX = G6")
                print(string.toHex(G6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## COLOUM 8 / H ##########
-- ===========================================================
            elseif string.match(data.payload , "H1") then
                pm.wake("UART_SENT2MCU")
                local H1 = "\x01\x05\x46\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\xDB"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H1)
                print ("UART TX = H1")
                print(string.toHex(H1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H2") then
                pm.wake("UART_SENT2MCU")
                local H2 = "\x01\x05\x47\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC2\x4B"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H2)
                print ("UART TX = H2")
                print(string.toHex(H2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H3") then
                pm.wake("UART_SENT2MCU")
                local H3 = "\x01\x05\x48\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x87\xBF"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H3)
                print ("UART TX = H3")
                print(string.toHex(H3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H4") then
                pm.wake("UART_SENT2MCU")
                local H4 = "\x01\x05\x49\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x46\x2F"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H4)
                print ("UART TX = H4")
                print(string.toHex(H4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H5") then
                pm.wake("UART_SENT2MCU")
                local H5 = "\x01\x05\x4A\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x06\xDE"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H5)
                print ("UART TX = H5")
                print(string.toHex(H5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H6") then
                pm.wake("UART_SENT2MCU")
                local H6 = "\x01\x05\x4B\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC7\x4E"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H6)
                print ("UART TX = H6")
                print(H6)
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## COLOUM 9 / I ##########
-- ===========================================================
            elseif string.match(data.payload , "I1") then
                pm.wake("UART_SENT2MCU")
                local I1 = "\x01\x05\x50\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8D\xB5"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I1)
                print ("UART TX = I1")
                print(string.toHex(I1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I2") then
                pm.wake("UART_SENT2MCU")
                local I2 = "\x01\x05\x51\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4C\x25"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I2)
                print ("UART TX = I2")
                print(string.toHex(I2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I3") then
                pm.wake("UART_SENT2MCU")
                local I3 = "\x01\x05\x52\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0C\xD4"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I3)
                print ("UART TX = I3")
                print(string.toHex(I3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I4") then
                pm.wake("UART_SENT2MCU")
                local I4 = "\x01\x05\x53\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xCD\x44"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I4)
                print ("UART TX = I4")
                print(string.toHex(I4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I5") then
                pm.wake("UART_SENT2MCU")
                local I5 = "\x01\x05\x54\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8F\x76"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I5)
                print ("UART TX = I5")
                print(string.toHex(I5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I6") then
                pm.wake("UART_SENT2MCU")
                local I6 = "\x01\x05\x55\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4E\xE6"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I6)
                print ("UART TX = I6")
                print(string.toHex(I6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## COLOUM 10 / J ##########
-- ===========================================================
            elseif string.match(data.payload , "J1") then
                pm.wake("UART_SENT2MCU")
                local J1 = "\x01\x05\x5A\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0B\x12"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J1)
                print ("UART TX = J1")
                print(string.toHex(J1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J2") then
                pm.wake("UART_SENT2MCU")
                local J2 = "\x01\x05\x5B\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xCA\x82"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J2)
                print ("UART TX = J2")
                print(string.toHex(J2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J3") then
                pm.wake("UART_SENT2MCU")
                local J3 = "\x01\x05\x5C\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x88\xB0"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J3)
                print ("UART TX = J3")
                print(string.toHex(J3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J4") then
                pm.wake("UART_SENT2MCU")
                local J4 = "\x01\x05\x5D\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x49\x20"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J4)
                print ("UART TX = J4")
                print(string.toHex(J4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J5") then
                pm.wake("UART_SENT2MCU")
                local J5 = "\x01\x05\x5E\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09\xD1"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J5)
                print ("UART TX = J5")
                print(string.toHex(J5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J6") then
                pm.wake("UART_SENT2MCU")
                local J6 = "\x01\x05\x5F\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC8\x41"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J6)
                print ("UART TX = J6")
                print(string.toHex(J6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            else
                print("INPUT ERROR")
                break
            end
        else
            break
        end
    end
	
    return result or data=="timeout" or data=="APP_SOCKET_SEND_DATA"
end
