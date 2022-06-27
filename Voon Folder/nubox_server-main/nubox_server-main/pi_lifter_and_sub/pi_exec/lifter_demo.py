import time
from serial_com import SerialCom

serial_com = SerialCom()
# Start serial com process
serial_com.start()
lift_motor_status = ""


def request_bool_reply(_station_number):
    _status = serial_com.read_serial().rstrip()
    print("line12")
    
    if _status == (station_number + "true") or _status == (station_number + "false"):
        print("line15")
        print(_status)
        global lift_motor_status
        lift_motor_status = _status
        return _status
    else:
        print("line18")
        request_bool_reply(_station_number)


def request_status_reply(_station_number):
    _status = serial_com.read_serial().rstrip()
    if _status == (station_number + "done") or _status == (station_number + "jam") or _status == (station_number + "error"):
        print("line26")
        print(_status)
        global lift_motor_status
        lift_motor_status = _status
        return _status
    else:
        print("line29")
        print(_status)
        request_status_reply(_station_number)



while True:
    station_number = "0" + str(1) + " "
    # station_number = ""
    status="zzz"
    query = input("insert command: ")
    # lifter motor
    if query == "motorgo":
        distance = int(input())
        serial_com.write_serial(station_number + "moveLifterMotor F " + str(distance) + "\n")
        status = request_status_reply(station_number)
        print(lift_motor_status)

    elif query == "motorback":
        distance = int(input())
        serial_com.write_serial(station_number + "moveLifterMotor B " + str(distance) + "\n")
        status = request_status_reply(station_number)
        print(lift_motor_status)

    elif query == "motorHome":
        print("motor main back")
        print("row " + str(1))
        print("tray_in_machine " + str(1))
        serial_com.write_serial(station_number + "moveLifterMotor H\n")
        status = request_status_reply(station_number)
        print(lift_motor_status)
    # door
    elif query == "unlockTheDoor":
        print("door_unlocking...")
        print("tray_in_machine " + str(1))
        serial_com.write_serial(station_number + "unlockTheDoor" + "\n")
        status = request_status_reply(station_number)
        print(lift_motor_status)
    elif query == "doorlock":
        print("door_locking...")
        print("tray_in_machine " + str(1))
        serial_com.write_serial(station_number + "lockTheDoor" + "\n")
        status = request_status_reply(station_number)
        print("line65")
        print(lift_motor_status)
    # inductor
    elif query == "inductor":
        print("inductor_checking...")
        serial_com.write_serial(station_number + "getInductiveSensor" + "\n")
        status = request_bool_reply(station_number)
        print("line71")
        print(lift_motor_status)
    elif query == "actBack":
        serial_com.write_serial(station_number + "openActuator" + "\n")
        status = request_status_reply(station_number)
        print(lift_motor_status)
    elif query == "actGo":
        serial_com.write_serial(station_number + "closeActuator" + "\n")
        status = request_status_reply(station_number)
        print(lift_motor_status)
    elif query == "getLimitSensor":
        print("home_checking...")
        print("row " + str(1))
        print("tray_in_machine " + str(1))
        serial_com.write_serial(station_number + "getLimitSensor" + "\n")
        status = request_bool_reply(station_number)
        print(lift_motor_status)

    elif query == "go":
        serial_com.write_serial(station_number + "runSpiralMotor " + str(0) + " " + str(6) + "\n")
        status = request_status_reply(station_number)
        print("line99")
        print(lift_motor_status)
    elif query == "quarter":
        serial_com.write_serial(station_number + "runSpiralMotorQuarter " + str(0) + " " + str(6) + "\n")
        status = request_status_reply(station_number)
        print("line99")
        print(lift_motor_status)
    elif query == "trackIns":
        serial_com.write_serial(station_number + "trackInspectionMotor " + str(0) + " " + str(7) + "\n")
        status = request_status_reply(station_number)
        print("line99")
        print(lift_motor_status)    
    elif query == "s":
        serial_com.write_serial(station_number + "stopLifter" + "\n")
