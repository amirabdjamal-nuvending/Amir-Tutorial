import multiprocessing

import RPi.GPIO as GPIO
import time


class LifterDropSensor:
    firstPinIN = 22
    firstPinOUT = 17

    secPinIN = 27
    secPinOUT = 26

    pinIN = 0
    pinOUT = 0

    # Init
    @classmethod
    def initLifterDropSensor(cls, which_machine: int):

        GPIO.setmode(GPIO.BCM)
        GPIO.setwarnings(False)
        if which_machine == 1:
            cls.pinOUT = cls.firstPinOUT
            cls.pinIN = cls.firstPinIN
            print("main lifter drop sensor")
        elif which_machine == 2:
            cls.pinOUT = cls.secPinOUT
            cls.pinIN = cls.secPinIN
            print("sub lifter drop sensor")
        GPIO.setup(cls.pinOUT, GPIO.OUT)
        GPIO.setup(cls.pinIN, GPIO.IN)
        cls.ir_send_data(0x34, which_machine=which_machine)

        print("Initialized lifter drop sensor")

    @classmethod
    def ir_send_data(cls, x, which_machine: int):
        # print(x)
        if which_machine == 1:
            cls.pinOUT = cls.firstPinOUT
            cls.pinIN = cls.firstPinIN
        elif which_machine == 2:
            cls.pinOUT = cls.secPinOUT
            cls.pinIN = cls.secPinIN
        i = 0
        GPIO.output(cls.pinOUT, GPIO.LOW)
        time.sleep(0.05)
        for i in range(8):
            GPIO.output(cls.pinOUT, GPIO.HIGH)
            if x & 0x01:
                # print("x",x&0x01)
                time.sleep(0.0003)
                GPIO.output(cls.pinOUT, GPIO.LOW)
                time.sleep(0.0001)
            else:
                time.sleep(0.0001)
                GPIO.output(cls.pinOUT, GPIO.LOW)
                time.sleep(0.0003)
            x >>= 1
            # print(x)

    # def IR_31(cls):
    #     cls.ir_send_data(0x31)
    #     GPIO.output(LifterDropSensor.pinOUT, GPIO.HIGH)
    #     time.sleep(0.005)

    # disable drop sensor
    @classmethod
    def disable_ir_sensor(cls, which_machine: int):
        if which_machine == 1:
            cls.pinOUT = cls.firstPinOUT
            cls.pinIN = cls.firstPinIN
        elif which_machine == 2:
            cls.pinOUT = cls.secPinOUT
            cls.pinIN = cls.secPinIN
        cls.ir_send_data(0x33, which_machine=which_machine)
        GPIO.output(cls.pinOUT, GPIO.HIGH)

    # check drop flag
    @classmethod
    def read_ir_value(cls, which_machine: int):
        i = 0
        if which_machine == 1:
            cls.pinOUT = cls.firstPinOUT
            cls.pinIN = cls.firstPinIN
        elif which_machine == 2:
            cls.pinOUT = cls.secPinOUT
            cls.pinIN = cls.secPinIN
        # print(cls.firstPinOUT)
        # print(cls.firstPinIN)
        print("enable lifter drop sensor")
        cls.ir_send_data(0x32, which_machine=which_machine)
        GPIO.output(cls.pinOUT, GPIO.HIGH)
        time.sleep(0.005)
        print("reading value......")
        try:
            while i < 1000:
                if not GPIO.input(cls.pinIN):
                    print("get")
                    cls.disable_ir_sensor(which_machine)
                    return 1
                i = i + 1
                time.sleep(0.001)
            cls.disable_ir_sensor(which_machine)
            print("failed")
            return 0

        except KeyboardInterrupt:
            cls.disable_ir_sensor(which_machine)
            print("stop")
            pass
        except Exception as e:
            print("[ERROR] LifterDropSensorProcessError: Unknown error")
            pass

    # //s  (2-15)   2最高   15最低 ir_send_data(s);

    # 频率调整
    # ? ir_send_data(0x37);
