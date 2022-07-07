---Module functions:
--network management, signal query, GSM network status query, network light control, near cell information query
-- @module net
-- @author openLuat
-- @license MIT
-- @copyright openLuat
-- @release 2017.02.17

require "sys"
require "ril"
require "pio"
require "sim"
require "log"
require "utils"
module(..., package.seeall)

--Load commonly used global functions locally
local publish = sys.publish

--netmode define
NetMode_noNet=   0
NetMode_GSM=     1--2G
NetMode_EDGE=    2--2.5G
NetMode_TD=      3--3G
NetMode_LTE=     4--4G
NetMode_WCDMA=   5--3G
local netMode = NetMode_noNet

--The network status：
--INIT：The state in power-on initialization
--REGISTERED：Register on the GSM network
--UNREGISTER：GSM network is not registered
local state = "INIT"
--SIM Card status：true is an exception，false Or nil is normal
local simerrsta
-- Flight mode status
flyMode = false

--lac：Location ID
--ci：Cell ID
--rssi：Signal strength
--rsrp：Signal receives power
local lac, ci, rssi, rsrp = "", "", 0, 0

--cellinfo：The current and adjacent cell information table
--multicellcb：Gets a callback function for multiple cells
local cellinfo, multicellcb = {}
local curCellSeted

local function cops(data)
    --+COPS: 0,2,"46000",7
    local fmt,oper = data:match('COPS:%s*%d+%s*,(%d+)%s*,"(%d+)"')
    log.info("cops",fmt,oper,curCellSeted)
    if fmt=="2" and not curCellSeted then
        cellinfo[1].mcc = tonumber(oper:sub(1,3),16)
        cellinfo[1].mnc = tonumber(oper:sub(4,5),16)
    end
end

--[[
The function name：creg
function  ：Resolve the CREG information
parameter  ：data：CREG information string，For example +CREG: 2、+CREG: 1,"18be","93e1"、+CREG: 5,"18a7","cb51"
Returns the value：none
]]
local function creg(data)
    local p1, s,act
    local prefix = (netMode == NetMode_LTE) and "+CEREG: " or (netMode == NetMode_noNet and "+CREG: " or "+CGREG: ")
    log.info("net.creg1",netMode,prefix)
    if not data:match(prefix) then
        --log.info("net.creg2",prefix)
        if prefix=="+CREG: " then
            --log.info("net.creg3")
            prefix = "+CGREG: "
            if not data:match("+CGREG: ") then
                log.warn("net.creg1","no match",data)
                return
            end
        elseif prefix=="+CGREG: " then
            --log.info("net.creg4")
            prefix = "+CREG: "
            if not data:match("+CREG: ") then
                log.warn("net.creg2","no match",data)
                return
            end
        end        
    end
    --Get the registration status
    _, _, p1 = data:find(prefix .. "%d,(%d+)")
    --log.info("net.creg5",p1 == nil)
    if p1 == nil then
        _, _, p1 = data:find(prefix .. "(%d+)")
        --log.info("net.creg6",p1 == nil)
        if p1 == nil then return end
        act = data:match(prefix .. "%d+,.-,.-,(%d+)")
    else
        act = data:match(prefix .. "%d,%d+,.-,.-,(%d+)")
    end
    
    log.info("net.creg7",p1,act)

    --Set the registration status
    s = (p1=="1" or p1=="5") and "REGISTERED" or "UNREGISTER"
    
    --log.info("net.creg8",s,state)
    if prefix=="+CGREG: " and s=="UNREGISTER" then
        log.info("net.creg9 ignore!!!")
        return
    end
    --The registration status has changed
    if s ~= state then
        --Near the cell query processing
        if s == "REGISTERED" then
            --An internal message is generated NET_STATE_CHANGED indicating a change in the GSM network registration status
            publish("NET_STATE_REGISTERED")
            cengQueryPoll()
        end
        state = s
    end
    --Registered and lac or ci has changed
    if state == "REGISTERED" then
        p2, p3 = data:match("\"(%x+)\",\"(%x+)\"")
        if p2 and p3 and (lac ~= p2 or ci ~= p3) then
            lac = p2
            ci = p3
            --An internal message is generated NET_CELL_CHANGED indicating a change in lac or ci
            publish("NET_CELL_CHANGED")
            --cellinfo[1].mcc = tonumber(sim.getMcc(),16)
            --cellinfo[1].mnc = tonumber(sim.getMnc(),16)
            cellinfo[1].lac = tonumber(lac,16)
            cellinfo[1].ci = tonumber(ci,16)
            cellinfo[1].rssi = 28
        end

        if act then
            if act=="0" then
                UpdNetMode("^MODE: 3,1")
            elseif act=="1" then
                UpdNetMode("^MODE: 3,2")
            elseif act=="3" then
                UpdNetMode("^MODE: 3,3")
            elseif act=="7" then
                UpdNetMode("^MODE: 17,17")
            else
                UpdNetMode("^MODE: 5,7")
            end
        end
    end
end

--[[
The function name：resetcellinfo
Feature: Reset the current and adjacent cell information tables
Argument: None
Return value: None
]]
local function resetCellInfo()
    local i
    cellinfo.cnt = 11 --最大个数
    for i = 1, cellinfo.cnt do
        cellinfo[i] = {}
        cellinfo[i].mcc, cellinfo[i].mnc = nil
        cellinfo[i].lac = 0
        cellinfo[i].ci = 0
        cellinfo[i].rssi = 0
        cellinfo[i].ta = 0
    end
end

--[[
The function name：eemMgInfoSvc
function：Resolve 4G networks，Current and adjacent cell information
参数  ：
data：The current and adjacent cell information strings，For example, each line in the following：
+EEMLTESVC:xx,xx,...
Returns the value：not
]]
local function eemLteSvc(data)
    local mcc,mnc,lac,ci,rssi,svcData
    if data:match("%+EEMLTESVC:%s*%d+,%s*%d+,%s*%d+,%s*.+") then
        svcData = string.match(data, "%+EEMLTESVC:(.+)")
        --log.info("eemLteSvc",svcData)
        if svcData then
            svcDataT = string.split(svcData, ', ')
            --log.info("eemLteSvc1",svcDataT[1],svcDataT[3],svcDataT[4],svcDataT[10],svcDataT[15])
            if not(svcDataT[1] and svcDataT[3] and svcDataT[4] and svcDataT[10] and svcDataT[15]) then
                svcDataT = string.split(svcData, ',')
                log.info("eemLteSvc2",svcDataT[1],svcDataT[3],svcDataT[4],svcDataT[10],svcDataT[15])
            end
            mcc = svcDataT[1]
            mnc = svcDataT[3]
            lac = svcDataT[4]
            ci = svcDataT[10]
            rssi = (tonumber(svcDataT[15])-(tonumber(svcDataT[15])%3))/3
            if rssi>31 then rssi=31 end
            if rssi<0 then rssi=0 end
        end
        log.info("eemLteSvc1",lac,ci,mcc,mnc)
        if lac and lac~="0" and ci and ci ~= "0" and mcc and mnc then
            --If it is the first, clear the information table
            resetCellInfo()
            curCellSeted = true
            --Save mcc、mnc、lac、ci、rssi、ta
            cellinfo[1].mcc = mcc
            cellinfo[1].mnc = mnc
            cellinfo[1].lac = tonumber(lac)
            cellinfo[1].ci = tonumber(ci)
            cellinfo[1].rssi = tonumber(rssi)
            --cellinfo[id + 1].ta = tonumber(ta or "0")
            --Produces an internal message CELL_INFO_IND that indicates that new and adjacent cell information has been read
            if multicellcb then multicellcb(cellinfo) end
            publish("CELL_INFO_IND", cellinfo)
        end
    elseif data:match("%+EEMLTEINTER") or data:match("%+EEMLTEINTRA") or data:match("%+EEMLTEINTERRAT") then
        --data = "+EEMLTEINTRA: 0, 98, 39148, 51, 21, 1120, 0, 6311, 25418539"
        --data = "+EEMLTEINTERRAT:0,16,1120,0,6213,26862,627,1,-77"
        data = data:gsub(" ","")

        if data:match("%+EEMLTEINTERRAT") then
            mcc,mnc,lac,ci,rssi = data:match("[-]*%d+,[-]*%d+,([-]*%d+),([-]*%d+),([-]*%d+),([-]*%d+),[-]*%d+,[-]*%d+,([-]*%d+)")
        else
            rssi,mcc,mnc,lac,ci = data:match("[-]*%d+,[-]*%d+,[-]*%d+,([-]*%d+),[-]*%d+,([-]*%d+),([-]*%d+),([-]*%d+),([-]*%d+)")
        end
        
        --print(mcc,mnc,lac,ci,rssi)

        if rssi then
            rssi = (rssi-(rssi%3))/3
            if rssi>31 then rssi=31 end
            if rssi<0 then rssi=0 end
        end
        if lac~="0" and lac~="-1" and ci~="0" and ci~="-1" then
            for i = 1, cellinfo.cnt do
                --print("cellinfo["..i.."].lac="..cellinfo[i].lac)
                if cellinfo[i].lac==0 then
                    cellinfo[i] = 
                    {
                        mcc = mcc,
                        mnc = mnc,
                        lac = tonumber(lac),
                        ci = tonumber(ci),
                        rssi = tonumber(rssi)
                    }
                    break
                end
            end
        end
    end
end
--[[
The function name：eemMgInfoSvc
function  ：Resolve 2G network, current cell
parameter  ：
data：The current cell information string, such as each line below：
+EEMGINFOSVC:xx,xx,...
Return value: None
]]
local function eemGsmInfoSvc(data)
	--Only valid CENG information is processed
	if string.find(data, "%+EEMGINFOSVC:%s*%d+,%s*%d+,%s*%d+,%s*.+") then
		local mcc,mnc,lac,ci,ta,rssi
		local svcData = string.match(data, "%+EEMGINFOSVC:(.+)")
		if svcData then
			svcDataT = string.split(svcData, ', ')
			mcc = svcDataT[1]
			mnc = svcDataT[2]
			lac = svcDataT[3]
			ci = svcDataT[4]
			ta = svcDataT[10]
			rssi = svcDataT[12]
			if tonumber(rssi) >31
				then rssi = 31
			end
			if tonumber(rssi) < 0
				then rssi = 0
			end
		end
		if lac and lac~="0" and ci and ci ~= "0" and mcc and mnc then
			--If it is the first, clear the information table
			resetCellInfo()
         curCellSeted = true
			--save mcc、mnc、lac、ci、rssi、ta
			cellinfo[1].mcc = mcc
			cellinfo[1].mnc = mnc
			cellinfo[1].lac = tonumber(lac)
			cellinfo[1].ci = tonumber(ci)
			cellinfo[1].rssi = (tonumber(rssi) == 99) and 0 or tonumber(rssi)
			cellinfo[1].ta = tonumber(ta or "0")
			--Produces an internal message CELL_INFO_IND that indicates that new and adjacent cell information has been read
			if multicellcb then multicellcb(cellinfo) end
			publish("CELL_INFO_IND", cellinfo)
		end
	end
end
--[[
The function name：eemMgInfoSvc
function  ：Analysis of 2G network, near the cell information
parameter  ：
data：The current and adjacent cell information strings, such as each of the following lines:
+EEMGINFOSVC:xx,xx,...
Return value: None
]]
local function eemGsmNCInfoSvc(data)
	if string.find(data, "%+EEMGINFONC: %d+, %d+, %d+, .+") then
		local mcc,mnc,lac,ci,ta,rssi,id
		local svcData = string.match(data, "%+EEMGINFONC:(.+)")
		if svcData then
			svcDataT = string.split(svcData, ', ')
			id = svcDataT[1]
			mcc = svcDataT[2]
			mnc = svcDataT[3]
			lac = svcDataT[4]
			ci = svcDataT[6]
			rssi = svcDataT[7]
			if tonumber(rssi) >31
				then rssi = 31
			end
			if tonumber(rssi) < 0
				then rssi = 0
			end
		end
		if lac and ci and mcc and mnc then
			--save mcc、mnc、lac、ci、rssi、ta
			cellinfo[id + 2].mcc = mcc
			cellinfo[id + 2].mnc = mnc
			cellinfo[id + 2].lac = tonumber(lac)
			cellinfo[id + 2].ci = tonumber(ci)
			cellinfo[id + 2].rssi = (tonumber(rssi) == 99) and 0 or tonumber(rssi)
			--cellinfo[id + 1].ta = tonumber(ta or "0")
		end
	end
end
--[[
The function name：eemMgInfoSvc
function  ：Analyze 3G network, current cell and adjacent cell information
parameter  ：
data：The current and adjacent cell information strings, such as each of the following lines:
+EEMUMTSSVC:xx,xx,...
Return value: None
]]
local function eemUMTSInfoSvc(data)
	--Only valid CENG information is processed
	if string.find(data, "%+EEMUMTSSVC: %d+, %d+, %d+, .+") then
		local mcc,mnc,lac,ci,rssi
		local svcData = string.match(data, "%+EEMUMTSSVC:(.+)")
		local cellMeasureFlag, cellParamFlag = string.match(data, "%+EEMUMTSSVC:%d+, (%d+), (%d+), .+")
		local svcDataT = string.split(svcData, ', ')
		local offset = 4
		if svcData and svcDataT then
			if tonumber(cellMeasureFlag) ~= 0 then
				offset = offset + 2
				rssi = svcDataT[offset]
				offset = offset + 4
			else 
				offset = offset + 2
				rssi = svcDataT[offset]
				offset = offset + 2
			end

			if tonumber(cellParamFlag) ~= 0 then
				offset = offset + 3
				mcc = svcDataT[offset]
				mnc = svcDataT[offset + 1]
				lac = svcDataT[offset + 2]
				ci  = svcDataT[offset + 3]
				offset = offset + 3
			end
		end
		if lac and lac~="0" and ci and ci ~= "0" and mcc and mnc and rssi then
			--If it is the first, clear the information table
			resetCellInfo()
         curCellSeted = true   
			--save mcc、mnc、lac、ci、rssi、ta
			cellinfo[1].mcc = mcc
			cellinfo[1].mnc = mnc
			cellinfo[1].lac = tonumber(lac)
			cellinfo[1].ci = tonumber(ci)
			cellinfo[1].rssi = tonumber(rssi)
			--Produces an internal message CELL_INFO_IND that indicates that new and adjacent cell information has been read
			if multicellcb then multicellcb(cellinfo) end
			publish("CELL_INFO_IND", cellinfo)
		end
	end
end

--[[
The function name：UpdNetMode
function  ：parse NetMode
parameter  ：data：NetMode Information strings, for example"^MODE: 17,17"
Return value: None
]]
function UpdNetMode(data)
	local _, _, SysMainMode,SysMode = string.find(data, "(%d+),(%d+)")
	local netMode_cur
	log.info("net.UpdNetMode",netMode_cur,netMode, SysMainMode,SysMode)
	if SysMainMode and SysMode then
		if SysMainMode=="3" then
			netMode_cur = NetMode_GSM
		elseif SysMainMode=="5" then
			netMode_cur = NetMode_WCDMA
		elseif SysMainMode=="15" then
			netMode_cur = NetMode_TD
		elseif SysMainMode=="17" then
			netMode_cur = NetMode_LTE
		else
			netMode_cur = NetMode_noNet
		end
		
		if SysMode=="3" then
			netMode_cur = NetMode_EDGE
		end
	end
  
	if netMode ~= netMode_cur then
		netMode = netMode_cur
		publish("NET_UPD_NET_MODE",netMode)
		log.info("net.NET_UPD_NET_MODE",netMode)   
		ril.request("AT+COPS?")
		if netMode == NetMode_LTE then 
			ril.request("AT+CEREG?")  
		elseif netMode == NetMode_noNet then 
			ril.request("AT+CREG?")  
		else
			ril.request("AT+CGREG?")  
		end
	end
end

--[[
The function name：neturc
function  ：The processing of "Registered underlying cores actively reported notifications via virtual serial port" within this functional module
parameter  ：
data：The full string information for the notification
prefix：The prefix of the notification
Return value: None
]]
local function neturc(data, prefix)
    if prefix=="+COPS" then
        cops(data)
    elseif prefix == "+CREG" or prefix == "+CGREG" or prefix == "+CEREG" then
        --When you receive a change in network status, update the signal value
        csqQueryPoll()
        --Resolve the creg information
        creg(data)
    elseif prefix == "+EEMLTESVC" or prefix == "+EEMLTEINTRA" or prefix == "+EEMLTEINTER" or prefix=="+EEMLTEINTERRAT" then
        eemLteSvc(data)
    elseif prefix == "+EEMUMTSSVC" then
        eemUMTSInfoSvc(data)
    elseif prefix == "+EEMGINFOSVC" then
        eemGsmInfoSvc(data)
    elseif prefix == "+EEMGINFONC" then
        eemGsmNCInfoSvc(data)   
    elseif prefix == "^MODE" then
        UpdNetMode(data)
    end
end

--- Set the flight mode
-- Note: If you want to test the power consumption of airplane mode, do not call this interface into airplane mode immediately after powering on
-- Calling this interface into airplane mode is not only ineffective until the module is registered on the network, it also results in an abnormal power consumption data
-- For more information：http://doc.openluat.com/article/488/0
-- @bool mode，true:Flight mode is on，false:Flight mode off
-- @return nil
-- @usage net.switchFly(mode)
function switchFly(mode)
	if flyMode == mode then return end
	flyMode = mode
	-- Handle flight mode
	if mode then
		ril.request("AT+CFUN=0")
	-- Handle exit flight mode
	else
		ril.request("AT+CFUN=1")
		--Process the query timer
		csqQueryPoll()
		cengQueryPoll()
		--Reset the GSM network state
		neturc("2", "+CREG")
	end
end

--- fetch netmode
-- @return number netMode,The type of network registered
-- 0：Not registered
-- 1：2G GSM Internet
-- 2：2.5G EDGE data network
-- 3：3G TD Internet
-- 4：4G LTE Internet
-- 5：3G WCDMA Internet
-- @usage net.getNetMode()
function getNetMode()
	return netMode
end

--- Get the status of your network registration
-- @return string state,GSM The status of the network registration，
-- "INIT" Indicates that initialization is in the process
-- "REGISTERED" Indicates that it is registered
-- "UNREGISTER" Indicates that it is not registered
-- @usage net.getState()
function getState()
	return state
end

--- Gets the current cell mcc
-- @return string mcc,The mcc of the current cell, if the GSM network has not been registered, returns the mcc of the sim card
-- @usage net.getMcc()
function getMcc()
	return cellinfo[1].mcc and string.format("%x",cellinfo[1].mcc) or sim.getMcc()
end

--- Gets the mnc of the current cell
-- @return string mcn,The mnc of the current cell, if the GSM network has not been registered, returns the mnc of the sim card
-- @usage net.getMnc()
function getMnc()
	return cellinfo[1].mnc and string.format("%x",cellinfo[1].mnc) or sim.getMnc()
end

--- Gets the current location ID
-- @return string lac,The current location ID (16-in string, such as "18be") returns if the GSM network is not registered
-- @usage net.getLac()
function getLac()
	return lac
end

--- Gets the current cell ID
-- @return string ci,The current cell ID (16 feed strings, such as "93e1") is returned if the GSM network is not registered.
-- @usage net.getCi()
function getCi()
	return ci
end

--- Get the signal strength
-- Currently registered is the 2G network, that is, the signal strength of the 2G network
-- Currently registered is the 4G network, that is, the signal strength of the 4G network
-- @return number rssi,Current signal strength (value range 0-31)
-- @usage net.getRssi()
function getRssi()
	return rssi
end

--- 4G network signal receives power
-- @return number rsrp,Current signal receive power (value range -140 - -40)
-- @usage net.getRsrp()
function getRsrp()
	return rsrp
end

function getCell()
	local i,ret = 1,""
	for i=1,cellinfo.cnt do
		if cellinfo[i] and cellinfo[i].lac and cellinfo[i].lac ~= 0 and cellinfo[i].ci and cellinfo[i].ci ~= 0 then
			ret = ret..cellinfo[i].ci.."."..cellinfo[i].rssi.."."
		end
	end
	return ret
end

--- Gets stitched strings for current and near location areas, cells, and signal strength
-- @return string cellInfo,Stitch strings for current and near location areas, cells, and signal strength, for example
--"6311.49234.30;6311.49233.23;6322.49232.18;"
-- @usage net.getCellInfo()
function getCellInfo()
	local i, ret = 1, ""
	for i = 1, cellinfo.cnt do
		if cellinfo[i] and cellinfo[i].lac and cellinfo[i].lac ~= 0 and cellinfo[i].ci and cellinfo[i].ci ~= 0 then
			ret = ret .. cellinfo[i].lac .. "." .. cellinfo[i].ci .. "." .. cellinfo[i].rssi .. ";"
		end
	end
	return ret
end

--- Gets the current and near location area, cell、mcc、mnc、and splicing strings of signal strength
-- @return string cellInfo,Current and near location areas, neighborhoods、mcc、mnc、and splicing strings of signal strength,
--for example："460.01.6311.49234.30;460.01.6311.49233.23;460.02.6322.49232.18;"
-- @usage net.getCellInfoExt()
function getCellInfoExt(rssi)
	local i, ret = 1, ""
	for i = 1, cellinfo.cnt do
		if cellinfo[i] and cellinfo[i].mcc and cellinfo[i].mnc and cellinfo[i].lac and cellinfo[i].lac ~= 0 and cellinfo[i].ci and cellinfo[i].ci ~= 0 then
			ret = ret .. string.format("%x",cellinfo[i].mcc) .. "." .. string.format("%x",cellinfo[i].mnc) .. "." .. cellinfo[i].lac .. "." .. cellinfo[i].ci .. "." .. (rssi and (cellinfo[i].rssi*2-113) or cellinfo[i].rssi) .. ";"
		end
	end
	return ret
end

--- Get the TA value
-- @return number ta,TA value
-- @usage net.getTa()
function getTa()
	return cellinfo[1].ta
end

--[[
The function name：rsp
function  ：The answer processing of "AT commands sent to the underlying core software via virtual serial port" in this function module
parameter ：
cmd：This answer corresponds to the AT command
success：AT command execution results, true or false
response：The execution result string in the answer to the AT command
intermediate：Intermediate information in the answer to the AT command
Return value: None
]]
local function rsp(cmd, success, response, intermediate)
	local prefix = string.match(cmd, "AT(%+%u+)")
	
	if intermediate ~= nil then
		if prefix == "+CSQ" then
			local s = string.match(intermediate, "+CSQ:%s*(%d+)")
			if s ~= nil then
				rssi = tonumber(s)
				rssi = rssi == 99 and 0 or rssi
				--产生一个内部消息GSM_SIGNAL_REPORT_IND，表示读取到了信号强度
				publish("GSM_SIGNAL_REPORT_IND", success, rssi)
			end
		elseif prefix == "+CESQ" then
	        local s = string.match(intermediate, "+CESQ: %d+,%d+,%d+,%d+,%d+,(%d+)")
			if s ~= nil then
				rsrp = tonumber(s)
			end
		elseif prefix == "+CENG" then end
	end
    if prefix == "+CFUN" then
        if success then publish("FLYMODE", flyMode) end
    end
end

--- Read "Current and Near Cell Information" in real time
-- @function cbFnc，The callback function, which is called when cell information is read, is called in the form of a callback function：
-- cbFnc(cells)，Where cells are the string type，Format: current and near location, cell、mcc、mnc、and splicing strings of signal strength,
--for example："460.01.6311.49234.30;460.01.6311.49233.23;460.02.6322.49232.18;"
-- @return nil
function getMultiCell(cbFnc)
	multicellcb = cbFnc
	--发送AT+CENG?查询
	ril.request("AT+EEMGINFO?")
end

--- A request to query base station information (current and near cell information).
-- @number period Query interval, in milliseconds
-- @return bool result, true:The query succeeded, false: the query failed
-- @usage net.cengQueryPoll() --Query once
-- @usage net.cengQueryPoll(60000) --Query once per minute
function cengQueryPoll(period)
	-- Not airplane mode and operating mode is full mode
	if not flyMode then
		--Send an AT-CENG? query
		ril.request("AT+EEMGINFO?")
	else
		log.warn("net.cengQueryPoll", "flymode:", flyMode)
	end
	if nil ~= period then
		--Start the timer
		sys.timerStopAll(cengQueryPoll)
		sys.timerStart(cengQueryPoll, period, period)
	end
	return not flyMode
end

--- A request to query the signal strength is initiated
-- @number period Query interval, in milliseconds
-- @return bool , true:The query succeeded, false: the query stopped
-- @usage net.csqQueryPoll() --Query once
-- @usage net.csqQueryPoll(60000) --Query once per minute
function csqQueryPoll(period)
    --Not airplane mode and operating mode is full mode
    if not flyMode then        
        --Send an AT-CSQ query
        ril.request("AT+CSQ")
        ril.request("AT+CESQ")
    else
        log.warn("net.csqQueryPoll", "flymode:", flyMode)
    end
    if nil ~= period then
        --Start the timer
        sys.timerStopAll(csqQueryPoll)
        sys.timerStart(csqQueryPoll, period, period)
    end
    return not flyMode
end


--- Set the interval between querying signal strength and base station information
-- @number ... Query period, variable parameters, parameters nil only query 1 time, parameter 1 is signal strength query cycle, parameter 2 is the base station query cycle
-- @return bool ，true：The setting was successful, false: the setting failed
-- @usage net.startQueryAll()
-- @usage net.startQueryAll(60000) -- 1 minute to query the signal strength, 10 minutes to query the base station information function startQueryAll(...)
-- @usage net.startQueryAll(60000,600000) -- Check the signal strength once a minute，10 minutes to query the base station information once
function startQueryAll(...)
	local arg = { ... }
    csqQueryPoll(arg[1])
    cengQueryPoll(arg[2])
    if flyMode then        
        log.info("sim.startQuerAll", "flyMode:", flyMode)
    end
    return true
end

--- Stop querying for signal strength and base station information
-- @return none
-- @usage net.stopQueryAll()
function stopQueryAll()
    sys.timerStopAll(csqQueryPoll)
    sys.timerStopAll(cengQueryPoll)
end

local sEngMode
--- Set the engineering mode
-- @number[opt=1] mode，Engineering mode, currently only 0 and 1 are supported
-- When mode is 0, near cell queries are not supported and low power consumption is consumed during sleep
-- When mode 1, near cell queries are supported, but power consumption is higher during sleep
-- @return nil
-- @usage
-- net.setEngMode(0)
function setEngMode(mode)
    sEngMode = mode or 1
    ril.request("AT+EEMOPT="..sEngMode,nil,function(cmd,success)
            function retrySetEngMode()
                setEngMode(sEngMode)
            end
            if success then
                sys.timerStop(retrySetEngMode)
            else
                sys.timerStart(retrySetEngMode,3000)
            end
        end)
end

-- When processing SIM card status messages, the SIM card does not work properly when the updated network status is unregistered
sys.subscribe("SIM_IND", function(para)
	log.info("SIM.subscribe", simerrsta, para)
	if simerrsta ~= (para ~= "RDY") then
		simerrsta = (para ~= "RDY")
	end
	--The sim card is not working properly
	if para ~= "RDY" then
		--Update the GSM network status
		state = "UNREGISTER"
		--An internal message NET_STATE_CHANGED that indicates a change in network state
		publish("NET_STATE_UNREGISTER")
	else
		state = "INIT"
	end
end)

--Register the handler for notifications for the sCREG and sCENG notifications
ril.regUrc("+COPS", neturc)
ril.regUrc("+CREG", neturc)
ril.regUrc("+CGREG", neturc)
ril.regUrc("+CEREG", neturc)
--ril.regUrc("+CENG", neturc)
ril.regUrc("+EEMLTESVC", neturc)
ril.regUrc("+EEMLTEINTER", neturc)
ril.regUrc("+EEMLTEINTRA", neturc)
ril.regUrc("+EEMLTEINTERRAT", neturc)
ril.regUrc("+EEMGINFOSVC", neturc)
ril.regUrc("+EEMGINFONC", neturc)
ril.regUrc("+EEMUMTSSVC", neturc)
ril.regUrc("^MODE", neturc)
--ril.regUrc("+CRSM", neturc)
--Register the answer handler for the AT-CCSQ and AT-CENG?commands
ril.regRsp("+CSQ", rsp)
ril.regRsp("+CESQ",rsp)
--ril.regRsp("+CENG", rsp)
ril.regRsp("+CFUN", rsp)-- Flight mode
--Send an AT command
ril.request("AT+COPS?")
ril.request("AT+CREG=2")
ril.request("AT+CGREG=2")
ril.request("AT+CEREG=2")
ril.request("AT+CREG?")
ril.request("AT+CGREG?")
ril.request("AT+CEREG?")
ril.request("AT+CALIBINFO?")
ril.request("AT*BAND?")
setEngMode(1)
--重置当前小区和临近小区信息表
resetCellInfo()
