from motor import Motor
from http_service import HttpService
from current_sensor import CurrentSensor
from drop_sensor import DropSensor
from lifter_drop_sensor import LifterDropSensor
# from write_report import WriteReport
from flask import jsonify
from lifter_component import LifterComponent

import time
import RPi.GPIO as GPIO
GPIO.setmode(GPIO.BCM)            # choose BCM or BOARD
GPIO.setup(10, GPIO.IN)


class DispenseService:
    current_sensor = None
    second_current_sensor = None
    drop_sensor = None
    lifter_drop_sensor = None
    in_machine_list = []
    in_machine = 0
    tray_quantity_in_first_machine = 0
    mfirst_is_first_dispense = True
    mfirst_is_last_dispense = False
    msec_is_first_dispense = True
    msec_is_last_dispense = False
    is_first_dispense = False
    is_last_dispense = False
    main_lifter_exist = False
    sub_lifter_exist = False
    lifter_drop_sensor_flag = 0

    @classmethod
    def init_dispense_service(cls, current_sensor: CurrentSensor, drop_sensor: DropSensor,
                              second_drop_sensor: DropSensor,
                              second_current_sensor: CurrentSensor, sub_exist: bool,
                              main_lifter_exist: bool, sub_lifter_exist: bool):
        # LifterComponent.update_lifter_status()
        cls.main_lifter_exist = main_lifter_exist
        cls.sub_lifter_exist = sub_lifter_exist
        LifterComponent.step_each_row = HttpService.get_row_steps()
        cls.in_machine_list = HttpService.get_row_in_machine_list()
        for x in range(len(cls.in_machine_list)):
            if x > 0 & (cls.in_machine_list[x - 1] < cls.in_machine_list[x]):
                cls.tray_quantity_in_first_machine = x

        Motor.init_motor(sub_exist)

        cls.current_sensor = current_sensor
        # lifter in main machine exist
        if main_lifter_exist:
            cls.lifter_drop_sensor = LifterDropSensor
            home_check = LifterComponent.home_check(
                1, cls.tray_quantity_in_first_machine)
            time.sleep(0.05)
            if not home_check:
                actuator_check = LifterComponent.actuator_back(
                    1, cls.tray_quantity_in_first_machine)
                if actuator_check:
                    time.sleep(3)
                    LifterComponent.motor_back()
                    time.sleep(1)
        else:
            cls.drop_sensor = drop_sensor

        if sub_exist:
            cls.second_current_sensor = second_current_sensor
            if sub_lifter_exist:
                cls.second_lifter_drop_sensor = LifterDropSensor
                home_check = LifterComponent.home_check(
                    cls.tray_quantity_in_first_machine+1, cls.tray_quantity_in_first_machine)
                time.sleep(0.05)
                if not home_check:
                    actuator_check = LifterComponent.actuator_back(
                        cls.tray_quantity_in_first_machine+1, cls.tray_quantity_in_first_machine)
                    if actuator_check:
                        time.sleep(3)
                        LifterComponent.motor_back()
                        time.sleep(1)
            else:
                cls.second_drop_sensor = drop_sensor

    @classmethod
    def dispense_item(cls, motor_number: int, mfirst_is_first_dispense: bool, mfirst_is_last_dispense: bool,
                      msec_is_first_dispense: bool, msec_is_last_dispense: bool, is_api=False) -> str:

        motor_result = HttpService.get_motor_coordinate(motor_number)
        cls.in_machine = cls.in_machine_list[motor_result.row]

        if motor_result.status == 'error':
            return "failed to get API"
        else:
            if is_api:
                cls.is_first_dispense = True
                cls.is_last_dispense = True
                return cls.dispense_item_without_drop_sensor(row=motor_result.row, column=motor_result.column,
                                                             is_first_dispense=True, is_last_dispense=True)
            else:
                if motor_result.need_drop_sensor:
                    is_lifter_exist = HttpService.get_lifter_exist(
                        motor_result.row)
                    if not is_lifter_exist:
                        if motor_result.row <= cls.tray_quantity_in_first_machine:
                            if cls.drop_sensor.get_need_to_read_drop_sensor and DropSensor.read_drop_sensor_value(
                                    1) == 1:
                                # will return "done dropsensor", "done quarter", "fail quarter", "failAndNoContinueOrder
                                # quarter", "fail dropsensor", "failAndNoContinueOrder dropsensor"
                                return cls.dispense_item_with_drop_sensor(
                                    is_quarter_enabled=motor_result.is_quarter_enabled,
                                    is_continue_order=motor_result.continue_purchase,
                                    row=motor_result.row, column=motor_result.column,
                                    is_first_dispense=True,
                                    is_last_dispense=True)
                        else:
                            if cls.second_drop_sensor.get_need_to_read_drop_sensor and DropSensor.read_drop_sensor_value(
                                    2) == 1:
                                # will return "done dropsensor", "done quarter", "fail quarter", "failAndNoContinueOrder
                                # quarter", "fail dropsensor", "failAndNoContinueOrder dropsensor"
                                return cls.dispense_item_with_drop_sensor(
                                    is_quarter_enabled=motor_result.is_quarter_enabled,
                                    is_continue_order=motor_result.continue_purchase,
                                    row=motor_result.row, column=motor_result.column,
                                    is_first_dispense=True,
                                    is_last_dispense=True)

                    else:
                        return cls.dispense_item_with_drop_sensor(is_quarter_enabled=motor_result.is_quarter_enabled,
                                                                  is_continue_order=motor_result.continue_purchase,
                                                                  row=motor_result.row, column=motor_result.column,
                                                                  is_first_dispense=True,
                                                                  is_last_dispense=True)

                else:
                    # will return done or error
                    #   first item
                    if mfirst_is_first_dispense and msec_is_first_dispense:
                        cls.is_first_dispense = True
                        if motor_result.row < cls.tray_quantity_in_first_machine:
                            cls.mfirst_is_first_dispense = False
                        else:
                            cls.msec_is_first_dispense = False
                    else:
                        if cls.mfirst_is_first_dispense and motor_result.row < cls.tray_quantity_in_first_machine:
                            cls.is_first_dispense = True
                            cls.mfirst_is_first_dispense = False
                        elif cls.msec_is_first_dispense and motor_result.row > cls.tray_quantity_in_first_machine:
                            cls.is_first_dispense = True
                            cls.msec_is_first_dispense = False
                        else:
                            cls.is_first_dispense = False

                    if mfirst_is_last_dispense and msec_is_last_dispense:
                        cls.is_last_dispense = True
                    else:
                        cls.is_last_dispense = False
# change to below if dont want return home
#is_first_dispense=cls.is_first_dispense,
#is_last_dispense=cls.is_last_dispense)
                    return cls.dispense_item_without_drop_sensor(row=motor_result.row, column=motor_result.column,
                                                                 is_first_dispense=True,
                                                                 is_last_dispense=True  )

    @classmethod
    def dispense_item_without_drop_sensor(cls, row: int, column: int, is_first_dispense: bool,
                                          is_last_dispense: bool) -> str:
        print("dispense_item_without_drop_sensor")
        is_lifter_exist = HttpService.get_lifter_exist(row)
        if is_lifter_exist:
            if is_first_dispense:
                # print("line 151 first dispense")
                # time.sleep(2)
                home_check = LifterComponent.home_check(
                    row, cls.tray_quantity_in_first_machine)
                time.sleep(0.05)
                if not home_check:
                    actuator_check = LifterComponent.actuator_back(
                        row, cls.tray_quantity_in_first_machine)
                    if actuator_check:
                        time.sleep(3)
                        LifterComponent.motor_back()
                        
                        LifterComponent.door_lock()
                        time.sleep(1)
                        actuator_check = LifterComponent.actuator_back(
                            row, cls.tray_quantity_in_first_machine)
                        if actuator_check:
                            time.sleep(3)
                            LifterComponent.motor_forward(
                                row, cls.tray_quantity_in_first_machine)

                else:
                    actuator_check = LifterComponent.actuator_back(
                        row, cls.tray_quantity_in_first_machine)
                    if actuator_check:
                        time.sleep(3)
                        LifterComponent.motor_forward(
                            row, cls.tray_quantity_in_first_machine)
            else:
                LifterComponent.motor_forward(
                    row, cls.tray_quantity_in_first_machine)

        Motor.turn_on_motor(row, column, cls.in_machine,
                            cls.tray_quantity_in_first_machine)
        time.sleep(0.3)
        if cls.in_machine == 1:
            while cls.current_sensor.get_current_value() > cls.current_sensor.CURRENT_THRESHOLD:
                # while GPIO.input(10):
                i = 0
        elif cls.in_machine == 2:
            while cls.second_current_sensor.get_current_value() > cls.second_current_sensor.CURRENT_THRESHOLD:
                i = 0
        time.sleep(0.4)
        Motor.turn_off_motor(row, column, cls.in_machine,
                             cls.tray_quantity_in_first_machine)

        if is_last_dispense:
            is_any_lifter_exist = HttpService.get_any_lifter_exist()
            if is_any_lifter_exist:
                cls.mfirst_is_first_dispense = True
                cls.mfirst_is_last_dispense = False
                cls.msec_is_first_dispense = True
                cls.msec_is_last_dispense = False
                cls.is_first_dispense = False
                cls.is_last_dispense = False
                # time.sleep(2)
                # print("line 186 last dispense")
                time.sleep(2)
                LifterComponent.motor_back()

        return "done"

    @classmethod
    def dispense_item_with_drop_sensor(cls, is_quarter_enabled: bool, is_continue_order: bool, row: int, column: int,
                                       is_first_dispense: bool, is_last_dispense: bool):
        print("dispense_item_with_drop_sensor")

        is_lifter_exist = HttpService.get_lifter_exist(row)

        if not is_lifter_exist:
            cls.drop_sensor.reset_drop_sensor_flag()
        else:
            if is_first_dispense:
                home_check = LifterComponent.home_check(
                    row, cls.tray_quantity_in_first_machine)
                time.sleep(0.05)
                if not home_check:
                    actuator_check = LifterComponent.actuator_back(
                        row, cls.tray_quantity_in_first_machine)
                    if actuator_check:
                        time.sleep(3)
                        LifterComponent.motor_back()
                        LifterComponent.door_lock()
                        time.sleep(1)
                        actuator_check = LifterComponent.actuator_back(
                            row, cls.tray_quantity_in_first_machine)
                        if actuator_check:
                            time.sleep(3)
                            LifterComponent.motor_forward(
                                row, cls.tray_quantity_in_first_machine)
                else:
                    actuator_check = LifterComponent.actuator_back(
                        row, cls.tray_quantity_in_first_machine)
                    if actuator_check:
                        print("after actuator")
                        time.sleep(3)
                        LifterComponent.motor_forward(
                            row, cls.tray_quantity_in_first_machine)

        cls.in_machine = cls.in_machine_list[row]
        Motor.turn_on_motor(row, column, cls.in_machine,
                            cls.tray_quantity_in_first_machine)
        time.sleep(0.3)
        if cls.in_machine == 1:
            while cls.current_sensor.get_current_value() > cls.current_sensor.CURRENT_THRESHOLD:
                # while GPIO.input(10):
                i = 0
        elif cls.in_machine == 2:
            while cls.second_current_sensor.get_current_value() > cls.second_current_sensor.CURRENT_THRESHOLD:
                i = 0
        time.sleep(0.4)
        Motor.turn_off_motor(row, column, cls.in_machine,
                             cls.tray_quantity_in_first_machine)

        time.sleep(2)
        if not is_lifter_exist:
            cls.drop_sensor.set_need_to_read_drop_sensor(is_needed=0)
        else:
            cls.lifter_drop_sensor_flag = cls.lifter_drop_sensor.read_ir_value(
                which_machine=cls.in_machine)

        if is_quarter_enabled:
            if not is_lifter_exist:
                if cls.drop_sensor.get_drop_sensor_flag() == 1:
                    return "done dropsensor"
                else:
                    cls.drop_sensor.reset_drop_sensor_flag()

                    Motor.turn_on_motor(
                        row, column, cls.in_machine, cls.tray_quantity_in_first_machine)
                    time.sleep(0.5)
                    Motor.turn_off_motor(
                        row, column, cls.in_machine, cls.tray_quantity_in_first_machine)
                    time.sleep(1)
                    cls.drop_sensor.set_need_to_read_drop_sensor(is_needed=0)

                    if cls.drop_sensor.get_drop_sensor_flag() == 1:
                        return "done quarter"
                    else:
                        if is_continue_order:
                            return "fail quarter"
                        else:
                            return "failAndNoContinueOrder quarter"
            # Lifter does exist
            else:
                if cls.lifter_drop_sensor_flag == 1:
                    # print("line 247 motor back")
                    # time.sleep(2)
                    LifterComponent.motor_back()
                    return "done dropsensor"

                else:
                    time.sleep(1)

                    Motor.turn_on_motor(
                        row, column, cls.in_machine, cls.tray_quantity_in_first_machine)
                    time.sleep(0.5)
                    Motor.turn_off_motor(
                        row, column, cls.in_machine, cls.tray_quantity_in_first_machine)
                    time.sleep(1)
                    cls.lifter_drop_sensor_flag = cls.lifter_drop_sensor.read_ir_value(
                        which_machine=cls.in_machine)

                    if cls.lifter_drop_sensor_flag == 1:
                        # print("line 261 motor back")
                        # time.sleep(2)
                        LifterComponent.motor_back()
                        return "done quarter"
                    else:
                        if is_continue_order:
                            # print("line 266 motor back")
                            # time.sleep(2)
                            LifterComponent.motor_back()
                            return "fail quarter"
                        else:
                            # print("line 270 motor back")
                            # time.sleep(2)
                            LifterComponent.motor_back()
                            return "failAndNoContinueOrder quarter"
        # Lifter does exist
        # quarter disabled
        else:
            if cls.lifter_drop_sensor_flag == 1:
                # print("line 277 motor back no quart")
                # time.sleep(2)
                LifterComponent.motor_back()
                return "done dropsensor"
            else:
                if is_continue_order:
                    # print("line 282 motor back no quart")
                    # time.sleep(2)
                    LifterComponent.motor_back()
                    return "fail dropsensor"
                else:
                    # print("line 286 motor back no quart")
                    # time.sleep(2)
                    LifterComponent.motor_back()
                    return "failAndNoContinueOrder dropsensor"

    @classmethod
    def track_inspection(cls, motor_number: int):
        motor_result = HttpService.get_motor_coordinate(motor_number)
        if motor_result.status == 'error':
            return "failed to get API"
        else:
            cls.in_machine = cls.in_machine_list[motor_result.row]
            Motor.turn_on_motor(motor_result.row, motor_result.column,
                                cls.in_machine, cls.tray_quantity_in_first_machine)
            time.sleep(0.01)
            if cls.in_machine == 1:
                while cls.current_sensor.get_current_value() > cls.current_sensor.CURRENT_THRESHOLD:
                # while GPIO.input(10):
                    Motor.turn_off_motor(motor_result.row, motor_result.column,
                                         cls.in_machine, cls.tray_quantity_in_first_machine)
                    return "OK"
            elif cls.in_machine == 2:
                while cls.second_current_sensor.get_current_value() > cls.second_current_sensor.CURRENT_THRESHOLD:
                    Motor.turn_off_motor(motor_result.row, motor_result.column,
                                         cls.in_machine, cls.tray_quantity_in_first_machine)
                    return "OK"
            Motor.turn_off_motor(motor_result.row, motor_result.column,
                                 cls.in_machine, cls.tray_quantity_in_first_machine)
            return "error"

    @classmethod
    def row_motor_home(cls, row_number: int):
        cls.slot_list = HttpService.get_slot_list()
        cls.motor_quantity_in_row = cls.slot_list[row_number - 1]
        print("row motor home")
        print(cls.slot_list)
        print(row_number)

        for i in range(cls.motor_quantity_in_row):
            cls.in_machine = cls.in_machine_list[row_number - 1]
            Motor.turn_on_motor(row_number - 1, i + cls.tray_quantity_in_first_machine + 1,
                                cls.in_machine, cls.tray_quantity_in_first_machine)
            time.sleep(0.3)
            if cls.in_machine == 1:
                while cls.current_sensor.get_current_value() > cls.current_sensor.CURRENT_THRESHOLD:
                    j = 0

            elif cls.in_machine == 2:
                while cls.second_current_sensor.get_current_value() > cls.second_current_sensor.CURRENT_THRESHOLD:
                    j = 0
            time.sleep(0.4)
            Motor.turn_off_motor(row_number - 1, i + cls.tray_quantity_in_first_machine + 1,
                                 cls.in_machine, cls.tray_quantity_in_first_machine)
            i += 1
        return True

    @classmethod
    def error_motor_to_home(cls, motor_list):

        for motor_i in motor_list:
            motor_result = HttpService.get_motor_coordinate(motor_i)
            cls.in_machine = cls.in_machine_list[motor_result.row]
            Motor.turn_on_motor(motor_result.row, motor_result.column,
                                cls.in_machine, cls.tray_quantity_in_first_machine)
            time.sleep(0.3)
            if cls.in_machine == 1:
                while cls.current_sensor.get_current_value() > cls.current_sensor.CURRENT_THRESHOLD:
                    j = 0

            elif cls.in_machine == 2:
                while cls.second_current_sensor.get_current_value() > cls.second_current_sensor.CURRENT_THRESHOLD:
                    j = 0
            time.sleep(0.4)
            Motor.turn_off_motor(motor_result.row, motor_result.column,
                                 cls.in_machine, cls.tray_quantity_in_first_machine)
            time.sleep(0.5)
        return "OK"

    @staticmethod
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
