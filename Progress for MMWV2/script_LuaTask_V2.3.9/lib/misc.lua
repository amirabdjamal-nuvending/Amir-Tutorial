--- Module functions: configuration management - serial number, IMEI, underlying software version number, clock, calibration, flight mode, query battery level and other functions
-- @module misc
-- @author openLuat
-- @license MIT
-- @copyright openLuat
-- @release 2017.10.20
require "ril"
local req = ril.request
module(..., package.seeall)
--sn：Serial number
--imei：IMEI
--calib: Calibration signs
--ant: Coupling test flag bits
local sn, imei, calib, ver, muid, ant
local setSnCbFnc,setImeiCbFnc,setClkCbFnc

local function timeReport()
    sys.publish("TIME_CLK_IND")
    sys.timerStart(setTimeReport,2000)
end

function setTimeReport()
    sys.timerStart(timeReport,(os.time()%60==0) and 50 or (60-os.time()%60)*1000)
end

--[[
The name of the function：rsp
function  ：The response processing of the AT command "sent to the underlying core software via virtual serial port" in this function module
parameter  ：
cmd：This answer corresponds to the AT command
success：AT command execution result, true or false
response：The execution result string in the answer to the AT command
intermediate：Intermediate information in the answer to the AT command
Returns the value：not
]]
local function rsp(cmd, success, response, intermediate)
    local prefix = string.match(cmd, "AT(%+%u+)")
    --查询序列号
    if cmd == "AT+WISN?" then
        result = (intermediate~="*CME ERROR: Missing SN")
        if result then
            sn = intermediate
            sys.publish('SN_READY_IND')
        end
        if setSnCbFnc then setSnCbFnc(result) end        
    --Check IMEI
    elseif cmd == "AT+CGSN" then
        imei = intermediate
        if setImeiCbFnc then setImeiCbFnc(true) end
        sys.publish('IMEI_READY_IND')
    elseif cmd == 'AT+VER' then
        ver = intermediate
    elseif prefix == '+CCLK' then
        if success then
            sys.publish('TIME_UPDATE_IND')
            setTimeReport()
        end
        if setClkCbFnc then setClkCbFnc(getClock(),success) end
    elseif cmd:match("AT%+WISN=") then
        if success then
            req("AT+WISN?")
        else
            if setSnCbFnc then setSnCbFnc(false) end
        end
	elseif cmd:match("AT%+CALIBINFO%?") then
		if intermediate then
			local LTE_afc = intermediate:match("LTE_afc:(%d)")
			local LTE_TDD_agc = intermediate:match("LTE_TDD_agc:(%d)")
			local LTE_TDD_apc = intermediate:match("LTE_TDD_apc:(%d)")
			local LTE_FDD_agc = intermediate:match("LTE_FDD_agc:(%d)")
			local LTE_FDD_apc = intermediate:match("LTE_FDD_apc:(%d)")
			local ANT_LTE = intermediate:match("ANT_LTE:(%d)")
			
			calib = (LTE_afc == "1" and LTE_TDD_agc == "1" and LTE_TDD_apc == "1" and LTE_FDD_agc == "1" and LTE_FDD_apc == "1")
			ant = (ANT_LTE == "1")
		end
    elseif cmd:match("AT%+WIMEI=") then
        if success then
            req("AT+CGSN")
        else
            if setImeiCbFnc then setImeiCbFnc(false) end
        end
    elseif cmd:match("AT%+MUID?") then
        if intermediate then muid = intermediate:match("+MUID:%s*(.+)") end
    end
end

--- Get the core firmware name
-- @return string version，Core firmware name
-- @usage
-- local version = misc.getVersion()
-- If core is Luat_V0026_RDA8910_TTS_FLOAT, version is a "Luat_V0026_RDA8910_TTS_FLOAT" of the string type
function getVersion()
    return rtos.get_version()
end

--- Set the system time
-- @table t,System time, format reference: s year-2017, s-month 2, day-14, hour-14, min-2, sec-58
-- @function[opt=nil] cbFnc，Set the result callback function, which is called in the form of:
-- cnFnc(time，result)，result is true for success, false or nil for failure, time for system time after setting, table type, e.g. synony 2017, month=2, day=14, hour=14,min=19,sec=23?
-- @return nil
-- @usage misc.setClock({year=2017,month=2,day=14,hour=14,min=2,sec=58})
function setClock(t,cbFnc)
    if type(t) ~= "table" or (t.year-2021>38) then
        if cbFnc then cbFnc(getClock(),false) end
        return
    end
    setClkCbFnc = cbFnc
    req(string.format("AT+CCLK=\"%02d/%02d/%02d,%02d:%02d:%02d+32\"", string.sub(t.year, 3, 4), t.month, t.day, t.hour, t.min, t.sec), nil, rsp)
end
--- Get the system time
-- @return table time,{year=2017,month=2,day=14,hour=14,min=19,sec=23}
-- @usage time = getClock()
function getClock()
    return os.date("*t")
end
--- Get the week
-- @return number week，1-7 Monday to Sunday, respectively
-- @usage week = misc.getWeek()
function getWeek()
    local clk = os.date("*t")
    return ((clk.wday == 1) and 7 or (clk.wday - 1))
end
--- Get the calibration mark
-- @return bool calib, true indicates that it has been calibrated, false or nil indicates that it is not calibrated
-- @usage calib = misc.getCalib()
function getCalib()
    return calib
end

--- Gets the coupling test flag
-- @return bool ant, true indicates a coupling test, false or nil indicates an uncouply test
-- @usage ant = misc.getAnt()
function getAnt()
	return ant
end
--- Set up the SN
-- @string s,The string of the new sn
-- @function[opt=nil] cbFnc,Set the result callback function, which is called in the form of a callback function：
-- cnFnc(result)，result For true to indicate success, false or nil to failure
-- @return nil
-- @usagef
-- misc.setSn("1234567890")
-- misc.setSn("1234567890",cbFnc)
function setSn(s, cbFnc)
    if s ~= sn then
        setSnCbFnc = cbFnc
        req("AT+WISN=\"" .. s .. "\"") 
    else
        if cbFnc then cbFnc(true) end
    end
end
--- Get the module serial number
-- @return string sn,Serial number, if not acquired to return""
-- note：After the boot lua script runs, an at command is sent to query sn, so it takes some time to get sn. This interface is called immediately after powering on, essentially returning ""
-- @usage sn = misc.getSn()
function getSn()
    return sn or ""
end
--- Set up IMEI
-- @string s,The new IMEI string
-- @function[opt=nil] cbFnc,Set the result callback function, which is called in the form of a callback function：
-- cnFnc(result)，result for true to indicate success, false or nil to failure
-- @return nil
-- @usage misc.setImei(”359759002514931”)
function setImei(s, cbFnc)
    if s ~= imei then
        setImeiCbFnc = cbFnc
        req("AT+WIMEI=\"" .. s .. "\"")
    else
        if cbFnc then cbFnc(true) end
    end
end
--- Get module IMEI
-- @return string,IMEI number, if not acquired to return""
-- Note: After the power-on lua script runs, a at command is sent to query imei, so it takes some time to get imei. This interface is called immediately after powering on, essentially returning ""
-- @usage imei = misc.getImei()
function getImei()
    return imei or ""
end
--- Get the battery voltage of the VBAT
-- @return number,Battery voltage, mv per unit
-- @usage vb = getVbatt()
function getVbatt()
    local v1, v2, v3, v4, v5 = pmd.param_get()
    return v2
end

--- Gets the VBUS connection status
-- @return boolean，true means VBUS connection, false means not connected
-- @usage vbus = getVbus()
function getVbus()
    local v1, v2, v3, v4, v5 = pmd.param_get()
    log.info("misc.getVbus",v1, v2, v3, v4, v5)
    return v4
end

--- Get the module MUID
-- @return string,MUID if the return is not obtained""
-- Note: After the boot lua script runs, an at command is sent to query the muid, so it takes some time to get the muid. This interface is called immediately after powering on, essentially returning ""
-- @usage muid = misc.getMuid()
function getMuid()
    return muid or ""
end

--- Open and configure PWM (supports 2 PWMs, output only)
-- @number id，PWM output channels, support only 0 and 1
-- 0 Use MODULE_STATUS/GPIO_5 pin
-- 1 Use GPIO_13 pin, note: do not pull the GPIO_13 up to V_GLOBAL_1V8 when powered on, otherwise the module will enter calibration mode, not normal power on
-- @number para1，
-- Para1 represents a divider coefficient with a maximum value of 1024 when the id is 0, and the conversion relationship between the divider coefficient and frequency is: frequency is 2500000/para1, for example, para1 is 5000Hz
-- When the id is 1, para1 represents the clock period, with a value range of 0-7, supporting only integers
--                                         0-7 corresponds to 125, 250, 500, 1000, 1500, 2000, 2500, 3000 milliseconds, respectively
-- @number para2，
-- When the id is 0, para2 represents the duty-to-duty calculation factor, with a maximum value of 512, and the duty-to-duty calculation factor and duty-to-duty ratio are calculated as: duty-to-duty ratio, para2/para1
-- 当id为1时，para2表示一个时钟周期内的高电平时间，取值范围为1-15，仅支持整数
--                                                           1-15分别对应15.6、31.2、46.8、62、78、94、110、125、140、156、172、188、200、218、234毫秒
-- @return nil
-- @usage
-- 通道0，频率为50000Hz，占空比为0.2：
-- 频率为50000Hz，表示时钟周期为1/50000=0.00002秒=0.02毫秒=20微秒  
-- 占空比表示在一个时钟周期内，高电平的时长/时钟周期的时长，本例子中的0.2就表示，高电平时长为4微秒，低电平时长为16微秒
-- misc.openPwm(0,500,100)
--
-- 通道1，时钟周期为500ms，高电平时间为125毫秒：
-- misc.openPwm(1,2,8)
function openPwm(id, para1, para2)
    pwm.open(id)
    pwm.set(id,para1,para2)
end

--- 关闭PWM
-- @number id，PWM输出通道，仅支持0和1
-- 0使用MODULE_STATUS/GPIO_5引脚
-- 1使用GPIO_13引脚，注意：上电的时候不要把 GPIO_13 拉高到V_GLOBAL_1V8，否则模块会进入校准模式，不正常开机
-- @return nil
function closePwm(id)
    assert(id == 0 or id == 1, "closepwm id error: " .. id)
    pwm.close(id)
end

--Register the answer handler for the following AT commands
ril.regRsp("+WISN", rsp)
ril.regRsp("+CGSN", rsp)
ril.regRsp("+MUID", rsp)
ril.regRsp("+WIMEI", rsp)
ril.regRsp("+AMFAC", rsp)
--ril.regRsp('+VER', rsp, 4, '^[%w_]+$')
ril.regRsp("+CALIBINFO",rsp)
--req('AT+VER')
--查询序列号
req("AT+WISN?")
--Check IMEI
req("AT+CGSN")
req("AT+MUID?")
req("AT*EXINFO?")
setTimeReport()
