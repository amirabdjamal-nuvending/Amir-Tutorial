import serial
import multiprocessing
import os


class ScannerV2(multiprocessing.Process):
    serial_port = None
    response = None

    def __init__(self, port: str):
        try:
            multiprocessing.Process.__init__(self)

            self.serial_port = serial.Serial(port=port, baudrate=9600)

            print("Initialized qr code scanner")
        except Exception as e:
            print(e)
            os.system("sudo systemctl restart xy_serial.service")

    def run(self):
        try:
            while True:
                i = 0
        except KeyboardInterrupt:
            print("Scanner process keyboard interrupted")
            self.close()
            pass
        except Exception as e:
            print("[ERROR] ScannerProcessError: Unknown error")
            print(e)
            self.close()
            # os.system("sudo pm2 restart nubox-python-server")
            os.system("sudo systemctl restart xy_serial.service")
            pass

    def scan_qr_code(self):
        if not self.serial_port.isOpen():
            print("QR Code scanner serial port closed")
            self.serial_port.open()
            print("QR Code scanner opened. Ready to scan")

        qr_code_response = self.serial_port.read(24).decode('utf-8')
        print("Scanned result: " + qr_code_response)
        self.serial_port.close()
        print("QR Code scanner closed.")
        return qr_code_response

    def close_port(self):
        if self.serial_port.isOpen():
            print("QR Code scanner opened, closing...")
            self.serial_port.close()
            print("QR Code scanner closed.")

    @staticmethod
    def get_qr_code(qr_code_response):
        if len(qr_code_response) > 0:
            print(qr_code_response)
            return qr_code_response[-1].decode('utf-8')
        else:
            return ""
