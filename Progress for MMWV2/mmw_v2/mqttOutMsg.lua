-- Module function: MQTT client data sending processing
module(...,package.seeall)

require"utils"
require"pm"
require "mqttTask"

local uart_ID = 1

--The message queue for the data sent
local msgQueue = {}
local identifier = " "
local cmdfrmsrvr = " "

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function Identifier(rec_identifier)
    identifier = rec_identifier
end

function Cmd_from_server(servrcmd)
    cmdfrmsrvr = servrcmd
end

local function insertMsg(topic,payload,qos,retain)
    table.insert(msgQueue,{t=topic,p=payload,q=qos,r=retain})
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
    local PubPath = "BOARD_DATA"
    pm.wake("UART_SENT2MCU")
    uart.on(uart_ID)
    --check back the baudrate setting
    uart.setup(uart_ID,9600,8,uart.PAR_NONE,uart.STOP_1)
    print("UART Temperature Open")
    local read_data = uart.read(uart_ID, "*s")

    -- local time = misc.getClock()
    -- local SCTime = os.time{year = time.year, month=time.month, day = time.day, hour = time.hour, min = time.min, sec = time.sec}
   
    -- Recv from arduino : 6.17_0_0
    local recv_data = read_data
    print(recv_data)
    local recvfrmard = Split(recv_data, "_")
    print(recvfrmard[1])
    print(recvfrmard[2])
    print(recvfrmard[3])

    -- local sendData = "{\"M\":\""..mqttTask.Machine_name().."\",".."\"CM\":\""..cmdfrmsrvr.."\",".."\"ID\": \""..identifier.."\",".."\"T\":\""..recvfrmard[1].."\",".."\"DO\":\""..recvfrmard[2].."\",".."\"DR\":\""..recvfrmard[3].."\""..'}'
    
    local sendData ={
        M = mqttTask.Machine_name(),
        CM = cmdfrmsrvr,
        ID = identifier,
        T = recvfrmard[1],
        DO =recvfrmard[2],
        DR = recvfrmard[3]
    }

    local jsonData = json.encode(sendData)
   --[[         JSON RETURN
   {
        "M"  : "220630",        || MACHINE ID
        "cm" : "A1",            || COMMAND
        "ID" : "22070101",      || IDENTIFIER
        "T"  : "6.24",          || TEMPERATURE
        "DO" : "1 or 0",        || DOOR
        "DR" : "1 or 0"         || DROP
   }
   ]]

    -- insertMsg(PubPath,sendData,1,1)
    insertMsg(PubPath,jsonData,1,1)
    print("**********----- PUBLISH MQTT DATA -----**********")
    print("---------------------------------------------------------------------")
    print(jsonData)
    print("---------------------------------------------------------------------")
end

--[[ #################### PUBLISH START DATA BEFORE EXECUTE MOTOR ####################]]
function PubQosStart()
    local PubPath = "BOARD_DATA"
    -- local sendData2 = "{\"M\":\""..mqttTask.Machine_name().."\",".."\"CM\":\""..cmdfrmsrvr.."\",".."\"ID\": \""..identifier.."\",".."\"T\":\""..RecTemp2.."\",".."\"DO\":\"1\",".."\"DR\":\""..sendtemp.."\""..'}'
    
    local sendDataStart ={
        M = mqttTask.Machine_name(),
        CM = cmdfrmsrvr,
        ID = identifier,
        T = "-127.0",
        DO = "0",
        DR = "0"
    }

    local jsonDataStart = json.encode(sendDataStart)
   --[[         JSON RETURN
   {
        "M"  : "220630",        || MACHINE ID
        "cm" : "A1",            || COMMAND
        "ID" : "22070101",      || IDENTIFIER
        "T"  : "6.24",          || TEMPERATURE
        "DO" : "1 or 0",        || DOOR
        "DR" : "1 or 0"         || DROP
   }
   ]]

    insertMsg(PubPath,jsonDataStart,1,1)
    print("********** PUBLISH START DATA BEFORE EXECUTE MOTOR **********")
    print("---------------------------------------------------------------------")
    print(jsonDataStart)
    print("---------------------------------------------------------------------")  
end

--[[ MQTT client data sending processing ]]
-- @param mqttClient，MQTT client object
-- @return Processing returned successfully true，Processing error returns false
-- @usage mqttOutMsg.proc(mqttClient)
function proc(mqttClient)
    while #msgQueue>0 do
        local outMsg = table.remove(msgQueue,1)
        local result = mqttClient:publish(outMsg.t,outMsg.p,outMsg.q,outMsg.r)
        -- if outMsg.user and outMsg.user.cb then outMsg.user.cb(result,outMsg.user.para) end
        if not result then return end
    end
    return true
end

