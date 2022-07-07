require "mqtt"
module(..., package.seeall)
--Here please fill in Huawei cloud background docking information shown the device information MQTT access mode information
local host, port ="iot-mqtts.cn-north-4.myhuaweicloud.com", 1883
--Here you set the device's service id and key, two strings that you get when you create the device new
--In practice, these two values can exist in the SN, burning in one by one during production
local device = "6063e66caaafca02d89db9bf_asd1234"
local secret = "able6123"
--Synchronize NTP time because authentication requires UTC time
require"ntp"
local function ntbcb(r)
    if r then
        sys.publish("NTP_OK")--When the time synchronization is complete, send a command to start the mqtt connection
    else
        ntp.timeSync(nil,ntbcb)
    end
end
ntp.timeSync(nil,ntbcb)--Start the sync time task
--Refer to Huawei's cloud documentation here to generate the key used to connect
local function keyGenerate(key)
    local clk = os.date("*t",os.time()-3600*8)--Get the table of UTC time
    local timeStr = string.format("%02d%02d%02d%02d",clk.year,clk.month,clk.day,clk.hour)--时间戳
    local result = crypto.hmac_sha256(key,timeStr):lower()
    log.info("keyGenerate",timeStr,key,result)
    if crypto.hmac_sha256 then
        return result
    else
        log.error("crypto.hmac_sha256","please update your lod version, higher than 0034!")
        rtos.poweroff()
    end
end

--socket.setSendMode(1)
-- 测试MQTT的任务代码
sys.taskInit(function()
    sys.waitUntil("NTP_OK")--等待时间同步成功
    while true do
        while not socket.isReady() do sys.wait(1000) end
        local clk = os.date("*t",os.time()-3600*8)--Get the table of UTC time
        local mqttc = mqtt.client(
            device.."_0_0_"..string.format("%02d%02d%02d%02d",clk.year,clk.month,clk.day,clk.hour),--时间戳鉴权模式
            300,
            device,
            keyGenerate(secret))
        while not mqttc:connect(host, port, "tcp_ssl",{caCert="hw.crt"}) do sys.wait(2000) end
        --topic订阅规则详细请见华为云文档：https://support.huaweicloud.com/api-IoT/iot_06_3008.html#ZH-CN_TOPIC_0172230104
        if mqttc:subscribe("/huawei/v1/devices/"..device.."/command/json") then
            while true do
                local r, data, param = mqttc:receive(120000, "pub_msg")
                if r then
                    log.info("This is the message that was received from the server:", data.payload or "nil")
                    sys.publish("rev_msg",data.payload)--把收到的数据推送出去
                elseif data == "pub_msg" then
                    log.info("This is the message and parameter display for which the subscription was received:", param)
                    --For more information on topic subscription rules, please refer to Huawei Cloud Documentation
                    mqttc:publish("/huawei/v1/devices/"..device.."/data/json", param)
                elseif data == "timeout" then
                    --Wait for the timeout to proceed to the next round of waiting
                else
                    break
                end
            end
        end
        mqttc:disconnect()
    end
end)
--After receiving mqtt, the data is processed
sys.subscribe("rev_msg",function(data)
    local t,r,e = json.decode(data)--解包收到的json数据，具体参考手册：https://support.huaweicloud.com/api-IoT/iot_06_3011.html
    if r and type(t)=="table" then
        log.info("receive.msgType",t.msgType)--表示平台下发的请求，固定值“cloudReq”
        log.info("receive.serviceId",t.serviceId)--设备服务的ID
        log.info("receive.cmd",t.cmd)--服务的命令名，参见profile的服务命令定义
        log.info("receive.mid",t.mid)--2字节无符号的命令id，平台内部分配（范围1-65535），设备命令响应平台时，需要返回该值
        if t.cmd == "testcmd" then--匹配上了之前写的cmd名称
            log.info("receive.paras.testControl",t.paras.testControl)
            local clk = os.date("*t",os.time()-3600*8)--Get the table of UTC time
            --组包回复用的json，具体参考手册：https://support.huaweicloud.com/api-IoT/iot_06_3012.html
            local reply = {
                msgType = "deviceRsp",--固定值“deviceRsp”，表示设备的应答消息
                mid = t.mid,--2字节无符号的命令ID，根据平台下发命令时的mid返回给平台。建议在消息中携带此参数
                errcode = 0,--请求处理的结果码。“0”表示成功。“1”表示失败
                body = {--命令的应答，具体字段由profile定义
                    testReply = "done",--这是之前后台设置的那个
                }
            }
            sys.publish("pub_msg",json.encode(reply))--Report the returned message
            --Jason for group pack reporting, specific reference manual：https://support.huaweicloud.com/api-IoT/iot_06_3010.html
            local upload = {
                msgType = "deviceReq",--Represents data reported on the device with a fixed value of "deviceReq"
                data = {--Data for a set of services (specifically, refer to the ServiceData definition table below), which you can add when you need to upload bulk data
                    {
                        serviceId = "testServer",--设备服务的ID
                        serviceData = {--一个服务的数据，具体字段在profile里定义
                            testProperty = t.paras.testControl,--把刚刚下发的东西，上报上去
                        },
                        eventTime = string.format("%02d%02d%02d%02d%02d%02dZ",--Device acquisition data UTC time (format)：yyyyMMddTHHmmssZ）
                                    clk.year,clk.month,clk.day,clk.hour,clk.min,clk.sec)--timestamp
                    },
                }
            }
            sys.publish("pub_msg",json.encode(upload))--Report the returned message
        end
    else
        log.info("json.decode error",e)
    end
end)