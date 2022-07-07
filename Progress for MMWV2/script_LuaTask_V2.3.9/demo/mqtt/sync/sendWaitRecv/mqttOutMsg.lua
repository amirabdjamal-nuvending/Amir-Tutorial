-- Module function: MQTT client data sending processing
-- @author openLuat
-- @module mqtt.mqttOutMsg
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.28


module(...,package.seeall)

--The message queue for the data sent
local msgQueue = {}

local function insertMsg(topic,payload,qos,user)
    table.insert(msgQueue,{t=topic,p=payload,q=qos,user=user})
    sys.publish("APP_SOCKET_SEND_DATA")
end

local function pubQos0TestCb(result)
    log.info("mqttOutMsg.pubQos0TestCb",result)
    if result then sys.timerStart(pubQos0Test,10000) end
end

function pubQos0Test()
    insertMsg("/qos0topic","qos0data",0,{cb=pubQos0TestCb})
end

local function pubQos1TestCb(result)
    log.info("mqttOutMsg.pubQos1TestCb",result)
    if result then sys.timerStart(pubQos1Test,20000) end
end

function pubQos1Test()
    insertMsg("/中文qos1topic","中文qos1data",1,{cb=pubQos1TestCb})
end

--- Initialize "MQTT Client Data Sending"
-- @return none
-- @usage mqttOutMsg.init()
function init()
    pubQos0Test()
    pubQos1Test()
end

---De-initialize "MQTT client data sending"
-- @return none
-- @usage mqttOutMsg.unInit()
function unInit()
    sys.timerStop(pubQos0Test)
    sys.timerStop(pubQos1Test)
    while #msgQueue>0 do
        local outMsg = table.remove(msgQueue,1)
        if outMsg.user and outMsg.user.cb then outMsg.user.cb(false,outMsg.user.para) end
    end
end


--- MQTT client data sending processing
-- @param mqttClient，MQTT client object
-- @return Processing returned successfully true，Processing error returns false
-- @usage mqttOutMsg.proc(mqttClient)
function proc(mqttClient)
    while #msgQueue>0 do
        local outMsg = table.remove(msgQueue,1)
        local result = mqttClient:publish(outMsg.t,outMsg.p,outMsg.q)
        if outMsg.user and outMsg.user.cb then outMsg.user.cb(result,outMsg.user.para) end
        if not result then return end
    end
    return true
end
