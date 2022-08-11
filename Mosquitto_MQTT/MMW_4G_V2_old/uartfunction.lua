module(...,package.seeall)

require"utils"
require"pm"
require "mqttOutMsg"

--[[
Feature definition:
]]

--Serial ID, 1 for uart1
--If want to modify it to uart2, assign the UART_ID to 2
local UART_ID = 1
--The type of frame header and the end of the frame
-- local CMD_SCANNER,CMD_GPIO,CMD_PORT,FRM_TAIL = 1,2,3,string.char(0xC0)
--The data buffer read by the serial port
local rdbuf = ""

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function PubQosStart()
    write("stachck")
end

--[[
Function name: parse
Function: Process a complete piece of frame data according to frame structure resolution
parameter:
        data: All unprocessed data
Return value: The first return value is the result of processing a full frame message, and the second return value is unprocessed data
]]
local function parse(data)
    if not data then return end

    if string.match(data, "_") then
        local stm32data = Split(data, "_")
        if ((stm32data[2] ~= "") == true) and (stm32data[2] ~= nil) then
            if ((stm32data[3] ~= "") == true) and (stm32data[3] ~= nil) then
                if ((stm32data[4] ~= "") == true) and (stm32data[4] ~= nil) then
                    if ((stm32data[5] ~= "") == true) and (stm32data[5] ~= nil) then
                        print("Mode From STM : "..stm32data[1])
                        print("Temperature : "..stm32data[2])
                        print("Door : "..stm32data[3])
                        print("Drop : "..stm32data[4])
                        print("Motor : "..stm32data[5])

                        local data_to_send = stm32data[2].."_"..stm32data[3].."_"..stm32data[4].."_"..stm32data[5]
                        print("Data To Send : "..data_to_send)
    
                       mqttOutMsg.PubQos0Drop(data_to_send)
                    else
                        print("Invalid Motor Data")
                    end
                else
                    print("Invalid Drop Sensor Data")
                end
            else
                print("Invalid Door Data")
            end
        else
            print("Invalid Temperature Data")
        end
    else
        if string.find(data, "DOOR OPEN") then
            print("door opennn\n")
        else
            print("Invalid Command Format")
        end
    end
end

--[[
Function name: proc
Function: Process data read from serial ports
parameter：
        data: Data currently read from a serial port at a time
Return value: None
]]
local function proc(data)
    if not data or string.len(data) == 0 then return end
    -- Append to buffer
    rdbuf = rdbuf..data    
    
    local result,unproc
    unproc = rdbuf
    --The unprocessed data is resolved in a loop based on the frame structure
    while true do
        result,unproc = parse(unproc)
        if not unproc or unproc == "" or not result then
            break
        end
    end

    rdbuf = unproc or ""
end

--[[
Function name: read
Function: Reads the data received by the serial port
Parameter: None
Return value: None
]]
local function read()
    local data = ""
    --In the underlying core, when the serial port receives data:
    --If the receiving buffer is empty, the Lua script is notified of the receipt of new data by interrupt;
    --If the receive buffer is not empty, the Lua script is not notified
    --So when lua script receives interrupt read serial data, 
    --it must read all the data in the receive buffer each time,
    --so as to ensure that the new data in the underlying core is interrupted,
    --as guaranteed in the while statement in this read function
    while true do        
        data = uart.read(UART_ID,"*l")
        if not data or string.len(data) == 0 then break end
        --Opening the print below can take time
        print("-----------------------------------------")
        print("UART Receive : "..data)
        -- log.info("testUart.read bin",data)
        -- log.info("testUart.read hex",data:toHex())
        proc(data)
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
    -- log.info("testUart.write",s)
    -- uart.write(UART_ID,s.."\r\n")
    print("UART WRITE : "..s)
    uart.write(UART_ID,s)
end

local function writeOk()
    log.info("testUart.writeOk")
end


--Keep the system awake, here just for testing purposes, so this module has no place to call pm.sleep ("testUart") hibernate and does not enter a low-power hibernation state
--When developing a project that requires low power consumption, be sure to find a way to ensure that after pm.wake ("testUart"), call pm.sleep when serial porting is not required
pm.wake("testUart")
--Register the data reception function of the serial port, which, when the serial port receives the data, calls the read interface to read the data in an interrupted manner
uart.on(UART_ID,"receive",read)
--Register the serial port data to send notification function
uart.on(UART_ID,"sent",writeOk)

--Configure and open the serial port
uart.setup(UART_ID,115200,8,uart.PAR_NONE,uart.STOP_1)
--If you need to turn on the "Send data through asynchronous message notifications" feature, use this line below to comment out the setup on the previous line
--uart.setup(UART_ID,115200,8,uart.PAR_NONE,uart.STOP_1,nil,1)