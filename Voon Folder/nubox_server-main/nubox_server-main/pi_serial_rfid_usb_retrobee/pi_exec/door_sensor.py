import RPi.GPIO as GPIO
import multiprocessing
from constant import Constant


class DoorSensor(multiprocessing.Process):

    def __init__(self):
        multiprocessing.Process.__init__(self)

        GPIO.setmode(GPIO.BCM)
        GPIO.setwarnings(False)

        GPIO.setup(Constant.DOOR_SENSOR_GPIO,
                   GPIO.IN, pull_up_down=GPIO.PUD_UP)

        print("Initialized door sensor")

    @staticmethod
    def read_door_sensor_value():
        # True = button pressed
        return GPIO.input(Constant.DOOR_SENSOR_GPIO) == 1

    def run(self):
        try:
            while True:
                self.read_door_sensor_value()
        except KeyboardInterrupt:
            print("Door sensor process keyboard interrupted")
            pass
        except Exception as e:
            print("[ERROR] DoorSensorProcessError: Unknown error")
            pass
