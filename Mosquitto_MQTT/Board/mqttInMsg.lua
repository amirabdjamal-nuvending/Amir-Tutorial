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
                -- mqttOutMsg.PubQosConnected()
                break
            else
                if string.match(data.payload, "_") then

                    -- Find string _ if there do split, if not break
                    local command = Split(data.payload, "_")
                    print("-----------------------------------------")
                    if ((command[2] ~= "") == true) and (command[2] ~= nil) then
                        if ((command[3] ~= "") == true) and (command[3] ~= nil) then
                            mqttOutMsg.Cmd_from_server(command[1])
                            mqttOutMsg.Date_rec_cmd(command[2])
                            mqttOutMsg.Cmd_count(command[3])
                            All_Motor.Run(command[1])
                        else
                            print("ERROR : Invalid Command Count Format ")
                        end
                    else
                        print("ERROR : Invalid Command Date Format")
                    end
                else
                    print("ERROR : Invalid Command Format ")
                    break
                end
                print("-----------------------------------------")
            end
        else
            break
        end
    end
    return result or data=="timeout" or data=="APP_SOCKET_SEND_DATA"
end