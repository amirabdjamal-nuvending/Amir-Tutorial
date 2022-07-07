--- Module function: algorithm function test.
-- @author openLuat
-- @module crypto.testCrypto
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.20

module(...,package.seeall)

require"utils"
require "common"
--[[
The results of the decryption algorithm can be compared
http://tool.oschina.net/encrypt?type=2
http://www.ip33.com/crc.html
http://tool.chacuo.net/cryptaes
Test
]]

local slen = string.len

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

--- Base64 plus decryption algorithm test
-- @return None
-- @usage base64Test()
local function base64Test()
    ------------------------------- GETTING TIMESTAMP ----------------------------
    --local time = os.time()
    --print(time)
    --local clk = os.date("*t",os.time()-3600*8)--Get the table of UTC time
    --print("CLK :"..clk)
    --local timeStr = string.format("%02d-%02d-%02d-%02d-%02d-%02d",clk.year,clk.month,clk.day,clk.hour,clk.min,clk.sec)
    --print("Clock: "..timeStr)
    local epoch = os.time{year=2021, month=11, day=9, hour=15, min=00, sec=10}
    print("iat: "..epoch)
    local epoch2 = os.time{year=2021, month=11, day=9, hour=15, min=40, sec=10}
    print("exp: "..epoch2)
    ------------------------------- END GETTING TIMESTAMP --------------------------

    ------------------------------- GETTING BASE64 ENCODED -------------------------
    --local originStr = "123456crypto.base64_encodemodule(...,package.seeall)sys.timerStart(test,5000)jdklasdjklaskdjklsa"
    local originStr = "{\"typ\":\"JWT\",\"alg\":\"RS256\""..'}'
    --local originStr = "{\"typ\":\"JWT\",\"alg\":\"RS256\""..'}'..'.'.."{\"iat\": 1635894801,\"exp\": 1635896001,\"aud\":\"cedar-abacus-328802\""..'}'
    local encodeStr = crypto.base64_encode(originStr,slen(originStr))
    log.info("testCrypto.base64_encode",encodeStr)
    log.info("testCrypto.base64_decode",crypto.base64_decode(encodeStr,slen(encodeStr)))
    print("***************************************************")
    print()
    local Payload = "{\"iat\": 1635894801,\"exp\": 1635896001,\"aud\":\"cedar-abacus-328802\""..'}'
    local encodePayload = crypto.base64_encode(Payload,slen(Payload))
    log.info("testCrypto.base64_encode",encodePayload)
    log.info("testCrypto.base64_decode",crypto.base64_decode(encodePayload,slen(encodePayload)))
    ------------------------------- END GETTING BASE64 ENCODED --------------------------
end


--- hmac_md5 algorithm test
-- @return None
-- @usage hmacMd5Test()
local function hmacMd5Test()
    local originStr = "asdasdsadas"
    local signKey = "123456"
    log.info("testCrypto.hmac_md5",crypto.hmac_md5(originStr,slen(originStr),signKey,slen(signKey)))
end

--- xxtea algorithm test
-- @return None
-- @usage xxteaTest()
local function xxteaTest()
    if crypto.xxtea_encrypt then
        local text = "Hello World!";
        local key = "07946";
        local encrypt_data = crypto.xxtea_encrypt(text, key);
        log.info("testCrypto.xxteaTest","xxtea_encrypt:"..encrypt_data)
        local decrypt_data = crypto.xxtea_decrypt(encrypt_data, key);
        log.info("testCrypto.xxteaTest","decrypt_data:"..decrypt_data)
    end
end


--- Streaming md5 algorithm test
-- @return None
-- @usage flowMd5Test()
local function flowMd5Test()
    local fmd5Obj=crypto.flow_md5()
    local testTable={"lqlq666lqlq946","07946lq94607946","lq54075407540707946"}
    for i=1, #(testTable) do
        fmd5Obj:update(testTable[i])
    end
    log.info("testCrypto.flowMd5Test",fmd5Obj:hexdigest())
end
--- md5 algorithm test
-- @return none
-- @usage md5Test()
local function md5Test()
    --Calculates the md5 value of the string
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    log.info("testCrypto.md5",crypto.md5(originStr,slen(originStr)))
--  crypto.md5，The first argument is the file path, and the second argument must be "file"
	log.info("testCrypto.sys.lua md5",crypto.md5("/lua/sys.lua","file"))
end

--- hmac_sha1 algorithm test
-- @return None
-- @usage hmacSha1Test()
local function hmacSha1Test()
    local originStr = "asdasdsadasweqcdsjghjvcb"
    local signKey = "12345689012345"
    log.info("testCrypto.hmac_sha1",crypto.hmac_sha1(originStr,slen(originStr),signKey,slen(signKey)))
end

--- Sha1 algorithm test
-- @return none
-- @usage sha1Test()
local function sha1Test()
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    log.info("testCrypto.sha1",crypto.sha1(originStr,slen(originStr)))
end
--- Sha256 algorithm test
-- @return none
-- @usage sha256Test()
local function sha256Test()
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    log.info("testCrypto.sha1",crypto.sha256(originStr,slen(originStr)))
end

local function hmacSha256Test()
    if type(crypto.hmac_sha256)=="function" then
        local originStr = "asdasdsadasweqcdsjghjvcb"
        local signKey = "12345689012345"
        log.info("testCrypto.hmac_sha256",crypto.hmac_sha256(originStr,signKey))
    end
end


--- crc algorithm test
-- @return none
-- @usage crcTest()
local function crcTest()
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    --crypto.crc16()The first argument is the check method, which must be the following, and the second argument is the string that calculates the check
    log.info("testCrypto.crc16_MODBUS",string.format("%04X",crypto.crc16("MODBUS",originStr)))
    log.info("testCrypto.crc16_IBM",string.format("%04X",crypto.crc16("IBM",originStr)))
    log.info("testCrypto.crc16_X25",string.format("%04X",crypto.crc16("X25",originStr)))
    log.info("testCrypto.crc16_MAXIM",string.format("%04X",crypto.crc16("MAXIM",originStr)))
    log.info("testCrypto.crc16_USB",string.format("%04X",crypto.crc16("USB",originStr)))
    log.info("testCrypto.crc16_CCITT",string.format("%04X",crypto.crc16("CCITT",originStr)))
    log.info("testCrypto.crc16_CCITT-FALSE",string.format("%04X",crypto.crc16("CCITT-FALSE",originStr)))
    log.info("testCrypto.crc16_XMODEM",string.format("%04X",crypto.crc16("XMODEM",originStr)))
    log.info("testCrypto.crc16_DNP",string.format("%04X",crypto.crc16("DNP",originStr)))
    log.info("testCrypto.USER-DEFINED",string.format("%04X",crypto.crc16("USER-DEFINED",originStr,0x8005,0x0000,0x0000,0,0)))
--  log.info("testCrypto.crc16_modbus",string.format("%04X",crypto.crc16_modbus(originStr,slen(originStr))))
--  log.info("testCrypto.crc32",string.format("%08X",crypto.crc32(originStr,slen(originStr))))
end
--- aes algorithm test（reference http://tool.chacuo.net/cryptaes）
-- @return none
-- @usage aesTest()
local function aesTest()
        local originStr = "AES128 ECB ZeroP"--长度为16的整数倍
        --Encryption mode：ECB；填充方式：ZeroPadding；密钥：1234567890123456；密钥长度：128 bit
        local encodeStr = crypto.aes_encrypt("ECB","ZERO",originStr,"1234567890123456")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("ECB","ZERO",encodeStr,"1234567890123456"))

        originStr = "AES128 ECB ZeroP"
        --Encryption mode：ECB；填充方式：Pkcs5Padding；密钥：1234567890123456；密钥长度：128 bit
        encodeStr = crypto.aes_encrypt("ECB","PKCS5",originStr,"1234567890123456")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("ECB","PKCS5",encodeStr,"1234567890123456"))

        originStr = "AES128 ECB ZeroPt"
        --Encryption mode：ECB；填充方式：Pkcs7Padding；密钥：1234567890123456；密钥长度：128 bit
        encodeStr = crypto.aes_encrypt("ECB","PKCS7",originStr,"1234567890123456")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("ECB","PKCS7",encodeStr,"1234567890123456"))

        originStr = "AES192 ECB ZeroPadding test"
        --Encryption mode：ECB；填充方式：ZeroPadding；密钥：123456789012345678901234；密钥长度：192 bit
        local encodeStr = crypto.aes_encrypt("ECB","ZERO",originStr,"123456789012345678901234")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("ECB","ZERO",encodeStr,"123456789012345678901234"))

        originStr = "AES192 ECB Pkcs5Padding test"
        --Encryption mode：ECB；填充方式：Pkcs5Padding；密钥：123456789012345678901234；密钥长度：192 bit
        encodeStr = crypto.aes_encrypt("ECB","PKCS5",originStr,"123456789012345678901234")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("ECB","PKCS5",encodeStr,"123456789012345678901234"))

        originStr = "AES192 ECB Pkcs7Padding test"
        --Encryption mode：ECB；填充方式：Pkcs7Padding；密钥：123456789012345678901234；密钥长度：192 bit
        encodeStr = crypto.aes_encrypt("ECB","PKCS7",originStr,"123456789012345678901234")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("ECB","PKCS7",encodeStr,"123456789012345678901234"))

        originStr = "AES256 ECB ZeroPadding test"
        --Encryption mode：ECB；填充方式：ZeroPadding；密钥：12345678901234567890123456789012；密钥长度：256 bit
        local encodeStr = crypto.aes_encrypt("ECB","ZERO",originStr,"12345678901234567890123456789012")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("ECB","ZERO",encodeStr,"12345678901234567890123456789012"))

        originStr = "AES256 ECB Pkcs5Padding test"
        --Encryption mode：ECB；填充方式：Pkcs5Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit
        encodeStr = crypto.aes_encrypt("ECB","PKCS5",originStr,"12345678901234567890123456789012")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("ECB","PKCS5",encodeStr,"12345678901234567890123456789012"))

        originStr = "AES256 ECB Pkcs7Padding test"
        --Encryption mode：ECB；填充方式：Pkcs7Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit
        encodeStr = crypto.aes_encrypt("ECB","PKCS7",originStr,"12345678901234567890123456789012")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("ECB","PKCS7",encodeStr,"12345678901234567890123456789012"))




        originStr = "AES128 CBC ZeroPadding test"
        --Encryption mode：CBC；填充方式：ZeroPadding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
        local encodeStr = crypto.aes_encrypt("CBC","ZERO",originStr,"1234567890123456","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CBC","ZERO",encodeStr,"1234567890123456","1234567890666666"))

        originStr = "AES128 CBC Pkcs5Padding test"
        --Encryption mode：CBC；填充方式：Pkcs5Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CBC","PKCS5",originStr,"1234567890123456","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CBC","PKCS5",encodeStr,"1234567890123456","1234567890666666"))

        originStr = "AES128 CBC Pkcs7Padding test"
        --加密模式：CBC；填充方式：Pkcs7Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CBC","PKCS7",originStr,"1234567890123456","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CBC","PKCS7",encodeStr,"1234567890123456","1234567890666666"))

        originStr = "AES192 CBC ZeroPadding test"
        --加密模式：CBC；填充方式：ZeroPadding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
        local encodeStr = crypto.aes_encrypt("CBC","ZERO",originStr,"123456789012345678901234","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CBC","ZERO",encodeStr,"123456789012345678901234","1234567890666666"))

        originStr = "AES192 CBC Pkcs5Padding test"
        --加密模式：CBC；填充方式：Pkcs5Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CBC","PKCS5",originStr,"123456789012345678901234","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CBC","PKCS5",encodeStr,"123456789012345678901234","1234567890666666"))

        originStr = "AES192 CBC Pkcs7Padding test"
        --加密模式：CBC；填充方式：Pkcs7Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CBC","PKCS7",originStr,"123456789012345678901234","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CBC","PKCS7",encodeStr,"123456789012345678901234","1234567890666666"))

        originStr = "AES256 CBC ZeroPadding test"
        --加密模式：CBC；填充方式：ZeroPadding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
        local encodeStr = crypto.aes_encrypt("CBC","ZERO",originStr,"12345678901234567890123456789012","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CBC","ZERO",encodeStr,"12345678901234567890123456789012","1234567890666666"))

        originStr = "AES256 CBC Pkcs5Padding test"
        --加密模式：CBC；填充方式：Pkcs5Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CBC","PKCS5",originStr,"12345678901234567890123456789012","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CBC","PKCS5",encodeStr,"12345678901234567890123456789012","1234567890666666"))

        originStr = "AES256 CBC Pkcs7Padding test"
        --加密模式：CBC；填充方式：Pkcs7Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CBC","PKCS7",originStr,"12345678901234567890123456789012","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CBC","PKCS7",encodeStr,"12345678901234567890123456789012","1234567890666666"))





        originStr = "AES128 CTR ZeroPadding test"
        --加密模式：CTR；填充方式：ZeroPadding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
        local encodeStr = crypto.aes_encrypt("CTR","ZERO",originStr,"1234567890123456","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","ZERO",encodeStr,"1234567890123456","1234567890666666"))

        originStr = "AES128 CTR Pkcs5Padding test"
        --加密模式：CTR；填充方式：Pkcs5Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CTR","PKCS5",originStr,"1234567890123456","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","PKCS5",encodeStr,"1234567890123456","1234567890666666"))

        originStr = "AES128 CTR Pkcs7Padding test"
        --加密模式：CTR；填充方式：Pkcs7Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CTR","PKCS7",originStr,"1234567890123456","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","PKCS7",encodeStr,"1234567890123456","1234567890666666"))

        originStr = "AES128 CTR NoneP"--长度为16的整数倍
        --加密模式：CTR；填充方式：NonePadding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CTR","NONE",originStr,"1234567890123456","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","NONE",encodeStr,"1234567890123456","1234567890666666"))

        originStr = "AES192 CTR ZeroPadding test"
        --加密模式：CTR；填充方式：ZeroPadding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
        local encodeStr = crypto.aes_encrypt("CTR","ZERO",originStr,"123456789012345678901234","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","ZERO",encodeStr,"123456789012345678901234","1234567890666666"))

        originStr = "AES192 CTR Pkcs5Padding test"
        --加密模式：CTR；填充方式：Pkcs5Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CTR","PKCS5",originStr,"123456789012345678901234","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","PKCS5",encodeStr,"123456789012345678901234","1234567890666666"))

        originStr = "AES192 CTR Pkcs7Padding test"
        --加密模式：CTR；填充方式：Pkcs7Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CTR","PKCS7",originStr,"123456789012345678901234","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","PKCS7",encodeStr,"123456789012345678901234","1234567890666666"))

        originStr = "AES192 CTR NoneP"--长度为16的整数倍
        --加密模式：CTR；填充方式：NonePadding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CTR","NONE",originStr,"123456789012345678901234","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","NONE",encodeStr,"123456789012345678901234","1234567890666666"))

        originStr = "AES256 CTR ZeroPadding test"
        --加密模式：CTR；填充方式：ZeroPadding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
        local encodeStr = crypto.aes_encrypt("CTR","ZERO",originStr,"12345678901234567890123456789012","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","ZERO",encodeStr,"12345678901234567890123456789012","1234567890666666"))

        originStr = "AES256 CTR Pkcs5Padding test"
        --加密模式：CTR；填充方式：Pkcs5Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CTR","PKCS5",originStr,"12345678901234567890123456789012","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","PKCS5",encodeStr,"12345678901234567890123456789012","1234567890666666"))

        originStr = "AES256 CTR Pkcs7Padding test"
        --加密模式：CTR；填充方式：Pkcs7Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CTR","PKCS7",originStr,"12345678901234567890123456789012","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","PKCS7",encodeStr,"12345678901234567890123456789012","1234567890666666"))

        originStr = "AES256 CTR NoneP"--长度为16的整数倍
        --加密模式：CTR；填充方式：NonePadding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
        encodeStr = crypto.aes_encrypt("CTR","NONE",originStr,"12345678901234567890123456789012","1234567890666666")
        print(originStr,"encrypt",string.toHex(encodeStr))
        log.info("testCrypto.decrypt",crypto.aes_decrypt("CTR","NONE",encodeStr,"12345678901234567890123456789012","1234567890666666"))
end

function JWTToken()

    local startepoch = os.time{year=2021, month=11, day=9, hour=15, min=00, sec=10}
    local iat = "\"iat\": "..startepoch
    print(iat)
    local endepoch = os.time{year=2021, month=11, day=9, hour=15, min=40, sec=10}
    local exp = "\"exp\": "..endepoch
    print(exp)

    local aud =  "\"aud\":\"cedar-abacus-328802\""
    print(aud)

    local payloadforbased64 = "{"..aud..","..iat..","..exp.."}"
    print(payloadforbased64)
    print("========================================================")
    local encodepayload = crypto.base64_encode(payloadforbased64,slen(payloadforbased64))

    local changeplus = string.gsub(encodepayload, "(+)","-")
    local changeslash = string.gsub(changeplus, "(/)","_")
    local changeequal2 = string.gsub(changeslash, "(==)","")
    local payloadcomplete = string.gsub(changeequal2, "(=)","")
    print(payloadcomplete)
    print("========================================================")

    local Header = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9"
    local PayLoad = payloadcomplete
    local HeaderAndPayLoad = Header.."."..PayLoad
    --local HeaderAndPayLoad = Header.."."..payloadcomplete

    --Private key signature (2048bit，This bit is consistent with the bit of the actual private key)
    local signStr = crypto.rsa_sha256_sign("PRIVATE_KEY",io.readFile("/lua/private.key"),2048,"PRIVATE_CRYPT",HeaderAndPayLoad)
    --log.info("rsaTest.signStr",signStr:toHex())
    local encodeStr = crypto.base64_encode(signStr,slen(signStr))
    print("********************")
    print(encodeStr)
    local plustominus = string.gsub(encodeStr, "(+)","-")
    local slash = string.gsub(plustominus, "(/)","_")
    local equal2 = string.gsub(slash, "(==)","")
    local signcomplete = string.gsub(equal2, "(=)","")

    local CompleteToken = HeaderAndPayLoad.."."..signcomplete
    print("--------------------------------------------------------")
    print()
    print("Complete Token:  "..CompleteToken)

    return CompleteToken
end

--rsa algorithm test
local function rsaTest()
    --local plainStr = "1234567890asdfghjklzxcvbnm"
    -- local plainStr = "firmId=10015&model=zw-sp300&sn=W01201910300000108&version=1.0.0"
    --local plainStr = "{\"typ\":\"JWT\",\"alg\":\"RS256\""..'}'..'.'.."{\"iat\": 1635730706,\"exp\": 1635731906,\"aud\":\"cedar-abacus-328802\""..'}'
    local plainStr = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2MzU4OTQ4MDEsImV4cCI6MTYzNTg5NjAwMSwiYXVkIjoiY2VkYXItYWJhY3VzLTMyODgwMiJ9"

    --Public key encryption (2048bit，This one Bits should be consistent with bits of the actual public key)
    local encryptStr = crypto.rsa_encrypt("PUBLIC_KEY",io.readFile("/lua/public.key"),2048,"PUBLIC_CRYPT",plainStr)
    log.info("rsaTest.encrypt",encryptStr:toHex())
    --The private key is decrypted (2048bit，This bit is consistent with the bit of the actual private key)
    local decryptStr = crypto.rsa_decrypt("PRIVATE_KEY",io.readFile("/lua/private.key"),2048,"PRIVATE_CRYPT",encryptStr)
    log.info("rsaTest.decrypt",decryptStr) --The decryptStr here should be the same as the platinStr

    --Private key signature (2048bit，This bit is consistent with the bit of the actual private key)
    local signStr = crypto.rsa_sha256_sign("PRIVATE_KEY",io.readFile("/lua/private.key"),2048,"PRIVATE_CRYPT",plainStr)
    log.info("rsaTest.signStr",signStr:toHex())
    local encodeStr = crypto.base64_encode(signStr,slen(signStr))
    print("********************")
    print(encodeStr)
    local plustominus = string.gsub(encodeStr, "(+)","-")
    local slash = string.gsub(plustominus, "(/)","_")
    local signcomplete = string.gsub(slash, "(==)","")
    --local replacements = {["(==)"] = "",["(+)"] = "-",["(/)"] = "_"}
    --local result = string.gsub (encodeStrs, "%a+", replacements)
    --local woi = encodeStr
    --local res, result = string.gsub(woi:gsub('=[=]$'),'+','-')
    --print(res)
    print("~~~~~~~~~~~~~~~~~~~~~~~")
    log.info("testCrypto.base64_encode",signcomplete)
    
    --Public key check (2048bit，This bit should be consistent with the bit of the actual public key)
    local verifyResult = crypto.rsa_sha256_verify("PUBLIC_KEY",io.readFile("/lua/public.key"),2048,"PUBLIC_CRYPT",signStr,plainStr)
    log.info("rsaTest.verify",verifyResult)



    --The private key decrypts a customer's public key encrypted redaction
    encryptStr = string.fromHex("af750a8c95f9d973a033686488197cffacb8c1b2b5a15ea8779a48a72a1cdb2f9c948fe5ce0ac231a16de16b5fb609f62ec81c7646c1f018e333860627b5d4853cfe77f71ea7e4573323905faf0a759d59729d2afb80e46ff1f1b715227b599a14f3b9feb676f1feb1c2acd97f4d494124237a720ca781a16a2b600c17e348a5fdd3c374384276147b93ce93cc5a005a0aaf1581cdb7d58bfa84b4e4d7263efc02bf7ad80b15937ce8b37ced4e1ef8899be5c2a7d338cb5c4784c6b8a1cb31e7ecd1ec48597a02050b1190a3e13f2253a35e8cbc094c0af28b968f05a7f946a7a8cf3f9da2013d53ee51ca74279f8f36662e093b37db83caef5b18b666d405d4")
    decryptStr = crypto.rsa_decrypt("PRIVATE_KEY",io.readFile("/lua/private.key"),2048,"PRIVATE_CRYPT",encryptStr)
    log.info("rsaTest.decrypt",decryptStr)

    --The public key checks a customer's private key signature redaction
    signStr = string.fromHex("7251fd625c01ac41e277d11b5b795962ba42d89a645eb9fe2241b2d8a9b6b5b6ea70e23e6933ef1324495749abde0e31eaf4fefe6d09f9270c0510790bd6075595717522539b7b70b798bdc216dae3873389644d73b04ecaeb01b25831904955a891d2459334a3f9f1e4558f7f99906c35f94c377f7f95cf0d3e062d8eb513fd723ad8b3981027b09126fbeb72d5fe4554a32b9c270f8f46032ede59387769b1fb090f0b4be15aaac2744a666dfbde7c04e02979f1c1b4e4c0f23c6bb9f60941312850caf41442d68ad7c9e939b7305ac6712ad31427f1c1d7b4f68001df9ce03367bd35e401a420f526aee3c96c2caaccb9a8db09b30930172b4c2847725d05")
    verifyResult = crypto.rsa_sha256_verify("PUBLIC_KEY",io.readFile("/lua/public.key"),2048,"PUBLIC_CRYPT",signStr,"firmId=10015&model=zw-sp300&sn=W01201910300000108&version=1.0.0")
    log.info("rsaTest.verifyResult customer",verifyResult)
end

--DES algorithm test

local function desTest()

        local originStr = "123456781234"
		--加密模式：DES CBC；填充方式：ZERO；密钥：12345678; 偏移：00000000
        encodeStr = crypto.des_encrypt("CBC","ZERO",originStr,"12345678","00000000")
		print(originStr,"DES ECB ZeroPadding encrypt",string.toHex(encodeStr))
        log.info("DES ECB ZeroPadding decrypt",crypto.des_decrypt("CBC","ZERO",encodeStr,"12345678","00000000"))

		originStr = "123456789"
        --加密模式：DES CBC；填充方式：Pkcs5Padding；密钥：12345678; 偏移：00000000
        encodeStr = crypto.des_encrypt("CBC","PKCS5",originStr,"12345678","00000000")
        print(originStr,"DES ECB Pkcs5Padding encrypt",string.toHex(encodeStr))
        log.info("DES ECB Pkcs5Padding decrypt",crypto.des_decrypt("CBC","PKCS5",encodeStr,"12345678","00000000"))

        originStr = "123456789"
        --加密模式：DES ECB；填充方式：Pkcs7Padding；密钥：12345678
        encodeStr = crypto.des_encrypt("ECB","PKCS7",originStr,"12345678","12345678")
        print(originStr,"DES ECB Pkcs7Padding encrypt",string.toHex(encodeStr))
        log.info("DES ECB Pkcs7Padding decrypt",crypto.des_decrypt("ECB","PKCS7",encodeStr,"12345678"))

        originStr = ("31323334353637383900000000000000"):fromHex()
        --加密模式：DES ECB；填充方式：NONE；密钥：12345678
        encodeStr = crypto.des_encrypt("ECB","NONE",originStr,"12345678")
        print(originStr,"DES ECB NonePadding encrypt",string.toHex(encodeStr))
        log.info("DES ECB NonePadding decrypt",string.toHex(crypto.des_decrypt("ECB","NONE",encodeStr,"12345678")))
end

--DES3 algorithm test
local function des3Test()

        local originStr = "123456781234"
		--加密模式：DES CBC；填充方式：ZERO；密钥：123456781234567812345678; 偏移：00000000
        encodeStr = crypto.des3_encrypt("CBC","ZERO",originStr,"123456781234567812345678","00000000")
		print(originStr,"DES ECB ZeroPadding encrypt",string.toHex(encodeStr))
        log.info("DES ECB ZeroPadding decrypt",crypto.des3_decrypt("CBC","ZERO",encodeStr,"123456781234567812345678","00000000"))

		originStr = "123456789"
        --加密模式：DES CBC；填充方式：Pkcs5Padding；密钥：123456781234567812345678; 偏移：00000000
        encodeStr = crypto.des3_encrypt("CBC","PKCS5",originStr,"123456781234567812345678","00000000")
        print(originStr,"DES ECB Pkcs5Padding encrypt",string.toHex(encodeStr))
        log.info("DES ECB Pkcs5Padding decrypt",crypto.des3_decrypt("CBC","PKCS5",encodeStr,"123456781234567812345678","00000000"))

        originStr = "123456789"
        --加密模式：DES ECB；填充方式：Pkcs7Padding；密钥：123456781234567812345678
        encodeStr = crypto.des3_encrypt("ECB","PKCS7",originStr,"123456781234567812345678","123456781234567812345678")
        print(originStr,"DES ECB Pkcs7Padding encrypt",string.toHex(encodeStr))
        log.info("DES ECB Pkcs7Padding decrypt",crypto.des3_decrypt("ECB","PKCS7",encodeStr,"123456781234567812345678"))

        originStr = ("31323334353637383900000000000000"):fromHex()
        --加密模式：DES ECB；填充方式：NONE；密钥：123456781234567812345678
        encodeStr = crypto.des3_encrypt("ECB","NONE",originStr,"123456781234567812345678")
        print(originStr,"DES ECB NonePadding encrypt",string.toHex(encodeStr))
        log.info("DES ECB NonePadding decrypt",string.toHex(crypto.des3_decrypt("ECB","NONE",encodeStr,"123456781234567812345678")))
end

--- The algorithm tests the portal
-- @return
local function cryptoTest()
    print("test start")
    print("--- hmacMd5Test")
    hmacMd5Test()
    print(" ")
    print("--- Md5Test")
    md5Test()
    print(" ")
    print("--- hmacSha1Test")
    hmacSha1Test()
    print(" ")
    print("--- floiwMd5Test")
    flowMd5Test()
    print(" ")
    print("--- base64Test")
    base64Test()
    print(" ")
    print("--- crcTest")
    crcTest()
    print(" ")
    print("--- aesTest")
    aesTest()
    print(" ")
    print("--- sha1Test")
    sha1Test()
    print(" ")
    print("--- sha256Test")
    sha256Test()
    print(" ")
    print("--- hmacSha256Test")
    hmacSha256Test()
    print(" ")
    print("--- xxteaTest")
    xxteaTest()
    print(" ")
    print("-----------------------------")
    print(pcall(rsaTest))
    print("-----------------------------")
    print(" ")
    desTest()
    des3Test()
    print("")
    print("--- JWT")
    local JWT = JWTToken()
    print()
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    print(JWT)

    print("test end")
end

sys.timerStart(cryptoTest,6000)


