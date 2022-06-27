import serial
import multiprocessing


class SerialCom(multiprocessing.Process):
    serial_device = None

    def __init__(self):
        multiprocessing.Process.__init__(self)

        self.serial_device = serial.Serial(port='/dev/serial1', baudrate=9600, parity=serial.PARITY_NONE,
                                           stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS)
        self.serial_device.flush()

    def run(self):
        try:
            while True:
                i = 0
        except KeyboardInterrupt:
            print("Serial Com process keyboard interrupted")
            self.close()
            pass
        except Exception as e:
            print("[ERROR] SerialProcessError: Unknown error")
            print(e)
            self.close()
            pass

    def write_serial(self, message: str):

        try:
            self.serial_device.write(str.encode(message))
        except Exception as e:
            print("[ERROR] SerialProcessError: Error while writing message")
            print(e)

    def read_serial(self):
        try:
            return self.serial_device.readline().decode('utf-8', errors='ignore')
        except Exception as e:
            print("[ERROR] SerialProcessError: Error while reading message")
            print(e)
            return "error"
