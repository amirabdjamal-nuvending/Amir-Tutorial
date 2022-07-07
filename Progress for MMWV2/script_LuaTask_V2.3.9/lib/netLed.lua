-- module function: Network Indicator module
-- @module netLed
-- @author openLuat
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.14
module(..., package.seeall)

require "pins"
require "sim"

--SIM status：true is abnormal，false or nil is normal
local simError
--Is it in airplane mode：true is YES，false or nil is NO
local flyMode
--Whether to register on the GSM network，true is YES，false or nil is NO
local gsmRegistered
--Whether to register on the GPRS network，true is YES，false or nil is NO
local gprsAttached
--Is there a socket connection on the background，true is YES，false or nil is NO
local socketConnected

--The working status indicated by the network light
--NULL：Function off
--FLYMODE：Flight mode
--SIMERR：No SIM card anomalies such as SIM card or SIM card lock pin code have been detected
--IDLE：GSM network is not registered
--GSM：Registered GSM network
--GPRS：GPRS data network attached
--SCK：socket is connected to the background local 
local ledState = "NULL"
local ON,OFF = 1,2
--Lighting and extinguising time (in milliseconds) configured in various operating states
local ledBlinkTime =
{
    NULL = {0,0xFFFF},  --Always out
    FLYMODE = {0,0xFFFF},  --Often perished
    SIMERR = {300,5700},  --Ligth up 300 milliseconds，out 5700 milliseconds.
    IDLE = {300,3700},  --Ligth up 300 milliseconds，turn off 3700 milliseconds
    GSM = {300,1700},  --Light up 300 milliseconds，turn off 1700 milliseconds
    GPRS = {300,700},  --Ligth up 300 milliseconds，turn off 700 milliseconds
    SCK = {100,100},  --Ligth up 100 milliseconds，turn off 100 milliseconds
}

--Network Ligth Switch，true on，false or nil off
local ledSwitch = false
--Network Indicator Defau PIN Foot（GPIO64）
local LEDPIN = pio.P2_0
--LTE Ligth Switch，true ON，false or nil OFF
local lteSwitch = false
--LTE Default PIN（GPIO65)
local LTEPIN = pio.P2_1


--[[
-- Module Function：Update the working status indicated by the network light
-- Parameter：None
-- Return Value：None
--]]
local function updateState()
    --log.info("netLed.updateState",ledSwitch,ledState,flyMode,simError,gsmRegistered,gprsAttached,socketConnected)
    if ledSwitch then
        local newState = "IDLE"
        if flyMode then
            newState = "FLYMODE"
        elseif simError then
            newState = "SIMERR"
        elseif socketConnected then
            newState = "SCK"
        elseif gprsAttached then
            newState = "GPRS"
        elseif gsmRegistered then
            newState = "GSM"	
        end
        --The status of led changes
        if newState~=ledState then
            ledState = newState
            sys.publish("NET_LED_UPDATE")
        end
    end
end

--[[
-- Module Function：The running task of the network Light Module
-- Parameters：
       ledPinSetFunc：The setting function of the LED GPIO
-- Return Value：None
--]]
local function taskLed(ledPinSetFunc)
    while true do
        --log.info("netLed.taskLed",ledPinSetFunc,ledSwitch,ledState)
        if ledSwitch then
            local onTime,offTime = ledBlinkTime[ledState][ON],ledBlinkTime[ledState][OFF]
            if onTime>0 then
                ledPinSetFunc(1)
                if not sys.waitUntil("NET_LED_UPDATE", onTime) then
                    if offTime>0 then
                        ledPinSetFunc(0)
                        sys.waitUntil("NET_LED_UPDATE", offTime)
                    end
                end
            else if offTime>0 then
                    ledPinSetFunc(0)
                    sys.waitUntil("NET_LED_UPDATE", offTime)
                end
            end            
        else
            ledPinSetFunc(0)
            break
        end
    end
end

--[[
-- Module Function：The running task of the LTE LED module
-- Parameters：
       ledPinSetFunc：The setting funtion of the LED GPIO
-- Return Value：None
--]]
local function taskLte(ledPinSetFunc)
    while true do
        local _,arg = sys.waitUntil("LTE_LED_UPDATE")
        if lteSwitch then
            ledPinSetFunc(arg and 1 or 0)
        end
    end
end

--- Configure the network and LTE indicators and perform the post-configuration action immediately
-- @bool flag，whether to turn on the network light and LTE indicator function，true to ON，false to OFF
-- @number ledPin，GPIO pins that control flashing network light such as pio.P0_1，represent GPIO1
-- @number ltePin，To control the GPIO pins that flash the LTE indicator such as pio.P0_4 represent GPIO4
-- @return nil
-- @usage setup(true,pio.P0_1,pio.P0_4) indicates that the network light & LTE indicator function are turn ON，GPIO1=network ligh，GPIO4=LTE indicator
-- @usage setup(false) means turning off the network and LTE indicator functions
function setup(flag,ledPin,ltePin)
    --log.info("netLed.setup",flag,pin,ledSwitch)    
    local oldSwitch = ledSwitch
    if flag~=ledSwitch then
        ledSwitch = flag
        sys.publish("NET_LED_UPDATE")
    end
    if flag and not oldSwitch then
        sys.taskInit(taskLed, pins.setup(ledPin or LEDPIN, 0))
    end
    if flag~=lteSwitch then
        lteSwitch = flag	
    end  
    if flag and ltePin and not oldSwitch then
        sys.taskInit(taskLte, pins.setup(ltePin, 0))  
    end	
end
-- Configure the duration for which LEDs are ON and OFF in a working state
--(use the default values of the ledBlinkTime configuration in netLed.lua if the user does not configure them)
-- @string state，working state"FLYMODE"、"SIMERR"、"IDLE"、"GSM"、"GPRS"、"SCK"
-- @number on，The indicator lights up for a long time, in milliseconds, 0xFFFF indicates solid and 0 indicates normal
-- @number off，The light goes out for a long time, in milliseconds, 0xFFFF indicates normally off, and 0 is on
-- @return nil
-- @usage updateBlinkTime("FLYMODE",1000,500) Indicates that the flight mode is operating,
--        the light flashing law is: 1 second on, 0.5 seconds off
-- @usage updateBlinkTime("SCK",0xFFFF,0)Indicates that there is a stock connection in the background working state,
--        the light flashing law is: always on
-- @usage updateBlinkTime("SIMERR",0,0xFFFF)Indicates that the SIM card is abnormal, the light flashing law is: normally out

function updateBlinkTime(state,on,off)
    if not ledBlinkTime[state] then log.error("netLed.updateBlinkTime") return end    
    local updated
    if on and ledBlinkTime[state][ON]~=on then
        ledBlinkTime[state][ON] = on
        updated = true
    end
    if off and ledBlinkTime[state][OFF]~=off then
        ledBlinkTime[state][OFF] = off
        updated = true
    end
    --log.info("netLed.updateBlinkTime",state,on,off,updated)
    if updated then sys.publish("NET_LED_UPDATE") end
end

sys.subscribe("FLYMODE", function(mode) if flyMode~=mode then flyMode=mode updateState() end end)
sys.subscribe("SIM_IND", function(para) if simError~=(para~="RDY") then simError=(para~="RDY") updateState() end end)
sys.subscribe("NET_STATE_UNREGISTER", function() if gsmRegistered then gsmRegistered=false updateState() end end)
sys.subscribe("NET_STATE_REGISTERED", function() if not gsmRegistered then gsmRegistered=true updateState() end end)
sys.subscribe("GPRS_ATTACH", function(attach) if gprsAttached~=attach then gprsAttached=attach updateState() end end)
sys.subscribe("SOCKET_ACTIVE", function(active) if socketConnected~=active then socketConnected=active updateState() end end)
sys.subscribe("NET_UPD_NET_MODE", function() if lteSwitch then sys.publish("LTE_LED_UPDATE",net.getNetMode()==net.NetMode_LTE) end end)
