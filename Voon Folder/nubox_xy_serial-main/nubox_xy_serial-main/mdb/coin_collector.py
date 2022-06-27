import serial
import time


class CoinCollector:

    def __init__(self, ser):
        self.is_refunding = False
        self.ser = ser

    def get_refunding_status(self):
        return self.is_refunding

    def set_refunding_status(self, refunding_status: bool):
        self.is_refunding = refunding_status

    def setup(self):
        print("Setting up the Coin Collector")
        self.ser.write(serial.to_bytes([0x09]))

    def enable(self):
        print("Enabling the Coin Collector")
        enable_code = serial.to_bytes([0x0C, 0xFF, 0xFF, 0xFF, 0xFF])

        self.ser.write(enable_code)

        time.sleep(1)

        mdb_response = self.ser.readline()

        mdb_response = mdb_response.decode('utf-8')
        mdb_response_1H = str(mdb_response[0:2])

        while mdb_response_1H != '00':
            self.ser.write(enable_code)

            mdb_response = self.ser.readline()
            mdb_response = mdb_response.decode('utf-8')

            mdb_response_1H = str(mdb_response[0:2])

        print("Coin Acceptor enabled!")

    def disable(self):
        print("Disabling the Coin Collector")
        self.ser.write(serial.to_bytes([0x0C, 0x00, 0x00, 0x00, 0x00]))

    def reset(self):
        print("Resetting the Coin Collector")
        self.ser.write(serial.to_bytes([0x08]))

    def dispense_nickel(self):
        print('Dispensing Nickel\n')
        self.ser.write(serial.to_bytes([0x0F, 0x02, 0x01]))

    def dispense_dime(self):
        print('Dispensing Dime\n')
        self.ser.write(serial.to_bytes([0x0F, 0x02, 0x02]))

    def dispense_quarter(self):
        print('Dispensing Quarter\n')
        self.ser.write(serial.to_bytes([0x0F, 0x02, 0x05]))

    def get_tube_status_response_code(self):
        tube_status_code = serial.to_bytes([0x0A])
        print('Getting the tube status of the Coin Collector')

        self.ser.write(tube_status_code)

        time.sleep(1)

        mdb_response = self.ser.readline()
        mdb_response = mdb_response.decode('utf-8')

        while len(mdb_response) < 55:
            self.ser.write(tube_status_code)

            mdb_response = self.ser.readline()
            mdb_response = mdb_response.decode('utf-8')

            if len(mdb_response) >= 55:
                break

        print("Tube Status Received!")

        return mdb_response

    @staticmethod
    def get_tube_status_10(tube_response):
        print('Getting number of 10 cents')

        # 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
        response_conv10_old = str(tube_response[6:8])
        num_dec10_old = int(response_conv10_old, 16)

        # 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
        response_conv10_new = str(tube_response[9:11])
        num_dec10_new = int(response_conv10_new, 16)

        num_dec10 = num_dec10_old + num_dec10_new

        return num_dec10

    @staticmethod
    def get_tube_status_20(tube_response):
        print('Getting number of 20 cents')

        # 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 01
        response_conv20_old = str(tube_response[12:14])
        num_dec20_old = int(response_conv20_old, 16)

        # 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 01
        response_conv20_new = str(tube_response[15:17])
        num_dec20_new = int(response_conv20_new, 16)

        num_dec20 = num_dec20_old + num_dec20_new

        return num_dec20

    @staticmethod
    def get_tube_status_50(tube_response):
        print('Getting number of 50 cents')

        # 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 01
        response_conv50_old = str(tube_response[18:20])
        num_dec50_old = int(response_conv50_old, 16)

        # 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 01
        response_conv50_new = str(tube_response[21:23])
        num_dec50_new = int(response_conv50_new, 16)

        num_dec50 = num_dec50_old + num_dec50_new

        return num_dec50

    @staticmethod
    def get_tube_status_all(tube_response):
        response_conv_all = str(tube_response[54:56])

        num_decAll = int(response_conv_all, 16)

        return num_decAll

    def refund(self, balance):
        self.set_refunding_status(refunding_status=True)

        m_balance = abs(balance)
        m_balance = round(m_balance, 2)

        temp_balance = m_balance

        tube_response = self.get_tube_status_response_code()

        number_of_10_remaining = self.get_tube_status_10(
            tube_response=tube_response)
        number_of_20_remaining = self.get_tube_status_20(
            tube_response=tube_response)
        number_of_50_remaining = self.get_tube_status_50(
            tube_response=tube_response)

        available_balance = 0.10 * number_of_10_remaining + 0.20 * \
            number_of_20_remaining + 0.50 * number_of_50_remaining

        if available_balance < temp_balance:
            return 'Insufficient balance'
        else:
            counter_10 = 0
            counter_20 = 0
            counter_50 = 0

            for i in range(number_of_50_remaining):
                if temp_balance > 0:
                    temp_balance = temp_balance - 0.5
                    counter_50 = counter_50 + 1

            for i in range(number_of_20_remaining):
                if temp_balance > 0:
                    temp_balance = temp_balance - 0.2
                    counter_20 = counter_20 + 1

            for i in range(number_of_10_remaining):
                if temp_balance > 0:
                    temp_balance = temp_balance - 0.1
                    counter_10 = counter_10 + 1

            for i in range(counter_50):
                self.dispense_quarter()
                time.sleep(2)

            for i in range(counter_20):
                self.dispense_dime()
                time.sleep(2)

            for i in range(counter_10):
                self.dispense_nickel()
                time.sleep(2)

            self.set_refunding_status(refunding_status=False)

            return "Refund successful"

    @staticmethod
    def check_coin_collector_status(mdb_response):
        if mdb_response == '03':
            # No credit
            message = 'Coin No credit!'
        elif mdb_response == '04':
            # Defective tube sensor
            message = 'Coin Defective tube sensor!'
        elif mdb_response == '05':
            # Double Arrival
            message = 'Coin Double Arrival!'
        elif mdb_response == '06':
            # Acceptor unplugged
            message = 'Coin Acceptor unplugged!'
        elif mdb_response == '07':
            # Tube jam
            message = 'Coin Tube jam!'
        elif mdb_response == '08':
            # ROM checksum error
            message = 'Coin ROM checksum error!'
        elif mdb_response == '09':
            # Coin routing error
            message = 'Coin routing error!'
        elif mdb_response == '0A':
            # Changer busy
            message = 'Coin Changer busy!'
        elif mdb_response == '0B':
            # Changer reset
            message = 'Coin Changer reset!'
        elif mdb_response == '0C':
            # Coin jam
            message = 'Coin jam!'
        elif mdb_response == '21':
            # Coin not recognized
            message = 'Coin not recognized!'
        else:
            message = 'no error'

        return message
