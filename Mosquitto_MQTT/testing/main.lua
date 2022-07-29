PROJECT = "MMW_V2_MOSQUITTO"
VERSION = "2.0.0"

require "sys"       -- Load system module function
require "net"       -- Load Network module function


--Query GSM signal strength every 1 minute
--The base station information is queried every 1 minute
net.startQueryAll(60000, 60000)

--Load the network indicator and LTE  INDICATOR function modules
--[[Depending on your project needs and hardware configuration：
    1. whether to load this function module；
    2. placement instruction light pull leg]]
--The network led pin on the Air724U development board, which is officially sold by Hezhou, is pio.P0_1 and the LTE indicator pin is pio.P0_4
require "netLed"
pmd.ldoset(2,pmd.LDO_VLCD)
netLed.setup(true,pio.P0_1,pio.P0_4)

-- require "mqttTask"  --Load the MQTT functional test module
require "uarttest"
--Start the system framework   
sys.init(0, 0)
sys.run()