module(...,package.seeall)

require"utils"
require"pm"

--[[
Feature definition:
uart receives input from peripherals according to the frame structure and replies to the ASCII string when it receives the correct instructions

The frame structure is as follows:
Frame head: 1 byte, 0x01 for scan instructions, 0x02 for control GPIO commands, 0x03 for control port commands
Frame body: Bytes are not fixed and are related to the frame header
End of frame: 1 byte, fixed to 0xC0

When the received instruction frame header is 0x01，Reply to the peripheral "CMD_SCANNER\r\n"
For example, two bytes of 0x01, 0xC0 received，just reply "CMD_SCANNER\r\n"

When the command frame header received is 0x02，Reply to the peripheral "CMD_GPIO\r\n"
For example, if you receive two bytes of 0x02 0xC0, you reply to "CMD_GPIO\r\n"

When the end of the instruction received is 0x03, reply to "CMD_PORT\r\n" to the peripheral device
For example, when you receive 0x03 0xC0 two bytes, reply to "CMD_PORT\r\n"

When the instruction frame header is received for the rest of the data, reply to "CMD_ERROR\r\n" to the peripheral device,
For example, when receiving 0x04 0xC0 two bytes, reply to "CMD_ERROR\r\n"
]]


--Serial ID, 1 for uart1
--If want to modify it to uart2, assign the UART_ID to 2
local UART_ID = 1
--The type of frame header and the end of the frame
local CMD_SCANNER,CMD_GPIO,CMD_PORT,FRM_TAIL = 1,2,3,string.char(0xC0)
--The data buffer read by the serial port
local rdbuf = ""


--[[
Function name: parse
Function: Process a complete piece of frame data according to frame structure resolution
parameter:
        data: All unprocessed data
Return value: The first return value is the result of processing a full frame message, and the second return value is unprocessed data
]]
local function parse(data)
    if not data then return end    
    
    local tail = string.find(data,string.char(0xC0))
    if not tail then return false,data end    
    local cmdtyp = string.byte(data,1)
    local body,result = string.sub(data,2,tail-1)
    
    log.info("testUart.parse",data:toHex(),cmdtyp,body:toHex())
    
    if cmdtyp == CMD_SCANNER then
        write("CMD_SCANNER")
    elseif cmdtyp == CMD_GPIO then
        write("CMD_GPIO")
    elseif cmdtyp == CMD_PORT then
        write("CMD_PORT")
    else
        write("CMD_ERROR")
    end
    
    return true,string.sub(data,tail+1,-1)    
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
        log.info("testUart.read bin",data)
        log.info("testUart.read hex",data:toHex())
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
    log.info("testUart.write",s)
    uart.write(UART_ID,s.."\r\n")
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
uart.setup(UART_ID,9600,8,uart.PAR_NONE,uart.STOP_1)
--If you need to turn on the "Send data through asynchronous message notifications" feature, use this line below to comment out the setup on the previous line
--uart.setup(UART_ID,115200,8,uart.PAR_NONE,uart.STOP_1,nil,1)
