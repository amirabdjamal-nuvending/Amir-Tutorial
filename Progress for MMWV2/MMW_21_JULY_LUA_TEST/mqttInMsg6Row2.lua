 --- Module function: MQTT client data reception processing
-- @author openLuat
-- @module mqtt.mqttInMsg
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.28

module(...,package.seeall)

require"utils"
require"pm"
require"All_Motor"

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

            All_Motor.Run(data.payload)

        else
            break
        end
    end
	
    return result or data=="timeout" or data=="APP_SOCKET_SEND_DATA"
end