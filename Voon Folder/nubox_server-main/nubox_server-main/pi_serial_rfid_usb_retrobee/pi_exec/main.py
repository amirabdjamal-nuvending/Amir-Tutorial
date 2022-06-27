import time
import os
from drop_sensor import DropSensor
from door_sensor import DoorSensor
from scanner_v2 import ScannerV2
from rfid_scanner import RFIDScanner
from mdb.mdb_service import MdbService
from flask import Flask, request, jsonify
from http_service import HttpService
from serial_com import SerialCom

app = Flask(__name__)

is_motor_running = False


def generate_dispense_result(payment_type: str, dispense_message: str):
    if dispense_message == "done":
        return jsonify(
            dispense_status="OK",
            payment_type=payment_type,
            is_drop_sensor_on=False,
            is_quarter_on=False,
            is_continue_purchase=False
        )
    elif dispense_message == "error" or dispense_message == "fail dropsensor":
        return jsonify(
            dispense_status="error",
            payment_type=payment_type,
            is_drop_sensor_on=True,
            is_quarter_on=False,
            is_continue_purchase=True
        )
    elif dispense_message == "done dropsensor":
        return jsonify(
            dispense_status="OK",
            payment_type=payment_type,
            is_drop_sensor_on=True,
            is_quarter_on=False,
            is_continue_purchase=False
        )
    elif dispense_message == "failAndNoContinueOrder dropsensor":
        return jsonify(
            dispense_status="error",
            payment_type=payment_type,
            is_drop_sensor_on=True,
            is_quarter_on=False,
            is_continue_purchase=False
        )
    elif dispense_message == "done quarter":
        return jsonify(
            dispense_status="OK",
            payment_type=payment_type,
            is_drop_sensor_on=True,
            is_quarter_on=True,
            is_continue_purchase=False
        )
    elif dispense_message == "fail quarter":
        return jsonify(
            dispense_status="error",
            payment_type=payment_type,
            is_drop_sensor_on=True,
            is_quarter_on=True,
            is_continue_purchase=True
        )
    elif dispense_message == "failAndNoContinueOrder quarter":
        return jsonify(
            dispense_status="error",
            payment_type=payment_type,
            is_drop_sensor_on=True,
            is_quarter_on=True,
            is_continue_purchase=False
        )
    else:
        return jsonify(
            dispense_status="unknown error"
        )


@app.route('/reinitNuboxPython', methods=['POST'])
def reinitNuboxPython():
    os.system("sudo pm2 restart nubox-python-server")


@app.route('/dispenseItem', methods=['POST'])
def dispenseItem():
    request_body = request.json
    motor_number = request_body["motor_number"]
    payment_type = request_body["payment_type"]
    motor_result = HttpService.get_motor_coordinate(motor_number)

    if motor_result.status == 'error':
        return jsonify(
            status="error"
        )
    else:
        if motor_result.need_drop_sensor:
            drop_sensor_process.reset_drop_sensor_flag()

            serial_com.write_serial(
                "runSpiralMotor " + str(motor_result.row) + " " + str(motor_result.column) + "\n")
            status = serial_com.read_serial().rstrip()

            print(status)

            time.sleep(2)

            drop_sensor_process.set_need_to_read_drop_sensor(is_needed=0)

            if motor_result.is_quarter_enabled:
                if drop_sensor_process.get_drop_sensor_flag() == 1:
                    return generate_dispense_result(payment_type, "done dropsensor")
                else:
                    time.sleep(1)
                    drop_sensor_process.reset_drop_sensor_flag()

                    serial_com.write_serial(
                        "runSpiralMotorQuarter " + str(motor_result.row) + " " + str(motor_result.column) + "\n")
                    status = serial_com.read_serial().rstrip()

                    time.sleep(1)

                    drop_sensor_process.set_need_to_read_drop_sensor(
                        is_needed=0)

                    if drop_sensor_process.get_drop_sensor_flag() == 1:
                        return generate_dispense_result(payment_type, "done quarter")
                    else:
                        if motor_result.continue_purchase:
                            return generate_dispense_result(payment_type, "fail quarter")
                        else:
                            return generate_dispense_result(payment_type, "failAndNoContinueOrder quarter")
            else:
                if drop_sensor_process.get_drop_sensor_flag() == 1:
                    return generate_dispense_result(payment_type, "done dropsensor")
                else:
                    if motor_result.continue_purchase:
                        return generate_dispense_result(payment_type, "fail dropsensor")
                    else:
                        return generate_dispense_result(payment_type, "failAndNoContinueOrder dropsensor")
        else:
            serial_com.write_serial(
                "runSpiralMotor " + str(motor_result.row) + " " + str(motor_result.column) + "\n")
            status = serial_com.read_serial().rstrip()
            # will return done or error
            return generate_dispense_result(payment_type, status)


@app.route('/trackInspection', methods=['POST'])
def trackInspection():
    global is_motor_running
    is_motor_running = True
    request_body = request.json
    motor_number = request_body["motor_number"]
    motor_result = HttpService.get_motor_coordinate(motor_number)
    if motor_result.status == 'error':
        is_motor_running = False
        return jsonify(
            status="failed to get API"
        )
    else:
        serial_com.write_serial(
            "runSpiralMotor " + str(motor_result.row) + " " + str(motor_result.column) + "\n")
        # status = serial_com.read_serial().rstrip()
        # will return done or error
        is_motor_running = False
        return jsonify(
            status="OK"
        )


@app.route('/rowMotorHome', methods=['POST'])
def rowMotorHome():
    global is_motor_running
    is_motor_running = True
    print(is_motor_running)
    request_body = request.json
    row_number = request_body["row_number"]
    slot_list = HttpService.get_slot_list()
    motor_quantity_in_row = slot_list[row_number - 1]
    print(motor_quantity_in_row)

    for i in range(motor_quantity_in_row):
        print(i)
        serial_com.write_serial(
            "runSpiralMotor " + str(row_number - 1) + " " + str(i + 6) + "\n")
        print("running " + str(i))
        serial_com.read_serial().rstrip()
        print("done " + str(i))
        time.sleep(0.3)

    is_motor_running = False
    return jsonify(
        status=True
    )


@app.route('/errorMotorToHome', methods=['POST'])
def errorMotorToHome():
    global is_motor_running
    is_motor_running = True
    request_body = request.json
    motor_list = request_body["motor_list"]

    for motor_i in motor_list:
        motor_result = HttpService.get_motor_coordinate(motor_i)

        serial_com.write_serial(
            "runSpiralMotor " + str(motor_result.row) + " " + str(motor_result.column) + "\n")
        status = serial_com.read_serial().rstrip()
        time.sleep(0.3)

    is_motor_running = False
    return jsonify(
        status="OK"
    )


@app.route('/getSensorValue', methods=['POST'])
def getSensorValue():
    global is_motor_running
    print("is_motor_running")
    print(is_motor_running)
    if is_motor_running:
        print("motor running")
        return jsonify(
            door_status=door_sensor_process.read_door_sensor_value(),
            temperature=0
        )
    else:
        serial_com.write_serial("readTemp" + "\n")
        status = serial_com.read_serial().rstrip()
        print(status)
        return jsonify(
            door_status=door_sensor_process.read_door_sensor_value(),
            temperature=int(status)
        )


@app.route('/testDropSensor', methods=['POST'])
def testDropSensor():
    if DropSensor.read_drop_sensor_value(1) == 1:
        data = "OK"
    else:
        data = "error"
    return jsonify(
        status=data
    )


@app.route('/scanQRCode', methods=['POST'])
def scanQRCode():
    data = scanner.scan_qr_code()
    # scanner.set_should_run(1)
    # while scanner.get_should_run() == 1:
    #     i = 0
    # data = scanner.get_actual_response()
    print(data)
    return jsonify(
        data=data
    )


@app.route('/interruptQRCode', methods=['POST'])
def interruptQRCode():
    if tng_port != "":
        scanner.close_port()
    return jsonify(
        status="OK"
    )


@app.route('/scanRFIDCode', methods=['POST'])
def scanRFIDCode():
    rfidScanner.set_should_run(1)
    while rfidScanner.get_should_run() == 1:
        i = 0
    data = rfidScanner.get_actual_response()
    return jsonify(
        data=data
    )


@app.route('/interruptRFIDCode', methods=['POST'])
def interruptRFIDCode():
    if rfid_port != "":
        rfidScanner.set_should_run(0)
    return jsonify(
        status="OK"
    )


@app.route('/testSendSerial', methods=['POST'])
def testSendSerial():
    request_body = request.json
    message = request_body["message"]
    serial_com.write_serial(message)
    status = serial_com.read_serial()
    return jsonify(
        status=status
    )


time.sleep(10)
usb_port_info = HttpService.get_usb_port_info()
ghl_port = "-"
mdb_port = "-"
rfid_port = "-"
tng_port = "-"

for item in usb_port_info.port_info:
    print(item['device'])  # GHL,MDB,RFID,TNG
    print(item['port'])
    if item['device'] == "GHL Pay":
        ghl_port = item['port']
    elif item['device'] == "Cash and Coin":
        mdb_port = item['port']
    elif item['device'] == "Discount Card":
        rfid_port = item['port']
    elif item['device'] == "TNG Pay":
        tng_port = item['port']

if tng_port != "-":
    # Initialize scanner multiprocess
    scanner = ScannerV2(tng_port)
    # Start scanner process
    scanner.start()

if rfid_port != "-":
    # Initialize RFID scanner multiprocess
    rfidScanner = RFIDScanner(rfid_port)
    # Start scanner process
    rfidScanner.start()

# Initialize serial com multiprocess
serial_com = SerialCom()
# Start serial com process
serial_com.start()

# Initialize drop sensor multiprocess
drop_sensor_process = DropSensor(1)
# Start drop sensor process
drop_sensor_process.start()

# Initialize door sensor multiprocess
door_sensor_process = DoorSensor()
# Start door sensor process
door_sensor_process.start()

# # Initialize temperature sensor multiprocess
# temperature_sensor_process = TemperatureSensor()
# if temperature_sensor_process.get_is_sensor_initialized():
#     # Start drop sensor process
#     temperature_sensor_process.start()

# Initialize mdb service multiprocess
if mdb_port != "-":
    mdb_service_process = MdbService(mdb_port, 9600)
    if mdb_service_process.get_is_mdb_initialized():
        # Start mdb process
        mdb_service_process.start()

app.run(host='0.0.0.0', debug=False, port=9090)
