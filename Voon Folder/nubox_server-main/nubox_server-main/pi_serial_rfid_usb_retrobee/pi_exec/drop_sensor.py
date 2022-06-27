import RPi.GPIO as GPIO
import multiprocessing
import time


class DropSensor(multiprocessing.Process):

    DROP_SENSOR_GPIO = 22
    SECOND_DROP_SENSOR_GPIO = 27

    def __init__(self, which_machine):
        multiprocessing.Process.__init__(self)

        GPIO.setmode(GPIO.BCM)
        GPIO.setwarnings(False)
        if which_machine == 1:
            GPIO.setup(DropSensor.DROP_SENSOR_GPIO, GPIO.IN, pull_up_down=GPIO.PUD_UP)
        elif which_machine == 2:
            GPIO.setup(DropSensor.SECOND_DROP_SENSOR_GPIO, GPIO.IN)

        self.manager = multiprocessing.Manager()
        # self.drop_sensor_value = self.manager.Value('i', 0)
        self.need_to_read_drop_sensor = self.manager.Value('i', 0)
        self.drop_sensor_flag = self.manager.Value('i', 0)

        print("Initialized drop sensor")

    def run(self):
        try:
            while True:
                try:
                    self.update_drop_sensor(1)
                except:
                    pass
                try:
                    self.update_drop_sensor(2)
                except:
                    pass
        except KeyboardInterrupt:
            print("Drop sensor process keyboard interrupted")
            pass
        except Exception as e:
            print("[ERROR] DropSensorProcessError: Unknown error")
            pass

    def set_need_to_read_drop_sensor(self, is_needed: int):
        self.need_to_read_drop_sensor.value = is_needed

    def get_need_to_read_drop_sensor(self) -> int:
        return self.need_to_read_drop_sensor.value

    def set_drop_sensor_flag(self, flag_value: int):
        self.drop_sensor_flag = flag_value

    def get_drop_sensor_flag(self) -> int:
        return self.drop_sensor_flag.value

    def reset_drop_sensor_flag(self):
        self.need_to_read_drop_sensor.value = 1
        self.drop_sensor_flag.value = 0
        print("Reset drop sensor flag")

    @staticmethod
    def read_drop_sensor_value(which_machine):
        if which_machine == 1:
            return GPIO.input(DropSensor.DROP_SENSOR_GPIO)
        elif which_machine == 2:
            return GPIO.input(DropSensor.SECOND_DROP_SENSOR_GPIO)

    def update_drop_sensor(self, which_machine):
        if self.need_to_read_drop_sensor.value == 1:
            if which_machine == 1:
                if GPIO.input(DropSensor.DROP_SENSOR_GPIO) == 0:
                    self.drop_sensor_flag.value = 1
                    time.sleep(0.1)
            elif which_machine == 2:
                if GPIO.input(DropSensor.SECOND_DROP_SENSOR_GPIO) == 0:
                    self.drop_sensor_flag.value = 1
                    time.sleep(0.1)
