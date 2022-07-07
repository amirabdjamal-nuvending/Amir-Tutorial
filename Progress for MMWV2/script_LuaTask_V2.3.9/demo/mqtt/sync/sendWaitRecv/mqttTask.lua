--- Module features: MQTT client processing framework
-- @author openLuat
-- @module mqtt.mqttTask
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.28

module(...,package.seeall)

require"misc"
require"mqtt"
require"mqttOutMsg"
require"mqttInMsg"

local ready = false

--- Whether the MQTT connection is active
-- @return The activation status returns true，The inactive state returns false
-- @usage mqttTask.isReady()
function isReady()
    return ready
end

--Start the MQTT client task
sys.taskInit(
    function()
        local retryConnectCnt = 0
        while true do
            if not socket.isReady() then
                retryConnectCnt = 0
                --Wait for the network environment to be ready, the timeout is 5 minutes
                sys.waitUntil("IP_READY_IND",300000)
            end
            
            if socket.isReady() then
                local imei = misc.getImei()
                --Create an MQTT client
                local mqttClient = mqtt.client(imei,600,"Hafiz94","aio_efZT2876kAnyhJkYx0pCAuPYDsCR")
                --Block the execution of the MQTT CONNECT action until it succeeds
                --If use a ssl connection，Open it as mqttClient:connect("lbsmqtt.airm2m.com",1884,"tcp_ssl",{caCert="ca.crt"})
                --Configure according to your needs
                --mqttClient:connect("lbsmqtt.airm2m.com",1884,"tcp_ssl",{caCert="ca.crt"})
                if mqttClient:connect("io.adafruit.com",1883,"tcp") then
                    retryConnectCnt = 0
                    ready = true
                    --Subscribe to the topic
                    if mqttClient:subscribe("Hafiz94/feeds/air724ug",0) then
                        --mqttOutMsg.init()
                        --Loop through the data received and sent
                        while true do
                            if not mqttInMsg.proc(mqttClient) then log.error("mqttTask.mqttInMsg.proc error") break end
                            --if not mqttOutMsg.proc(mqttClient) then log.error("mqttTask.mqttOutMsg proc error") break end
                        end
                        --mqttOutMsg.unInit()
                    end
                    ready = false
                else
                    retryConnectCnt = retryConnectCnt+1
                end
                --Disconnect the MQTT connection
                mqttClient:disconnect()
                if retryConnectCnt>=5 then link.shut() retryConnectCnt=0 end
                sys.wait(5000)
            else
                --Enter airplane mode and exit airplane mode after 20 seconds
                net.switchFly(true)
                sys.wait(20000)
                net.switchFly(false)
            end
        end
    end
)
