--THE PROJECT AND VERSION VARIABLES MUST BE DEFINED AT THIS LOCATION
--PROJECT：Ascii string type, can be defined at will, as long as not used, on the line
--VERSION：Ascii string type, if you use the features of the Luat Co-op Cloud Platform firmware upgrade, must be defined as "X.X.X", X represents 1 digit;
PROJECT = "MMW_6_ROW_NO_LIFTER"
VERSION = "1.0.0"

--Load the log function module and set the log output level
--If you close the log output log that calls the log module interface, the rating is set to log. LOG_SILENT it
--require "log"
--LOG_LEVEL = log.LOGLEVEL_TRACE
--[[
If you use the UART output log, open the line of comment code "--log.openTrace (true, 1,115200)" and modify the parameters of this interface according to your needs
If you want to completely close the output log in the script, including the log that calls the log module interface and the lua standard print interface output,
execute the log.openTrace (false, the second argument is the same as the second parameter that calls the openTrace interface to open the log), for example:

1. did not call sys.opntrace configuration log output port or last time call log.openTrace (true, nil, 921600) configuration log output port, at this time to close the output log,
directly call log.openTrace (false) c   an be
2. the last time is to call log.openTrace (true, 1,115200) configuration log output port, at this time to close the output log, directly call log.openTrace (false,1) can be
]]
--log.openTrace(true,1,115200)
require "sys"

require "net"
--Query GSM signal strength every 1 minute
--The base station information is queried every 1 minute
net.startQueryAll(60000, 60000)

--Turn off the RNDIS network card feature heree
--Otherwise, after the module is connected to the computer via USB, an RNDIS network card is enumerated in the computer's network adapter, which the computer uses by default to access the Internet, resulting in the loss of sim card traffic used by the module
--If you need to turn this feature on in your project, modify the ril.request ("AT-RNDISCALL-0,1") to ril.request ("AT-RNDISCALL=1,1").
--Note: Core firmware: V0030 and subsequent versions, V3028, and later versions to support this feature in a stable manner
--print("--------------------- REQ AT+RNDISCALL ---------------")
--ril.request("AT+RNDISCALL=0,1")

--Load the console debug function module (the code here is configured with uart2, Baud rate 115200)
--This feature module is not required to decide whether to load based on project requirements
--Note when using: The uart used by the console does not conflict with the uart used by other features
--Instructions for using the instructions refer to the "Console Features Use Instructions.docx" under demo/console
--require "console"
--console.setup(2, 115200)

--Load the network indicator and LTE INDICATOR function modules
--[[Depending on your project needs and hardware configuration：
    1. whether to load this function module；
    2. placement instruction light pull leg]]
--The network led pin on the Air724U development board, which is officially sold by Hezhou, is pio.P0_1 and the LTE indicator pin is pio.P0_4
require "netLed"
pmd.ldoset(2,pmd.LDO_VLCD)
netLed.setup(true,pio.P0_1,pio.P0_4) --try P0_5
--[[
   The network LIGHT function module
   The flashing laws of the leDs in various operating states are configured by default
   Refer to the default values of the ledBlinkTime configuration in the netLed.lua
]]
--If the default value does not meet the requirements，Call netLed.updateBlinkTime here to configure the flashing time
--LTE INDICATOR function module，The configuration is to register the 4G network，The light is always on，Any remaining status lights will go out

--Load the error log management function module, It is highly recommended to turn on this feature
--Here are 2 lines of code，Just a simple demonstration of how to use the errDump feature，For more information, refer to the api of errDump
--require "errDump" -- later comment
--errDump.request("https://docs.google.com/document/d/1tNr0D7Xxp3uzYYxOJFp7-H2KJN4IflUoNr1Qo1gAEoM/edit?usp=drive_web&ouid=100559529725341203332") -- later comment

--Loading the Remote Upgrade feature module is highly recommended to turn this feature on
--If you use Alibaba Cloud's OTA functionality，You can't turn this feature on.
--Here are three lines of code，Just a simple demonstration of how to use the update feature，For more information, please refer to the api of update and demo/update
--PRODUCT_KEY = "v32xEAKsGTIEQxtqgwCldp5aPlcnPs3K"
--require "update"
--update.request()

--Load the MQTT functional test module
require "mqttTask"
--Start the system framework   
sys.init(0, 0)
sys.run()
