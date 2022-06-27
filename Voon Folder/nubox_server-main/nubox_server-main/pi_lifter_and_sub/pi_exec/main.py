import time
import os
from drop_sensor import DropSensor
from door_sensor import DoorSensor
from lifter_drop_sensor import LifterDropSensor
from lifter_component import LifterComponent
from scanner_v2 import ScannerV2
from rfid_scanner import RFIDScanner
from mdb.mdb_service import MdbService
from flask import Flask, request, jsonify
from http_service import HttpService
from serial_com import SerialCom

app = Flask(__name__)

is_motor_running = False
lift_motor_status = ""
lift_temp_status = ""


def request_bool_reply(_station_number):
    _status = serial_com.read_serial().rstrip()
    print(_status)
    if _status == (_station_number + "true") or _status == (_station_number + "false"):
        global lift_motor_status
        lift_motor_status = _status
        return _status
    else:
        request_bool_reply(_station_number)


def request_status_reply(_station_number):
    _status = serial_com.read_serial().rstrip()
    print(_status)
    if _status == (_station_number + "done") or _status == (_station_number + "jam") or _status == (
            _station_number + "error"):
        global lift_motor_status
        lift_motor_status = _status
        return _status
    else:
        request_status_reply(_station_number)


def request_temp_reply(_station_number):
    _status = serial_com.read_serial().rstrip()
    received_id = _status.split(" ")
    print(_status)
    if received_id[0] == _station_number:
        global lift_temp_status
        lift_temp_status = _status.replace(_station_number + " ", '')
        print("line49")
        print("lift_temp_status:" + lift_temp_status)
        return lift_temp_status
    else:
        request_temp_reply(_station_number)


def generate_dispense_result(payment_type: str, dispense_message: str):
    print("generate_dispense_result: "+dispense_message)
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
    elif dispense_message == "motorStuck":
        return jsonify(
            dispense_status="motorStuck",
            payment_type=payment_type,
            is_drop_sensor_on=False,
            is_quarter_on=False,
            is_continue_purchase=False
        )
    elif dispense_message == "motorStuckRecovered":
        return jsonify(
            dispense_status="motorStuckRecovered",
            payment_type=payment_type,
            is_drop_sensor_on=False,
            is_quarter_on=False,
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
    station_number = "0" + str(in_machine_list[motor_result.row]) + " "

    if motor_result.status == 'error':
        return jsonify(
            status="error"
        )
    else:
        global is_motor_running
        is_motor_running = True
        in_machine = in_machine_list[motor_result.row - 1]
        is_lifter_exist = HttpService.get_lifter_exist(motor_result.row)
        if is_lifter_exist:
            print("lifter move")
            #  Arduino check home first
            _home_check = LifterComponent.home_check(
                motor_result.row, in_machine_list, serial_com)
            if not _home_check:
                _actuator_check = LifterComponent.actuator_back(
                    motor_result.row, in_machine_list, serial_com)
                if _actuator_check:
                    LifterComponent.motor_back(
                        motor_result.row, in_machine_list, serial_com)
                    LifterComponent.door_lock(
                        in_machine_list[motor_result.row], serial_com)
                    time.sleep(1)
                    print("abnormal homing done")

            #  Arduino pre-dispense step
            _actuator_check = LifterComponent.actuator_back(
                motor_result.row, in_machine_list, serial_com)
            if _actuator_check:
                is_lifter_ok = LifterComponent.motor_forward(
                    motor_result.row, in_machine_list, serial_com, tray_quantity_in_machine_list)
                if not is_lifter_ok:
                    time.sleep(1)
                    is_flow_success = LifterComponent.motor_back(
                        motor_result.row, in_machine_list, serial_com)
                    if not is_flow_success:
                        return generate_dispense_result(payment_type, "motorStuck")
                    return generate_dispense_result(payment_type, "motorStuckRecovered")

        if motor_result.need_drop_sensor:
            if not is_lifter_exist:
                dropSensorList[in_machine].reset_drop_sensor_flag()

            serial_com.write_serial(
                station_number + "runSpiralMotor " + str(motor_result.row) + " " + str(motor_result.column) + "\n")

            status = request_status_reply(station_number)

            print(lift_motor_status)

            if not is_lifter_exist:
                time.sleep(2)
                dropSensorList[in_machine].set_need_to_read_drop_sensor(
                    is_needed=0)

            if motor_result.is_quarter_enabled:
                if not is_lifter_exist:
                    drop_sensor_check = dropSensorList[in_machine].get_drop_sensor_flag(
                    ) == 1
                else:
                    print("check lifter drop status")
                    drop_sensor_check = LifterDropSensor.read_ir_value(
                        which_machine=in_machine) == 1

                if drop_sensor_check:
                    if is_lifter_exist:
                        is_flow_success = LifterComponent.motor_back(
                            motor_result.row, in_machine_list, serial_com)
                        if not is_flow_success:
                            return generate_dispense_result(payment_type, "motorStuck")
                    is_motor_running = False
                    return generate_dispense_result(payment_type, "done dropsensor")
                else:
                    time.sleep(1)
                    if not is_lifter_exist:
                        dropSensorList[in_machine].reset_drop_sensor_flag()

                    serial_com.write_serial(
                        station_number + "runSpiralMotorQuarter " + str(motor_result.row) + " " + str(
                            motor_result.column) + "\n")
                    status = serial_com.read_serial().rstrip()
                    print(lift_motor_status)

                    time.sleep(1)
                    if not is_lifter_exist:
                        dropSensorList[in_machine].set_need_to_read_drop_sensor(
                            is_needed=0)
                        drop_sensor_check = dropSensorList[in_machine].get_drop_sensor_flag(
                        ) == 1
                    else:
                        print("check lifter drop status")
                        drop_sensor_check = LifterDropSensor.read_ir_value(
                            which_machine=in_machine) == 1

                    if drop_sensor_check:
                        if is_lifter_exist:
                            is_flow_success = LifterComponent.motor_back(
                                motor_result.row, in_machine_list, serial_com)
                            if not is_flow_success:
                                return generate_dispense_result(payment_type, "motorStuck")
                        is_motor_running = False
                        return generate_dispense_result(payment_type, "done quarter")
                    else:
                        if motor_result.continue_purchase:
                            if is_lifter_exist:
                                is_flow_success = LifterComponent.motor_back(motor_result.row, in_machine_list,
                                                                             serial_com)
                                if not is_flow_success:
                                    return generate_dispense_result(payment_type, "motorStuck")
                            is_motor_running = False
                            return generate_dispense_result(payment_type, "fail quarter")
                        else:
                            if is_lifter_exist:
                                is_flow_success = LifterComponent.motor_back(motor_result.row, in_machine_list,
                                                                             serial_com)
                                if not is_flow_success:
                                    return generate_dispense_result(payment_type, "motorStuck")
                            is_motor_running = False
                            return generate_dispense_result(payment_type, "failAndNoContinueOrder quarter")

            else:
                if not is_lifter_exist:
                    drop_sensor_check = dropSensorList[in_machine].get_drop_sensor_flag(
                    ) == 1
                else:
                    print("check lifter drop status")
                    drop_sensor_check = LifterDropSensor.read_ir_value(
                        which_machine=in_machine) == 1

                if drop_sensor_check:
                    if is_lifter_exist:
                        is_flow_success = LifterComponent.motor_back(
                            motor_result.row, in_machine_list, serial_com)
                        if not is_flow_success:
                            return generate_dispense_result(payment_type, "motorStuck")
                    is_motor_running = False
                    return generate_dispense_result(payment_type, "done dropsensor")
                else:
                    if motor_result.continue_purchase:
                        if is_lifter_exist:
                            is_flow_success = LifterComponent.motor_back(
                                motor_result.row, in_machine_list, serial_com)
                            if not is_flow_success:
                                return generate_dispense_result(payment_type, "motorStuck")
                        is_motor_running = False
                        return generate_dispense_result(payment_type, "fail dropsensor")
                    else:
                        if is_lifter_exist:
                            is_flow_success = LifterComponent.motor_back(
                                motor_result.row, in_machine_list, serial_com)
                            if not is_flow_success:
                                return generate_dispense_result(payment_type, "motorStuck")
                        is_motor_running = False
                        return generate_dispense_result(payment_type, "failAndNoContinueOrder dropsensor")

        else:
            serial_com.write_serial(
                station_number + "runSpiralMotor " + str(motor_result.row) + " " + str(motor_result.column) + "\n")
            status = serial_com.read_serial().rstrip()
            print(lift_motor_status)
            if is_lifter_exist:
                # lifter back home
                is_flow_success = LifterComponent.motor_back(
                    motor_result.row, in_machine_list, serial_com)
                if not is_flow_success:
                    return generate_dispense_result(payment_type, "motorStuck")
                # if motor stuck status become error
            # will return done or error
            is_motor_running = False
            return generate_dispense_result(payment_type, "done")


@app.route('/trackInspection', methods=['POST'])
# todo jwei check trackInspection work in submachine
def trackInspection():
    row_quantity_in_previous_machine = 0
    global is_motor_running
    is_motor_running = True
    request_body = request.json
    motor_number = request_body["motor_number"]
    motor_result = HttpService.get_motor_coordinate(motor_number)
    station_number = "0" + str(in_machine_list[motor_result.row]) + " "

    if motor_result.status == 'error':
        is_motor_running = False
        return jsonify(
            status="failed to get API"
        )
    else:
        if in_machine_list[motor_result.row] > 1:
            j = 1
            for _item in tray_quantity_in_machine_list:
                if j < in_machine_list[motor_result.row]:
                    row_quantity_in_previous_machine += _item
                j += 1
        serial_com.write_serial(station_number + "trackInspectionMotor " + str(
            motor_result.row - row_quantity_in_previous_machine) + " " + str(motor_result.column) + "\n")
        status = serial_com.read_serial().rstrip()
        # will return done or error
        is_motor_running = False
        if status == "done":
            return jsonify(
                status="OK"
            )
        else:
            return jsonify(
                status="error"
            )


@app.route('/rowMotorHome', methods=['POST'])
# todo jwei check rowMotorHome work in submachine
def rowMotorHome():
    global is_motor_running
    is_motor_running = True
    print(is_motor_running)
    request_body = request.json
    row_number = request_body["row_number"]
    slot_list = HttpService.get_slot_list()
    motor_quantity_in_row = slot_list[row_number - 1]
    print(motor_quantity_in_row)
    row_quantity_in_previous_machine = 0
    station_number = "0" + str(in_machine_list[row_number - 1]) + " "

    if in_machine_list[row_number] > 1:
        j = 1
        for _item in tray_quantity_in_machine_list:
            if j < in_machine_list[row_number]:
                row_quantity_in_previous_machine += _item
            j += 1

    for i in range(motor_quantity_in_row):
        print(i)
        serial_com.write_serial(
            station_number + "runSpiralMotor " + str(row_number - 1 - row_quantity_in_previous_machine) + " " + str(
                i + 6) + "\n")
        print("running " + str(i))
        serial_com.read_serial().rstrip()
        print("done " + str(i))
        time.sleep(0.3)

    is_motor_running = False
    return jsonify(
        status=True
    )


@app.route('/errorMotorToHome', methods=['POST'])
# todo jwei check errorMotorToHome work in submachine
def errorMotorToHome():
    global is_motor_running
    is_motor_running = True
    request_body = request.json
    motor_list = request_body["motor_list"]
    row_quantity_in_previous_machine = 0

    for motor_i in motor_list:
        motor_result = HttpService.get_motor_coordinate(motor_i)
        station_number = "0" + str(in_machine_list[motor_result.row]) + " "

        if in_machine_list[motor_result.row] > 1:
            j = 1
            for _item in tray_quantity_in_machine_list:
                if j < in_machine_list[motor_result.row]:
                    row_quantity_in_previous_machine += _item
                j += 1

        serial_com.write_serial(
            station_number + "runSpiralMotor " + str(motor_result.row - row_quantity_in_previous_machine) + " " + str(
                motor_result.column) + "\n")
        status = serial_com.read_serial().rstrip()
        row_quantity_in_previous_machine = 0
        time.sleep(0.3)

    is_motor_running = False
    return jsonify(
        status="OK"
    )


@app.route('/testLifterStep', methods=['POST'])
def testLifterStep():
    global is_motor_running
    is_motor_running = True
    request_body = request.json
    _which_lifter = request_body["which_lifter"]
    step_number = request_body["step_number"]
    result = LifterComponent.test_step(
        which_lifter=_which_lifter, step_number=step_number, serial_com=serial_com)
    is_motor_running = False
    return jsonify(
        result=result
    )


@app.route('/testLifterBackToHome', methods=['POST'])
def testLifterBackToHome():
    request_body = request.json
    _which_lifter = request_body["which_lifter"]
    result = LifterComponent.testLifterBackToHome(
        which_lifter=_which_lifter, serial_com=serial_com)
    return jsonify(
        result=result
    )


@app.route('/getSensorValue', methods=['POST'])
def getSensorValue():
    tray_quantity_in_machine_list

    global is_device_initializing
    global is_motor_running
    if not is_device_initializing:
        if is_motor_running:
            print("motor running")
            temp_sensor_list = []
            door_sensor_list = []
            for item in tray_quantity_in_machine_list:
                door_sensor_list.append(
                    door_sensor_process.read_door_sensor_value())
                temp_sensor_list.append(0)
            return jsonify(
                door_status=door_sensor_list,
                temperature=temp_sensor_list
            )
        else:
            _id = 1
            temp_sensor_list = []
            door_sensor_list = []
            for item in tray_quantity_in_machine_list:
                station_number = "0" + str(_id) + " "

                print("temp requesting...")
                serial_com.write_serial(
                    station_number + " " + "readTemp" + "\n")
                actual_temp = request_temp_reply(station_number)
                print("temp signal:" + str(lift_temp_status))

                temp_sensor_list.append(int(lift_temp_status))
                door_sensor_list.append(
                    door_sensor_process.read_door_sensor_value())
                _id += 1
            return jsonify(
                door_status=door_sensor_list,
                temperature=temp_sensor_list
            )
    else:
        temp_sensor_list = []
        door_sensor_list = []
        for item in tray_quantity_in_machine_list:
            door_sensor_list.append(
                door_sensor_process.read_door_sensor_value())
            temp_sensor_list.append(0)
        return jsonify(
            door_status=door_sensor_list,
            temperature=temp_sensor_list
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
    # return 0
    data = scanner.scan_qr_code()
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
    if rfid_port != "-":
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


@app.route('/pickUpSlotCheck', methods=['POST'])
def pickUpSlotCheck():
    print("pickUpSlotCheck")
    print(lifter_enable_list)
    _which_lifter = 0
    for _enable in lifter_enable_list:
        if _enable == 1:
            # got lifter
            global is_motor_running
            is_motor_running = True
            result = LifterDropSensor.read_ir_value(
                which_machine=_which_lifter + 1) == 1
            print("486" + str(result))
            # got item in pick up slot
            if result:
                print("door unlocking...")
                LifterComponent.door_unlock(_which_lifter + 1, serial_com)
                return jsonify(
                    status='OK',
                    result=True
                )
            else:
                inductor_check = LifterComponent.inductor_check(
                    _which_lifter + 1, serial_com)
                if inductor_check:
                    print("door locking...")
                    LifterComponent.door_lock(_which_lifter + 1, serial_com)
                else:
                    return jsonify(
                        status='OK',
                        result=True
                    )
        _which_lifter += 1
    is_motor_running = False

    return jsonify(
        status='OK',
        result=False
    )


@app.route('/getLifterStatus', methods=['POST'])
def getLifterStatus():
    return jsonify(
        status=lifter_status
    )


global is_device_initializing
is_device_initializing = True

# Initialize serial com multiprocess
serial_com = SerialCom()
# Start serial com process
serial_com.start()

# Check if sub machine exist
time.sleep(50)
in_machine_list = HttpService.get_row_in_machine_list()
usb_port_info = HttpService.get_usb_port_info()
LifterComponent.step_each_row = HttpService.get_row_steps()
lifter_enable_list = HttpService.get_lifter_enable()


ghl_port = "-"
mdb_port = "-"
rfid_port = "-"
tng_port = "-"
global tray_quantity_in_machine_list
tray_quantity_in_machine_list = []
machine_number = 1
print("total in_machine_list quantity: " + str(in_machine_list))

number_in_current_machine = 0
for x in range(len(in_machine_list)):
    number_in_current_machine += 1
    if in_machine_list[x] > machine_number or (x == (len(in_machine_list) - 1)):
        tray_quantity_in_machine_list.append(number_in_current_machine)
        machine_number += 1
        number_in_current_machine = 0

print("total tray quantity: " + str(len(in_machine_list)))
print("tray_quantity_in_machine_list: " + str(tray_quantity_in_machine_list))

for item in usb_port_info.port_info:
    print(item['device'])  # GHL,MDB,RFID,TNG
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

dropSensorList = ["first_drop_process", "second_drop_process", "third_drop_process", "fourth_drop_process",
                  "fifth_drop_process"]
which_lifter = 0

lifter_status = True
# time.sleep(10)
print("home_checking.....")
for enable in lifter_enable_list:
    if enable == 1:
        # got lifter
        LifterDropSensor.initLifterDropSensor(which_machine=which_lifter + 1)

        home_check = LifterComponent.home_check(
            which_lifter + 1, in_machine_list, serial_com)
        if not home_check:
            actuator_check = LifterComponent.actuator_back(
                which_lifter + 1, in_machine_list, serial_com)
            if actuator_check:
                time.sleep(3)
                lifter_status = LifterComponent.motor_back(
                    which_lifter + 1, in_machine_list, serial_com)
                # Todo jwei if motor stuck here app shows error dialog
                time.sleep(1)

    else:
        # Initialize drop sensor multiprocess
        dropSensorList[which_lifter] = DropSensor(which_lifter + 1)
        # Start drop sensor process
        dropSensorList[which_lifter].start()
    which_lifter += 1

# Initialize door sensor multiprocess
door_sensor_process = DoorSensor()
# Start drop sensor process
door_sensor_process.start()

# # Initialize mdb service multiprocess
if mdb_port != "-":
    mdb_service_process = MdbService(mdb_port, 9600)
    if mdb_service_process.get_is_mdb_initialized():
        #     Start mdb process
        mdb_service_process.start()

is_device_initializing = False

app.run(host='0.0.0.0', debug=False, port=9090)
