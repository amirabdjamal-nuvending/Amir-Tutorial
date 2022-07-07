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
            -- ########## ROW 1 / A ##########
-- ===========================================================
            if string.match(data.payload , "A1") then
                pm.wake("UART_SENT2MCU")
                local A1 = "\x01\x05\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB1\x48"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A1)
                print(string.toHex(A1))
                print("UART TX = A1")
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "A2") then
                pm.wake("UART_SENT2MCU")
                local A2 = "\x01\x05\x01\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x70\xD8"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A2)
                print("UART TX = A2")
                print(string.toHex(A2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "A3") then
                pm.wake("UART_SENT2MCU")
                local A3 = "\x01\x05\x02\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x30\x29"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A3)
                print ("UART TX = A3")
                print(string.toHex(A3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "A4") then
                pm.wake("UART_SENT2MCU")
                local A4 = "\x01\x05\x03\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF1\xB9"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A4)
                print ("UART TX = A4")
                print(string.toHex(A4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "A5") then
                pm.wake("UART_SENT2MCU")
                local A5 = "\x01\x05\x04\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB3\x8B"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A5)
                print ("UART TX = A5")
                print(string.toHex(A5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "A6") then
                pm.wake("UART_SENT2MCU")
                local A6 = "\x01\x05\x05\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x72\x1B"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A6)
                print ("UART TX = A6")
                print(string.toHex(A6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "A7") then
                pm.wake("UART_SENT2MCU")
                local A7 = "\x01\x05\x06\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x32\xEA"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A7)
                print ("UART TX = A7")
                print(string.toHex(A7))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "A8") then
                pm.wake("UART_SENT2MCU")
                local A8 = "\x01\x05\x07\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF3\x7A"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A8)
                print ("UART TX = A8")
                print(string.toHex(A8))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "A9") then
                pm.wake("UART_SENT2MCU")
                local A9 = "\x01\x05\x08\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB6\x8E"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A9)
                print ("UART TX = A9")
                print(string.toHex(A9))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "10A") then
                pm.wake("UART_SENT2MCU")
                local A10 = "\x01\x05\x09\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x77\x1E"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,A10)
                print ("UART TX = A10")
                print(string.toHex(A10))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
-- ===========================================================
            -- ########## ROW 2 / B ##########
-- ===========================================================
            elseif string.match(data.payload , "B1") then
                pm.wake("UART_SENT2MCU")
                local B1 = "\x01\x05\x0A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x37\xEF"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B1)
                print ("UART TX = B1")
                print(string.toHex(B1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B2") then
                pm.wake("UART_SENT2MCU")
                local B2 = "\x01\x05\x0B\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF6\x7F"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B2)
                print ("UART TX = B2")
                print(string.toHex(B2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B3") then
                pm.wake("UART_SENT2MCU")
                local B3 = "\x01\x05\x0C\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB4\x4D"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B3)
                print ("UART TX = A3")
                print(string.toHex(B3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B4") then
                pm.wake("UART_SENT2MCU")
                local B4 = "\x01\x05\x0D\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x75\xDD"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B4)
                print ("UART TX = B4")
                print(string.toHex(B4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B5") then
                pm.wake("UART_SENT2MCU")
                local B5 = "\x01\x05\x0E\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x35\x2C"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B5)
                print ("UART TX = B5")
                print(string.toHex(B5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B6") then
                pm.wake("UART_SENT2MCU")
                local B6 = "\x01\x05\x0F\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF4\xBC"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B6)
                print ("UART TX = B6")
                print(string.toHex(B6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "B7") then
                pm.wake("UART_SENT2MCU")
                local B7 = "\x01\x05\x10\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xBC\x84"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B7)
                print ("UART TX = B7")
                print(string.toHex(B7))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "B8") then
                pm.wake("UART_SENT2MCU")
                local B8 = "\x01\x05\x11\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7D\x14"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B8)
                print ("UART TX = B8")
                print(string.toHex(B8))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "B9") then
                pm.wake("UART_SENT2MCU")
                local B9 = "\x01\x05\x12\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3D\xE5"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B9)
                print ("UART TX = B8")
                print(string.toHex(B9))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "10B") then
                pm.wake("UART_SENT2MCU")
                local B10 = "\x01\x05\x13\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFC\x75"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,B10)
                print ("UART TX = B10")
                print(string.toHex(B10))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## ROW 3 / C ##########
-- ===========================================================
            elseif string.match(data.payload , "C1") then
                pm.wake("UART_SENT2MCU")
                local C1 = "\x01\x05\x14\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xBE\x47"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C1)
                print ("UART TX = C1")
                print(string.toHex(C1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C2") then
                pm.wake("UART_SENT2MCU")
                local C2 = "\x01\x05\x15\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7F\xD7"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C2)
                print ("UART TX = C2")
                print(string.toHex(C2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C3") then
                pm.wake("UART_SENT2MCU")
                local C3 = "\x01\x05\x16\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3F\x26"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C3)
                print ("UART TX = C3")
                print(string.toHex(C3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C4") then
                pm.wake("UART_SENT2MCU")
                local C4 = "\x01\x05\x17\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFE\xB6"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C4)
                print ("UART TX = C4")
                print(string.toHex(C4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C5") then
                pm.wake("UART_SENT2MCU")
                local C5 = "\x01\x05\x18\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xBB\x42"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C5)
                print ("UART TX = C5")
                print(string.toHex(C5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C6") then
                pm.wake("UART_SENT2MCU")
                local C6 = "\x01\x05\x19\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7A\xD2"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C6)
                print ("UART TX = C6")
                print(string.toHex(C6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C7") then
                pm.wake("UART_SENT2MCU")
                local C7 = "\x01\x05\x1A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3A\x23"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C7)
                print ("UART TX = C7")
                print(string.toHex(C7))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C8") then
                pm.wake("UART_SENT2MCU")
                local C8 = "\x01\x05\x1B\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFB\xB3"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C8)
                print ("UART TX = C8")
                print(string.toHex(C8))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "C9") then
                pm.wake("UART_SENT2MCU")
                local C9 = "\x01\x05\x1C\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xB9\x81"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C9)
                print ("UART TX = C9")
                print(string.toHex(C9))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "10C") then
                pm.wake("UART_SENT2MCU")
                local C10 = "\x01\x05\x1D\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x78\x11"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,C10)
                print ("UART TX = C10")
                print(string.toHex(C10))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## ROW 4 / D ##########
-- ===========================================================
            elseif string.match(data.payload , "D1") then
                pm.wake("UART_SENT2MCU")
                local D1 = "\x01\x05\x1E\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x38\xE0"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D1)
                print ("UART TX = D1")
                print(string.toHex(D1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D2") then
                pm.wake("UART_SENT2MCU")
                local D2 = "\x01\x05\x1F\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF9\x70"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D2)
                print ("UART TX = D2")
                print(string.toHex(D2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D3") then
                pm.wake("UART_SENT2MCU")
                local D3 = "\x01\x05\x20\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA8\x90"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D3)
                print ("UART TX = D3")
                print(string.toHex(D3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D4") then
                pm.wake("UART_SENT2MCU")
                local D4 = "\x01\x05\x21\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x69\x00"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D4)
                print ("UART TX = D4")
                print(string.toHex(D4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D5") then
                pm.wake("UART_SENT2MCU")
                local D5 = "\x01\x05\x22\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x29\xF1"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D5)
                print ("UART TX = D5")
                print(string.toHex(D5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D6") then
                pm.wake("UART_SENT2MCU")
                local D6 = "\x01\x05\x23\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE8\x61"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D6)
                print ("UART TX = D6")
                print(string.toHex(D6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D7") then
                pm.wake("UART_SENT2MCU")
                local D7 = "\x01\x05\x24\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAA\x53"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D7)
                print ("UART TX = D7")
                print(string.toHex(D7))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D8") then
                pm.wake("UART_SENT2MCU")
                local D8 = "\x01\x05\x25\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6B\xC3"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D8)
                print ("UART TX = D8")
                print(string.toHex(D8))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "D9") then
                pm.wake("UART_SENT2MCU")
                local D9 = "\x01\x05\x26\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2B\x32"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D9)
                print ("UART TX = D9")
                print(string.toHex(D9))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "10D") then
                pm.wake("UART_SENT2MCU")
                local D10 = "\x01\x05\x27\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xEA\xA2"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,D10)
                print ("UART TX = D10")
                print(string.toHex(D10))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
-- ===========================================================
            -- ########## ROW 5 / E ##########
-- ===========================================================
            elseif string.match(data.payload , "E1") then
                pm.wake("UART_SENT2MCU")
                local E1 = "\x01\x05\x28\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAF\x56"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E1)
                print ("UART TX = E1")
                print(string.toHex(E1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E2") then
                pm.wake("UART_SENT2MCU")
                local E2 = "\x01\x05\x29\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6E\xC6"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E2)
                print ("UART TX = E2")
                print(string.toHex(E2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E3") then
                pm.wake("UART_SENT2MCU")
                local E3 = "\x01\x05\x2A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2E\x37"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E3)
                print ("UART TX = E3")
                print(E3)
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E4") then
                pm.wake("UART_SENT2MCU")
                local E4 = "\x01\x05\x2B\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xEF\xA7"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E4)
                print ("UART TX = E4")
                print(string.toHex(E4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E5") then
                pm.wake("UART_SENT2MCU")
                local E5 = "\x01\x05\x2C\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAD\x95"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E5)
                print ("UART TX = E5")
                print(string.toHex(E5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E6") then
                pm.wake("UART_SENT2MCU")
                local E6 = "\x01\x05\x2D\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6C\x05"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E6)
                print ("UART TX = E6")
                print(string.toHex(E6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E7") then
                pm.wake("UART_SENT2MCU")
                local E7 = "\x01\x05\x2E\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2C\xF4"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E7)
                print ("UART TX = E7")
                print(string.toHex(E7))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E8") then
                pm.wake("UART_SENT2MCU")
                local E8 = "\x01\x05\x2F\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xED\x64"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E8)
                print ("UART TX = E8")
                print(string.toHex(E8))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "E9") then
                pm.wake("UART_SENT2MCU")
                local E9 = "\x01\x05\x30\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA5\x5C"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E9)
                print ("UART TX = E9")
                print(string.toHex(E9))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "10E") then
                pm.wake("UART_SENT2MCU")
                local E10 = "\x01\x05\x31\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x64\xCC"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,E10)
                print ("UART TX = E10")
                print(string.toHex(E10))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## ROW 6 / F ##########
-- ===========================================================
            elseif string.match(data.payload , "F1") then
                pm.wake("UART_SENT2MCU")
                local F1 = "\x01\x05\x32\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x24\x3D"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F1)
                print ("UART TX = F1")
                print(string.toHex(F1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F2") then
                pm.wake("UART_SENT2MCU")
                local F2 = "\x01\x05\x33\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE5\xAD"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F2)
                print ("UART TX = F2")
                print(string.toHex(F2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F3") then
                pm.wake("UART_SENT2MCU")
                local F3 = "\x01\x05\x34\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA7\x9F"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F3)
                print ("UART TX = F3")
                print(string.toHex(F3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F4") then
                pm.wake("UART_SENT2MCU")
                local F4 = "\x01\x05\x35\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x66\x0F"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F4)
                print ("UART TX = F4")
                print(string.toHex(F4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F5") then
                pm.wake("UART_SENT2MCU")
                local F5 = "\x01\x05\x36\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x26\xFE"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F5)
                print ("UART TX = F5")
                print(string.toHex(F5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F6") then
                pm.wake("UART_SENT2MCU")
                local F6 = "\x01\x05\x37\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE7\x6E"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F6)
                print ("UART TX = F6")
                print(string.toHex(F6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F7") then
                pm.wake("UART_SENT2MCU")
                local F7 = "\x01\x05\x38\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA2\x9A"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F7)
                print ("UART TX = F7")
                print(string.toHex(F7))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F8") then
                pm.wake("UART_SENT2MCU")
                local F8 = "\x01\x05\x39\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x63\x0A"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F8)
                print ("UART TX = F8")
                print(string.toHex(F8))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "F9") then
                pm.wake("UART_SENT2MCU")
                local F9 = "\x01\x05\x3A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\xFB"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F9)
                print ("UART TX = F9")
                print(string.toHex(F9))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "10F") then
                pm.wake("UART_SENT2MCU")
                local F10 = "\x01\x05\x3B\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE2\x6B"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,F10)
                print ("UART TX = F10")
                print(string.toHex(F10))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## ROW 7 / G ##########
-- ===========================================================
            elseif string.match(data.payload , "G1") then
                pm.wake("UART_SENT2MCU")
                local G1 = "\x01\x05\x3C\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xA0\x59"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G1)
                print ("UART TX = G1")
                print(string.toHex(G1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "G2") then
                pm.wake("UART_SENT2MCU")
                local G2 = "\x01\x05\x3D\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\xC9"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G2)
                print ("UART TX = G2")
                print(string.toHex(G2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "G3") then
                pm.wake("UART_SENT2MCU")
                local G3 = "\x01\x05\x3E\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x38"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G3)
                print ("UART TX = G3")
                print(string.toHex(G3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "G4") then
                pm.wake("UART_SENT2MCU")
                local G4 = "\x01\x05\x3F\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE0\xA8"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G4)
                print ("UART TX = G4")
                print(string.toHex(G4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "G5") then
                pm.wake("UART_SENT2MCU")
                local G5 = "\x01\x05\x40\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\xB8"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G5)
                print ("UART TX = G5")
                print(string.toHex(G5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "G6") then
                pm.wake("UART_SENT2MCU")
                local G6 = "\x01\x05\x41\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x41\x28"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G6)
                print ("UART TX = G6")
                print(string.toHex(G6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")
            
            elseif string.match(data.payload , "G7") then
                pm.wake("UART_SENT2MCU")
                local G7 = "\x01\x05\x42\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\xD9"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G7)
                print ("UART TX = G7")
                print(string.toHex(G7))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "G8") then
                pm.wake("UART_SENT2MCU")
                local G8 = "\x01\x05\x43\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC0\x49"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G8)
                print ("UART TX = G8")
                print(string.toHex(G8))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "G9") then
                pm.wake("UART_SENT2MCU")
                local G9 = "\x01\x05\x44\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x82\x7B"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G9)
                print ("UART TX = G9")
                print(string.toHex(G9))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "10G") then
                pm.wake("UART_SENT2MCU")
                local G10 = "\x01\x05\x45\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x43\xEB"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,G10)
                print ("UART TX = G10")
                print(string.toHex(G10))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## ROW 8 / H ##########
-- ===========================================================
            elseif string.match(data.payload , "H1") then
                pm.wake("UART_SENT2MCU")
                local H1 = "\x01\x05\x46\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x1A"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H1)
                print ("UART TX = H1")
                print(string.toHex(H1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H2") then
                pm.wake("UART_SENT2MCU")
                local H2 = "\x01\x05\x47\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC2\x8A"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H2)
                print ("UART TX = H2")
                print(string.toHex(H2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H3") then
                pm.wake("UART_SENT2MCU")
                local H3 = "\x01\x05\x48\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x87\x7E"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H3)
                print ("UART TX = H3")
                print(string.toHex(H3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H4") then
                pm.wake("UART_SENT2MCU")
                local H4 = "\x01\x05\x49\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x46\xEE"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H4)
                print ("UART TX = H4")
                print(string.toHex(H4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H5") then
                pm.wake("UART_SENT2MCU")
                local H5 = "\x01\x05\x4A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x06\x1F"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H5)
                print ("UART TX = H5")
                print(string.toHex(H5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H6") then
                pm.wake("UART_SENT2MCU")
                local H6 = "\x01\x05\x4B\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC7\x8F"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H6)
                print ("UART TX = H6")
                print(H6)
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H7") then
                pm.wake("UART_SENT2MCU")
                local H7 = "\x01\x05\x4C\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x85\xBD"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H7)
                print ("UART TX = H7")
                print(string.toHex(H7))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H8") then
                pm.wake("UART_SENT2MCU")
                local H8 = "\x01\x05\x4D\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x44\x2D"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H8)
                print ("UART TX = H8")
                print(string.toHex(H8))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H9") then
                pm.wake("UART_SENT2MCU")
                local H9 = "\x01\x05\x4E\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\xDC"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H9)
                print ("UART TX = H9")
                print(string.toHex(H9))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "H10") then
                pm.wake("UART_SENT2MCU")
                local H10 = "\x01\x05\x4F\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC5\x4C"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,H10)
                print ("UART TX = H10")
                print(string.toHex(H10))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## ROW 9 / I ##########
-- ===========================================================
            elseif string.match(data.payload , "I1") then
                pm.wake("UART_SENT2MCU")
                local I1 = "\x01\x05\x50\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8D\x74"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I1)
                print ("UART TX = I1")
                print(string.toHex(I1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I2") then
                pm.wake("UART_SENT2MCU")
                local I2 = "\x01\x05\x51\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4C\xE4"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I2)
                print ("UART TX = I2")
                print(string.toHex(I2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I3") then
                pm.wake("UART_SENT2MCU")
                local I3 = "\x01\x05\x52\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0C\x15"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I3)
                print ("UART TX = I3")
                print(string.toHex(I3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I4") then
                pm.wake("UART_SENT2MCU")
                local I4 = "\x01\x05\x53\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xCD\x85"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I4)
                print ("UART TX = I4")
                print(string.toHex(I4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I5") then
                pm.wake("UART_SENT2MCU")
                local I5 = "\x01\x05\x54\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8F\xB7"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I5)
                print ("UART TX = I5")
                print(string.toHex(I5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I6") then
                pm.wake("UART_SENT2MCU")
                local I6 = "\x01\x05\x55\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4E\x27"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I6)
                print ("UART TX = I6")
                print(string.toHex(I6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I7") then
                pm.wake("UART_SENT2MCU")
                local I7 = "\x01\x05\x56\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0E\xD6"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I7)
                print ("UART TX = I7")
                print(string.toHex(I7))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I8") then
                pm.wake("UART_SENT2MCU")
                local I8 = "\x01\x05\x57\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xCF\x46"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I8)
                print ("UART TX = I8")
                print(string.toHex(I8))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "I9") then
                pm.wake("UART_SENT2MCU")
                local I9 = "\x01\x05\x58\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8A\xB2"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I9)
                print ("UART TX = I9")
                print(string.toHex(I9))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "10I") then
                pm.wake("UART_SENT2MCU")
                local I10 = "\x01\x05\x59\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4B\x22"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,I10)
                print ("UART TX = I10")
                print(string.toHex(I10))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

-- ===========================================================
            -- ########## ROW 10 / J ##########
-- ===========================================================
            elseif string.match(data.payload , "J1") then
                pm.wake("UART_SENT2MCU")
                local J1 = "\x01\x05\x5A\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0B\xD3"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J1)
                print ("UART TX = J1")
                print(string.toHex(J1))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J2") then
                pm.wake("UART_SENT2MCU")
                local J2 = "\x01\x05\x5B\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xCA\x43"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J2)
                print ("UART TX = J2")
                print(string.toHex(J2))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J3") then
                pm.wake("UART_SENT2MCU")
                local J3 = "\x01\x05\x5C\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x88\x71"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J3)
                print ("UART TX = J3")
                print(string.toHex(J3))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J4") then
                pm.wake("UART_SENT2MCU")
                local J4 = "\x01\x05\x5D\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x49\xE1"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J4)
                print ("UART TX = J4")
                print(string.toHex(J4))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J5") then
                pm.wake("UART_SENT2MCU")
                local J5 = "\x01\x05\x5E\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09\x10"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J5)
                print ("UART TX = J5")
                print(string.toHex(J5))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J6") then
                pm.wake("UART_SENT2MCU")
                local J6 = "\x01\x05\x5F\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC8\x80"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J6)
                print ("UART TX = J6")
                print(string.toHex(J6))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J7") then
                pm.wake("UART_SENT2MCU")
                local J7 = "\x01\x05\x60\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x99\x60"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J7)
                print ("UART TX = J7")
                print(string.toHex(J7))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J8") then
                pm.wake("UART_SENT2MCU")
                local J8 = "\x01\x05\x61\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x58\xF0"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J8)
                print ("UART TX = J8")
                print(string.toHex(J8))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "J9") then
                pm.wake("UART_SENT2MCU")
                local J9 = "\x01\x05\x62\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x01"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J9)
                print ("UART TX = J9")
                print(J9)
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            elseif string.match(data.payload , "10J") then
                pm.wake("UART_SENT2MCU")
                local J10 = "\x01\x05\x63\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xD9\x91"
                uart.on(uartID)
                uart.setup(uartID,9600,8,uart.PAR_NONE,uart.STOP_1,nil,1)
                uart.write(uartID,J10)
                print ("UART TX = J10")
                print(string.toHex(J10))
                uart.close(uartID)
                pm.sleep("UART_SENT2MCU")

            else
                print("Testing")
                break
            end
            --TODO：Handle data.payload yourself on demand
        else
            break
        end
    end
	
    return result or data=="timeout" or data=="APP_SOCKET_SEND_DATA"
end
