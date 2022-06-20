import serial
import time
import os.path
import csv

if not os.path.exists("log"):
    os.mkdir("log")

file_path = f"log/data_log.csv"

def main():
    while True:
        while True:
            try:
                print("checking serial port: ")
                ser = serial.Serial(port="/dev/ttyUSB1", baudrate=57600)
                # ser = serial.Serial(port="/dev/ttyUSB0", baudrate=9600)
                # ser = serial.Serial(port="/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0", baudrate=9600)
                ser.flush()
                print("Serial available")
                break

            except:
                print("com port not detected..")
                time.sleep(5)

        while True:
            try:
                if ser.inWaiting() != 0:

                    new_message = []
                    new_message = ser.read(ser.inWaiting())
                    message = ['0x{:02x}'.format(x) for x in list(new_message)]

                    print()
                    print("Write to txt")
                    print(message)
                    with open(file_path, mode='a') as csv_file:
                        csv_writer = csv.writer(csv_file, delimiter=',' ,quotechar='"', quoting=csv.QUOTE_MINIMAL)
                        csv_writer.writerow(message)
            except:
                print(f"Please Attach The Device At Port")
                break

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print("Keyboard Interrupt")