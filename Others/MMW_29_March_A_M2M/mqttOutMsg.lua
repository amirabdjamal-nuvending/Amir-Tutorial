-- Module function: MQTT client data sending processing


module(...,package.seeall)

require"utils"
require"pm"

local uart_ID = 1

--The message queue for the data sent
local msgQueue = {}

local function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch(".-")..delimiter do
        table.insert(result, match);
    end
    return result;
end

local function insertMsg(topic,payload,qos)
    table.insert(msgQueue,{t=topic,p=payload,q=qos})
    print("MQTT HERE")
    sys.publish("APP_SOCKET_SEND_DATA")
end

--[[ ############## TESTING TO GET TEMPERATURE FROM BOARD ###########]]
--[[ ##### TESTING PURPOSE ONLY ##### ]]
--[[function PubQos0Drop()
    local PubPath = "/devices/SERVER/events"
    local TempBytes = "\x01\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x92\x29"
    pm.wake("UART_SENT2MCU")
    uart.on(uart_ID)
    --check back the baudrate setting
    uart.setup(uart_ID,9600,8,uart.PAR_NONE,uart.STOP_1)
    print("UART Temperature Open")
    uart.write(uart_ID, TempBytes)
    local temp = uart.read(uart_ID, "*l")
    local sendtemp = temp
    print("------------------------------")
    print(sendtemp)
    print("------------------------------")
    --local split_string = Split(temp, "\)
    local sendData = "{\"D\":\"1\", \"T\":\""..sendtemp.."\",".."\"N\": \"2209170001\""..'}'
    
    insertMsg(PubPath,sendData,1)
    print("------------------------")
    print(sendData)
    print("---------------------------")
    print("MQTT OUT")
end ]]

--[[ ########## ORIGINAL USING ARDUINO ##########]]
function PubQos0Drop()
    local PubPath = "/devices/SERVER/events"
    pm.wake("UART_SENT2MCU")
    uart.on(uart_ID)
    --check back the baudrate setting
    uart.setup(uart_ID,9600,8,uart.PAR_NONE,uart.STOP_1)
    print("UART Temperature Open")
    local temp = uart.read(uart_ID, "*s")

    local sendtemp = temp
    local time = misc.getClock()
    local SCTime = os.time{year = time.year, month=time.month, day = time.day, hour = time.hour, min = time.min, sec = time.sec}
    local sendData = "{\"D\":\"1\", \"T\":\""..sendtemp.."\",".."\"N\": \"2109130012\""..",".."\"C\": \"".. SCTime.."\""..'}'
    
    insertMsg(PubPath,sendData,1)
    print("------------------------")
    print(sendData)
    print("---------------------------")
    print("MQTT OUT")
end

--[[ #################### SENDING TEMPERATURE WHEN RECEIVE HI ####################]]
function PubQos0Temp(currentTemp)
    local PubPath = "/devices/SERVER/events"
    local RecTemp2 = currentTemp
    local time = misc.getClock()
    local SCTime = os.time{year = time.year, month=time.month, day = time.day, hour = time.hour, min = time.min, sec = time.sec}
    local sendData2 = "{\"D\":\"1\", \"T\":\""..RecTemp2.."\",".."\"N\": \"2209170001\""..",".."\"C\": \"".. SCTime.."\""..'}'

    insertMsg(PubPath,sendData2,1)
    print("---------------------------------------------------------------------")
    print(sendData2)
    print("---------------------------------------------------------------------")
    print("PUBLISH TEMP -->")
end

--[[ MQTT client data sending processing ]]
-- @param mqttClient，MQTT client object
-- @return Processing returned successfully true，Processing error returns false
-- @usage mqttOutMsg.proc(mqttClient)
function proc(mqttClient)
    while #msgQueue>0 do
        local outMsg = table.remove(msgQueue,1)
        local result = mqttClient:publish(outMsg.t,outMsg.p,outMsg.q)
        -- if outMsg.user and outMsg.user.cb then outMsg.user.cb(result,outMsg.user.para) end
        if not result then return end
    end
    return true
end

