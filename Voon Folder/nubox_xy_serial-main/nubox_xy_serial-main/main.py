import time
import os
from scanner_v2 import ScannerV2
from rfid_scanner import RFIDScanner
from mdb.mdb_service import MdbService
from serial_com import SerialCom
from keyboard_input import KeyboardInput
from flask import Flask, request, jsonify
from http_service import HttpService

app = Flask(__name__)


@app.route('/setInput', methods=['POST'])
def setInput():
    request_body = request.json
    value = request_body["value"]
    print(value)
    keyboard_input.set_value(message=value)
    return jsonify(
        status="OK"
    )


@app.route('/updateBalance', methods=['POST'])
def updateBalance():
    request_body = request.json
    # RM1 = 100
    amount = request_body["amount"]
    keyboard_input.set_value("updateBalance " + str(amount))
    return jsonify(
        status="OK"
    )


@app.route('/testDropSensor', methods=['POST'])
def testDropSensor():
    keyboard_input.set_value(message="testDropSensor")

    while serial_com.get_is_checking_drop_sensor() == -1 or serial_com.get_drop_sensor_status() == -1:
        i = 0

    if serial_com.get_drop_sensor_status() == 0:
        data = "OK"
    else:
        data = "error"
    serial_com.set_is_checking_drop_sensor(is_checking_drop_sensor=1)
    return jsonify(
        status=data
    )


@app.route('/reinitNuboxPython', methods=['POST'])
def reinitNuboxPython():
    os.system("sudo systemctl restart xy_serial.service")


@app.route('/errorMotorToHome', methods=['POST'])
def errorMotorToHome():
    request_body = request.json
    motor_list = request_body["motor_list"]

    new_motor_list = []
    for motor_i in motor_list:
        motor_result = HttpService.get_motor_coordinate(motor_number=motor_i)
        new_motor_list.append(motor_result.new_motor_number)

    for i in new_motor_list:
        keyboard_input.set_value(message="trackInspection " + str(i))

        while serial_com.get_is_inspecting_track() == -1 or serial_com.get_track_status() == -1:
            i = 0

        serial_com.set_is_inspecting_track(is_inspecting_track=-1)
        serial_com.set_track_status(track_status=-1)

        time.sleep(3.5)
    return jsonify(status="OK")


@app.route('/rowMotorHome', methods=['POST'])
def rowMotorHome():
    request_body = request.json
    row_number = request_body["row_number"]  # int number

    motor_list = HttpService.get_motor_number_list(row=row_number)

    print(motor_list)

    for i in motor_list:
        keyboard_input.set_value(message="trackInspection " + str(i))

        while serial_com.get_is_inspecting_track() == -1 or serial_com.get_track_status() == -1:
            i = 0

        serial_com.set_is_inspecting_track(is_inspecting_track=-1)
        serial_com.set_track_status(track_status=-1)

        time.sleep(3.5)

    return jsonify(status=True)


@app.route('/rowMotorHomeTest', methods=['POST'])
def rowMotorHomeTest():
    request_body = request.json
    row_number = request_body["row_number"]  # int number

    motor_list = [1, 2]

    for i in motor_list:
        keyboard_input.set_value(message="trackInspection " + str(i))

        while serial_com.get_is_inspecting_track() == -1 or serial_com.get_track_status() == -1:
            i = 0

        serial_com.set_is_inspecting_track(is_inspecting_track=-1)
        serial_com.set_track_status(track_status=-1)

        time.sleep(1)

    return jsonify(status="OK")


@app.route('/getSensorValue', methods=['POST'])
def getSensorValue():
    door_list = [serial_com.get_door_status() == 0]
    temperature_list = [serial_com.get_main_temperature()]
    if serial_com.get_sub_temperature() >= 0:
        temperature_list.append(serial_com.get_sub_temperature())
    return jsonify(
        door_status=door_list,
        temperature=temperature_list
    )


@app.route('/trackInspectionTest', methods=['POST'])
def trackInspectionTest():
    request_body = request.json
    motor_number = request_body["motor_number"]  # int number

    keyboard_input.set_value(message="trackInspection " + str(motor_number))

    while serial_com.get_is_inspecting_track() == -1 or serial_com.get_track_status() == -1:
        i = 0

    if serial_com.get_track_status() == 1:
        motor_result = 'OK'
    else:
        motor_result = 'error'

    serial_com.set_is_inspecting_track(is_inspecting_track=-1)
    serial_com.set_track_status(track_status=-1)

    return jsonify(
        status=motor_result
    )


@app.route('/trackInspection', methods=['POST'])
def trackInspection():
    request_body = request.json
    motor_number = request_body["motor_number"]  # int number

    motor_result = HttpService.get_motor_coordinate(motor_number=motor_number)

    keyboard_input.set_value(
        message="trackInspection " + str(motor_result.new_motor_number))

    while serial_com.get_is_inspecting_track() == -1 or serial_com.get_track_status() == -1:
        i = 0

    if serial_com.get_track_status() == 1:
        motor_result = 'OK'
    else:
        motor_result = 'error'

    serial_com.set_is_inspecting_track(is_inspecting_track=-1)
    serial_com.set_track_status(track_status=-1)

    return jsonify(
        status=motor_result
    )


@app.route('/checkMotorStatusTest', methods=['POST'])
def checkMotorStatusTest():
    request_body = request.json
    motor_number = request_body["motor_number"]  # int number

    keyboard_input.set_value(message="checkMotorStatus " + str(motor_number))

    while serial_com.get_is_motor_checking() == -1 or serial_com.get_motor_status() == -1:
        i = 0

    if serial_com.get_motor_status() == 0:
        motor_status = 'error'
    elif serial_com.get_motor_status() == 1:
        motor_status = 'OK'
    elif serial_com.get_motor_status() == 2:
        motor_status = 'Door not close'
    elif serial_com.get_motor_status() == 3:
        motor_status = 'Item in lifter'
    elif serial_com.get_motor_status() == 4:
        motor_status = "Lifter error"
    else:
        motor_status = "error"

    serial_com.set_is_motor_checking(is_motor_checking=-1)
    serial_com.set_motor_status(motor_status=-1)

    return jsonify(
        status="OK",
        motor_status=motor_status
    )


@app.route('/checkMotorStatus', methods=['POST'])
def checkMotorStatus():
    request_body = request.json
    motor_number = request_body["motor_number"]  # int number

    motor_result = HttpService.get_motor_coordinate(motor_number=motor_number)

    keyboard_input.set_value(
        message="checkMotorStatus " + str(motor_result.new_motor_number))

    while serial_com.get_is_motor_checking() == -1 or serial_com.get_motor_status() == -1:
        i = 0

    if serial_com.get_motor_status() == 0:
        motor_status = 'error'
    elif serial_com.get_motor_status() == 1:
        motor_status = 'OK'
    elif serial_com.get_motor_status() == 2:
        motor_status = 'Door not close'
    elif serial_com.get_motor_status() == 3:
        motor_status = 'Item in lifter'
    elif serial_com.get_motor_status() == 4:
        motor_status = "Lifter error"
    else:
        motor_status = "error"

    serial_com.set_is_motor_checking(is_motor_checking=-1)
    serial_com.set_motor_status(motor_status=-1)

    return jsonify(
        status="OK",
        motor_status=motor_status
    )


@app.route('/dispenseItemTest', methods=['POST'])
def dispenseItemTest():
    request_body = request.json
    motor_number = request_body["motor_number"]  # int number
    payment_type = request_body["payment_type"]
    need_drop_sensor = request_body["need_drop_sensor"]  # 1 or 0
    need_lifter = request_body["need_lifter"]  # 1 or 0
    is_continue_purchase = request_body["is_continue_purchase"]  # 1 or 0

    keyboard_input.set_value(
        message="runSpiralMotor " + str(motor_number) + ' ' + str(need_drop_sensor) + ' ' + str(need_lifter))
    while serial_com.get_is_dispensing() == -1 or serial_com.get_dispense_status() == -1:
        i = 0

    if serial_com.get_dispense_status() == 1:
        dispense_result = 'OK'
    else:
        dispense_result = 'Fail'

    serial_com.set_is_dispensing(is_dispensing=-1)
    serial_com.set_dispense_status(dispense_status=-1)

    return jsonify(
        status="OK",
        dispense_status=dispense_result,
        payment_type=payment_type,
        is_drop_sensor_on=need_drop_sensor == 1,
        is_quarter_on=False,
        is_continue_purchase=is_continue_purchase == 1
    )


@app.route('/clearCredit', methods=['POST'])
def clearCredit():
    keyboard_input.set_value('deductBalance 0')
    while serial_com.get_is_clearing_credit() == -1:
        i = 0
    serial_com.set_is_clearing_credit(is_clearing_credit=-1)
    return jsonify(
        status="OK"
    )


@app.route('/refund', methods=['POST'])
def refund():
    keyboard_input.set_value('refund')
    if serial_com.get_current_credit() > 0.0:
        while serial_com.get_is_refunding() == -1:
            i = 0
        serial_com.set_is_refunding(is_refunding=-1)
        return jsonify(
            status="OK"
        )
    else:
        serial_com.set_is_refunding(is_refunding=-1)
        return jsonify(
            status="OK"
        )


@app.route('/dispenseItem', methods=['POST'])
def dispenseItem():
    request_body = request.json
    motor_number = request_body["motor_number"]  # int number
    payment_type = request_body["payment_type"]

    motor_result = HttpService.get_motor_coordinate(motor_number=motor_number)
    is_lifter_exist = HttpService.get_lifter_exist(motor_result.row)

    if motor_result.need_drop_sensor:
        need_drop_sensor = 1
    else:
        need_drop_sensor = 0

    if is_lifter_exist:
        need_lifter = 1
    else:
        need_lifter = 0

    keyboard_input.set_value(
        message="runSpiralMotor " + str(motor_result.new_motor_number) + ' ' + str(need_drop_sensor) + ' ' + str(
            need_lifter))
    while serial_com.get_is_dispensing() == -1 or serial_com.get_dispense_status() == -1:
        i = 0

    if serial_com.get_dispense_status() == 1:
        dispense_result = 'OK'
    else:
        dispense_result = 'Fail'

    serial_com.set_is_dispensing(is_dispensing=-1)
    serial_com.set_dispense_status(dispense_status=-1)

    return jsonify(
        status="OK",
        dispense_status=dispense_result,
        payment_type=payment_type,
        is_drop_sensor_on=motor_result.need_drop_sensor,
        is_quarter_on=motor_result.is_quarter_enabled,
        is_continue_purchase=motor_result.continue_purchase
    )


@app.route('/scanQRCode', methods=['POST'])
def scanQRCode():
    # return 0
    data = scanner.scan_qr_code()
    print(data)
    return jsonify(
        data=data
    )


@app.route('/interruptQRCode', methods=['POST'])
def interruptQRCode():
    if tng_port != "-":
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
    if rfid_port != "-":
        rfidScanner.set_should_run(0)
    return jsonify(
        status="OK"
    )


@app.route('/readLifterSetting', methods=['POST'])
def readLifterSetting():
    request_body = request.json
    # main or sub
    machine_type = request_body["machine_type"]

    keyboard_input.set_value(message="readLifterSetting " + machine_type)

    while serial_com.get_is_reading_or_setting() == -1:
        i = 0

    serial_com.set_is_reading_or_setting(is_reading_or_setting=-1)

    return jsonify(
        status="OK",
        is_lifter_enabled=serial_com.get_is_lifter_enabled() == 1,
        is_lifter_over_current_protection_enabled=serial_com.get_is_lifter_over_current_protection_enabled() == 1
    )


@app.route('/writeLifterSetting', methods=['POST'])
def writeLifterSetting():
    request_body = request.json
    # main or sub
    machine_type = request_body["machine_type"]
    # 0 = Disable, 1 = Enabled (must be string)
    lifter_enabled = request_body["lifter_enabled"]
    over_current_protection_enabled = request_body["over_current_protection_enabled"]

    keyboard_input.set_value(message="writeLifterSetting " + machine_type +
                             " " + lifter_enabled + " " + over_current_protection_enabled)

    while serial_com.get_is_reading_or_setting() == -1:
        i = 0

    serial_com.set_is_reading_or_setting(is_reading_or_setting=-1)

    return jsonify(
        status="OK",
        message=serial_com.get_is_lifter_set_success() == 1
    )


@app.route('/setLifterPosition', methods=['POST'])
def setLifterPosition():
    request_body = request.json
    # main or sub
    machine_type = request_body["machine_type"]
    # 0 - 9 must be string
    row_number = request_body["row_number"]
    # 0 - 4000 must be string
    position = request_body["position"]
    keyboard_input.set_value(
        message="setLifterPosition " + machine_type + " " + row_number + " " + position)

    while serial_com.get_is_reading_or_setting() == -1:
        i = 0

    serial_com.set_is_reading_or_setting(is_reading_or_setting=-1)

    return jsonify(
        status="OK"
    )


@app.route('/readLifterPosition', methods=['POST'])
def readLifterPosition():
    request_body = request.json
    # main or sub
    machine_type = request_body["machine_type"]
    # 0 - 9 must be string
    row_number = request_body["row_number"]
    keyboard_input.set_value(
        message="readLifterPosition " + machine_type + " " + row_number)

    while serial_com.get_is_reading_or_setting() == -1:
        i = 0

    lifter_position = serial_com.get_lifter_position()

    serial_com.set_is_reading_or_setting(is_reading_or_setting=-1)
    serial_com.set_lifter_position(lifter_position=0)

    return jsonify(
        status="OK",
        result=lifter_position
    )


@app.route('/testCashDevice', methods=['POST'])
def testCashDevice():
    keyboard_input.set_value(message="testCashDevice")

    while serial_com.get_is_reading_or_setting() == -1:
        i = 0

    serial_com.set_is_reading_or_setting(is_reading_or_setting=-1)

    return jsonify(
        status="OK",
        message=serial_com.get_cash_device_status() == 1
    )


@app.route('/testCoinDevice', methods=['POST'])
def testCoinDevice():
    keyboard_input.set_value(message="testCoinDevice")

    while serial_com.get_is_reading_or_setting() == -1:
        i = 0

    serial_com.set_is_reading_or_setting(is_reading_or_setting=-1)

    return jsonify(
        status="OK",
        message=serial_com.get_coin_device_status() == 1
    )


@app.route('/clearLifterFault', methods=['POST'])
def clearLifterFault():
    keyboard_input.set_value(message="clearLifterFault")

    while serial_com.get_is_reading_or_setting() == -1:
        i = 0

    serial_com.set_is_reading_or_setting(is_reading_or_setting=-1)

    return jsonify(
        status="OK",
        message=serial_com.get_lifter_clear_fault_status() == 1
    )


@app.route('/disableAllCashValue', methods=['POST'])
def disableAllCashValue():
    keyboard_input.set_value(message="disableAllCashValue")

    return jsonify(
        status="OK"
    )


@app.route('/setupTemperature', methods=['POST'])
def setupTemperature():
    request_body = request.json
    machine_type = request_body["machine_type"]  # main or sub
    temperature = request_body["temperature"]  # number but must be string

    keyboard_input.set_value(
        message="setTemperatureController " + machine_type + " " + temperature)

    return jsonify(
        status="OK"
    )


@app.route('/setupCustomCashValue', methods=['POST'])
def setupCustomCashValue():
    request_body = request.json
    # Must be string 1, 5, 10, 20, 50, 100
    note_value = request_body["note_value"]

    keyboard_input.set_value(message="setupCustomCashValue " + note_value)

    return jsonify(
        status="OK"
    )


@app.route('/setupCustomCashValue1', methods=['POST'])
def setupCustomCashValue1():
    keyboard_input.set_value(message="setupCustomCashValue 1")

    return jsonify(
        status="OK"
    )


@app.route('/setupCustomCashValue5', methods=['POST'])
def setupCustomCashValue5():
    keyboard_input.set_value(message="setupCustomCashValue 5")

    return jsonify(
        status="OK"
    )


@app.route('/setupCustomCashValue10', methods=['POST'])
def setupCustomCashValue10():
    keyboard_input.set_value(message="setupCustomCashValue 10")

    return jsonify(
        status="OK"
    )


@app.route('/setupCustomCashValue20', methods=['POST'])
def setupCustomCashValue20():
    keyboard_input.set_value(message="setupCustomCashValue 20")

    return jsonify(
        status="OK"
    )


@app.route('/setupCustomCashValue50', methods=['POST'])
def setupCustomCashValue50():
    keyboard_input.set_value(message="setupCustomCashValue 50")

    return jsonify(
        status="OK"
    )


@app.route('/setupCustomCashValue100', methods=['POST'])
def setupCustomCashValue100():
    keyboard_input.set_value(message="setupCustomCashValue 100")

    return jsonify(
        status="OK"
    )


# usb_port_info = HttpService.get_usb_port_info()
#
# ghl_port = "-"
# mdb_port = "-"
rfid_port = "-"
tng_port = "-"
#
# for item in usb_port_info.port_info:
#     print(item['device'])  # GHL,MDB,RFID,TNG
#     if item['device'] == "GHL Pay":
#         ghl_port = item['port']
#     elif item['device'] == "Cash and Coin":
#         mdb_port = item['port']
#     elif item['device'] == "Discount Card":
#         rfid_port = item['port']
#     elif item['device'] == "TNG Pay":
#         tng_port = item['port']
#
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

# Initialize mdb service multiprocess
# if mdb_port != "-":
#     mdb_service_process = MdbService(mdb_port, 9600)
#     if mdb_service_process.get_is_mdb_initialized():
#         # Start mdb process
#         mdb_service_process.start()

# Initialize keyboard input multiprocess
keyboard_input = KeyboardInput()
# Start serial com process
keyboard_input.start()

# Initialize serial com multiprocess
serial_com = SerialCom(keyboard_input=keyboard_input)
# Start serial com process
serial_com.start()

app.run(host='0.0.0.0', debug=False, port=9090)
