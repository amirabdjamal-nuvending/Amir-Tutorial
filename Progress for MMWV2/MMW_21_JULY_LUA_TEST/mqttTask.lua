--- [[ Module features: MQTT client processing framework ]]

module(...,package.seeall)

require "utils"
require "common"
require "misc"
require "mqtt"
require "mqttOutMsg"
require "mqttInMsg6Row2"
require "All_Motor"
require "pins"
require "pio"
require "http"
require "Time"

local ready = false
local slen = string.len
local StartTime = 1637292904
local EndTimeMQTT = 1637292910
--local count = 0

--setGpio5Fnc(1)

--- Whether the MQTT connection is active
-- @return The activation status returns true，The inactive state returns false
-- @usage mqttTask.isReady()
function isReady()
    return ready
end

local function cbFnc(result,prompt,head,body)
    --count = 0
    log.info("testHttp.cbFnc00",result,prompt)

    if result == true then
        if result and head then
            for k,v in pairs(head) do
                log.info("testHttp.cbFnc01",k..": "..v)
            end
        end

        if result and body then
            log.info("testHttp.cbFnc02","bodyLen="..body:len())
            print("Result ---> "..body)
            Epoch(body)
            Time.Time(body)
            print("Epoch Done")

        --[[elseif not result and body then
            print("Request back Epoch ")
            sys.wait(1000)

            http.request("GET","http://scr8api.nuvending.my/mmw/timestamp",nil,
                            {
                                ["cr8-key"] ="f@nU^EnScr8@p!",
                                ["Authorization"] ="Basic bVRSc3RkNzU6Nm5WZTRVakxraUVaTW1zRWwzRDM=",
                            },
                        nil,nil,cbFnc) 
        else
            local dummy = 1637292904
            Epoch(dummy)]]
        end
    else
        print(" Request Back EPOCH ")
        sys.wait(1000)

        http.request("GET","http://scr8api.nuvending.my/mmw/timestamp",nil,
                            {
                                ["cr8-key"] ="f@nU^EnScr8@p!",
                                ["Authorization"] ="Basic bVRSc3RkNzU6Nm5WZTRVakxraUVaTW1zRWwzRDM=",
                            },
                        nil,nil,cbFnc)
    end
end


function Epoch(EpochTime)
    StartTime = EpochTime
    print("Start Epoch: "..StartTime)
    EndTimeMQTT = EpochTime + 0000086400
    --EndTimeMQTT = EpochTime + 0000000060
    print("End Epoch: "..EndTimeMQTT)
end

local function JWTToken()

    --local startepoch = os.time{year=2021, month=11, day=10, hour=17, min=40, sec=10}
    local iat = "\"iat\": "..StartTime
    --print(iat)
    --local endepoch = os.time{year=2021, month=11, day=10, hour=17, min=50, sec=10}
    local exp = "\"exp\": "..EndTimeMQTT
    --print(exp)

    local aud =  "\"aud\":\"cedar-abacus-328802\""
    --print(aud)

    local payloadforbased64 = "{"..aud..","..iat..","..exp.."}"
    --print(payloadforbased64)
    --print("========================================================")
    local encodepayload = crypto.base64_encode(payloadforbased64,slen(payloadforbased64))

    local changeplus = string.gsub(encodepayload, "(+)","-")
    local changeslash = string.gsub(changeplus, "(/)","_")
    local changeequal2 = string.gsub(changeslash, "(==)","")
    local payloadcomplete = string.gsub(changeequal2, "(=)","")
    --print(payloadcomplete)
    --print("========================================================")

    local Header = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9"
    local PayLoad = payloadcomplete
    local HeaderAndPayLoad = Header.."."..PayLoad
    --print("Header & Payload"..HeaderAndPayLoad)
    --print()
    --local HeaderAndPayLoad = Header.."."..payloadcomplete

    --Private key signature (2048bit，This bit is consistent with the bit of the actual private key)
    local signStr = crypto.rsa_sha256_sign("PRIVATE_KEY",io.readFile("/lua/private.key"),2048,"PRIVATE_CRYPT",HeaderAndPayLoad)
    --log.info("rsaTest.signStr",signStr:toHex())
    local encodeStr = crypto.base64_encode(signStr,slen(signStr))
    --print("********************")
    --print(encodeStr)
    local plustominus = string.gsub(encodeStr, "(+)","-")
    local slash = string.gsub(plustominus, "(/)","_")
    local equal2 = string.gsub(slash, "(==)","")
    local signcomplete = string.gsub(equal2, "(=)","")

    local CompleteToken = HeaderAndPayLoad.."."..signcomplete
    --print("Complete Token: "..CompleteToken)

    return CompleteToken
end
--Start the MQTT client task
sys.taskInit(
    function()
        local retryConnectCnt = 0
        --sys.waitUntil("IP_READY_IND")
        --setGpio5Fnc(0)
        local setGpio5Fnc = pins.setup(pio.P0_5,0)
        
        while true do
            --local PubPath = "/devices/SERVER/events"
            local SubPath = "/devices/Dev_v2_board/commands/#"
            local BoardID = "projects/cedar-abacus-328802/locations/asia-east1/registries/Development_v2/devices/Dev_v2_board"
            --setGpio5Fnc(1)
            
            print("------ STARTING ------")
            if not socket.isReady() then
                retryConnectCnt = 0
                setGpio5Fnc(0)
                --Wait for the network environment to be ready, the timeout is 5 minutes
                --print("!!!!!!!!!!!!!!!!!!!!! IP_READYYYYY !!!!!!!!!!!")
                sys.waitUntil("IP_READY_IND",200000) -- make less time
                --sys.waitUntil("IP_READY_IND")
                print("+++++++++++++ IP_Ready_Ind ++++++++++++++++++++")
                --print("Searching Internet......")
            end
            
            if socket.isReady() then

                http.request("GET","http://scr8api.nuvending.my/mmw/timestamp",nil,
                                {
                                    ["cr8-key"] ="f@nU^EnScr8@p!",
                                    ["Authorization"] ="Basic bVRSc3RkNzU6Nm5WZTRVakxraUVaTW1zRWwzRDM=",
                                },
                            nil,nil,cbFnc)

                local password = JWTToken()
                print()
                print("GET PASSWORD ENCODE")
                print("Password: "..password)

                --pins.setup(pio.P0_5,0)
                ---local imei = misc.getImei()
                --Create an MQTT client
                local mqttClient = mqtt.client(BoardID,600,"unused",password)
                --Block the execution of the MQTT CONNECT action until it succeeds
                --If use a ssl connection，Open it as mqttClient:connect("lbsmqtt.airm2m.com",1884,"tcp_ssl",{caCert="ca.crt"})
                --Configure according to your needs
                --mqttClient:connect("lbsmqtt.airm2m.com",1884,"tcp_ssl",{caCert="ca.crt"})
                print("$$$$$$$$$$$ imei $$$$$$$$$$")
                if mqttClient:connect("mqtt.googleapis.com",8883,"tcp_ssl",{caCert="ca.crt"}) then
                    retryConnectCnt = 0
                    ready = true
                    --Subscribe to the topic
                    if mqttClient:subscribe(SubPath,1) then
                        print("Subcribe to topic")
                        setGpio5Fnc(1)
                        --sys.wait(200)
                        --setGpio5Fnc(0)
                        --sys.wait(200)
                        --setGpio5Fnc(1)
                        --sys.wait(200)

                        --Loop through the data received and sent
                        while true do
                            print("*********** while loop ***********")
                            --setGpio5Fnc(1)
                            --setGpio5Fnc(0)
                            --sys.wait(200)
                            --setGpio5Fnc(1)
                            --sys.wait(200)

                            if not mqttInMsg6Row2.proc(mqttClient) then
                                print("MQTTINError")
                                --setGpio5Fnc(0)
                                break
                            end
                            if not mqttOutMsg.proc(mqttClient) then
                                print("MQTTOUTError")
                                --setGpio5Fnc(0)
                                break
                            end
                        end

                    print("@@@@@@@@@@@@@@@@@@ while end @@@@@@@@@@@")
                    end
                    ready = false
                    --setGpio5Fnc(0)
                    print("-------------------- Ready == False ---------------")
                else
                    retryConnectCnt = retryConnectCnt+1
                    setGpio5Fnc(0)
                    print("Retry ---> "..retryConnectCnt)

                    --if retryConnectCnt>=2 then
                        --print("-----------> Retry = 2 <------------")
                        --link.shut() -- change to flymode
                        --print("------------------- FLY TRUE ---------------------")
                        --net.switchFly(true)
                        --setGpio5Fnc(0)
                        --sys.wait(1000) --20000
                        --net.switchFly(false)
                        --setGpio5Fnc(1)
                        --print("------------------- FLY FALSE ---------------------")
                        --retryConnectCnt=0
                        --setGpio5Fnc(1)
                    --end
                end
                mqttClient:disconnect()
                --if retryConnectCnt>=2 then link.shut() retryConnectCnt=0 end
                --sys.wait(5000)
                --Try to earese see what happen
                --Disconnect the MQTT connection
                --mqttClient:disconnect()
                --if retryConnectCnt>=2 then link.shut() retryConnectCnt=0 end
                if retryConnectCnt>=1 then
                    print("-----------> Retry = 2 <------------")
                    link.shut() -- change to flymode
                    --print("------------------- FLY TRUE ---------------------")
                    --net.switchFly(true)
                    --setGpio5Fnc(0)
                    --sys.wait(1000) --20000
                    --net.switchFly(false)
                    --setGpio5Fnc(1)
                    --print("------------------- FLY FALSE ---------------------")
                    retryConnectCnt=0
                    setGpio5Fnc(1)
                end
                sys.wait(500)
            else
                --Enter airplane mode and exit airplane mode after 20 seconds
                --pins.setup(pio.P0_5,0)
                print("------------------- FLY TRUE ---------------------")
                net.switchFly(true)
                --setGpio5Fnc(0)
                sys.wait(5000) --20000
                net.switchFly(false)
                --setGpio5Fnc(1)
                print("------------------- FLY FALSE ---------------------")
            end
        end
    end
)
