--- Module function: HTTP function test.
-- @author openLuat
-- @module http.testHttp
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.23

module(...,package.seeall)

require"http"

local function cbFnc(result,prompt,head,body)
    log.info("testHttp.cbFnc00",result,prompt)
    --if result and head then
    --    for k,v in pairs(head) do
    --        log.info("testHttp.cbFnc01",k..": "..v)
    --    end
    --end
    if result and body then
        log.info("testHttp.cbFnc02","bodyLen="..body:len())
        print("Result ---> "..body)
    end

    print("Body -->:"..(body + 0000086400))
end

local function cbFncFile(result,prompt,head,filePath)
    log.info("testHttp.cbFncFile",result,prompt,filePath)
    if result and head then
        for k,v in pairs(head) do
            log.info("testHttp.cbFncFile",k..": "..v)
        end
    end
    if result and filePath then
        local size = io.fileSize(filePath)
        log.info("testHttp.cbFncFile","fileSize="..size)
        
        --Output file content, if the file is too large,
        --read out the file contents at once may cause low memory,
        --read out in stages to avoid this problem
        if size<=4096 then
            log.info("testHttp.cbFncFile",io.readFile(filePath))
        else
			
        end
    end
    --Once the file is finished, you'll need to delete it yourself if you don't use it again
    if filePath then os.remove(filePath) end
end

http.request("GET","http://scr8api.nuvending.my/mmw/timestamp",nil,
            {
                ["cr8-key"] ="f@nU^EnScr8@p!",
                ["Authorization"] ="Basic bVRSc3RkNzU6Nm5WZTRVakxraUVaTW1zRWwzRDM=",
            },
            nil,nil,cbFnc)

--[[sys.taskInit(
    function()
        while true do
            print("===============================================================")
            local time = http.request("GET","http://scr8api.nuvending.my/mmw/timestamp",nil,
            {
                ["cr8-key"] ="f@nU^EnScr8@p!",
                ["Authorization"] ="Basic bVRSc3RkNzU6Nm5WZTRVakxraUVaTW1zRWwzRDM=",
            },
            nil,nil,cbFnc)
            print("Time --->>> "..time)
            print("===============================================================")
        end
    end
)

--http.request("GET","https://www.baidu.com",{caCert="ca.crt"},nil,nil,nil,cbFnc)
--http.request("GET","www.lua.org",nil,nil,nil,30000,cbFncFile,"download.bin")
--http.request("GET","http://www.lua.org",nil,nil,nil,30000,cbFnc)
--http.request("GET","www.lua.org/about.html",nil,nil,nil,30000,cbFnc)
--http.request("GET","www.lua.org:80/about.html",nil,nil,nil,30000,cbFnc)
--http.request("POST","www.iciba.com",nil,nil,"Luat",30000,cbFnc)
--http.request("POST","36.7.87.100:6500",nil,{head1="value1"},{[1]=" begin\r\n",[2]={file="/lua/http.lua"},[3]="end\r\n"},30000,cbFnc)
--http.request("POST","http://lq946.ngrok.xiaomiqiu.cn/",nil,nil,{[1]="begin\r\n",[2]={file_base64="/lua/http.lua"},[3]="end\r\n"},30000,cbFnc)

--The following example code is to use file streaming mode, upload the recording file demo, using the URL is randomly fabricated
--[[
http.request("POST","www.test.com/postTest?imei=1&iccid=2",nil,
         {['Content-Type']="application/octet-stream",['Connection']="keep-alive"},
         {[1]={['file']="/RecDir/rec001"}},
         30000,cbFnc)
]]

--[[
    http://scr8api.nuvending.my/mmw/timestamp
    key = cr8-key
    value = f@nU^EnScr8@p!
    mTRstd75
    6nVe4UjLkiEZMmsEl3D3
]]

--The following example code is to use x-www-form-urlencoded mode to upload 3 parameters to notify openluat sms platform to send text messages
--[[
function urlencodeTab(params)
    local msg = {}
    for k, v in pairs(params) do
        table.insert(msg, string.urlEncode(k) .. '=' .. string.urlEncode(v))
        table.insert(msg, '&')
    end
    table.remove(msg)
    return table.concat(msg)
end

http.request("POST","http://api.openluat.com/sms/send",nil,
         {
             ["Authorization]"="Basic jffdsfdsfdsfdsfjakljfdoiuweonlkdsjdsjapodaskdsf",
             ["Content-Type"]="application/x-www-form-urlencoded",
         },
         urlencodeTab({content="Your gas detection is in an alarm state，Please ventilate in time!", phone="13512345678", sign="The sender of the text message"}),
         30000,cbFnc)
]]
         
         


--The following example code is to use the multipart/form-data mode to upload 2 parameters and 1 photo file
--[[
local function postMultipartFormData(url,cert,params,timeout,cbFnc,rcvFileName)
    local boundary,body,k,v,kk,vv = "--------------------------"..os.time()..rtos.tick(),{}
    
    for k,v in pairs(params) do
        if k=="texts" then
            local bodyText = ""
            for kk,vv in pairs(v) do
                bodyText = bodyText.."--"..boundary.."\r\nContent-Disposition: form-data; name=\""..kk.."\"\r\n\r\n"..vv.."\r\n"
            end
            body[#body+1] = bodyText
        elseif k=="files" then
            local contentType =
            {
                jpg = "image/jpeg",
                jpeg = "image/jpeg",
                png = "image/png",                
            }
            for kk,vv in pairs(v) do
                print(kk,vv)
                body[#body+1] = "--"..boundary.."\r\nContent-Disposition: form-data; name=\""..kk.."\"; filename=\""..kk.."\"\r\nContent-Type: "..contentType[vv:match("%.(%w+)$")].."\r\n\r\n"
                body[#body+1] = {file = vv}
                body[#body+1] = "\r\n"
            end
        end
    end    
    body[#body+1] = "--"..boundary.."--\r\n"
        
    http.request(
        "POST",
        url,
        cert,
        {
            ["Content-Type"] = "multipart/form-data; boundary="..boundary,
            ["Connection"] = "keep-alive"
        },
        body,
        timeout,
        cbFnc,
        rcvFileName
        )    
end

postMultipartFormData(
    "1.202.80.121:4567/api/uploadimage",
    nil,
    {
        texts = 
        {
            ["imei"] = "862991234567890",
            ["time"] = "20180802180345"
        },
        
        files =
        {
            ["logo_color.jpg"] = "/ldata/logo_color.jpg"
        }
    },
    60000,
    cbFnc
)
]]
