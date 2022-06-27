import serial
import time


class BillAcceptor:

    def __init__(self, ser):
        self.ser = ser

    def setup(self):
        print("Setting up the Bill Validator")
        self.ser.write(serial.to_bytes([0x31]))

    def enable(self):
        print("Enabling the Bill Validator")

        enable_code = serial.to_bytes([0x34, 0x00, 0x1F, 0x00, 0x00])
        self.ser.write(enable_code)

        time.sleep(1)

        mdb_response = self.ser.readline()
        mdb_response = mdb_response.decode('utf-8')

        mdb_response_1H = str(mdb_response[0:2])
        mdb_response_2H = str(mdb_response[3:5])

        while mdb_response_1H != '00':
            while (mdb_response_1H == '30') & (mdb_response_2H == '09'):
                self.ser.write(enable_code)

                mdb_response = self.ser.readline()
                mdb_response = mdb_response.decode('utf-8')

                mdb_response_1H = str(mdb_response[0:2])
                mdb_response_2H = str(mdb_response[3:5])

            self.ser.write(enable_code)

            mdb_response = self.ser.readline()
            mdb_response = mdb_response.decode('utf-8')

            mdb_response_1H = str(mdb_response[0:2])

        print("Bill Validator enabled!")

    def reset(self):
        print("Resetting the Bill Validator")
        self.ser.write(serial.to_bytes([0x30]))

    def disable(self):
        print("Disabling the Bill Validator")
        self.ser.write(serial.to_bytes([0x34, 0x00, 0x00, 0x00, 0x00]))

    def get_serial(self):
        return self.ser

    @staticmethod
    def check_bill_collector_status(mdb_response):
        if mdb_response == '01':
            # Defective motor
            message = 'Bill Defective motor!'
        elif mdb_response == '02':
            # Sensor problem
            message = 'Bill Sensor problem!'
        elif mdb_response == '03':
            # Validator busy
            message = 'Bill Validator busy!'
        elif mdb_response == '04':
            # ROM Checksum Error
            message = 'Bill ROM Checksum Error!'
        elif mdb_response == '05':
            # Validator jam
            message = 'Bill Validator jam!'
        elif mdb_response == '06':
            # Validator reset
            message = 'Bill Validator reset!'
        elif mdb_response == '07':
            # Bill removed
            message = 'Bill removed!'
        elif mdb_response == '08':
            # Cash box out of position
            message = 'Bill Cash box out of position!'
        elif mdb_response == '09':
            # Unit disabled
            message = 'Bill Unit disabled!'
        elif mdb_response == '0A':
            # Invalid escrow request
            message = 'Bill Invalid escrow request!'
        elif mdb_response == '0B':
            # Bill rejected
            message = 'Bill rejected!'
        elif mdb_response == '14':
            # Bill rejected
            message = 'Bill not enabled/recognized!'
        else:
            message = 'no error'
        return message
