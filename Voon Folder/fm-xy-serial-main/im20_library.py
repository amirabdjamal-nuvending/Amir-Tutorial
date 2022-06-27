from binascii import hexlify
from XOR_CheckSum import xor_checksum_string
from http_service import HttpService
import multiprocessing
import ctypes
import serial
import time
import logging
from datetime import datetime
from pathlib import Path

Path("/home/pi/Desktop/log").mkdir(parents=True, exist_ok=True)
fileName = datetime.now().strftime('GHL_%H_%M_%d_%m_%Y.log')
logging.basicConfig(filename="/home/pi/Desktop/log/" + fileName,
                    format='%(asctime)s %(message)s',
                    filemode='w')
logger = logging.getLogger()
logger.setLevel(logging.DEBUG)


# The amount lengths for all transaction are fixed to 12 which will be left padded with 0
# cmd="C100"
# hostNum="00"
# accType="1"
# amount="123"
# transactionTrace="000014"
# qrID="01" # ID=”01” for Alipay; “02”for QrPay; “03”  for GHLMAH
# qrNum="hQVDUFYwMWEhTwegAAAGFQABWhIAAAAAAAAAAABQeAgVg5GFSZGfUwEBYxWfJgQ5SRiRnwgBAV8tAkVOnyUCSUg="
class IM20(multiprocessing.Process):

    def __init__(self):
        multiprocessing.Process.__init__(self)
        logger.info("Initialized IM20")
        print("Initialized IM20")
        self.manager = multiprocessing.Manager()
        # is a flag ! 0 = idle, 1=scanning ,2=aborted
        self.is_processing = self.manager.Value(ctypes.c_char_p, "0")

        self.cmd_mp = self.manager.Value(ctypes.c_char_p, "")
        self.hostNum_mp = self.manager.Value(ctypes.c_char_p, "")
        self.accType_mp = self.manager.Value(ctypes.c_char_p, "")
        self.id_mp = self.manager.Value(ctypes.c_char_p, "")
        self.amount_mp = self.manager.Value(ctypes.c_char_p, "")

        # initia PORT for GHL
        # self.usb = HttpService.getUsbPort("GHL")
        self.usb = '/dev/serial/by-path/platform-fd500000.pcie-pci-0000:01:00.0-usb-0:1.1:1.0-port0'
        self.ser = serial.Serial(
        self.usb, 9600, bytesize=8, stopbits=1, parity='N',timeout=5)
       
    def run(self):
        
        while True:
            try:
                
                if self.is_processing.value == 1:  # scanning state

                    print("currentId: ", self.id_mp.value)
                    self.requestCode(self.id_mp.value, self.cmd_mp.value, self.hostNum_mp.value, self.accType_mp.value,
                                     self.amount_mp.value)
                    self.is_processing.value = 2
                # if self.is_processing.value== 2: #aborting state/

            except KeyboardInterrupt:
                print("IM20 process keyboard interrupted")
                self.close()
                pass
            except Exception as e:
                print("[ERROR] IM20 procees error: Unknown error")
                print(e)
                self.is_processing.value = 2
                self.close()
                pass

    def set_is_processing(self, a: int, currentId, cmd, hostNum, accType, amount):

        self.cmd_mp.value = cmd
        self.hostNum_mp.value = hostNum
        self.accType_mp.value = accType
        self.amount_mp.value = amount
        self.id_mp.value = currentId
        self.is_processing.value = a
        print("saved: ", self.id_mp.value)
        logger.info(currentId)
        print("id: ", currentId)

    def get_should_run(self):
        return self.is_processing.value

    @classmethod
    def amountPreProcess(cls, a):
        amount = str(a).zfill(12)
        return amount

    @classmethod
    def additionalDataPreProcess(cls, a):
        amount = str(a).zfill(6)
        return amount

    # LRC is calculated based on the entire packet excluding the STX
    @classmethod
    def generateLRC(cls, a):
        # checksum=hex(0x43^0x39^0x30^0x33^0x30^0x31^0x03)[2:].upper()
        checksum = chr(xor_checksum_string(a))
        return checksum

    # Scanned QRcode value.The first 4 bytes represent length of the qrcode. The length is followed byQrcode value
    @classmethod
    def calQRLength(cls, a):
        b = str(len(a)).zfill(4)
        return b + a

    def qrSettlement(self):
        receivedData = ""
        ENQ = [0x05]  # ENQ acsii code

        self.ser = serial.Serial(self.usb, 9600, bytesize=8, stopbits=1, parity='N',timeout=3)
        self.ser.flushInput()
        self.ser.flushOutput()
        print("reeaaaQ")
        logger.info("times settlement try")
        try_times=0
        while try_times<5:
            logger.info(try_times)
            logger.info("times settlement try")
            try_times=try_times+1
            
            self.ser.write(serial.to_bytes(ENQ))  # send Enquiry from PC
            logger.info("Sent ENQ")
            print("Sent ENQ")
            s = self.ser.read(1)
            print(s)
            logger.info(s)


            if s == b'\x06':  # received ACK from IM20
                logger.info("Receive ACK")
                print("Receive ACK")
                data = "C500" + "04"
                # 01 for mmb
                # 04 for qr
                data = "\x02" + data + "\x03" + self.generateLRC(data + "\x03")
                data = data.encode()  # generated cmd code
                logger.info(data)
                print(data)
                self.ser.write(serial.to_bytes(data))
                logger.info("Sent Message")
                print("Sent Message")
                session_try=0
                while True:
                      
                    s = self.ser.read(1)
                    if s== b"":
                        if session_try==30:
                            logger.info("Session Retry 30 times failed")
                            logger.info("statement go next")            
                            break
                        session_try=session_try+1
                    elif s == b'\x06':  # received ACK from IM20
                        logger.info("Receive ACK")
                        print("Receive ACK")
                        session_try=0
                        while True:  # read Response Packet
                            s = self.ser.read(1)
                            if s== b"":
                                if session_try==50:
                                    logger.info("Session Retry 50 times failed")
                                    logger.info("statement go next")            
                                    break
                                session_try=session_try+1
                            elif s == b'\x05':
                                data = [0x06]  # ACK acsii code
                                receivedData = ""
                                # send ACK from PC
                                self.ser.write(serial.to_bytes(data))
                                session_try=0
                                while True:
                                    
                                    s = self.ser.read(1)
                                    if s== b"":
                                        if session_try==90:
                                            logger.info("Session Retry 90 times failed")
                                            logger.info("statement go next")            
                                            break
                                        session_try=session_try+1
                                    receivedData = receivedData + s.decode('utf-8')
                                    if s == b'\x03':  # received start text
                                        s = self.ser.read(1)
                                        logger.info(receivedData)
                                        print(receivedData)
                                        logger.info("Check Sum Correct")
                                        print("Check Sum Correct")
                                        receivedData = receivedData + \
                                            s.decode('utf-8')

                                        data = [0x06]  # ACK acsii code
                                        # send ACK from PC
                                        self.ser.write(serial.to_bytes(data))
                                        logger.info("Sent ACK")
                                        print("Sent ACK")
                                        s = self.ser.read(1)
                                        if s == b'\x04':  # end of transmission
                                            logger.info("Transmission end")
                                            print("Transmission end")
                                            if receivedData[7:9]=="00":
                                                logger.info("Settlement done")
                                                return "done"
                                            elif (receivedData[7:9] is not "00" )and try_times==5:
                                                
                                                logger.info(receivedData[7:9])
                                                print(receivedData[7:9])
                                                logger.info("Settlement failed")
                                                return "fail"
                                            break
                                break
                    break

    def cardSettlement(self):
        receivedData = ""
        ENQ = [0x05]  # ENQ acsii code

        self.ser = serial.Serial(self.usb, 9600, bytesize=8, stopbits=1, parity='N',timeout=3)
        self.ser.flushInput()
        self.ser.flushOutput()
        print("reeaaaQ")
        logger.info("times settlement try")
        try_times=0
        while try_times<5:
            logger.info(try_times)
            logger.info("times settlement try")
            try_times=try_times+1
            
            self.ser.write(serial.to_bytes(ENQ))  # send Enquiry from PC
            logger.info("Sent ENQ")
            print("Sent ENQ")
            s = self.ser.read(1)
            print(s)
            logger.info(s)


            if s == b'\x06':  # received ACK from IM20
                logger.info("Receive ACK")
                print("Receive ACK")
                data = "C500" + "01"
                # 01 for mmb
                # 04 for qr
                data = "\x02" + data + "\x03" + self.generateLRC(data + "\x03")
                data = data.encode()  # generated cmd code
                logger.info(data)
                print(data)
                self.ser.write(serial.to_bytes(data))
                logger.info("Sent Message")
                print("Sent Message")
                session_try=0
                while True:
                      
                    s = self.ser.read(1)
                    if s== b"":
                        if session_try==30:
                            logger.info("Session Retry 30 times failed")
                            logger.info("statement go next")            
                            break
                        session_try=session_try+1
                    elif s == b'\x06':  # received ACK from IM20
                        logger.info("Receive ACK")
                        print("Receive ACK")
                        session_try=0
                        while True:  # read Response Packet
                            s = self.ser.read(1)
                            if s== b"":
                                if session_try==50:
                                    logger.info("Session Retry 50 times failed")
                                    logger.info("statement go next")            
                                    break
                                session_try=session_try+1
                            elif s == b'\x05':
                                data = [0x06]  # ACK acsii code
                                receivedData = ""
                                # send ACK from PC
                                self.ser.write(serial.to_bytes(data))
                                session_try=0
                                while True:
                                    
                                    s = self.ser.read(1)
                                    if s== b"":
                                        if session_try==90:
                                            logger.info("Session Retry 90 times failed")
                                            logger.info("statement go next")            
                                            break
                                        session_try=session_try+1
                                    receivedData = receivedData + s.decode('utf-8')
                                    if s == b'\x03':  # received start text
                                        s = self.ser.read(1)
                                        logger.info(receivedData)
                                        print(receivedData)
                                        logger.info("Check Sum Correct")
                                        print("Check Sum Correct")
                                        receivedData = receivedData + \
                                            s.decode('utf-8')

                                        data = [0x06]  # ACK acsii code
                                        # send ACK from PC
                                        self.ser.write(serial.to_bytes(data))
                                        logger.info("Sent ACK")
                                        print("Sent ACK")
                                        s = self.ser.read(1)
                                        if s == b'\x04':  # end of transmission
                                            logger.info("Transmission end")
                                            print("Transmission end")
                                            if receivedData[7:9]=="00":
                                                logger.info("Settlement card done")
                                                return "done"
                                            elif (receivedData[7:9] is not "00" )and try_times==5:
                                                
                                                logger.info(receivedData[7:9])
                                                print(receivedData[7:9])
                                                logger.info("Settlement card failed")
                                                return "fail"
                                            break
                                break
                    break
    def amexSettlement(self):            
        receivedData = ""
        ENQ = [0x05]  # ENQ acsii code
        self.ser = serial.Serial(self.usb, 9600, bytesize=8, stopbits=1, parity='N',timeout=3)
        self.ser.flushInput()
        self.ser.flushOutput()
        print("readAmex")
        logger.info("times settlement try")
        try_times=0
        while try_times<5:
            logger.info(try_times)
            logger.info("times settlement try")
            try_times=try_times+1
            
            self.ser.write(serial.to_bytes(ENQ))  # send Enquiry from PC
            logger.info("Sent ENQ")
            print("Sent ENQ")
            s = self.ser.read(1)
            print(s)
            logger.info(s)


            if s == b'\x06':  # received ACK from IM20
                logger.info("Receive ACK")
                print("Receive ACK")
                data = "C500" + "02"
                # 01 for mmb
                # 02 for mmb
                # 04 for qr
                data = "\x02" + data + "\x03" + self.generateLRC(data + "\x03")
                data = data.encode()  # generated cmd code
                logger.info(data)
                print(data)
                self.ser.write(serial.to_bytes(data))
                logger.info("Sent Message")
                print("Sent Message")
                session_try=0
                while True:
                        
                    s = self.ser.read(1)
                    if s== b"":
                        if session_try==30:
                            logger.info("Session Retry 30 times failed")
                            logger.info("statement go next")            
                            break
                        session_try=session_try+1
                    elif s == b'\x06':  # received ACK from IM20
                        logger.info("Receive ACK")
                        print("Receive ACK")
                        session_try=0
                        while True:  # read Response Packet
                            s = self.ser.read(1)
                            if s== b"":
                                if session_try==50:
                                    logger.info("Session Retry 50 times failed")
                                    logger.info("statement go next")            
                                    break
                                session_try=session_try+1
                            elif s == b'\x05':
                                data = [0x06]  # ACK acsii code
                                receivedData = ""
                                # send ACK from PC
                                self.ser.write(serial.to_bytes(data))
                                session_try=0
                                while True:
                                    
                                    s = self.ser.read(1)
                                    if s== b"":
                                        if session_try==90:
                                            logger.info("Session Retry 90 times failed")
                                            logger.info("statement go next")            
                                            break
                                        session_try=session_try+1
                                    receivedData = receivedData + s.decode('utf-8')
                                    if s == b'\x03':  # received start text
                                        s = self.ser.read(1)
                                        logger.info(receivedData)
                                        print(receivedData)
                                        logger.info("Check Sum Correct")
                                        print("Check Sum Correct")
                                        receivedData = receivedData + \
                                            s.decode('utf-8')

                                        data = [0x06]  # ACK acsii code
                                        # send ACK from PC
                                        self.ser.write(serial.to_bytes(data))
                                        logger.info("Sent ACK")
                                        print("Sent ACK")
                                        s = self.ser.read(1)
                                        if s == b'\x04':  # end of transmission
                                            logger.info("Transmission end")
                                            print("Transmission end")
                                            if receivedData[7:9]=="00":
                                                logger.info("Settlement Amex done")
                                                return "done"
                                            elif (receivedData[7:9] is not "00" )and try_times==5:
                                                
                                                logger.info(receivedData[7:9])
                                                print(receivedData[7:9])
                                                logger.info("Settlement Amex failed")
                                                return "fail"
                                            break
                                break
                    break        


        

    def get_should_run(self):
        return self.is_processing.value

    def requestCode(self, currentId, cmd, hostNum, accType, amount):
        try:
            receivedData = ""

            self.ser = serial.Serial(
                self.usb, 9600, bytesize=8, stopbits=1, parity='N',timeout=1)
            ENQ = [0x05]  # ENQ acsii code
            EOT = [0x04]  # ENQ acsii code
            # 2.1 C100 (Pre-Auth Transaction Message C100)    and 2.2 SALES
            if (cmd == "C200" or cmd == "C100"):
                today = datetime.now()
                additionalData = "TI" + today.strftime('%y%m%d')+"M9000"+self.additionalDataPreProcess(str(currentId))
                print(additionalData)
                logger.info(additionalData)
                self.ser.flushInput()
                self.ser.flushOutput()
                self.ser.write(serial.to_bytes(ENQ))  # send Enquiry from PC
                logger.info("Sent ENQ")
                print("Sent ENQ")
                session_try=0
                while True:
                    s = self.ser.read(1)
                    
                    if s== b"":
                        if session_try==2:
                            logger.info("Session Retry 3 times failed")
                            logger.info("aborted")
                            print("aborted")
                            card_digits_IM20 = None
                            status_IM20 = "TA"
                            order_number_IM20 = None
                            transaction_trace_IM20 = None
                            batch_number_IM20 = None
                            host_no_IM20 = None
                            card_type_description_IM20 = None
                            approval_code_IM20 = None
                            amount = int(amount)
                            payment_method_IM20 = None
                            self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                            break
                        logger.info("Session Retry")
                        self.ser.write(serial.to_bytes(EOT))  # send Enquiry from PC
                        logger.info("Sent EOT")
                        time.sleep(1)
                        self.ser.write(serial.to_bytes(ENQ))  # send Enquiry from PC
                        logger.info("Sent ENQ")
                        session_try=session_try+1
                        

                    elif s == b'\x06':  # received ACK from IM20
                        logger.info("Receive ACK")
                        print("Receive ACK")
                        amount = self.amountPreProcess(amount)
                        additionalData = additionalData
                        data = cmd + hostNum + accType + amount + additionalData
                        data = "\x02" + data + "\x03" + self.generateLRC(data + "\x03")
                        data = data.encode()  # generated cmd code
                        logger.info(data)
                        self.ser.write(serial.to_bytes(data))
                        logger.info("Sent Message")
                        print("Sent Message")
                        session_try=0
                        while True:
                            s = self.ser.read(1)
                            if s== b"":
                                logger.info("Session Retry 1 times failed")
                                if session_try==6:
                                    logger.info("Session Retry 6 times failed")
                                    logger.info("Session Retry 6 times failed")
                                    logger.info("aborted")
                                    print("aborted")
                                    card_digits_IM20 = None
                                    status_IM20 = "TA"
                                    order_number_IM20 = None
                                    transaction_trace_IM20 = None
                                    batch_number_IM20 = None
                                    host_no_IM20 = None
                                    card_type_description_IM20 = None
                                    approval_code_IM20 = None
                                    amount = int(amount)
                                    payment_method_IM20 = None
                                    self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                    break
                                session_try=session_try+1
                            elif s == b'\x06':  # received ACK from IM20
                                logger.info("Receive ACK")
                                print("Receive ACK")
                                session_try=0
                                while True:  # check payment methods
                                    s = self.ser.read(1)
                                    receivedData = receivedData + s.decode('utf-8')
                                    
                                    if s== b"":
                                        logger.info("Session Retry 1 times failed")
                                        if session_try==60:
                                            logger.info("Session Retry 60 times failed")
                                            logger.info("Session Retry 60 times failed")
                                            logger.info("aborted")
                                            print("aborted")
                                            card_digits_IM20 = None
                                            status_IM20 = "TA"
                                            order_number_IM20 = None
                                            transaction_trace_IM20 = None
                                            batch_number_IM20 = None
                                            host_no_IM20 = None
                                            card_type_description_IM20 = None
                                            approval_code_IM20 = None
                                            amount = int(amount)
                                            payment_method_IM20 = None
                                            self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                            break
                                        session_try=session_try+1
                                    elif s == b'\x05':  # received ACK from IM20
                                        session_try=0
                                        while True:
                                            s = self.ser.read(1)
                                            print("Error!")
                                            logger.info("Error!!")
                                            if s== b"":
                                                logger.info("paying")
                                                if session_try==30:
                                                    logger.info("Session Retry 30 times failed")
                                                    logger.info("aborted")
                                                    print("aborted")
                                                    card_digits_IM20 = None
                                                    status_IM20 = "TA"
                                                    order_number_IM20 = None
                                                    transaction_trace_IM20 = None
                                                    batch_number_IM20 = None
                                                    host_no_IM20 = None
                                                    card_type_description_IM20 = None
                                                    approval_code_IM20 = None
                                                    amount = int(amount)
                                                    payment_method_IM20 = None
                                                    self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                    break
                                                session_try=session_try+1
                                            elif s == b'\x05':
                                                print("Received ENQ")
                                                data = [0x06]  # ACK acsii code
                                                logger.info("Received ENQ")
                                                # send ACK from PC
                                                self.ser.write(serial.to_bytes(data))
                                                logger.info("Sent ACK")
                                                print("Sent ACK")
                                                session_try=0
                                                while True:  # read Response Packet

                                                    s = self.ser.read(1)
                                                    receivedData = receivedData + \
                                                        s.decode('utf-8')
                                                    if s== b"":
                                                        logger.info("paying")
                                                        if session_try==200:
                                                            logger.info("Session Retry 200 times failed")
                                                            logger.info("aborted")
                                                            print("aborted")
                                                            card_digits_IM20 = None
                                                            status_IM20 = "TA"
                                                            order_number_IM20 = None
                                                            transaction_trace_IM20 = None
                                                            batch_number_IM20 = None
                                                            host_no_IM20 = None
                                                            card_type_description_IM20 = None
                                                            approval_code_IM20 = None
                                                            amount = int(amount)
                                                            payment_method_IM20 = None
                                                            self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                            break
                                                        session_try=session_try+1
                                                    elif s == b'\x03':  # received start text
                                                        s = self.ser.read(1)
                                                        logger.info(receivedData)
                                                        print(receivedData)
                                                        logger.info("Check Sum Correct")
                                                        print("Check Sum Correct")
                                                        logger.info("aborted")
                                                        print("aborted")
                                                        card_digits_IM20 = None
                                                        status_IM20 = "TA"
                                                        order_number_IM20 = None
                                                        transaction_trace_IM20 = None
                                                        batch_number_IM20 = None
                                                        host_no_IM20 = None
                                                        card_type_description_IM20 = None
                                                        approval_code_IM20 = None
                                                        amount = int(amount)
                                                        payment_method_IM20 = None
                                                        self.updateGhlPayment(currentId, transaction_trace_IM20,
                                                                            payment_method_IM20, amount, card_digits_IM20,
                                                                            order_number_IM20, batch_number_IM20,
                                                                            host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                
                                                        receivedData = receivedData + \
                                                            s.decode('utf-8')

                                                        data = [0x06]  # ACK acsii code
                                                        # send ACK from PC
                                                        self.ser.write(
                                                            serial.to_bytes(data))
                                                        logger.info("Sent ACK")
                                                        print("Sent ACK")
                                                        s = self.ser.read(1)
                                                        if s == b'\x04':  # end of transmission
                                                            logger.info(
                                                                "Transmission end")
                                                            print("Transmission end")

                                                            break
                                                        break
                                                break
                                        break
                                    elif s == b'\x06':  # received ACK from IM20 when aborting
                                        while True:
                                            print("Canceling")
                                            if self.ser.read(1) == b'\x05':
                                                print("Received ENQ")
                                                data = [0x06]  # ACK acsii code

                                                # send ACK from PC
                                                self.ser.write(serial.to_bytes(data))
                                                logger.info("Sent ACK")
                                                print("Sent ACK")
                                                session_try=0
                                                while True:  # read Response Packet

                                                    s = self.ser.read(1)
                                                    receivedData = receivedData + \
                                                        s.decode('utf-8')
                                                    if s== b"":
                                                        if session_try==200:
                                                            logger.info("Session Retry 200 times failed")
                                                            logger.info("aborted")
                                                            print("aborted")
                                                            card_digits_IM20 = None
                                                            status_IM20 = "TA"
                                                            order_number_IM20 = None
                                                            transaction_trace_IM20 = None
                                                            batch_number_IM20 = None
                                                            host_no_IM20 = None
                                                            card_type_description_IM20 = None
                                                            approval_code_IM20 = None
                                                            amount = int(amount)
                                                            payment_method_IM20 = None
                                                            self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                            break
                                                        session_try=session_try+1
                                                    if s == b'\x03':  # received start text
                                                        s = self.ser.read(1)
                                                        logger.info(receivedData)
                                                        print(receivedData)
                                                        # if s.decode('utf-8')==self.generateLRC(receivedData[1:]):
                                                        logger.info(
                                                            "Check Sum Correct")
                                                        print("Check Sum Correct")
                                                        logger.info("aborted")
                                                        print("aborted")
                                                        card_digits_IM20 = None
                                                        status_IM20 = "TA"
                                                        order_number_IM20 = None
                                                        transaction_trace_IM20 = None
                                                        batch_number_IM20 = None
                                                        host_no_IM20 = None
                                                        card_type_description_IM20 = None
                                                        approval_code_IM20 = None
                                                        amount = int(amount)
                                                        payment_method_IM20 = None
                                                        self.updateGhlPayment(currentId, transaction_trace_IM20,
                                                                            payment_method_IM20, amount, card_digits_IM20,
                                                                            order_number_IM20, batch_number_IM20,
                                                                            host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                        receivedData = receivedData + \
                                                            s.decode('utf-8')
                                                        # here
                                                        logger.info(receivedData)
                                                        print(receivedData)
                                                        data = [0x06]  # ACK acsii code
                                                        # send ACK from PC
                                                        self.ser.write(
                                                            serial.to_bytes(data))
                                                        logger.info("Sent ACK")
                                                        print("Sent ACK")
                                                        s = self.ser.read(1)
                                                        if s == b'\x04':  # end of transmission
                                                            logger.info(
                                                                "Transmission end")
                                                            print("Transmission end")

                                                            break
                                                        break
                                                break
                                            # else:
                                            #     data=[0x15] #ACK acsii code
                                            #     self.ser.write(serial.to_bytes(data))#send ACK from PC
                                            #     print("Check Sum Error,Sent NAK for retry")

                                        break

                                    elif receivedData == "CLES":  # is cash less payment
                                        logger.info(receivedData)
                                        print(receivedData)
                                        payment_method = "CLES"
                                        data = [0x06]  # ACK acsii code
                                        # send ACK from PC
                                        self.ser.write(serial.to_bytes(data))
                                        logger.info("Sent ACK")
                                        print("Sent ACK")
                                        receivedData = ""  # clear and ready for store next data from IM20
                                        if int(amount) < 25001:
                                            print("less")
                                            session_try=0
                                            # received ENQ from IM20
                                            while True:
                                                s = self.ser.read(1)
                                                if s== b"":
                                                    if session_try==30:
                                                        logger.info("Session Retry 30 times failed")
                                                        logger.info("aborted")
                                                        print("aborted")
                                                        card_digits_IM20 = None
                                                        status_IM20 = "TA"
                                                        order_number_IM20 = None
                                                        transaction_trace_IM20 = None
                                                        batch_number_IM20 = None
                                                        host_no_IM20 = None
                                                        card_type_description_IM20 = None
                                                        approval_code_IM20 = None
                                                        amount = int(amount)
                                                        payment_method_IM20 = None
                                                        self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                        break
                                                    session_try=session_try+1
                                                elif s == b'\x05':
                                                    print("Receive ENQ")
                                                    logger.info("Sent ACK")
                                                    data = [0x06]  # ACK acsii code
                                                    # send ACK from PC
                                                    self.ser.write(serial.to_bytes(data))
                                                    
                                                    print("Sent ACK")
                                                    session_try=0
                                                    while True:  # read Response Packet
                                                        
                                                        s = self.ser.read(1)
                                                        receivedData = receivedData + \
                                                            s.decode('utf-8')
                                                        logger.info(s)
                                                        if s== b"":
                                                            if session_try==200:
                                                                logger.info("Session Retry 200 times failed")
                                                                logger.info("aborted")
                                                                print("aborted")
                                                                card_digits_IM20 = None
                                                                status_IM20 = "TA"
                                                                order_number_IM20 = None
                                                                transaction_trace_IM20 = None
                                                                batch_number_IM20 = None
                                                                host_no_IM20 = None
                                                                card_type_description_IM20 = None
                                                                approval_code_IM20 = None
                                                                amount = int(amount)
                                                                payment_method_IM20 = None
                                                                self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                                break
                                                            session_try=session_try+1
                                                        elif s == b'\x03':  # received start text

                                                            s = self.ser.read(1)
                                                            if s.decode('utf-8') == self.generateLRC(receivedData[1:]):
                                                                logger.info(
                                                                    "Check Sum Correct")
                                                                print("Check Sum Correct")
                                                                receivedData = receivedData + \
                                                                    s.decode('utf-8')

                                                                logger.info(receivedData)
                                                                print(receivedData)
                                                                # ACK acsii code
                                                                data = [0x06]
                                                                # send ACK from PC
                                                                self.ser.write(
                                                                    serial.to_bytes(data))
                                                                logger.info("Sent ACK")
                                                                print("Sent ACK")
                                                                s = self.ser.read(1)
                                                                card_digits_IM20 = receivedData[5:21]
                                                                status_IM20 = receivedData[28:30]
                                                                order_number_IM20 = None
                                                                transaction_trace_IM20 = receivedData[48:54]
                                                                batch_number_IM20 = receivedData[54:60]
                                                                host_no_IM20 = receivedData[60:62]
                                                                amount = int(amount)
                                                                card_type_description_IM20 = receivedData[141:143]
                                                                approval_code_IM20 = receivedData[30:36]
                                                                card_type_IM20 = receivedData[141:143]
                                                                logger.info(card_type_IM20)
                                                                print(
                                                                    "currentId: ", currentId)
                                                                self.updateGhlPayment(currentId, transaction_trace_IM20,
                                                                                    payment_method, amount, card_digits_IM20,
                                                                                    order_number_IM20, batch_number_IM20,
                                                                                    host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                                if s == b'\x04':  # end of transmission
                                                                    logger.info(
                                                                        "Transmission end")
                                                                    print(
                                                                        "Transmission end")

                                                                break
                                                            else:
                                                                
                                                                # ACK acsii code
                                                                data = [0x15]
                                                                # send ACK from PC
                                                                self.ser.write(
                                                                    serial.to_bytes(data))
                                                                print(
                                                                    "Check Sum Error,Sent NAK for retry")
                                                                receivedData = ""
                                                                logger.info("Check Sum Error,Sent NAK for retry")

                                                                
                                                    break   
                                            break                 
                                        else:
                                            while True:
                                                s = self.ser.read(1)
                                                receivedData = receivedData + \
                                                    s.decode('utf-8')
                                                if receivedData == "PIN":  # PIN is Required
                                                    receivedData = ""
                                                    print("PIN is Required")
                                                    data = [0x06]  # ACK acsii code
                                                    # send ACK from PC
                                                    self.ser.write(
                                                        serial.to_bytes(data))
                                                    logger.info("Sent ACK")
                                                    print("Sent ACK")
                                                    while True:
                                                        s = self.ser.read(1)
                                                        receivedData = receivedData + \
                                                            s.decode('utf-8')

                                                        if receivedData == "PEF":  # PEF is Required
                                                            receivedData = ""
                                                            print("Received PEF")
                                                            # ACK acsii code
                                                            data = [0x06]
                                                            # send ACK from PC
                                                            self.ser.write(
                                                                serial.to_bytes(data))
                                                            logger.info("Sent ACK")
                                                            print("Sent ACK")
                                                            # received ENQ from IM20
                                                            if self.ser.read(1) == b'\x05':
                                                                print("Receive ENQ")
                                                                # ACK acsii code
                                                                data = [0x06]
                                                                # send ACK from PC
                                                                self.ser.write(
                                                                    serial.to_bytes(data))
                                                                logger.info("Sent ACK")
                                                                print("Sent ACK")
                                                                while True:  # read Response Packet

                                                                    s = self.ser.read(
                                                                        1)
                                                                    receivedData = receivedData + \
                                                                        s.decode(
                                                                            'utf-8')
                                                                    if s == b'\x03':  # received start text

                                                                        s = self.ser.read(
                                                                            1)
                                                                        if s.decode('utf-8') == self.generateLRC(
                                                                                receivedData[1:]):
                                                                            logger.info(
                                                                                "Check Sum Correct")
                                                                            print(
                                                                                "Check Sum Correct")
                                                                            receivedData = receivedData + \
                                                                                s.decode(
                                                                                    'utf-8')

                                                                            logger.info(
                                                                                receivedData)
                                                                            print(
                                                                                receivedData)
                                                                            # ACK acsii code
                                                                            data = [
                                                                                0x06]
                                                                            self.ser.write(
                                                                                serial.to_bytes(data))  # send ACK from PC
                                                                            logger.info(
                                                                                "Sent ACK")
                                                                            print(
                                                                                "Sent ACK")
                                                                            s = self.ser.read(
                                                                                1)
                                                                            card_digits_IM20 = receivedData[5:21]
                                                                            status_IM20 = receivedData[28:30]
                                                                            order_number_IM20 = None
                                                                            transaction_trace_IM20 = receivedData[48:54]
                                                                            batch_number_IM20 = receivedData[54:60]
                                                                            host_no_IM20 = receivedData[60:62]
                                                                            amount = int(
                                                                                amount)
                                                                            card_type_description_IM20 = receivedData[141:143]
                                                                            approval_code_IM20 = receivedData[30:36]
                                                                            card_type_IM20 = receivedData[141:143]
                                                                            logger.info(card_type_IM20)
                                                                            self.updateGhlPayment(currentId,
                                                                                                transaction_trace_IM20,
                                                                                                payment_method, amount,
                                                                                                card_digits_IM20,
                                                                                                order_number_IM20,
                                                                                                batch_number_IM20,
                                                                                                host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                                            if s == b'\x04':  # end of transmission
                                                                                logger.info(
                                                                                    "Transmission end")
                                                                                print(
                                                                                    "Transmission end")

                                                                            break
                                                                        else:
                                                                            # ACK acsii code
                                                                            data = [
                                                                                0x15]
                                                                            self.ser.write(
                                                                                serial.to_bytes(data))  # send ACK from PC
                                                                            print(
                                                                                "Check Sum Error,Sent NAK for retry")
                                                                            receivedData = ""
                                                                            logger.info("Check Sum Error,Sent NAK for retry")
                                                                            

                                                            break
                                                    break
                                            break

                                        break
                                    elif receivedData == "CARD":  # is Card payment
                                        logger.info(receivedData)
                                        print(receivedData)
                                        data = [0x06]  # ACK acsii code
                                        # send ACK from PC
                                        self.ser.write(serial.to_bytes(data))
                                        logger.info("Sent ACK")
                                        print("Sent ACK")
                                        payment_method = "CARD"
                                        receivedData = ""  # clear and ready for store next data from IM20
                                        session_try=0
                                        while True:
                                            s = self.ser.read(1)
                                            receivedData = receivedData + \
                                                s.decode('utf-8')
                                            if s== b"":
                                                if session_try==200:
                                                    logger.info("Session Retry 200 times failed")
                                                    logger.info("aborted")
                                                    print("aborted")
                                                    card_digits_IM20 = None
                                                    status_IM20 = "TA"
                                                    order_number_IM20 = None
                                                    transaction_trace_IM20 = None
                                                    batch_number_IM20 = None
                                                    host_no_IM20 = None
                                                    card_type_description_IM20 = None
                                                    approval_code_IM20 = None
                                                    amount = int(amount)
                                                    payment_method_IM20 = None
                                                    self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                    break
                                                session_try=session_try+1
                                            elif receivedData == "PIN":  # PIN is Required
                                                receivedData = ""
                                                print("PIN is Required")
                                                data = [0x06]  # ACK acsii code
                                                # send ACK from PC
                                                self.ser.write(serial.to_bytes(data))
                                                logger.info("Sent ACK")
                                                print("Sent ACK")
                                                session_try=0
                                                while True:
                                                    s = self.ser.read(1)
                                                    receivedData = receivedData + \
                                                        s.decode('utf-8')
                                                    if s== b"":

                                                        if session_try==200:
                                                            logger.info("Session Retry 200 times failed")
                                                            logger.info("aborted")
                                                            print("aborted")
                                                            card_digits_IM20 = None
                                                            status_IM20 = "TA"
                                                            order_number_IM20 = None
                                                            transaction_trace_IM20 = None
                                                            batch_number_IM20 = None
                                                            host_no_IM20 = None
                                                            card_type_description_IM20 = None
                                                            approval_code_IM20 = None
                                                            amount = int(amount)
                                                            payment_method_IM20 = None
                                                            self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                            break
                                                        session_try=session_try+1
                                                    elif receivedData == "PEF":  # PEF is Required
                                                        receivedData = ""
                                                        print("Received PEF")
                                                        logger.info("Received PEF")
                                                        data = [0x06]  # ACK acsii code
                                                        # send ACK from PC
                                                        self.ser.write(
                                                            serial.to_bytes(data))
                                                        logger.info("Sent ACK")
                                                        print("Sent ACK")
                                                        session_try=0
                                                        # received ENQ from IM20
                                                        while True:
                                                            s = self.ser.read(1)
                                                            if s== b"":
                                                                if session_try==30:
                                                                    logger.info("Session Retry 30 times failed")
                                                                    logger.info("aborted")
                                                                    print("aborted")
                                                                    card_digits_IM20 = None
                                                                    status_IM20 = "TA"
                                                                    order_number_IM20 = None
                                                                    transaction_trace_IM20 = None
                                                                    batch_number_IM20 = None
                                                                    host_no_IM20 = None
                                                                    card_type_description_IM20 = None
                                                                    approval_code_IM20 = None
                                                                    amount = int(amount)
                                                                    payment_method_IM20 = None
                                                                    self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                                    break
                                                                session_try=session_try+1
                                                            elif s == b'\x05':
                                                                print("Receive ENQ")
                                                                # ACK acsii code
                                                                data = [0x06]
                                                                # send ACK from PC
                                                                self.ser.write(
                                                                    serial.to_bytes(data))
                                                                logger.info("Sent ACK")
                                                                print("Sent ACK")
                                                                session_try=0
                                                                while True:  # read Response Packet

                                                                    s = self.ser.read(1)
                                                                    receivedData = receivedData + \
                                                                        s.decode('utf-8')
                                                                    if s== b"":
                                                                        if session_try==200:
                                                                            logger.info("Session Retry 200 times failed")
                                                                            logger.info("aborted")
                                                                            print("aborted")
                                                                            card_digits_IM20 = None
                                                                            status_IM20 = "TA"
                                                                            order_number_IM20 = None
                                                                            transaction_trace_IM20 = None
                                                                            batch_number_IM20 = None
                                                                            host_no_IM20 = None
                                                                            card_type_description_IM20 = None
                                                                            approval_code_IM20 = None
                                                                            amount = int(amount)
                                                                            payment_method_IM20 = None
                                                                            self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                                            break
                                                                        session_try=session_try+1
                                                                    if s == b'\x03':  # received start text

                                                                        s = self.ser.read(
                                                                            1)
                                                                        if s.decode('utf-8') == self.generateLRC(receivedData[1:]):
                                                                            logger.info(
                                                                                "Check Sum Correct")
                                                                            print(
                                                                                "Check Sum Correct")
                                                                            receivedData = receivedData + \
                                                                                s.decode(
                                                                                    'utf-8')

                                                                            logger.info(
                                                                                receivedData)
                                                                            print(
                                                                                receivedData)
                                                                            # ACK acsii code
                                                                            data = [0x06]
                                                                            self.ser.write(
                                                                                serial.to_bytes(data))  # send ACK from PC
                                                                            logger.info(
                                                                                "Sent ACK")
                                                                            print(
                                                                                "Sent ACK")
                                                                            s = self.ser.read(
                                                                                1)
                                                                            card_digits_IM20 = receivedData[5:21]
                                                                            status_IM20 = receivedData[28:30]
                                                                            order_number_IM20 = None
                                                                            transaction_trace_IM20 = receivedData[48:54]
                                                                            batch_number_IM20 = receivedData[54:60]
                                                                            host_no_IM20 = receivedData[60:62]
                                                                            card_type_IM20 = receivedData[141:143]
                                                                            logger.info(card_type_IM20)
                                                                            amount = int(
                                                                                amount)
                                                                            card_type_description_IM20 = receivedData[141:143]
                                                                            approval_code_IM20 = receivedData[30:36]
                                                                            self.updateGhlPayment(currentId, transaction_trace_IM20,
                                                                                                payment_method, amount,
                                                                                                card_digits_IM20,
                                                                                                order_number_IM20,
                                                                                                batch_number_IM20, host_no_IM20,
                                                                                                status_IM20, card_type_description_IM20, approval_code_IM20)
                                                                            if s == b'\x04':  # end of transmission
                                                                                logger.info(
                                                                                    "Transmission end")
                                                                                print(
                                                                                    "Transmission end")

                                                                            break
                                                                        else:
                                                                            # ACK acsii code
                                                                            data = [0x15]
                                                                            self.ser.write(
                                                                                serial.to_bytes(data))  # send ACK from PC
                                                                            print(
                                                                                "Check Sum Error,Sent NAK for retry")
                                                                            receivedData = ""
                                                                            logger.info("Check Sum Error,Sent NAK for retry")
                                                                            
                                                                        
                                                                break    
                                                        break
                                                break
                                        break
                                    elif receivedData == "SCAN":  # is Scan payment
                                        payment_method = "SCAN"
                                        logger.info(receivedData)
                                        print(receivedData)
                                        data = [0x06]  # ACK acsii code
                                        # send ACK from PC
                                        self.ser.write(serial.to_bytes(data))
                                        logger.info("Sent ACK")
                                        print("Sent ACK")

                                        receivedData = ""  # clear and ready for store next data from IM20
                                        # received ENQ from IM20
                                        session_try=0
                                        while True:
                                            s = self.ser.read(1)
                                            if s== b"":
                                                if session_try==200:
                                                    logger.info("Session Retry 200 times failed")
                                                    logger.info("aborted")
                                                    print("aborted")
                                                    card_digits_IM20 = None
                                                    status_IM20 = "TA"
                                                    order_number_IM20 = None
                                                    transaction_trace_IM20 = None
                                                    batch_number_IM20 = None
                                                    host_no_IM20 = None
                                                    card_type_description_IM20 = None
                                                    approval_code_IM20 = None
                                                    amount = int(amount)
                                                    payment_method_IM20 = None
                                                    self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                    break
                                                session_try=session_try+1
                                            elif s == b'\x05':
                                                print("Receive ENQ")
                                                logger.info("Sent ENQ")
                                                data = [0x06]  # ACK acsii code
                                                # send ACK from PC
                                                self.ser.write(serial.to_bytes(data))
                                                logger.info("Sent ACK")
                                                print("Sent ACK")
                                                session_try=0
                                                while True:  # read Response Packet

                                                    s = self.ser.read(1)
                                                    receivedData = receivedData + \
                                                        s.decode('utf-8')
                                                    if s== b"":
                                                        if session_try==200:
                                                            logger.info("Session Retry 200 times failed")
                                                            logger.info("aborted")
                                                            print("aborted")
                                                            card_digits_IM20 = None
                                                            status_IM20 = "TA"
                                                            order_number_IM20 = None
                                                            transaction_trace_IM20 = None
                                                            batch_number_IM20 = None
                                                            host_no_IM20 = None
                                                            card_type_description_IM20 = None
                                                            approval_code_IM20 = None
                                                            amount = int(amount)
                                                            payment_method_IM20 = None
                                                            self.updateGhlPayment(currentId, transaction_trace_IM20,payment_method_IM20, amount, card_digits_IM20,order_number_IM20, batch_number_IM20,host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                            break
                                                        session_try=session_try+1
                                                    elif s == b'\x03':  # received start text
                                                        s = self.ser.read(1)
                                                        if s.decode('utf-8') == self.generateLRC(receivedData[1:]):
                                                            logger.info(
                                                                "Check Sum Correct")
                                                            print("Check Sum Correct")
                                                            receivedData = receivedData + \
                                                                s.decode('utf-8')

                                                            logger.info(receivedData)
                                                            print(receivedData)
                                                            data = [0x06]  # ACK acsii code
                                                            # send ACK from PC
                                                            self.ser.write(
                                                                serial.to_bytes(data))
                                                            logger.info("Sent ACK")
                                                            print("Sent ACK")
                                                            s = self.ser.read(1)
                                                            card_digits_IM20 = None
                                                            status_IM20 = receivedData[5:7]
                                                            order_number_IM20 = receivedData[114:128]
                                                            transaction_trace_IM20 = receivedData[39:45]
                                                            batch_number_IM20 = receivedData[45:51]
                                                            host_no_IM20 = receivedData[51:53]
                                                            amount = int(amount)
                                                            # print( receivedData[401:403])
                                                            card_type_description_IM20 = receivedData[385:410]
                                                            approval_code_IM20 = None
                                                            self.updateGhlPayment(currentId, transaction_trace_IM20, payment_method,
                                                                                amount, card_digits_IM20, order_number_IM20,
                                                                                batch_number_IM20, host_no_IM20, status_IM20, card_type_description_IM20, approval_code_IM20)
                                                            if s == b'\x04':  # end of transmission
                                                                logger.info(
                                                                    "Transmission end")
                                                                print("Transmission end")

                                                                break
                                                        else:
                                                            data = [0x15]  # ACK acsii code
                                                            # send ACK from PC
                                                            self.ser.write(
                                                                serial.to_bytes(data))
                                                            print(
                                                                "Check Sum Error,Sent NAK for retry")
                                                            receivedData = ""
                                                            logger.info("Check Sum Error,Sent NAK for retry")
                                                break
                                        break
                                    
                                break
                            else:
                                print("recieved NAK")
                                break
                        return receivedData

            # 2.3 C201 (VOID Transaction Message C201)
            elif (cmd == "C201"):
                return
            # 2.4 C208 (Query Command for sale transaction)
            elif (cmd == "C208"):
                print("not yet develop")
                return
                # 2.5 C290 Sale Transaction Message for Alipay, MBB QRPay, GHLMAH (external scanner)
            elif (cmd == "C290"):
                print("not yet develop")
                return
            elif (cmd == "C902"):
                print("not yet develop")
                return
        except Exception as e:
            Logger.log("SerialTimeout", "Timeout when sending command to printer via USB.")
            

    def refund(self, dataFromDb, refundAmount):
        # start  ***！！！***！！***！！！1/7/21
        # for manual refund ***！！！***！！***！！！
        print(2111231322)
        return self.updateGhlRefund(dataFromDb['id'], int(refundAmount), "refunded")

        # # for manual refund.
        # #end  ***！！！***！！***！！！1/7/21
        # receivedData = ""
        # self.ser = serial.Serial(self.usb, 9600, bytesize=8, stopbits=1, parity='N')
        # ENQ = [0x05]  # ENQ acsii code
        # # 2.1 C100 (Pre-Auth Transaction Message C100)    and 2.2 SALES
        # if dataFromDb['payment_method'] == "CLES" or dataFromDb['payment_method'] == "CARD":
        #     print("saddsad")
        #     additionalData = "TI" + self.additionalDataPreProcess(dataFromDb['id'])
        #     print(additionalData)
        #     self.ser.flushInput()
        #     self.ser.flushOutput()
        #     self.ser.write(serial.to_bytes(ENQ))  # send Enquiry from PC
        #     logger.info("Sent ENQ")
        #     print("Sent ENQ")

        #     s = self.ser.read(1)

        #     if s == b'\x06':  # received ACK from IM20
        #         logger.info("Receive ACK")
        #         print("Receive ACK")
        #         amount = self.amountPreProcess(int(float(dataFromDb['amount']) * 100) - int(refundAmount))
        #         data = "C230" + dataFromDb['host_id'] + amount + "000000" + additionalData
        #         data = "\x02" + data + "\x03" + self.generateLRC(data + "\x03")
        #         data = data.encode()  # generated cmd code
        #         self.ser.write(serial.to_bytes(data))
        #         logger.info(data)
        #         logger.info("Sent Message")
        #         print("Sent Message")
        #         while True:
        #             if self.ser.read(1) == b'\x06':  # received ACK from IM20
        #                 logger.info("Receive ACK")
        #                 print("Receive ACK")
        #                 while True:  # check payment methods
        #                     s = self.ser.read(1)
        #                     receivedData = receivedData + s.decode('utf-8')
        #                     if s == b'\x05':  # received ACK from IM20
        #                         while True:

        #                             if self.ser.read(1) == b'\x05':
        #                                 print("Received ENQ")
        #                                 data = [0x06]  # ACK acsii code

        #                                 self.ser.write(serial.to_bytes(data))  # send ACK from PC
        #                                 logger.info("Sent ACK")
        #                                 print("Sent ACK")
        #                                 while True:  # read Response Packet

        #                                     s = self.ser.read(1)
        #                                     receivedData = receivedData + s.decode('utf-8')
        #                                     if s == b'\x03':  # received start text
        #                                         s = self.ser.read(1)
        #                                         logger.info(receivedData)
        #                                         print(receivedData)
        #                                         logger.info("Check Sum Correct")
        #                                         print("Check Sum Correct")
        #                                         receivedData = receivedData + s.decode('utf-8')

        #                                         data = [0x06]  # ACK acsii code
        #                                         self.ser.write(serial.to_bytes(data))  # send ACK from PC
        #                                         logger.info("Sent ACK")
        #                                         print("Sent ACK")
        #                                         s = self.ser.read(1)
        #                                         if s == b'\x04':  # end of transmission
        #                                             logger.info("Transmission end")
        #                                             print("Transmission end")
        #                                             status_IM20 = receivedData[8:10]
        #                                             if status_IM20 == "00":

        #                                                 self.updateGhlRefund(dataFromDb['id'], int(refundAmount),"refunded")
        #                                                 return "done"
        #                                             else:
        #                                                 return "refund failed"
        #                                             break
        #                             break
        #                         break
        #                 break
        #             else:
        #                 print("recieved NAK")

        # elif dataFromDb['payment_method'] == "SCAN":
        #     self.ser.flushInput()
        #     self.ser.flushOutput()
        #     self.ser.write(serial.to_bytes(ENQ))  # send Enquiry from PC
        #     logger.info("Sent ENQ")
        #     print("Sent ENQ")
        #     s = self.ser.read(1)

        #     if s == b'\x06':  # received ACK from IM20
        #         logger.info("Receive ACK")
        #         print("Receive ACK")
        #         amount = self.amountPreProcess(int(refundAmount))
        #         originalAmount = self.amountPreProcess(int(float(dataFromDb['amount']) * 100))
        #         data = "C292" + dataFromDb['host_id'] + amount + originalAmount + dataFromDb['order_number']
        #         logger.info(data)
        #         print(data)
        #         print(dataFromDb['order_number'])
        #         data = "\x02" + data + "\x03" + self.generateLRC(data + "\x03")
        #         data = data.encode()  # generated cmd code
        #         self.ser.write(serial.to_bytes(data))
        #         logger.info("Sent Message")
        #         print("Sent Message")
        #         while True:
        #             if self.ser.read(1) == b'\x06':  # received ACK from IM20
        #                 logger.info("Receive ACK")
        #                 print("Receive ACK")
        #                 while True:  # check payment methods
        #                     s = self.ser.read(1)
        #                     receivedData = receivedData + s.decode('utf-8')
        #                     if s == b'\x05':  # received ACK from IM20
        #                         while True:

        #                             if self.ser.read(1) == b'\x05':
        #                                 print("Received ENQ")
        #                                 data = [0x06]  # ACK acsii code

        #                                 self.ser.write(serial.to_bytes(data))  # send ACK from PC
        #                                 logger.info("Sent ACK")
        #                                 print("Sent ACK")
        #                                 while True:  # read Response Packet

        #                                     s = self.ser.read(1)
        #                                     receivedData = receivedData + s.decode('utf-8')
        #                                     if s == b'\x03':  # received start text
        #                                         s = self.ser.read(1)
        #                                         logger.info(receivedData)
        #                                         print(receivedData)
        #                                         logger.info("Check Sum Correct")
        #                                         print("Check Sum Correct")
        #                                         receivedData = receivedData + s.decode('utf-8')

        #                                         data = [0x06]  # ACK acsii code
        #                                         self.ser.write(serial.to_bytes(data))  # send ACK from PC
        #                                         logger.info("Sent ACK")
        #                                         print("Sent ACK")
        #                                         s = self.ser.read(1)
        #                                         if s == b'\x04':  # end of transmission
        #                                             logger.info("Transmission end")
        #                                             print("Transmission end")
        #                                             status_IM20 = receivedData[6:8]

        #                                             if status_IM20 == "00":

        #                                                 self.updateGhlRefund(dataFromDb['id'], int(refundAmount),
        #                                                                      "refunded")
        #                                                 return "done"
        #                                             else:
        #                                                 return "refund failed"
        #                                             break
        #                             break
        #                         break
        #                 break
        #             else:
        #                 print("recieved NAK")

    @classmethod
    def getIdData(cls, currentId):
        result = HttpService.getIdData(currentId)
        # print(result["status"])

        return result
        # if result["status"] == 'error':

        #     return "failed to get API"
        # else:
        #     return result["result"]

    @classmethod
    def insertGhlPayment(cls, payment_method: str, amount):
        result = HttpService.insertGhlPayment(payment_method, amount)
        if result["status"] == 'error':

            return "failed to get API"
        else:
            return result["result"]

    @classmethod
    def updateGhlPayment(cls, id, transaction_trace, payment_method, amount, card_digits, order_number, batch_number, host_id, status, card_type_description, approval_code):

        result = HttpService.updateGhlPayment(id, transaction_trace, payment_method, amount, card_digits, order_number,
                                              batch_number, host_id, status, card_type_description, approval_code)
        # print(id,transaction_trace,payment_method,batch_number,host_id,status)
        if result["status"] == 'error':

            return "failed to get API"
        else:

            return result["status"]

    @classmethod
    def updateGhlRefund(cls, id, refund_amount, refund_status):
        print(2112)
        result = HttpService.updateGhlRefund(id, refund_amount, refund_status)
        # print(id,transaction_trace,payment_method,batch_number,host_id,status)
        if result["status"] == 'error':

            return "failed to get API"
        else:

            return result["status"]

    def abortTransaction(self):
        self.ser = serial.Serial(
            self.usb, 9600, bytesize=8, stopbits=1, parity='N',timeout=5)
        data = "ABORT".encode()  # generated cmd code
        self.ser.write(serial.to_bytes(data))

        # if self.ser.read(1)==b'\x06': #received ACK from IM20
        #     self.data=[0x05]# generated cmd code
        #     self.ser.write(serial.to_bytes(data))
        #     print("Sent Abort")
        return
# print(requestCode(cmd,hostNum,accType,amount,transactionTrace,qrID,qrNum))


# // xxxx'00'AUTH71'181830210502''000026''000004''03'
# // G200'00''000031''000003''04'

# status_IM20=receivedData[28:30]
# transaction_trace_IM20=receivedData[48:54]
# batch_number_IM20=receivedData[54:60]
# host_no_IM20=receivedData[60:62]

# status_IM20=receivedData[6:8]
# transaction_trace_IM20=receivedData[8:13]
# batch_number_IM20=receivedData[13:19]
# host_no_IM20=receivedData[19:21]
