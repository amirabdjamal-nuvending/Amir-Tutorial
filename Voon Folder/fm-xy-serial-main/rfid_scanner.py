from evdev import InputDevice, categorize, ecodes
import multiprocessing
from select import select
import ctypes


class RFIDScanner(multiprocessing.Process):
    keys = {
        # Scancode: ASCIICode
        0: None, 1: u'ESC', 2: u'1', 3: u'2', 4: u'3', 5: u'4', 6: u'5', 7: u'6', 8: u'7', 9: u'8',
        10: u'9', 11: u'0', 12: u'-', 13: u'=', 14: u'BKSP', 15: u'TAB', 16: u'q', 17: u'w', 18: u'e', 19: u'r',
        20: u't', 21: u'y', 22: u'u', 23: u'i', 24: u'o', 25: u'p', 26: u'[', 27: u']', 28: u'CRLF', 29: u'LCTRL',
        30: u'a', 31: u's', 32: u'd', 33: u'f', 34: u'g', 35: u'h', 36: u'j', 37: u'k', 38: u'l', 39: u';',
        40: u'\'', 41: u'`', 42: u'LSHFT', 43: u'\\', 44: u'z', 45: u'x', 46: u'c', 47: u'v', 48: u'b', 49: u'n',
        50: u'm', 51: u',', 52: u'.', 53: u'/', 54: u'RSHFT', 56: u'LALT', 57: u' ', 100: u'RALT', 500: None,
        501: u'ESC',
        502: u'!', 503: u'@', 504: u'#', 505: u'$', 506: u'%', 507: u'^', 508: u'&', 509: u'*',
        510: u'(', 511: u')', 512: u'_', 513: u'+', 514: u'BKSP', 515: u'TAB', 516: u'Q', 517: u'W', 518: u'E',
        519: u'R',
        520: u'T', 521: u'Y', 522: u'U', 523: u'I', 524: u'O', 525: u'P', 526: u'{', 527: u'}', 528: u'CRLF',
        529: u'LCTRL',
        530: u'A', 531: u'S', 532: u'D', 533: u'F', 534: u'G', 535: u'H', 536: u'J', 537: u'K', 538: u'L', 539: u':',
        540: u'\"', 541: u'~', 542: u'LSHFT', 543: u'\\', 544: u'Z', 545: u'X', 546: u'C', 547: u'V', 548: u'B',
        549: u'N',
        550: u'M', 551: u'<', 552: u'>', 553: u'?', 554: u'RSHFT', 556: u'LALT'
    }

    device = None
    read = None
    write = None
    exception = None

    trigger = 1  # Start with 1 because want to use remainder of 2

    def __init__(self,port: str):
        multiprocessing.Process.__init__(self)
        self.device = InputDevice(port)
        self.manager = multiprocessing.Manager()
        self.rfid_response = ""
        self.actual_response = self.manager.Value(ctypes.c_char_p, "")
        self.should_run = self.manager.Value('i', 0)

        print("Initialized rfid scanner")

    def run(self):
        try:
            while True:
                self.scan_rfid_code()
        except KeyboardInterrupt:
            print("RFID Scanner process keyboard interrupted")
            self.close()
        except Exception as e:
            print("[ERROR] RFIDScannerProcessError: Unknown error")
            print(e)
            self.close()
            pass

    def scan_rfid_code(self):
        self.rfid_response = ""

        self.read, self.write, self.exception = select([self.device], [], [])

        lshift = False

        if self.read:
            for event in self.device.read_loop():
                if event.code == 28:
                    break
                if event.type == ecodes.EV_KEY:
                    if event.value == 1:
                        if event.code == 42:
                            lshift = True
                        else:
                            if lshift:
                                lshift = False
                                self.rfid_response = self.rfid_response + self.keys[event.code + 500]
                            else:
                                self.rfid_response = self.rfid_response + self.keys[event.code]
        self.trigger = self.trigger + 1
        if self.trigger % 2 == 0:
            self.actual_response.value = self.get_rfid_code()
        if self.actual_response.value != "":
            self.set_should_run(0)

    def get_rfid_code(self):
        if len(self.rfid_response) > 0:
            return self.rfid_response
        else:
            return ""

    def get_actual_response(self):
        return self.actual_response.value

    def set_should_run(self, should_run: int):
        if 0 <= should_run < 2:
            self.should_run.value = should_run

    def get_should_run(self):
        return self.should_run.value
