---Module function: onenet studio function test.
-- @module onenet
-- @author Dozingfiretruck
-- @license MIT
-- @copyright OpenLuat.com
-- @release 2021.4.7

module(...,package.seeall)

require "ntp"
require "pm"
require "misc"
require "mqtt"
require "utils"
require "patch"
require "socket"
require "http"
require "common"


--Product ID and product dynamic registration key
local ProductId = "vh8xhj9sxz"
local ProductSecret = "t7Ojq/VBDQO3r8l5nQXXPZdzZQ3JCY8riZMj87vX96c="

local onenet_mqttClient
--[[
Function name: getDeviceName
Feature: Gets the device name
Parameter: None
Return value: Device name
]]
local function getDeviceName()
    --The device's IMEI is used as the device name by default, and the user can modify it according to the project needs
    return misc.getImei()

    --When a user tests monolith,
    --the device name registered on Alibaba Cloud's iot console can be returned directly here, such as the "862991419835241"
    --return "862991419835241"
end

function onenet_publish()
    --sys.publish("APP_SOCKET_SEND_DATA")
    --mqtt Publish the theme to modify it as you need it
    local publish_data =
    {
        id = "123",
        version = "1.0",
        params = {},
    }
    local jsondata = json.encode(publish_data)
    onenet_mqttClient:publish("$sys/"..ProductId.."/"..getDeviceName().."/thing/property/post", jsondata, 0)
end

local function onenet_subscribe()
    --mqtt Subscribe to topics and modify them as you need them
    local onenet_topic = {
        ["$sys/"..ProductId.."/"..getDeviceName().."/thing/property/post/reply"]=0
    }
    if onenet_mqttClient:subscribe(onenet_topic) then
        return true
    else
        return false
    end
end

-- No network restart time, flight mode start time
local rstTim, flyTim = 600000, 300000
local mqtt_ready = false
--- Whether the MQTT connection is active
-- @return The activation status returns true，The inactive state returns false
-- @usage mqttTask.isReady()
function isReady()
    return mqtt_ready
end

local function get_token()
    local version = '2018-10-31'
    --Access MQ through the MQ instance name
    local res = "products/"..ProductId.."/devices/"..getDeviceName()
    -- The user customizes the token expiration time
    local et = tostring(os.time() + 3600)
    -- Signature method, support md5, sha1, sha256
    local method = 'sha256'
    -- Decode the access_key
    local key = crypto.base64_decode(ProductSecret,#ProductSecret)
    -- Calculate sign
    local StringForSignature  = et .. '\n' .. method .. '\n' .. res ..'\n' .. version
    local sign1 = crypto.hmac_sha256(StringForSignature,key)
    local sign2 = sign1:fromHex()
    local sign = crypto.base64_encode(sign2,#sign2)
    -- The value section is url encoded
    sign = string.urlEncode(sign)
    res = string.urlEncode(res)
    -- Token parameter stitching
    local token = string.format('version=%s&res=%s&et=%s&method=%s&sign=%s',version, res, et, method, sign)
    return token
end

--- MQTT client data reception processing
-- @param onenet_mqttClient，MQTT client object
-- @return Processing successfully returns true，Processing error returns false
-- @usage mqttInMsg.proc(onenet_mqttClient)
local function proc(onenet_mqttClient)
    local result,data
    while true do
        result,data = onenet_mqttClient:receive(60000,"APP_SOCKET_SEND_DATA")
        --The data was received
        if result then
            log.info("mqttInMsg.proc",data.topic,string.toHex(data.payload))

            --TODO：Handle data.payload yourself on demand
        else
            break
        end
    end
    return result or data=="timeout" or data=="APP_SOCKET_SEND_DATA"
end

local function onenet_iot()
    while true do
        if not socket.isReady() and not sys.waitUntil("IP_READY_IND", rstTim) then sys.restart("网络初始化失败!") end
        local clientid = getDeviceName()
        local username = ProductId
        local password = get_token()
        --Create an MQTT client
        onenet_mqttClient = mqtt.client(clientid,300,username,password)
        --Block MQTT CONNECT action until successful
        while not  onenet_mqttClient:connect("218.201.45.7",1883) do sys.wait(2000) end
        log.info("mqtt连接成功")

        --Subscribe to the topic
        if onenet_subscribe() then
            log.info("mqtt订阅成功")
            --Loop through the data received and sent
            while true do
                mqtt_ready = true
                if not proc(onenet_mqttClient) then log.error("mqttTask.mqttInMsg.proc error") break end
            end
        else
            log.info("mqtt订阅失败")
        end
        mqtt_ready = false
        --Disconnect the MQTT connection
        onenet_mqttClient:disconnect()
    end
end

local function iot()
    if not socket.isReady() and not sys.waitUntil("IP_READY_IND", rstTim) then sys.restart("网络初始化失败!") end
    while not ntp.isEnd() do sys.wait(1000) end
    onenet_iot()
end

net.switchFly(false)
-- NTP Synchronization failed to force a restart
local tid = sys.timerStart(function()
    net.switchFly(true)
    sys.timerStart(net.switchFly, 5000, false)
end, flyTim)
sys.subscribe("IP_READY_IND", function()
    sys.timerStop(tid)
    log.info("---------------------- 网络注册已成功 ----------------------")
end)

sys.taskInit(iot)
