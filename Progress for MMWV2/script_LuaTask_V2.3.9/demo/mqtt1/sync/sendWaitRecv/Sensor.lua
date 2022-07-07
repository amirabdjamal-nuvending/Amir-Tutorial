module(...,package.seeall)

require"utils"
require"pm"
require"mqttOutMsg"

local uartID = 1
local Drop = "\x00"

function SensorDetection()
    uart.on(uartID)
    uart.setup(uartID,300,8,uart.PAR_NONE,uart.STOP_1,nil,1)
    if uart.read(uartID,Drop) then
        mqttOutMsg.pubQos0Drop()
    else
        mqttOutMsg.pubQos0UnDrop()
    end
    uart.close(uartID)
end