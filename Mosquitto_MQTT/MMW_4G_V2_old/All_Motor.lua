--[[This code purpose to Run All Motor]]

module(...,package.seeall)

require"utils"
require"pm"
require"mqttOutMsg"
require "uartfunction"

local uartID = 1



local function test_timer()
    sys.wait(3000)
end

local MQTTData = " "
local InputData = " "

local function first_indicator()
    -- uart.write(uartID, "MO\n")      -- comment when NOT USE DEMO MACHINE (ARD USE NTC 7)
    -- sys.wait(2000)                  -- comment when NOT USE DEMO MACHINE (ARD USE NTC 7)
    print("----- Publish First Condition -----")
    uartfunction.PubQosStart()
    -- mqttOutMsg.PubQosStart()
    sys.wait(3000)
end

function Run(RecData)
    -- print(RecData)
    MQTTData = RecData
    -- print(MQTTData)
end

local function Run_All()
    while true do
        
        -- ##### TRAY A #####
        local A1 = "_A_1"
        local A2 = "_A_2"
        local A3 = "_A_3"
        local A4 = "_A_4"
        local A5 = "_A_5"
        local A6 = "_A_6"
        local A7 = "_A_7"
        local A8 = "_A_8"
        local A9 = "_A_9"
        local A10 = "_A_A"

        -- ##### TRAY B #####
        local B1 = "_B_1"
        local B2 = "_B_2"
        local B3 = "_B_3"
        local B4 = "_B_4"
        local B5 = "_B_5"
        local B6 = "_B_6"
        local B7 = "_B_7"
        local B8 = "_B_8"
        local B9 = "_B_9"
        local B10 = "_B_B"

        -- ##### TRAY C #####
        local C1 = "_C_1"
        local C2 = "_C_2"
        local C3 = "_C_3"
        local C4 = "_C_4"
        local C5 = "_C_5"
        local C6 = "_C_6"
        local C7 = "_C_7"
        local C8 = "_C_8"
        local C9 = "_C_9"
        local C10 = "_C_C"

        -- ##### TRAY D #####
        local D1 = "_D_1"
        local D2 = "_D_2"
        local D3 = "_D_3"
        local D4 = "_D_4"
        local D5 = "_D_5"
        local D6 = "_D_6"
        local D7 = "_D_7"
        local D8 = "_D_8"
        local D9 = "_D_9"
        local D10 = "_D_D"

        -- ##### TRAY E #####
        local E1 = "_E_1"
        local E2 = "_E_2"
        local E3 = "_E_3"
        local E4 = "_E_4"
        local E5 = "_E_5"
        local E6 = "_E_6"
        local E7 = "_E_7"
        local E8 = "_E_8"
        local E9 = "_E_9"
        local E10 = "_E_E"

        -- ##### TRAY F #####
        local F1 = "_F_1"
        local F2 = "_F_2"
        local F3 = "_F_3"
        local F4 = "_F_4"
        local F5 = "_F_5"
        local F6 = "_F_6"
        local F7 = "_F_7"
        local F8 = "_F_8"
        local F9 = "_F_9"
        local F10 = "_F_F"

        InputData = MQTTData
        
        -- print("--------------------------------------")
        if string.match(InputData , "HI") then
            MQTTData = " "
            -- uart.write(uartID,"stachck")
            uartfunction.write("stachck")
            print("--------------------------------------")
            -- mqttOutMsg.PubQos0Drop()

        -- elseif string.match(InputData , "TEMP") then
        --     MQTTData = " "
        --     uartfunction.write("stachck")
        --     print("--------------------------------------")

        -- elseif string.match(InputData , "DOOR") then
        --     MQTTData = " "
        --     uartfunction.write("stachck")
        --     print("--------------------------------------")
        
        elseif string.match(InputData , "A1") then
            MQTTData = " "
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..A1)
            uartfunction.write(mqttOutMsg.Mode_Status()..A1)
            print("--------------------------------------")
            

        elseif string.match(InputData , "B1") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..B1)
            uartfunction.write(mqttOutMsg.Mode_Status()..B1)
            MQTTData = " "
            print("--------------------------------------")
        
        elseif string.match(InputData , "C1") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..C1)
            uartfunction.write(mqttOutMsg.Mode_Status()..C1)
            MQTTData = " "
            print("--------------------------------------")
        
        elseif string.match(InputData , "D1") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..D1)
            uartfunction.write(mqttOutMsg.Mode_Status()..D1)
            MQTTData = " "
            print("--------------------------------------")
        
        elseif string.match(InputData , "E1") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..E1)
            uartfunction.write(mqttOutMsg.Mode_Status()..E1)
            MQTTData = " "
            print("--------------------------------------")
        
        elseif string.match(InputData , "F1") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..F1)
            uartfunction.write(mqttOutMsg.Mode_Status()..F1)
            MQTTData = " "
            print("--------------------------------------")
        
    -- ===========================================================
        -- ########## COLOUM 2 / B ##########
    -- ===========================================================
        elseif string.match(InputData , "A2") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..A2)
            uartfunction.write(mqttOutMsg.Mode_Status()..A2)
            MQTTData = " "
            print("--------------------------------------")
        
        elseif string.match(InputData , "B2") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..B2)
            uartfunction.write(mqttOutMsg.Mode_Status()..B2)
            MQTTData = " "
            print("--------------------------------------")
        
        elseif string.match(InputData , "C2") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..C2)
            uartfunction.write(mqttOutMsg.Mode_Status()..C2)
            MQTTData = " "
            print("--------------------------------------")
        
        elseif string.match(InputData , "D2") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..D2)
            uartfunction.write(mqttOutMsg.Mode_Status()..D2)
            MQTTData = " "
            print("--------------------------------------")
        
        elseif string.match(InputData , "E2") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..E2)
            uartfunction.write(mqttOutMsg.Mode_Status()..E2)
            MQTTData = " "
            print("--------------------------------------")
        
        elseif string.match(InputData , "F2") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..F2)
            uartfunction.write(mqttOutMsg.Mode_Status()..F2)
            MQTTData = " "
            print("--------------------------------------")

    -- ===========================================================
        -- ########## COLOUM 3 / C ##########
    -- ===========================================================
        elseif string.match(InputData , "A3") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..A3)
            uartfunction.write(mqttOutMsg.Mode_Status()..A3)
            MQTTData = " "
            print("--------------------------------------")

        elseif string.match(InputData , "B3") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..B3)
            uartfunction.write(mqttOutMsg.Mode_Status()..B3)
            MQTTData = " "
            print("--------------------------------------")

        elseif string.match(InputData , "C3") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..C3)
            uartfunction.write(mqttOutMsg.Mode_Status()..C3)
            MQTTData = " "
            print("--------------------------------------")
            
        elseif string.match(InputData , "D3") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..D3)
            uartfunction.write(mqttOutMsg.Mode_Status()..D3)
            MQTTData = " "
            print("--------------------------------------")
        
        elseif string.match(InputData , "E3") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..E3)
            uartfunction.write(mqttOutMsg.Mode_Status()..E3)
            MQTTData = " "
            print("--------------------------------------")

        elseif string.match(InputData , "F3") then
            first_indicator()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F3)
            uartfunction.write(mqttOutMsg.Mode_Status()..F3)
            print("--------------------------------------")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 4 / D ##########
    -- ===========================================================
        elseif string.match(InputData , "A4") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..A4)
            uartfunction.write(mqttOutMsg.Mode_Status()..A4)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "B4") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..B4)
            uartfunction.write(mqttOutMsg.Mode_Status()..B4)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "C4") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..C4)
            uartfunction.write(mqttOutMsg.Mode_Status()..C4)
            print("--------------------------------------")
            MQTTData = " "
            
        elseif string.match(InputData , "D4") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..D4)
            uartfunction.write(mqttOutMsg.Mode_Status()..D4)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "E4") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..E4)
            uartfunction.write(mqttOutMsg.Mode_Status()..E4)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "F4") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..F4)
            uartfunction.write(mqttOutMsg.Mode_Status()..F4)
            print("--------------------------------------")
            MQTTData = " "
        
    -- ===========================================================
        -- ########## COLOUM 5 / E ##########
    -- ===========================================================
        elseif string.match(InputData , "A5") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..A5)
            uartfunction.write(mqttOutMsg.Mode_Status()..A5)
            print("--------------------------------------")
            MQTTData = " "
            
        elseif string.match(InputData , "B5") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..B5)
            uartfunction.write(mqttOutMsg.Mode_Status()..B5)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "C5") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..C5)
            uartfunction.write(mqttOutMsg.Mode_Status()..C5)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "D5") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..D5)
            uartfunction.write(mqttOutMsg.Mode_Status()..D5)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "E5") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..E5)
            uartfunction.write(mqttOutMsg.Mode_Status()..E5)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "F5") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..F5)
            uartfunction.write(mqttOutMsg.Mode_Status()..F5)
            print("--------------------------------------")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 6 / F ##########
    -- ===========================================================
        elseif string.match(InputData , "A6") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..A6)
            uartfunction.write(mqttOutMsg.Mode_Status()..A6)
            print("--------------------------------------")
            MQTTData = " "
        
        elseif string.match(InputData , "B6") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..B6)
            uartfunction.write(mqttOutMsg.Mode_Status()..B6)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "C6") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..C6)
            uartfunction.write(mqttOutMsg.Mode_Status()..C6)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "D6") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..D6)
            uartfunction.write(mqttOutMsg.Mode_Status()..D6)
            print("--------------------------------------")
            MQTTData = " "
            
        elseif string.match(InputData , "E6") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..E6)
            uartfunction.write(mqttOutMsg.Mode_Status()..E6)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "F6") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..F6)
            uartfunction.write(mqttOutMsg.Mode_Status()..F6)
            print("--------------------------------------")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 7 / G ##########
    -- ===========================================================
        elseif string.match(InputData , "A7") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..A7)
            uartfunction.write(mqttOutMsg.Mode_Status()..A7)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "B7") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..B7)
            uartfunction.write(mqttOutMsg.Mode_Status()..B7)
            print("--------------------------------------")
            MQTTData = " "
            
        elseif string.match(InputData , "C7") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..C7)
            uartfunction.write(mqttOutMsg.Mode_Status()..C7)
            print("--------------------------------------")
            MQTTData = " "
        
        elseif string.match(InputData , "D7") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..D7)
            uartfunction.write(mqttOutMsg.Mode_Status()..D7)
            print("--------------------------------------")
            MQTTData = " "
        
        elseif string.match(InputData , "E7") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..E7)
            uartfunction.write(mqttOutMsg.Mode_Status()..E7)
            print("--------------------------------------")
            MQTTData = " "
        
        elseif string.match(InputData , "F7") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..F7)
            uartfunction.write(mqttOutMsg.Mode_Status()..F7)
            print("--------------------------------------")
            MQTTData = " "
            
    -- ===========================================================
        -- ########## COLOUM 8 / H ##########
    -- ===========================================================
        elseif string.match(InputData , "A8") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..A8)
            uartfunction.write(mqttOutMsg.Mode_Status()..A8)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "B8") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..B8)
            uartfunction.write(mqttOutMsg.Mode_Status()..B8)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "C8") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..C8)
            uartfunction.write(mqttOutMsg.Mode_Status()..C8)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "D8") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..D8)
            uartfunction.write(mqttOutMsg.Mode_Status()..D8)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "E8") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..E8)
            uartfunction.write(mqttOutMsg.Mode_Status()..E8)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "F8") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..F8)
            uartfunction.write(mqttOutMsg.Mode_Status()..F8)
            print("--------------------------------------")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 9 / I ##########
    -- ===========================================================
        elseif string.match(InputData , "A9") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..A9)
            uartfunction.write(mqttOutMsg.Mode_Status()..A9)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "B9") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..B9)
            uartfunction.write(mqttOutMsg.Mode_Status()..B9)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "C9") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..C9)
            uartfunction.write(mqttOutMsg.Mode_Status()..C9)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "D9") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..D9)
            uartfunction.write(mqttOutMsg.Mode_Status()..D9)
            print("--------------------------------------")
            MQTTData = " "
        
        elseif string.match(InputData , "E9") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..E9)
            uartfunction.write(mqttOutMsg.Mode_Status()..E9)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "F9") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..F9)
            uartfunction.write(mqttOutMsg.Mode_Status()..F9)
            print("--------------------------------------")
            MQTTData = " "

    -- ===========================================================
        -- ########## COLOUM 10 / J ##########
    -- ===========================================================
        elseif string.match(InputData , "10A") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..A10)
            uartfunction.write(mqttOutMsg.Mode_Status()..A10)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "10B") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..B10)
            uartfunction.write(mqttOutMsg.Mode_Status()..B10)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "10C") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..C10)
            uartfunction.write(mqttOutMsg.Mode_Status()..C10)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "10D") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..D10)
            uartfunction.write(mqttOutMsg.Mode_Status()..D10)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "10E") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..E10)
            uartfunction.write(mqttOutMsg.Mode_Status()..E10)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "10F") then
            first_indicator()
            -- uart.write(uartID,mqttOutMsg.Mode_Status()..F10)
            uartfunction.write(mqttOutMsg.Mode_Status()..F10)
            print("--------------------------------------")
            MQTTData = " "

        elseif string.match(InputData , "TEST") then
            MQTTData = " "
            first_indicator()
            print("**********----- TESTING ALL MOTOR -----**********")
            -- ######### TRAY A ##########
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A1)
            uartfunction.write(mqttOutMsg.Mode_Status()..A1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A2)
            uartfunction.write(mqttOutMsg.Mode_Status()..A2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A3)
            uartfunction.write(mqttOutMsg.Mode_Status()..A3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A4)
            uartfunction.write(mqttOutMsg.Mode_Status()..A4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A5)
            uartfunction.write(mqttOutMsg.Mode_Status()..A5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A6)
            uartfunction.write(mqttOutMsg.Mode_Status()..A6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A7)
            uartfunction.write(mqttOutMsg.Mode_Status()..A7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A8)
            uartfunction.write(mqttOutMsg.Mode_Status()..A8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A9)
            uartfunction.write(mqttOutMsg.Mode_Status()..A9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A10)
            uartfunction.write(mqttOutMsg.Mode_Status()..A10)
            test_timer()
        
            -- ######## TRAY B ##########
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B1)
            uartfunction.write(mqttOutMsg.Mode_Status()..B1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B2)
            uartfunction.write(mqttOutMsg.Mode_Status()..B2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B3)
            uartfunction.write(mqttOutMsg.Mode_Status()..B3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B4)
            uartfunction.write(mqttOutMsg.Mode_Status()..B4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B5)
            uartfunction.write(mqttOutMsg.Mode_Status()..B5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B6)
            uartfunction.write(mqttOutMsg.Mode_Status()..B6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B7)
            uartfunction.write(mqttOutMsg.Mode_Status()..B7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B8)
            uartfunction.write(mqttOutMsg.Mode_Status()..B8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B9)
            uartfunction.write(mqttOutMsg.Mode_Status()..B9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B10)
            uartfunction.write(mqttOutMsg.Mode_Status()..B10)
            test_timer()
        
            -- ######### TRAY C ##########
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C1)
            uartfunction.write(mqttOutMsg.Mode_Status()..C1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C2)
            uartfunction.write(mqttOutMsg.Mode_Status()..C2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C3)
            uartfunction.write(mqttOutMsg.Mode_Status()..C3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C4)
            uartfunction.write(mqttOutMsg.Mode_Status()..C4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C5)
            uartfunction.write(mqttOutMsg.Mode_Status()..C5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C6)
            uartfunction.write(mqttOutMsg.Mode_Status()..C6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C7)
            uartfunction.write(mqttOutMsg.Mode_Status()..C7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C8)
            uartfunction.write(mqttOutMsg.Mode_Status()..C8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C9)
            uartfunction.write(mqttOutMsg.Mode_Status()..C9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C10)
            uartfunction.write(mqttOutMsg.Mode_Status()..C10)
            test_timer()
        
            -- ########## TRAY D #############
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D1)
            uartfunction.write(mqttOutMsg.Mode_Status()..D1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D2)
            uartfunction.write(mqttOutMsg.Mode_Status()..D2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D3)
            uartfunction.write(mqttOutMsg.Mode_Status()..D3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D4)
            uartfunction.write(mqttOutMsg.Mode_Status()..D4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D5)
            uartfunction.write(mqttOutMsg.Mode_Status()..D5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D6)
            uartfunction.write(mqttOutMsg.Mode_Status()..D6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D7)
            uartfunction.write(mqttOutMsg.Mode_Status()..D7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D8)
            uartfunction.write(mqttOutMsg.Mode_Status()..D8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D9)
            uartfunction.write(mqttOutMsg.Mode_Status()..D9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D10)
            uartfunction.write(mqttOutMsg.Mode_Status()..D10)
            test_timer()
        
            -- ######### TRAY E ###########
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..E1)
            uartfunction.write(mqttOutMsg.Mode_Status()..E1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..E2)
            uartfunction.write(mqttOutMsg.Mode_Status()..E2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..E3)
            uartfunction.write(mqttOutMsg.Mode_Status()..E3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..E4)
            uartfunction.write(mqttOutMsg.Mode_Status()..E4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..E5)
            uartfunction.write(mqttOutMsg.Mode_Status()..E5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..E6)
            uartfunction.write(mqttOutMsg.Mode_Status()..E6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..E7)
            uartfunction.write(mqttOutMsg.Mode_Status()..E7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..E8)
            uartfunction.write(mqttOutMsg.Mode_Status()..E8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..E9)
            uartfunction.write(mqttOutMsg.Mode_Status()..E9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..E10)
            uartfunction.write(mqttOutMsg.Mode_Status()..E10)
            test_timer()
        
            -- ########### TRAY F ##########
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F1)
            uartfunction.write(mqttOutMsg.Mode_Status()..F1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F2)
            uartfunction.write(mqttOutMsg.Mode_Status()..F2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F3)
            uartfunction.write(mqttOutMsg.Mode_Status()..F3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F4)
            uartfunction.write(mqttOutMsg.Mode_Status()..F4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F5)
            uartfunction.write(mqttOutMsg.Mode_Status()..F5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F6)
            uartfunction.write(mqttOutMsg.Mode_Status()..F6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F7)
            uartfunction.write(mqttOutMsg.Mode_Status()..F7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F8)
            uartfunction.write(mqttOutMsg.Mode_Status()..F8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F9)
            uartfunction.write(mqttOutMsg.Mode_Status()..F9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F10)
            uartfunction.write(mqttOutMsg.Mode_Status()..F10)

            print("Complete Running All Motor")
            print("--------------------------------------")

        --[[ ########## INSTRUCTION FOR RUN BASED ON TRAY ONLY ########## ]]
        -- ######### RUN ONLY TRAY A ##########
        elseif string.match(InputData , "RWA") then
            MQTTData = " "
            first_indicator()
            print("**********--- RUNNING ALL MOTOR TRAY A ---**********")

            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A1)
            uartfunction.write(mqttOutMsg.Mode_Status()..A1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A2)
            uartfunction.write(mqttOutMsg.Mode_Status()..A2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A3)
            uartfunction.write(mqttOutMsg.Mode_Status()..A3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A4)
            uartfunction.write(mqttOutMsg.Mode_Status()..A4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A5)
            uartfunction.write(mqttOutMsg.Mode_Status()..A5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A6)
            uartfunction.write(mqttOutMsg.Mode_Status()..A6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A7)
            uartfunction.write(mqttOutMsg.Mode_Status()..A7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A8)
            uartfunction.write(mqttOutMsg.Mode_Status()..A8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A9)
            uartfunction.write(mqttOutMsg.Mode_Status()..A9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..A10)
            uartfunction.write(mqttOutMsg.Mode_Status()..A10)
            print("--------------------------------------")

        -- ######## RUN ONLY TRAY B ##########
        elseif string.match(InputData , "RWB") then
            MQTTData = " "
            first_indicator()
            print("**********--- RUNNING ALL MOTOR TRAY B ---**********")

            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B1)
            uartfunction.write(mqttOutMsg.Mode_Status()..B1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B2)
            uartfunction.write(mqttOutMsg.Mode_Status()..B2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B3)
            uartfunction.write(mqttOutMsg.Mode_Status()..B3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B4)
            uartfunction.write(mqttOutMsg.Mode_Status()..B4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B5)
            uartfunction.write(mqttOutMsg.Mode_Status()..B5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B6)
            uartfunction.write(mqttOutMsg.Mode_Status()..B6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B7)
            uartfunction.write(mqttOutMsg.Mode_Status()..B7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B8)
            uartfunction.write(mqttOutMsg.Mode_Status()..B8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B9)
            uartfunction.write(mqttOutMsg.Mode_Status()..B9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..B10)
            uartfunction.write(mqttOutMsg.Mode_Status()..B10)
            print("--------------------------------------")

        -- ######### RUN ONLY TRAY C ##########
        elseif string.match(InputData , "RWC") then
            MQTTData = " "
            first_indicator()
            print("**********--- RUNNING ALL MOTOR TRAY C ---**********")

            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C1)
            uartfunction.write(mqttOutMsg.Mode_Status()..C1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C2)
            uartfunction.write(mqttOutMsg.Mode_Status()..C2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C3)
            uartfunction.write(mqttOutMsg.Mode_Status()..C3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C4)
            uartfunction.write(mqttOutMsg.Mode_Status()..C4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C5)
            uartfunction.write(mqttOutMsg.Mode_Status()..C5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C6)
            uartfunction.write(mqttOutMsg.Mode_Status()..C6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C7)
            uartfunction.write(mqttOutMsg.Mode_Status()..C7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C8)
            uartfunction.write(mqttOutMsg.Mode_Status()..C8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C9)
            uartfunction.write(mqttOutMsg.Mode_Status()..C9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..C10)
            uartfunction.write(mqttOutMsg.Mode_Status()..C10)
            print("--------------------------------------")

        -- ########## RUN ONLY TRAY D #############
        elseif string.match(InputData , "RWD") then
            MQTTData = " "
            first_indicator()
            print("**********--- RUNNING ALL MOTOR TRAY D ---**********")

            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D1)
            uartfunction.write(mqttOutMsg.Mode_Status()..D1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D2)
            uartfunction.write(mqttOutMsg.Mode_Status()..D2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D3)
            uartfunction.write(mqttOutMsg.Mode_Status()..D3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D4)
            uartfunction.write(mqttOutMsg.Mode_Status()..D4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D5)
            uartfunction.write(mqttOutMsg.Mode_Status()..D5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D6)
            uartfunction.write(mqttOutMsg.Mode_Status()..D6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D7)
            uartfunction.write(mqttOutMsg.Mode_Status()..D7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D8)
            uartfunction.write(mqttOutMsg.Mode_Status()..D8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D9)
            uartfunction.write(mqttOutMsg.Mode_Status()..D9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..D10)
            uartfunction.write(mqttOutMsg.Mode_Status()..D10)
            print("--------------------------------------")

        -- ########### RUN ONLY TRAY F ##########
        elseif string.match(InputData , "RWF") then
            MQTTData = " "
            first_indicator()
            print("**********--- RUNNING ALL MOTOR TRAY F ---**********")

            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F1)
            uartfunction.write(mqttOutMsg.Mode_Status()..F1)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F2)
            uartfunction.write(mqttOutMsg.Mode_Status()..F2)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F3)
            uartfunction.write(mqttOutMsg.Mode_Status()..F3)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F4)
            uartfunction.write(mqttOutMsg.Mode_Status()..F4)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F5)
            uartfunction.write(mqttOutMsg.Mode_Status()..F5)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F6)
            uartfunction.write(mqttOutMsg.Mode_Status()..F6)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F7)
            uartfunction.write(mqttOutMsg.Mode_Status()..F7)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F8)
            uartfunction.write(mqttOutMsg.Mode_Status()..F8)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F9)
            uartfunction.write(mqttOutMsg.Mode_Status()..F9)
            test_timer()
            -- uart.write(uartID, mqttOutMsg.Mode_Status()..F10)
            uartfunction.write(mqttOutMsg.Mode_Status()..F10)
            print("--------------------------------------")

        else
            MQTTData = " "
            -- print("Invalid Command Format")
            sys.wait(5)
        end
    end
end

sys.taskInit(Run_All)