--- 模块功能：网络授时.
-- 重要提醒！！！！！！
-- 本功能模块采用多个免费公共的NTP服务器来同步时间
-- 并不能保证任何时间任何地点都能百分百同步到正确的时间
-- 所以，如果用户项目中的业务逻辑严格依赖于时间同步功能
-- 则不要使用使用本功能模块，建议使用自己的应用服务器来同步时间
-- 参考 http://ask.openluat.com/article/912 加深对授时功能的理解
-- @module ntp
-- @author openLuat
-- @license MIT
-- @copyright openLuat
-- @release 2017.10.21
require "misc"
require "socket"
require "utils"
require "log"
local sbyte, ssub = string.byte, string.sub
module(..., package.seeall)
-- NTP服务器域名集合
local timeServer = {
    "cn.pool.ntp.org",
    "edu.ntp.org.cn",
    "cn.ntp.org.cn",
    "s2c.time.edu.cn",
    "time1.aliyun.com",
    "tw.pool.ntp.org",
    "0.cn.pool.ntp.org",
    "0.tw.pool.ntp.org",
    "1.cn.pool.ntp.org",
    "1.tw.pool.ntp.org",
    "3.cn.pool.ntp.org",
    "3.tw.pool.ntp.org",
}
-- 同步超时等待时间
local NTP_TIMEOUT = 8000
-- 同步是否完成标记
local ntpEnd = false

-- 获取NTP服务器地址列表
-- @return table,服务器地址列表
-- @usage local addtable = ntp.getServers()
function getServers()
    return timeServer
end

-- 设置NTP服务器地址列表
-- @table st,tab类型，服务器地址列表
-- @return 无
-- @usage ntp.getServers({"1edu.ntp.org.cn","cn.ntp.org.cn"})
function setServers(st)
    timeServer = st
end

-- NTP同步标志
-- @return bool,NTP的同步状态true为成功,fasle为失败
-- @usage local sta = ntp.isEnd()
function isEnd()
    return ntpEnd
end

local sTs,sFnc,sFun

--- Synchronization time, 3 attempts per NTP server, timed out 8 seconds, is suitable for being called by task functions
-- @number ts,Synchronize every ts hour
-- @function fnc,Callback function after synchronization success
-- @function fun,Callback function before synchronization success
-- @return nil
-- @usage ntp.ntpTime() -- Sync only once
-- @usage ntp.ntpTime(1) -- Synchronize once in an hour
-- @usage ntp.ntpTime(nil,fnc) -- Synchronize only once, and perform fnc() after successful synchronization
-- @usage ntp.ntpTime(24,fnc) -- 1 synchronization in 24 hours, fnc() after successful synchronization
function ntpTime(ts, fnc, fun)
    local rc, data, ntim
    local sTs,sFnc,sFun = ts or sTs, fnc or sFnc, fun or sFun
    ntpEnd = false
    while true do
        local tUnusedSvr = {}
        for i = 1, #timeServer do
            tUnusedSvr[i] = timeServer[i]
        end
        for i = 1, #timeServer do
            while not socket.isReady() do sys.waitUntil('IP_READY_IND') end
            local c = socket.udp()
            local idx = rtos.tick() % #tUnusedSvr + 1
            if c:connect(tUnusedSvr[idx], "123") then
                if c:send(string.fromHex("E30006EC0000000000000000314E31340000000000000000000000000000000000000000000000000000000000000000")) then
                    rc, data = c:recv(NTP_TIMEOUT)
                    if rc and #data == 48 then
                        ntim = os.date("*t", (sbyte(ssub(data, 41, 41)) - 0x83) * 2 ^ 24 + (sbyte(ssub(data, 42, 42)) - 0xAA) * 2 ^ 16 + (sbyte(ssub(data, 43, 43)) - 0x7E) * 2 ^ 8 + (sbyte(ssub(data, 44, 44)) - 0x80) + 1)
                        if type(sFun) == "function" then sFun() end
                        misc.setClock(ntim, sFnc)
                        ntpEnd = true
                        c:close()
                        break
                    end
                end
            end
            
            local cnt, n, m = #tUnusedSvr, 1
            for m = 1, cnt do
                if m ~= idx then
                    tUnusedSvr[n] = tUnusedSvr[m]
                    n = n + 1
                end
            end
            tUnusedSvr[cnt] = nil
            
            c:close()
            sys.wait(1000)
        end
        if ntpEnd then
            sys.publish("NTP_SUCCEED")
            log.info("ntp.timeSync is date:", ntim.year .. "/" .. ntim.month .. "/" .. ntim.day .. "," .. ntim.hour .. ":" .. ntim.min .. ":" .. ntim.sec)
            if sTs == nil or type(sTs) ~= "number" then break end
            sys.wait(sTs * 3600 * 1000)
        else
            log.warn("ntp.timeSync is error!")
            sys.wait(1000)
        end
    end
end
--- 自动同步时间任务，适合独立执行.
-- 重要提醒！！！！！！
-- 本功能模块采用多个免费公共的NTP服务器来同步时间
-- 并不能保证任何时间任何地点都能百分百同步到正确的时间
-- 所以，如果用户项目中的业务逻辑严格依赖于时间同步功能
-- 则不要使用使用本功能模块，建议使用自己的应用服务器来同步时间
-- @number ts,每隔ts小时同步1次
-- @function fnc,同步成功后回调函数
-- @function fun,同步成功前回调函数
-- @return nil
-- @usage ntp.timeSync() -- Sync only once
-- @usage ntp.timeSync(1) -- Synchronize once in an hour
-- @usage ntp.timeSync(nil,fnc) -- Synchronize only once, and perform fnc() after successful synchronization
-- @usage ntp.timeSync(24,fnc) -- 1 synchronization in 24 hours, fnc() after successful synchronization
function timeSync(ts, fnc, fun)
    sTs,sFnc,sFun = ts, fnc, fun
    sys.taskInit(ntpTime)
end
