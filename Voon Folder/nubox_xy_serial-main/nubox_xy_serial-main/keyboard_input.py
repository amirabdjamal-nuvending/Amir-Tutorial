import multiprocessing
import ctypes
import os


class KeyboardInput(multiprocessing.Process):

    def __init__(self):
        multiprocessing.Process.__init__(self)
        self.manager = multiprocessing.Manager()
        self.value = self.manager.Value(ctypes.c_char_p, "")

    def run(self) -> None:
        try:
            while True:
                i = 0
        except KeyboardInterrupt:
            print("KeyboardInput process keyboard interrupted")
            self.close()
            pass
        except Exception as e:
            print("[ERROR] KeyboardInputProcessError: Unknown error")
            print(e)
            self.close()
            # os.system("sudo pm2 restart nubox-python-server")
            os.system("sudo systemctl restart xy_serial.service")
            pass

    def set_value(self, message: str):
        self.value.value = message

    def get_value(self):
        return self.value.value
