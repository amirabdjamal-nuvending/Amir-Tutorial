--- 模块功能：休眠功能测试.
-- @author openLuat
-- @module pm.testPm
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.27

module(...,package.seeall)

require"pm"

--[[
Notes on this part of Hibernation:
There are two ways to dormant treatment today,
One is that the underlying core is internal, automatically processed, such as when tcp sends or receives data, wakes up automatically, and automatically hibernates after sending and receiving;
另一种是lua脚本使用pm.sleep和pm.wake自行控制，例如，uart连接外围设备，uart接收数据前，要主动去pm.wake，这样才能保证前面接收的数据不出错，当不需要通信时，调用pm.sleep；如果有lcd的项目，也是同样道理
不休眠时功耗至少30mA左右
休眠后，飞行模式不到1mA，非飞行模式的功耗还没有数据（后续补充）
如果不是故意控制的不休眠，一定要保证pm.wake("A")了，有地方去调用pm.sleep("A")
]]


pm.wake("A") --After executing this sentence, A wakes up the module
pm.wake("A") --After executing this sentence, A repeats the wake-up module, which is virtually unchanged
pm.sleep("A") --After executing this sentence, A sleeps the module, the lua part no longer has the function to wake the module, whether the module sleeps or not is determined by core

pm.wake("B") --执行本句后，B唤醒了模块
pm.wake("C") --执行本句后，C唤醒了模块
pm.sleep("B") --执行本句后，B休眠了模块，但是lua部分还有C已经唤醒了模块，模块并不会休眠
pm.sleep("C") --执行本句后，C休眠了模块，lua部分已经没有功能唤醒模块了，模块是否休眠由core决定


