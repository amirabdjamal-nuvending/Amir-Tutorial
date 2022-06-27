import serial
import time
import multiprocessing
from mdb.bill_acceptor import BillAcceptor
from mdb.coin_collector import CoinCollector
from mdb.mdb_parameter import MdbParameter
from http_service import HttpService


class MdbService(multiprocessing.Process):

    def __init__(self, port: str, baudrate: int):
        multiprocessing.Process.__init__(self)

        try:
            self.ser = serial.Serial(port, baudrate)
            self.ser.flushInput()
            self.ser.flushOutput()
            self.bill_acceptor = None
            self.coin_collector = None
            self.is_mdb_initialized = True

            time.sleep(0.8)
            self.initialization()
            print("Initialized MDB Service")
        except Exception as e:
            print("[ERROR] MdbServiceError: Unknown Error")
            print(e)
            self.is_mdb_initialized = False
            pass

    def run(self):
        try:
            while True:
                mdb_raw_data = self.scan_money()
                self.process_mdb_data(mdb_raw_data)
        except KeyboardInterrupt:
            print("MDN service process keyboard interrupted")
            pass
        except Exception as e:
            print("[ERROR] MDBServiveProcessError: Unknown error")
            pass

    def initialization(self):
        # Set up bill validator
        self.bill_acceptor = BillAcceptor(self.ser)
        time.sleep(0.8)
        self.bill_acceptor.reset()
        time.sleep(0.8)
        self.bill_acceptor.setup()
        time.sleep(0.8)
        self.bill_acceptor.enable()

        # Set up coin acceptor
        self.coin_collector = CoinCollector(self.ser)
        time.sleep(0.8)
        self.coin_collector.reset()
        time.sleep(0.8)
        self.coin_collector.setup()
        time.sleep(0.8)
        self.coin_collector.enable()

    def scan_money(self):
        if not self.coin_collector.get_refunding_status():
            mdb_raw_data = self.ser.readline().decode('utf-8')
            return mdb_raw_data
        else:
            time.sleep(2)
            return "refunding"

    def get_is_mdb_initialized(self):
        return self.is_mdb_initialized

    def process_mdb_data(self, mdb_raw_data):
        if mdb_raw_data == "refunding":
            print("Refunding in progress...")
        else:
            serial_data = str(mdb_raw_data).split()[0]
            if serial_data == "FF":
                # Got error ?
                print("Got FF")
            else:
                mdb_device_code = str(mdb_raw_data[0:2])
                mdb_amount_code = str(mdb_raw_data[3:5])

                if mdb_device_code == MdbParameter.BILL_DEVICE_CODE:
                    # Check bill collector status
                    status = BillAcceptor.check_bill_collector_status(
                        mdb_amount_code)
                    if status == "no error":
                        for code in MdbParameter.BILL_VALUE_ALL:
                            if code.get('Code') == mdb_amount_code:
                                print(f"{str(code.get('Value'))}")
                                # Todo: Add API
                                status = HttpService.update_credit(
                                    code.get('Value'))
                                if status == 'OK':
                                    print("Credit updated in database")
                                else:
                                    print("Fail to update credit in database")
                    else:
                        print(status)
                elif str(mdb_device_code) == MdbParameter.COIN_DEVICE_CODE:
                    # Check coin collector status
                    status = CoinCollector.check_coin_collector_status(
                        mdb_amount_code)
                    if status == "no error":
                        if mdb_amount_code == '01':
                            print("Refund Level Pressed")
                            # Todo: Add API
                            # Todo: Get balance from Pi SQL
                            # self.coin_collector.refund(0.1)
                        else:
                            for code in MdbParameter.COIN_VALUE_ALL:
                                if code.get('Code') == mdb_amount_code:
                                    print(f"{str(code.get('Value'))}")
                                    # Todo: Add API
                                    status = HttpService.update_credit(
                                        code.get('Value'))
                                    if status == 'OK':
                                        print("Credit updated in database")
                                    else:
                                        print(
                                            "Fail to update credit in database")
                    else:
                        print(status)
