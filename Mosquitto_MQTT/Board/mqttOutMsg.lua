-- Module function: MQTT client data sending processing
module(...,package.seeall)

require"utils"
require"pm"
require "mqttTask"

local uart_ID = 1

--The message queue for the data sent
local msgQueue = {}
-- local identifier = " "
local rec_cmd_count = " "
local cmdfrmsrvr = " "
local send_date = " "
local PubPath = "DATA_2207081"

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

-- function Identifier(rec_identifier)
--     identifier = rec_identifier
-- end

function Cmd_from_server(servrcmd)
    cmdfrmsrvr = servrcmd
    print("Command : "..cmdfrmsrvr)
end

function Date_rec_cmd(rec_date)
    send_date = rec_date
    print("Date : "..send_date)
end

function Cmd_count(rec_count)
    rec_cmd_count = rec_count
    print("CMD_Count : "..rec_cmd_count)
end

local function insertMsg(topic,payload,qos,retain)
    table.insert(msgQueue,{t=topic,p=payload,q=qos,r=retain})
    print("MQTT HERE")
    sys.publish("APP_SOCKET_SEND_DATA")
end

--[[         JSON RETURN TO SERVER
   {
        "M"  : "220630",        || MACHINE ID
        "CM" : "A1",            || COMMAND
        "DT" : "220708",        || DATE
        "C"  : "1"              || COUNT COMMAND RECEIVE
        "T"  : "6.24",          || TEMPERATURE
        "DO" : "1 or 0",        || DOOR
        "DR" : "1 or 0"         || DROP
   }
]]

--[[ ########## ORIGINAL USING ARDUINO ##########]]
function PubQos0Drop()
    -- local PubPath = "BOARD_DATA"
    pm.wake("UART_SENT2MCU")
    uart.on(uart_ID)
    --check back the baudrate setting
    uart.setup(uart_ID,9600,8,uart.PAR_NONE,uart.STOP_1)
    print("UART Temperature Open")
    local read_data = uart.read(uart_ID, "*s")

    -- Recv from arduino : 6.17_0_0

    if read_data == "" then
        print("-----IF-----")
        local recv_data = "0_0_0"
        local recvfrmard = Split(recv_data, "_")
        print(recvfrmard[1])
        print(recvfrmard[2])
        print(recvfrmard[3])

        local sendData ={
            M = mqttTask.Machine_name(),
            CM = cmdfrmsrvr,
            DT = send_date,
            C = rec_cmd_count,
            T = recvfrmard[1],
            DO =recvfrmard[2],
            DR = recvfrmard[3]
        }
    
        local jsonData = json.encode(sendData)
        insertMsg(PubPath,jsonData,1,1)
        print("**********----- PUBLISH MQTT DROP DATA -----**********")
        print("---------------------------------------------------------------------")
        print(jsonData)
        print("---------------------------------------------------------------------")
    else
        print("------- ELSE --------")
        local recv_data = read_data
        local recvfrmard = Split(recv_data, "_")
        print(recvfrmard[1])
        print(recvfrmard[2])
        print(recvfrmard[3])

        local sendData ={
            M = mqttTask.Machine_name(),
            CM = cmdfrmsrvr,
            DT = send_date,
            C = rec_cmd_count,
            T = recvfrmard[1],
            DO =recvfrmard[2],
            DR = recvfrmard[3]
        }
    
        local jsonData = json.encode(sendData)
        insertMsg(PubPath,jsonData,1,1)
        print("**********----- PUBLISH MQTT DROP DATA -----**********")
        print("---------------------------------------------------------------------")
        print(jsonData)
        print("---------------------------------------------------------------------")
    end
    

    -- if (recvfrmard[1] == 0) and (recvfrmard[2] == 0) and (recvfrmard[3] == 0) then
    --     recvfrmard[1] = "0"
    --     recvfrmard[2] = "0"
    --     recvfrmard[3] = "0"
    -- end

    -- local sendData ={
    --     M = mqttTask.Machine_name(),
    --     CM = cmdfrmsrvr,
    --     DT = send_date,
    --     C = rec_cmd_count,
    --     T = recvfrmard[1],
    --     DO =recvfrmard[2],
    --     DR = recvfrmard[3]
    -- }

    -- local jsonData = json.encode(sendData)
    -- insertMsg(PubPath,jsonData,1,1)
    -- print("**********----- PUBLISH MQTT DATA -----**********")
    -- print("---------------------------------------------------------------------")
    -- print(jsonData)
    -- print("---------------------------------------------------------------------")
end

--[[ #################### PUBLISH START DATA BEFORE EXECUTE MOTOR ####################]]
function PubQosStart()
    -- local PubPath = "BOARD_DATA"
    pm.wake("UART_SENT2MCU")
    uart.on(uart_ID)
    --check back the baudrate setting
    uart.setup(uart_ID,9600,8,uart.PAR_NONE,uart.STOP_1)
    -- uart.write(uart_ID,"YO\n")
    uart.write(uart_ID,"MO\n")   -- comment when use DEMO MACHINE (ARD USE NTC 6)
    sys.wait(2000)               -- comment when use DEMO  MACHINE (ARD USE NTC 6)
    print("UART Temperature Open")
    local read_data = uart.read(uart_ID, "*s")

    if read_data == "" then
        print("-----IF-----")
        local recv_data = "0_0_0"
        local recvfrmard = Split(recv_data, "_")
        print(recvfrmard[1])
        print(recvfrmard[2])
        print(recvfrmard[3])

        local sendData ={
            M = mqttTask.Machine_name(),
            CM = cmdfrmsrvr,
            DT = send_date,
            C = rec_cmd_count,
            T = recvfrmard[1],
            DO =recvfrmard[2],
            DR = recvfrmard[3]
        }
    
        local jsonData = json.encode(sendData)
        insertMsg(PubPath,jsonData,1,1)
        print("**********----- PUBLISH MQTT FIRST DATA AFTER COMMAND -----**********")
        print("---------------------------------------------------------------------")
        print(jsonData)
        print("---------------------------------------------------------------------")
    else
        print("------- ELSE --------")
        local recv_data = read_data
        local recvfrmard = Split(recv_data, "_")
        print(recvfrmard[1])
        print(recvfrmard[2])
        print(recvfrmard[3])

        local sendData ={
            M = mqttTask.Machine_name(),
            CM = cmdfrmsrvr,
            DT = send_date,
            C = rec_cmd_count,
            T = recvfrmard[1],
            DO =recvfrmard[2],
            DR = recvfrmard[3]
        }
    
        local jsonData = json.encode(sendData)
        insertMsg(PubPath,jsonData,1,1)
        print("**********----- PUBLISH MQTT FIRST DATA AFTER COMMAND -----**********")
        print("---------------------------------------------------------------------")
        print(jsonData)
        print("---------------------------------------------------------------------")
    end
end

--[[ #################### PUBLISH START DATA BEFORE EXECUTE MOTOR ####################]]
function PubQosConnected()
    local sendDataConnected ={
        M = mqttTask.Machine_name(),
        CM = "0",
        DT = "0",
        C = "0",
        T = "0",
        DO = "0",
        DR = "0"
    }

    local jsonDataConnected = json.encode(sendDataConnected)

    insertMsg(PubPath,jsonDataConnected,1,1)
    print("********** PUBLISH FIRST DATA AFTER SUCCESSFUL CONNECTED TO MQTT **********")
    print("---------------------------------------------------------------------")
    print(jsonDataConnected)
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

