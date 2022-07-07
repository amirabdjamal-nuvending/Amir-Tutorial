--- Module function: Serial 2 function test
-- @author openLuat
-- @module uart.testUartTask
-- @license MIT
-- @copyright openLuat
-- @release 2018.05.24

--[[
Note: UART2 will automatically print a log after powering on, Baud rate 921600, this log can not be closed by modifying the software, it is recommended to use UART1 and UART3 first
The UART2 printed Logs are as follows:
RDA8910m Boot_ROM V1.0-17b887ec
HW_CFG: 36
SW_CFG: 0
SE_CFG: 0
check flash img
load complete! checking......
Security Disabled
Check uImage Done
Run ...
]]

module(...,package.seeall)

require"utils"
require"pm"

--[[
Feature definition:
uart receives data, if no new data is received in 100 milliseconds,
prints out all the data that has been received, emptys the data buffer,
replies to the received x frame to the peer, and then waits for the next data to be received

note:
Serial frames do not have a defined structure, software delay alone can not guarantee the integrity of the frame,
if there are strict requirements for the integrity of frame reception,
must customize the frame structure (reference testUart1.lua)

Because in the entire GSM module software system, the accuracy of the software timer can not be guaranteed,
For example, this demo configuration is 100 milliseconds, in the system busy,
the actual delay may be far more than 100 milliseconds,
up to 200 milliseconds, 300 milliseconds, 400 milliseconds and so on

The shorter the delay time set, the greater the error
]]


--Serial ID, 2 for uart2
--If you want to modify it to uart1, assign the UART_ID to 1
local UART_ID = 2


local function taskRead()
    local cacheData,frameCnt = "",0
    while true do
        local s = uart.read(UART_ID,"*l")
        if s == "" then            
            if not sys.waitUntil("UART_RECEIVE",100) then
                --uart receives data, and if no data is received for 100 milliseconds, print out all the data that has been received,
                --empty the data buffer, and wait for the next data to be received

                --note:
                --Serial frames do not have a defined structure, software delay alone can not guarantee the integrity of the frame,
                --if there are strict requirements for the integrity of frame reception,
                --must customize the frame structure (reference testUart1.lua)
                if cacheData:len()>0 then
                    log.info("testUartTask.taskRead","100ms no data, received length",cacheData:len())
                    --Too much data, and if you print it all, you may run out of memory, so only the first 1024 bytes are printed here
                    log.info("testUartTask.taskRead","received data",cacheData:sub(1,1024))
                    cacheData = ""
                    frameCnt = frameCnt+1
                    write("received "..frameCnt.." frame")
                end
            end
        else
            cacheData = cacheData..s            
        end
    end
end

--[[
Function name: write
Function: Send data through a serial port
parameter:
        s: The data to send
Return value: None
]]
function write(s)
    log.info("testUartTask.write",s)
    uart.write(UART_ID,s.."\r\n")
end

local function writeOk()
    log.info("testUartTask.writeOk")
end


--Keep the system awake, here just for testing purposes, so this module has no place to call pm.sleep ("testUartTask") to hibernate and does not enter a low-power hibernation state
--When developing a project that requires low power consumption, be sure to find a way to ensure that pm.wake ("testUartTask") is called when serial porting is not required
pm.wake("testUartTask")
--Register the serial port data to send notification function
uart.on(UART_ID,"sent",writeOk)
uart.on(UART_ID,"receive",function() sys.publish("UART_RECEIVE") end)
--Configure and open the serial port
uart.setup(UART_ID,115200,8,uart.PAR_NONE,uart.STOP_1)

--If you need to turn on the "Send data through asynchronous message notifications" feature, use this line below to comment out the setup on the previous line
--uart.setup(UART_ID,115200,8,uart.PAR_NONE,uart.STOP_1,nil,1)

--Start the serial data reception task
sys.taskInit(taskRead)
