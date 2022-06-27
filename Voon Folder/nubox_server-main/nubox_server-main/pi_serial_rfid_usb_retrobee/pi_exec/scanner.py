import serial
import multiprocessing
import ctypes


class Scanner(multiprocessing.Process):
    serial_port = None
    response = None
    # should_run = False

    def __init__(self,port: str):
        multiprocessing.Process.__init__(self)

        self.serial_port = serial.Serial(port, 9600, timeout=0.5)
        self.manager = multiprocessing.Manager()
        self.qr_code_response = []
        self.actual_response = self.manager.Value(ctypes.c_char_p, "")
        self.should_run = self.manager.Value('i', 0)

        print("Initialized qr code scanner")

    def run(self):
        try:
            while True:
                self.scan_qr_code()
        except KeyboardInterrupt:
            print("Scanner process keyboard interrupted")
            self.close()
            pass
        except Exception as e:
            print("[ERROR] ScannerProcessError: Unknown error")
            print(e)
            self.close()
            pass

    def scan_qr_code(self):
        self.qr_code_response = []
        self.qr_code_response = self.serial_port.readlines(None)
        self.actual_response.value = self.get_qr_code()
        if self.actual_response.value != "":
            self.set_should_run(0)

    def get_actual_response(self):
        return self.actual_response.value

    def get_qr_code(self):
        if len(self.qr_code_response) > 0:
            print(self.qr_code_response)
            return self.qr_code_response[-1].decode('utf-8')
        else:
            return ""

    def set_should_run(self, should_run: int):
        if 0 <= should_run < 2:
            self.should_run.value = should_run

    def get_should_run(self):
        return self.should_run.value
