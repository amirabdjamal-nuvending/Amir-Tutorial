--- Module Function：GPIO function configuretion，including input & output IO, rising & falling edge interrupt IO
-- @module pins
-- @author openLuat
-- @license MIT
-- @copyright openLuat
-- @release 2017.09.23 11:34
require "sys"
module(..., package.seeall)
local interruptCallbacks = {}
local dirs = {}

--- Configure GPIO mode
-- @number pin，GPIO ID
-- GPIO 0 to GPIO 31 is represent pio.P0_0 to pio.P0_31
-- GPIO 32 to GPIO XX is represent pio.P1_0 to pio.P1_(XX-32)，such as GPIO33 as pio.P1_1
-- GPIO 64 to GPIO XX is represnted pio.P2_0 to pio.P2_(XX-64)，such as GPIO65 as pio.P2_1

-- @param val，number、nil or function type
-- OUTPUT Config. for number type，level indicator，0 is LOW，1 is HIGH
-- INPUT Config. it is nil
-- Interupt mode Config. it is function type，represnted an interupt handlers

-- @param pull, number, pio.PULLUP：Pull-up mode, pio.PULLDOWN: Pull-down mode, pio.NOPULL：High resistance
-- If this parameter is not set, the default pull-up reference module's hardware design specification

-- @return function
-- When configured as output mode, the returned function can set the level of the IO
-- When configured as input or interrupt mode, the returned function gets the IO level in real time

-- @usage setOutputFnc = pins.setup(pio.P1_1,0)，configure GPIO 33，output mode，default ouput low
-- Executing setOutputFnc(0) outputs a low level，and executing setOutputFnc(1) a high level

-- @usage getInputFnc = pins.setup(pio.P1_1,intFnc)，configure GPIO33，interupt mode
-- The intFnc(msg) function is automatically called when an interrupt is generated:
-- when the rising edge is interrupted cpu.INT_GPIO_NEGEDGE: msg is cpu.INT_GPIO_POSEDGE;
-- The current level is obtained by executing getInputFnc(),
-- if it is low, getInputFnc() returns 0, and if it is high, getInputFnc() returns 1

-- @usage getInputFnc = pins.setup(pio. P1_1), configure GPIO33, input mode
-- The current level is obtained by executing getInputFnc(),
-- if it is low, getInputFnc() returns 0, and if it is high, getInputFnc() returns 1

-- @usage
-- Some GPIO needs to open the corresponding LDO voltage domain before it can be configured to work properly,
-- and the voltage domain and the corresponding GPIO relationship are as follows
--pmd.ldoset(x,pmd.LDO_VSIM1) -- GPIO 29、30、31
--pmd.ldoset(x,pmd.LDO_VLCD) -- GPIO 0、1、2、3、4
--pmd.ldoset(x,pmd.LDO_VMMC) -- GPIO 24、25、26、27、28
--x=0 time：Turn off LDO
--x=1 time ：LD0 = 1.716V
--x=2 ：LDO = 1.828V
--x=3 ：LDO = 1.939V
--x=4 ：LDO = 2.051V
--x=5 ：LD0 = 2.162V
--x=6 ：LDO = 2.271V
--x=7 ：LDO = 2.375V
--x=8 ：LDO = 2.493V
--x=9 ：LDO = 2.607V
--x=10 ：LDO = 2.719V
--x=11 ：LDO = 2.831V
--x=12 ：LDO = 2.942V
--x=13 ：LDO = 3.054V
--x=14 ：LDO = 3.165V
--x=15 ：LDO = 3.177V

-- In addition to the GPIO listed above,
-- the rest of the GPIO does not need to open a specific voltage domain, can be configured directly to work

function setup(pin, val, pull)
    -- Turn off IO
    pio.pin.close(pin)
    -- Interupt mode configurations
    if type(val) == "function" then
        pio.pin.setdir(pio.INT, pin)
        if pull then pio.pin.setpull(pull or pio.PULLUP, pin) end
        -- Register the handler for pin interupt
        interruptCallbacks[pin] = val
        dirs[pin] = false
        return function()
            return pio.pin.getval(pin)
        end
    end
    -- The output mode initializes the default configurations
    if val ~= nil then
        dirs[pin] = true
        pio.pin.setdir(val == 1 and pio.OUTPUT1 or pio.OUTPUT, pin)
    else
        -- Input mode initializes the defaults configurations
        dirs[pin] = false
        pio.pin.setdir(pio.INPUT, pin)
        if pull then pio.pin.setpull(pull or pio.PULLUP, pin) end
    end
    -- Returns a function that automatically switches input and output modes
    return function(val)
        val = tonumber(val)
        if (not val and dirs[pin]) or (val and not dirs[pin]) then
            pio.pin.close(pin)
            pio.pin.setdir(val and (val == 1 and pio.OUTPUT1 or pio.OUTPUT) or pio.INPUT, pin)
            if not val and pull then pio.pin.setpull(pull or pio.PULLUP, pin) end
            dirs[pin] = val and true or false
            return val or pio.pin.getval(pin)
        end
        if val then
            pio.pin.setval(val, pin)
            return val
        else
            return pio.pin.getval(pin)
        end
    end
end

--- Turn off GPIO mode
-- @number pin，GPIO ID
--
-- GPIO 0 to GPIO 31 is represented as pio. P0_0 to pio. P0_31
--
-- GPIO 32 to GPIO XX is represented as pio.P1_0 to pio. P1_ (XX-32), such as GPIO33, is represented as pio. P1_1
-- @usage pins.close(pio. P1_1), turn off GPIO33
function close(pin)
    pio.pin.close(pin)
end

rtos.on(rtos.MSG_INT, function(msg)
    if interruptCallbacks[msg.int_resnum] == nil then
        log.warn('pins.rtos.on', 'warning:rtos.MSG_INT callback nil', msg.int_resnum)
    end
    interruptCallbacks[msg.int_resnum](msg.int_id)
end)
