--- 模块功能：Luat协程调度框架
-- @module sys
-- @author openLuat
-- @license MIT
-- @copyright openLuat
-- @release 2017.9.13
require "utils"
require "log"
require "patch"
module(..., package.seeall)

-- lib脚本版本号，只要lib中的任何一个脚本做了修改，都需要更新此版本号
SCRIPT_LIB_VER = "2.3.9"

-- TaskID maximum
local TASK_TIMER_ID_MAX = 0x1FFFFFFF
-- msgId maximum (do not modify the risk of msgId collision)
local MSG_TIMER_ID_MAX = 0x7FFFFFFF

-- 任务定时器id
local taskTimerId = 0
-- 消息定时器id
local msgId = TASK_TIMER_ID_MAX
-- 定时器id表
local timerPool = {}
local taskTimerPool = {}
--消息定时器参数表
local para = {}
--定时器是否循环表
local loop = {}


-- Start the GSM protocol stack. For example, if the user's long-press key is powered on normally when the GSM stack is not started on the charging power-on, then it is sufficient to call this interface to start the GSM stack
-- @return 无
-- @usage sys.powerOn()
function powerOn()
    rtos.poweron(1)
end

--- 软件重启
-- @string r 重启原因，用户自定义，一般是string类型，重启后的trace中会打印出此重启原因
-- @return 无
-- @usage sys.restart('程序超时软件重启')
function restart(r)
    assert(r and r ~= "", "sys.restart cause null")
    if errDump and errDump.appendErr and type(errDump.appendErr) == "function" then errDump.appendErr("restart[" .. r .. "];") end
    log.warn("sys.restart", r)
    rtos.restart()
end


--- task任务延时函数
-- 只能直接或者间接的被task任务主函数调用，如果定时器创建成功，则本task会挂起
-- @number ms，延时时间，单位毫秒，最小1，最大0x7FFFFFFF
--             实际上支持的最小超时时间是5毫秒，小于5毫秒的时间都会被转化为5毫秒
-- @return result，分为如下三种情况：
--             1、如果定时器创建失败，本task不会被挂起，直接返回nil
--             2、如果定时器创建成功，本task被挂起，超时时间到达后，会激活本task，返回nil
--             3、如果定时器创建成功，本task被挂起，在超时时间到达之前，其他业务逻辑主动激活本task，
--                返回激活时携带的可变参数（如果不是故意为之，可能是写bug了）
-- @usage
-- task延时5秒：
-- sys.taskInit(function()
--     sys.wait(5000)
-- end)
function wait(ms)
    -- 参数检测，参数不能为负值
    assert(ms > 0, "The wait time cannot be negative!")
    --4G底层不支持小于5ms的定时器
    if ms < 5 then ms = 5 end
    -- 选一个未使用的定时器ID给该任务线程
    if taskTimerId >= TASK_TIMER_ID_MAX then taskTimerId = 0 end
    taskTimerId = taskTimerId + 1
    local timerid = taskTimerId
    taskTimerPool[coroutine.running()] = timerid
    timerPool[timerid] = coroutine.running()
    -- 调用core的rtos定时器
    if 1 ~= rtos.timer_start(timerid, ms) then log.debug("rtos.timer_start error") return end
    -- 挂起调用的任务线程
    local message = {coroutine.yield()}
    if #message ~= 0 then
        rtos.timer_stop(timerid)
        taskTimerPool[coroutine.running()] = nil
        timerPool[timerid] = nil
        return unpack(message)
    end
end


-- Task task condition wait function (supports event and timer messages)
-- Can only be called directly or indirectly by the task master function, and the task calling this interface is suspended
-- @string id，The message ID，The string type is recommended
-- @number[opt=nil] ms，Time-lapse，Units in milliseconds，Min 1，Maximum 0x7FFFFFFF
--             The minimum timeout actually supported is 5 milliseconds，Time less than 5 milliseconds is converted to 5 milliseconds
-- @return result,data，It is divided into three cases：
--             1、If there is a time-out parameter：
--                (1)、Before the timeout arrives，If you receive a waiting message ID，The result is true，Data is the parameters that the message ID carries (possibly multiple parameters)
--                (2)、Before the timeout arrives，If the waiting message ID is not confiscated，Then the result is false and the data is nil
--             2、If there is no time-out parameter：If you receive a waiting message ID，The result is true，Data is the parameters that the message ID carries (possibly multiple parameters)
--                (1)、If you receive a waiting message ID，Result is true, and data is the parameters (possibly multiple parameters) carried by the message ID
--                (2)、If the waiting message ID is not confiscated，The task hangs all the time
--             3、There is also a special case，When Bentask hangs，May be actively activated by task's external application logic (if not intentionally, a bug may have been written)
-- @usage
-- The task is delayed by 120 seconds or receives a "SIM_IND" message：
-- sys.taskInit(function()
--     local result, data = sys.waitUntil("SIM_IND",120000)
-- end)
function waitUntil(id, ms)
    subscribe(id, coroutine.running())
    local message = ms and {wait(ms)} or {coroutine.yield()}
    unsubscribe(id, coroutine.running())
    return message[1] ~= nil, unpack(message, 2, #message)
end

--- Task任务的条件等待函数扩展（包括事件消息和定时器消息等条件），只能用于任务函数中。
-- @param id 消息ID
-- @number ms 等待超时时间，单位ms，最大等待126322567毫秒
-- @return message 接收到消息返回message，超时返回false
-- @return data 接收到消息返回消息参数
-- @usage result, data = sys.waitUntilExt("SIM_IND", 120000)
function waitUntilExt(id, ms)
    subscribe(id, coroutine.running())
    local message = ms and {wait(ms)} or {coroutine.yield()}
    unsubscribe(id, coroutine.running())
    if message[1] ~= nil then return unpack(message) end
    return false
end

--- Create a task and run it
-- @param fun Task master function, used when task is activated
-- @param ... The variable parameters of the task main function fun
-- @return co  Returns the thread ID of the task
-- @usage sys.taskInit(task1,'a','b')
function taskInit(fun, ...)
    local co = coroutine.create(fun)
    coroutine.resume(co, ...)
    return co
end

--- Luat platform initialization
-- @param mode Charging power on whether to start the GSM protocol stack, 1 does not start, otherwise start
-- @param lprfncThe user applies the "low power shutdown handler" defined in the script, and if there is a function name, the run interface in this file does not perform any action when the function is low, otherwise, it will be delayed by 1 minute to automatically shut down
-- @return 无
-- @usage sys.init(1,0)
function init(mode, lprfnc)
    -- The user application script must define two global variables, PROJECT and VERSION, otherwise it will crash and restart, how to define refer to the main.lua in each demo
    assert(PROJECT and PROJECT ~= "" and VERSION and VERSION ~= "", "Undefine PROJECT or VERSION")
    collectgarbage("setpause", 80)

    -- Set the virtual serial port of the AT command
    uart.setup(uart.ATC, 0, 0, uart.PAR_NONE, uart.STOP_1)
    log.info("poweron reason:", rtos.poweron_reason(), PROJECT, VERSION, SCRIPT_LIB_VER, rtos.get_version())
    pcall(rtos.set_lua_info,"\r\n"..rtos.get_version().."\r\n"..(_G.PROJECT or "NO PROJECT").."\r\n"..(_G.VERSION or "NO VERSION"))
    if type(rtos.get_build_time)=="function" then log.info("core build time", rtos.get_build_time()) end
    if mode == 1 then
        -- Charge on
        if rtos.poweron_reason() == rtos.POWERON_CHARGER then
            -- Close the GSM protocol stack
            rtos.poweron(0)
        end
    end
end

------------------------------------------ rtos消息回调处理部分 ------------------------------------------
--[[
函数名：cmpTable
功能  ：比较两个table的内容是否相同，注意：table中不能再包含table
参数  ：
t1：第一个table
t2：第二个table
返回值：相同返回true，否则false
]]
local function cmpTable(t1, t2)
    if not t2 then return #t1 == 0 end
    if #t1 == #t2 then
        for i = 1, #t1 do
            if unpack(t1, i, i) ~= unpack(t2, i, i) then
                return false
            end
        end
        return true
    end
    return false
end

--- 关闭sys.timerStart和sys.timerLoopStart创建的定时器
-- 有两种方式可以唯一标识一个定时器：
-- 1、定时器ID
-- 2、定时器回调函数和可变参数
-- @param val，有两种形式：
--             1、为number类型时，表示定时器ID
--             2、为function类型时，表示定时器回调函数
-- @param ... 可变参数，当val为定时器回调函数时，此可变参数才有意义，表示定时器回调函数的可变回调参数
-- @return nil
-- @usage
-- 通过定时器ID关闭一个定时器：
-- local timerId = sys.timerStart(publicTimerCbFnc,8000,"second")
-- sys.timerStop(timerId)
-- 通过定时器回调函数和可变参数关闭一个定时器：
-- sys.timerStart(publicTimerCbFnc,8000,"first")
-- sys.timerStop(publicTimerCbFnc,"first")
function timerStop(val, ...)
    -- val 为定时器ID
	local arg={ ... }
    if type(val) == 'number' then
        timerPool[val], para[val], loop[val] = nil
        rtos.timer_stop(val)
    else
        for k, v in pairs(timerPool) do
            -- 回调函数相同
            if type(v) == 'table' and v.cb == val or v == val then
                -- 可变参数相同
                if cmpTable(arg, para[k]) then
                    rtos.timer_stop(k)
                    timerPool[k], para[k], loop[val] = nil
                    break
                end
            end
        end
    end
end

--- 关闭sys.timerStart和sys.timerLoopStart创建的某个回调函数的所有定时器
-- @function fnc， 定时器回调函数
-- @return nil
-- @usage 
-- 关闭回调函数为publicTimerCbFnc的所有定时器
-- local function publicTimerCbFnc(tag)
--     log.info("publicTimerCbFnc",tag)
-- end
-- 
-- sys.timerStart(publicTimerCbFnc,8000,"first")
-- sys.timerStart(publicTimerCbFnc,8000,"second")
-- sys.timerStart(publicTimerCbFnc,8000,"third")

-- sys.timerStopAll(publicTimerCbFnc)
function timerStopAll(fnc)
    for k, v in pairs(timerPool) do
        if type(v) == "table" and v.cb == fnc or v == fnc then
            rtos.timer_stop(k)
            timerPool[k], para[k], loop[k] = nil
        end
    end
end

--- 创建并且启动一个单次定时器
-- 有两种方式可以唯一标识一个定时器：
-- 1、定时器ID
-- 2、定时器回调函数和可变参数
-- @param fnc 定时器回调函数，必须存在，不允许为nil
--            当定时器超时时间到达时，回调函数的调用形式为fnc(...)，其中...为回调参数
-- @number ms 定时器超时时间，单位毫秒，最小1，最大0x7FFFFFFF
--                                      实际上支持的最小超时时间是5毫秒，小于5毫秒的时间都会被转化为5毫秒
-- @param ... 可变参数，回调函数fnc的回调参数
-- @return number timerId，创建成功返回定时器ID；创建失败返回nil
-- @usage
-- 创建一个5秒的单次定时器，回调函数打印"timerCb"，没有可变参数：
-- sys.timerStart(function() log.info("timerCb") end, 5000)
-- 创建一个5秒的单次定时器，回调函数打印"timerCb"和"test"，可变参数为"test"：
-- sys.timerStart(function(tag) log.info("timerCb",tag) end, 5000, "test")
function timerStart(fnc, ms, ...)
    --回调函数和时长检测
	local arg={ ... }
	local argcnt=0
	for i, v in pairs(arg) do
		argcnt = argcnt+1
	end
    assert(fnc ~= nil, "sys.timerStart(first param) is nil !")
    assert(ms > 0, "sys.timerStart(Second parameter) is <= zero !")
    --4G底层不支持小于5ms的定时器
    if ms < 5 then ms = 5 end
    -- 关闭完全相同的定时器
    if argcnt == 0 then
        timerStop(fnc)
    else
        timerStop(fnc, ...)
    end
    -- 为定时器申请ID，ID值 1-20 留给任务，20-30留给消息专用定时器
    while true do
        if msgId >= MSG_TIMER_ID_MAX then msgId = TASK_TIMER_ID_MAX end
        msgId = msgId + 1
        if timerPool[msgId] == nil then
            timerPool[msgId] = fnc
            break
        end
    end
    --调用底层接口启动定时器
    if rtos.timer_start(msgId, ms) ~= 1 then log.debug("rtos.timer_start error") return end
    --如果存在可变参数，在定时器参数表中保存参数
    if argcnt ~= 0 then
        para[msgId] = arg
    end
    --返回定时器id
    return msgId
end

--- 创建并且启动一个循环定时器
-- 有两种方式可以唯一标识一个定时器：
-- 1、定时器ID
-- 2、定时器回调函数和可变参数
-- @param fnc 定时器回调函数，必须存在，不允许为nil
--            当定时器超时时间到达时，回调函数的调用形式为fnc(...)，其中...为回调参数
-- @number ms 定时器超时时间，单位毫秒，最小1，最大0x7FFFFFFF
--                                      实际上支持的最小超时时间是5毫秒，小于5毫秒的时间都会被转化为5毫秒
-- @param ... 可变参数，回调函数fnc的回调参数
-- @return number timerId，创建成功返回定时器ID；创建失败返回nil
-- @usage
-- 创建一个5秒的循环定时器，回调函数打印"timerCb"，没有可变参数：
-- sys.timerLoopStart(function() log.info("timerCb") end, 5000)
-- 创建一个5秒的循环定时器，回调函数打印"timerCb"和"test"，可变参数为"test"：
-- sys.timerLoopStart(function(tag) log.info("timerCb",tag) end, 5000, "test")
function timerLoopStart(fnc, ms, ...)
    local tid = timerStart(fnc, ms, ...)
    if tid then loop[tid] = (ms<5 and 5 or ms) end
    return tid
end

--- 判断“通过timerStart或者timerLoopStart创建的定时器”是否处于激活状态
-- @param val，定时器标识，有两种表示形式
--                         1、number类型，通过timerStart或者timerLoopStart创建定时器时返回的定时器ID，此情况下，不需要传入回调参数...就能唯一标识一个定时器
--                         2、function类型，通过timerStart或者timerLoopStart创建定时器时的回调函数，此情况下，如果存在回调参数，需要传入回调参数...才能唯一标识一个定时器
-- @param ... 回调参数，和“通过timerStart或者timerLoopStart创建定时器”的回调参数保持一致
-- @return status，定时器激活状态；根据val的表示形式，有不同的返回值：
--                         1、val为number类型时：如果处于激活状态，则返回function类型的定时器回调函数；否则返回nil
--                         2、val为function类型时：如果处于激活状态，则返回bool类型的true；否则返回nil
-- @usage
-- 定时器ID形式标识定时器的使用参考：
-- local timerId1 = sys.timerStart(function() end,5000)
-- 
-- sys.taskInit(function()
--     sys.wait(3000)
--     log.info("after 3 senonds, timerId1 isActive?",sys.timerIsActive(timerId1))
--     
--     sys.wait(3000)
--     log.info("after 6 senonds, timerId1 isActive?",sys.timerIsActive(timerId1))
-- end)
--
--
-- 回调函数和回调参数标识定时器的使用参考：
-- local function timerCbFnc2(tag)
--     log.info("timerCbFnc2",tag)
-- end
-- 
-- sys.timerStart(timerCbFnc2,5000,"test")
-- 
-- sys.taskInit(function()
--     sys.wait(3000)
--     log.info("after 3 senonds, timerCbFnc2 test isActive?",sys.timerIsActive(timerCbFnc2,"test"))
--     
--     sys.wait(3000)
--     log.info("after 6 senonds, timerCbFnc2 test isActive?",sys.timerIsActive(timerCbFnc2,"test"))
-- end)
function timerIsActive(val, ...)
	local arg={ ... }
    if type(val) == "number" then
        return timerPool[val]
    else
        for k, v in pairs(timerPool) do
            if v == val then
                if cmpTable(arg, para[k]) then return true end
            end
        end
    end
end


------------------------------------------ LUA应用消息订阅/发布接口 ------------------------------------------
-- 订阅者列表
local subscribers = {}
--内部消息队列
local messageQueue = {}

--- 订阅消息
-- @param id 消息id
-- @param callback 消息回调处理
-- @usage subscribe("NET_STATUS_IND", callback)
function subscribe(id, callback)
    if type(id) ~= "string" or (type(callback) ~= "function" and type(callback) ~= "thread") then
        log.warn("warning: sys.subscribe invalid parameter", id, callback)
        return
    end
    if not subscribers[id] then subscribers[id] = {} end
    subscribers[id][callback] = true
end

--- 取消订阅消息
-- @param id 消息id
-- @param callback 消息回调处理
-- @usage unsubscribe("NET_STATUS_IND", callback)
function unsubscribe(id, callback)
    if type(id) ~= "string" or (type(callback) ~= "function" and type(callback) ~= "thread") then
        log.warn("warning: sys.unsubscribe invalid parameter", id, callback)
        return
    end
    if subscribers[id] then
        subscribers[id][callback] = nil
        
        local empty = true
        for k,v in pairs(subscribers[id]) do
            if v then
                empty=false
                break
            end
        end
        if empty then subscribers[id]=nil end
    end
end

--- Publish internal messages, stored in the internal message queue
-- @param ... Variable parameters, user-defined
-- @return 无
-- @usage publish("NET_STATUS_IND")
function publish(...)
	local arg = { ... }
    table.insert(messageQueue, arg)
end

-- Distribute the message
local function dispatch()
    while true do
        if #messageQueue == 0 then
            break
        end
        local message = table.remove(messageQueue, 1)
        if subscribers[message[1]] then
            for callback, flag in pairs(subscribers[message[1]]) do
                if flag then
                    if type(callback) == "function" then
                        callback(unpack(message, 2, #message))
                    elseif type(callback) == "thread" then
                        coroutine.resume(callback, unpack(message))
                    end
                end
            end
            
            if subscribers[message[1]] then
                for callback, flag in pairs(subscribers[message[1]]) do
                    if not flag then
                        subscribers[message[1]][callback] = nil
                    end
                end
            end
        end
    end
end

-- Rtos message callback
local handlers = {}
setmetatable(handlers, {__index = function() return function() end end, })

--- Register the rtos message callback handler
-- @number id The message type id
-- @param handler The message handler
-- @return 无
-- @usage rtos.on(rtos.MSG_KEYPAD, function(param) handle keypad message end)
rtos.on = function(id, handler)
    handlers[id] = handler
end

------------------------------------------ Luat master scheduling framework  ------------------------------------------
--- Run() gets core messages from the bottom and processes related messages in a timely manner, queries timers, and dispatches each registered successful task thread to run and suspend
-- @return 无
-- @usage sys.run()
function run()
    while true do
        -- Distribute internal messages
        dispatch()
        -- Blocks reading external messages
        local msg, param = rtos.receive(rtos.INF_TIMEOUT)
        -- Determines whether the message is a timer and whether the message is registered
        if msg == rtos.MSG_TIMER and timerPool[param] then
            if param < TASK_TIMER_ID_MAX then
                local taskId = timerPool[param]
                timerPool[param] = nil
                if taskTimerPool[taskId] == param then
                    taskTimerPool[taskId] = nil
                    coroutine.resume(taskId)
                end
            else
                local cb = timerPool[param]
                --If it is not a cycle timer, remove it from the timer id table
                if not loop[param] then timerPool[param] = nil end
                if para[param] ~= nil then
                    cb(unpack(para[param]))
                    if not loop[param] then para[param] = nil end
                else
                    cb()
                end
                --If it is a cycle timer, continue to start it
                if loop[param] then rtos.timer_start(param, loop[param]) end
            end
        --Other messages (audio messages, charging management messages, key messages, etc.)
        elseif type(msg) == "number" then
            handlers[msg](param)
        else
            handlers[msg.id](msg)
        end
    end
end

require "clib"

--if type(rtos.openSoftDog)=="function" then
--    rtos.openSoftDog(60000)
--    sys.timerLoopStart(rtos.eatSoftDog,20000)
--end
