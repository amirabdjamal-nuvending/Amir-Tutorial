--- Module function: MQTT client data reception processing

module(...,package.seeall)

require"utils"
require"pm"
require"All_Motor"
require "mqttOutMsg"

local status = 0

function Start_status(start_data)
    status = start_data
    print(status)
end

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

--- MQTT client data reception processing
-- @param mqttClient，MQTT client object
-- @return Processing successfully returns true，Processing error returns false
-- @usage mqttInMsg.proc(mqttClient.)
function proc(mqttClient)
    local result,data

    while true do
        result,data = mqttClient:receive(300000,"APP_SOCKET_SEND_DATA")
        --The data was received
        if result then
            if status == 1 then
                status = 0
                break
            else
                if string.match(data.payload, "_") then
                    -- Find string _ if there do split, if not break
                    local command = Split(data.payload, "_")
                    print("command : "..command[1])
                    print("identifier : "..command[2])
                    mqttOutMsg.Cmd_from_server(command[1])
                    mqttOutMsg.Identifier(command[2])
                    All_Motor.Run(command[1])
                
                else
                    print(" Wrong Command Format ")
                    break
                end
            end
        else
            break
        end
    end
    return result or data=="timeout" or data=="APP_SOCKET_SEND_DATA"
end