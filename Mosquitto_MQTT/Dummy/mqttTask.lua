--- [[ Module features: MQTT client processing framework ]]

module(...,package.seeall)

require "utils"
require "common"
require "misc"
require "mqtt"
require "mqttOutMsg"
require "mqttInMsg"
require "All_Motor"
require "pins"
require "pio"
require "http"
-- require "Time"
-- require "uarttest"

local ready = false
local slen = string.len
local First_start = 0


function Machine_name()
    local vmid = "202207011"
    return vmid
end

--- Whether the MQTT connection is active
-- @return The activation status returns true，The inactive state returns false
-- @usage mqttTask.isReady()
function isReady()
    return ready
end

-- local function cbFnc(result,prompt,head,body)

--     log.info("testHttp.cbFnc00",result,prompt)

--     if result == true then
--         if result and head then
--             for k,v in pairs(head) do
--                 log.info("testHttp.cbFnc01",k..": "..v)
--             end
--         end

--         if result and body then
--             log.info("testHttp.cbFnc02","bodyLen="..body:len())
--             print("Result ---> "..body)
--             Time.Time(body)
--             print("Epoch Done")
--         end
--     else
--         print(" Request Back Epoch ")
--         sys.wait(1000)

--         http.request("GET","http://scr8api.nuvending.my/mmw/timestamp",nil,
--                         {
--                             ["cr8-key"] ="f@nU^EnScr8@p!",
--                             ["Authorization"] ="Basic bVRSc3RkNzU6Nm5WZTRVakxraUVaTW1zRWwzRDM=",
--                         },
--                         nil,nil,cbFnc
--                     )
--     end
-- end

--Start the MQTT client task
sys.taskInit(
    function()
        local retryConnectCnt = 0
        local setGpio5Fnc = pins.setup(pio.P0_5,0)
        
        while true do
            local SubPath = "MMWV2TOPIC2"
            local BoardID = "MMW2"
            print("--"..SubPath)
            
            print("------ STARTING ------")
            if not socket.isReady() then
                retryConnectCnt = 0
                setGpio5Fnc(0)
                --Wait for the network environment to be ready, the timeout is 5 minutes
                sys.waitUntil("IP_READY_IND",200000) -- make less time
                print("+++++++++++++ IP_Ready_Ind ++++++++++++++++++++")
            end
            
            if socket.isReady() then
                -- http.request("GET","http://scr8api.nuvending.my/mmw/timestamp",nil,
                --                 {
                --                     ["cr8-key"] ="f@nU^EnScr8@p!",
                --                     ["Authorization"] ="Basic bVRSc3RkNzU6Nm5WZTRVakxraUVaTW1zRWwzRDM=",
                --                 },
                --                 nil,nil,cbFnc
                --             )
                            

                --Create an MQTT client
                local mqttClient = mqtt.client(BoardID,600,"mmwv2","RnD_2022",0)
                print("-- Connecting to MQTT --")
                --Block the execution of the MQTT CONNECT action until it succeeds
                --If use a ssl connection，Open it as mqttClient:connect("lbsmqtt.airm2m.com",1884,"tcp_ssl",{caCert="ca.crt"})
                --Configure according to your needs
                --mqttClient:connect("lbsmqtt.airm2m.com",1884,"tcp_ssl",{caCert="ca.crt"})
                if mqttClient:connect("103.215.136.99",1884,"tcp") then
                    print("------Connected??---")
                    First_start = First_start + 1
                    mqttInMsg.Start_status(First_start)
                    print("First Start = "..First_start)
                    retryConnectCnt = 0
                    ready = true
                    --Subscribe to the topic
                    if mqttClient:subscribe(SubPath,1) then
                        print("------------------------------------------------------")
                        print("Subcribe to topic " ..SubPath)
                        setGpio5Fnc(1)

                        --Loop through the data received and sent
                        while true do
                            print("**** MQTT Connection Establish ****")
                            if not mqttInMsg.proc(mqttClient) then
                                print("MQTT Subcribe Error")
                                break
                            end
                            if not mqttOutMsg.proc(mqttClient) then
                                print("MQTT Publish Error")
                                break
                            end
                        end
                    end
                    ready = false
                    --setGpio5Fnc(0)
                    print("-------------------- Ready == False ---------------")
                else
                    retryConnectCnt = retryConnectCnt+1
                    setGpio5Fnc(0)
                    print("Retry ---> "..retryConnectCnt)
                end
                mqttClient:disconnect()
                First_start = First_start - 1
                print("First Start = "..First_start)
                if retryConnectCnt>=1 then
                    print("-----------> Retry = 2 <------------")
                    link.shut()
                    retryConnectCnt=0
                    setGpio5Fnc(1)
                end
                sys.wait(500)
            else
                --Enter airplane mode and exit airplane mode after 20 seconds
                print("------------------- FLY TRUE ---------------------")
                net.switchFly(true)
                sys.wait(5000) --20000
                net.switchFly(false)
                print("------------------- FLY FALSE ---------------------")
            end
        end
    end
)
