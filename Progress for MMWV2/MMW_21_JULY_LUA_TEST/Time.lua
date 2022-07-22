module(...,package.seeall)

require"ntp"
require"misc"

function Time(EpochTime)
    misc.setClock(os.date("*t", EpochTime))
end

function CurrentTime()
    local time = misc.getClock()
    local SCTime = os.time{year = time.year, month=time.month, day = time.day, hour = time.hour, min = time.min, sec = time.sec}
    return SCTime
end

local function printTime()
    local tm = misc.getClock()
    log.info("testNtp.printTime", string.format("%04d/%02d/%02d,%02d:%02d:%02d", tm.year, tm.month, tm.day, tm.hour, tm.min, tm.sec))
    
end

sys.timerLoopStart(printTime,1000)