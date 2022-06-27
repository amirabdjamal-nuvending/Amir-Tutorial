import serial
import multiprocessing
from keyboard_input import KeyboardInput
from constant import Constant
from http_service import HttpService
import os
import time


class SerialCom(multiprocessing.Process):
    signal = 20

    def __init__(self, keyboard_input: KeyboardInput):
        try:
            multiprocessing.Process.__init__(self)

            self.is_initial = True

            self.trigger_new_message = False
            self.is_command_receive = True
            self.new_message = []
            self.byte_length = 9999

            self.keyboard_input = keyboard_input

            self.manager = multiprocessing.Manager()

            # self.serial_device = serial.Serial(
            #     port='/dev/serial/by-id/usb-Prolific_Technology_Inc._USB-Serial_Controller_D-if00-port0', baudrate=57600, timeout=20)
            self.serial_device = serial.Serial(
                port='/dev/serial/by-id/usb-Prolific_Technology_Inc._USB-Serial_Controller-if00-port0', baudrate=57600, timeout=20)

            self.serial_device.flushInput()
            self.serial_device.flushOutput()
            self.serial_device.flush()

            self.is_first_read = True

            # Dispense Parameters
            # -1 Floating, 0 = Not dispensing, 1 = Dispensing
            self.is_dispensing = self.manager.Value('i', -1)
            self.dispense_status = self.manager.Value(
                'i', -1)  # -1 = Floating, 0 = Fail, 1 = Success

            # Motor checking Parameters
            # -1 Floating, 0 = Checked, 1 = Checking
            self.is_motor_checking = self.manager.Value('i', -1)
            # -1 Floating, 0 = Error, 1 = OK, 2 = Door not close, 3 = Item in Lifter, 4 = Lifter error
            self.motor_status = self.manager.Value('i', -1)

            # Track Inspection Parameters
            # -1 Floating, 0 = Not checking, 1 = Checking
            self.is_inspecting_track = self.manager.Value('i', -1)
            # -1 = Floating, 0 = Fail, 1 = Success
            self.track_status = self.manager.Value('i', -1)

            # Sensor parameters
            self.door_status = self.manager.Value(
                'i', 1)  # 1 = Open, 0 = Closed
            self.main_temperature = self.manager.Value('i', 0)
            self.sub_temperature = self.manager.Value(
                'i', -1)  # -1 = Not exist

            # Drop sensor test parameters
            self.is_checking_drop_sensor = self.manager.Value(
                'i', -1)  # -1 Floating, 0 = Not checking, 1 = Checking
            self.drop_sensor_status = self.manager.Value(
                'i', -1)  # -1 = Floating, 0 = Fail, 1 = Success

            # Cash coin parameters
            # -1 Floating, 0 = Not refunding, 1 = Refunding
            self.is_refunding = self.manager.Value('i', -1)
            # self.current_credit_greater_than_zero = self.manager.Value('i', 0)  # 0 = False, 1 = True
            self.current_credit = self.manager.Value('float', 0.0)

            # 吞币 parameters
            # -1 Floating, 0 = Done clearing, 1 = Clearing
            self.is_clearing_credit = self.manager.Value('i', -1)

            # -1 Floating, 0 = Done reading or setting
            self.is_reading_or_setting = self.manager.Value('i', -1)

            # Lifter parameters
            # 0 = Disable, 1 = Enable
            self.is_lifter_enabled = self.manager.Value('i', 0)
            self.is_lifter_over_current_protection_enabled = self.manager.Value(
                'i', 0)
            # 0 = Fail, 1 = Success
            self.is_lifter_set_success = self.manager.Value('i', 0)
            self.lifter_position = self.manager.Value('i', 0)

            # 0 = Fail, 1 = Success
            self.coin_device_status = self.manager.Value('i', 0)
            self.cash_device_status = self.manager.Value('i', 0)
            self.lifter_clear_fault_status = self.manager.Value('i', 0)
        except Exception as e:
            print(e)
            #os.system("sudo reboot")

    def set_lifter_position(self, lifter_position: int):
        self.lifter_position.value = lifter_position

    def get_lifter_position(self):
        return self.lifter_position.value

    def set_lifter_clear_fault_status(self, lifter_clear_fault_status: int):
        self.lifter_clear_fault_status.value = lifter_clear_fault_status

    def get_lifter_clear_fault_status(self):
        return self.lifter_clear_fault_status.value

    def set_cash_device_status(self, cash_device_status: int):
        self.cash_device_status.value = cash_device_status

    def get_cash_device_status(self):
        return self.cash_device_status.value

    def set_coin_device_status(self, coin_device_status: int):
        self.coin_device_status.value = coin_device_status

    def get_coin_device_status(self):
        return self.coin_device_status.value

    def set_is_lifter_set_success(self, is_lifter_set_success: int):
        self.is_lifter_set_success.value = is_lifter_set_success

    def get_is_lifter_set_success(self):
        return self.is_lifter_set_success.value

    def set_is_lifter_enabled(self, is_lifter_enabled: int):
        self.is_lifter_enabled.value = is_lifter_enabled

    def get_is_lifter_enabled(self):
        return self.is_lifter_enabled.value

    def set_is_lifter_over_current_protection_enabled(self, is_lifter_over_current_protection_enabled: int):
        self.is_lifter_over_current_protection_enabled.value = is_lifter_over_current_protection_enabled

    def get_is_lifter_over_current_protection_enabled(self):
        return self.is_lifter_over_current_protection_enabled.value

    def set_is_reading_or_setting(self, is_reading_or_setting: int):
        self.is_reading_or_setting.value = is_reading_or_setting

    def get_is_reading_or_setting(self):
        return self.is_reading_or_setting.value

    def set_is_clearing_credit(self, is_clearing_credit: int):
        self.is_clearing_credit.value = is_clearing_credit

    def get_is_clearing_credit(self):
        return self.is_clearing_credit.value

    def set_current_credit(self, current_credit: float):
        self.current_credit.value = current_credit

    def get_current_credit(self):
        return self.current_credit.value

    def set_is_refunding(self, is_refunding: int):
        self.is_refunding.value = is_refunding

    def get_is_refunding(self):
        return self.is_refunding.value

    def set_is_motor_checking(self, is_motor_checking: int):
        self.is_motor_checking.value = is_motor_checking

    def get_is_motor_checking(self):
        return self.is_motor_checking.value

    def set_motor_status(self, motor_status: int):
        self.motor_status.value = motor_status

    def get_motor_status(self):
        return self.motor_status.value

    def set_dispense_status(self, dispense_status: int):
        self.dispense_status.value = dispense_status

    def get_dispense_status(self):
        return self.dispense_status.value

    def set_is_dispensing(self, is_dispensing: int):
        self.is_dispensing.value = is_dispensing

    def get_is_dispensing(self):
        return self.is_dispensing.value

    def set_is_inspecting_track(self, is_inspecting_track: int):
        self.is_inspecting_track.value = is_inspecting_track

    def get_is_inspecting_track(self):
        return self.is_inspecting_track.value

    def set_track_status(self, track_status: int):
        self.track_status.value = track_status

    def get_track_status(self):
        return self.track_status.value

    def set_door_status(self, door_status: int):
        self.door_status.value = door_status

    def get_door_status(self):
        return self.door_status.value

    def set_main_temperature(self, temperature: int):
        self.main_temperature.value = temperature

    def get_main_temperature(self):
        return self.main_temperature.value

    def set_sub_temperature(self, temperature: int):
        self.sub_temperature.value = temperature

    def get_sub_temperature(self):
        return self.sub_temperature.value

    def set_is_checking_drop_sensor(self, is_checking_drop_sensor: int):
        self.is_checking_drop_sensor.value = is_checking_drop_sensor

    def get_is_checking_drop_sensor(self):
        return self.is_checking_drop_sensor.value

    def set_drop_sensor_status(self, drop_sensor_status: int):
        self.drop_sensor_status.value = drop_sensor_status

    def get_drop_sensor_status(self):
        return self.drop_sensor_status.value

    def write_to_VMC(self):
        if self.keyboard_input.get_value() == '' and not self.is_command_receive:
            print("Send ACK")
            self.serial_device.write(Constant.ACK)
        else:
            keyboard_value = self.keyboard_input.get_value().split(' ')
            if keyboard_value[0] == 'checkMotorStatus':
                # checkMotorStatus 12
                motor_number = int(keyboard_value[1])
                print("Send Command")
                content = bytearray()

                content.extend(bytearray(motor_number.to_bytes(2, 'big')))

                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.MOTOR_CHECK_STATUS_COMMAND,
                                                          length=Constant.MOTOR_CHECK_STATUS_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'runSpiralMotor':
                # runSpiralMotor 12 0 0
                motor_number = int(keyboard_value[1])
                need_drop_sensor = int(keyboard_value[2])
                need_lifter = int(keyboard_value[3])
                print("Send Command")
                content = bytearray()

                if need_drop_sensor == 1:
                    content.extend(Constant.CONTROL_MOTOR_NEED_DROP_SENSOR)
                else:
                    content.extend(Constant.CONTROL_MOTOR_NO_NEED_DROP_SENSOR)

                if need_lifter == 1:
                    content.extend(Constant.CONTROL_MOTOR_NEED_LIFTER)
                else:
                    content.extend(Constant.CONTROL_MOTOR_NO_NEED_LIFTER)

                content.extend(bytearray(motor_number.to_bytes(2, 'big')))

                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.CONTROL_MOTOR_COMMAND,
                                                          length=Constant.CONTROL_MOTOR_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'trackInspection':
                # trackInspection 12
                motor_number = int(keyboard_value[1])
                print("Send Command")
                content = bytearray()
                content.extend(Constant.TRACK_INSPECTION_SETTING_COMMAND)
                content.extend(Constant.TRACK_INSPECTION_SETTING_MOTOR_ROTATE)
                content.extend(bytearray(motor_number.to_bytes(2, 'big')))
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.TRACK_INSPECTION_SETTING_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'testDropSensor':
                print("Send Command")
                content = bytearray()
                content.extend(Constant.DROP_SENSOR_TEST_SETTING_COMMAND)
                content.extend(Constant.DROP_SENSOR_TEST_MAIN_MACHINE)
                content.extend(Constant.DROP_SENSOR_TEST_AUTO_MODE)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.DROP_SENSOR_TEST_SETTING_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'testCashDevice':
                print("Send Command")
                content = bytearray()
                content.extend(Constant.CASH_DEVICE_TEST_SETTING_COMMAND)
                content.extend(Constant.CASH_DEVICE_TEST_SETTING_PARAMETER)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.CASH_DEVICE_TEST_SETTING_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'testCoinDevice':
                print("Send Command")
                content = bytearray()
                content.extend(Constant.COIN_DEVICE_TEST_SETTING_COMMAND)
                content.extend(Constant.COIN_DEVICE_TEST_SETTING_PARAMETER)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.COIN_DEVICE_TEST_SETTING_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'setupCoin':
                print("Send Command")
                content = bytearray()
                content.extend(Constant.CASH_COIN_SET_NOTE_ACCEPTANCE_COMMAND)
                content.extend(
                    Constant.CASH_COIN_SET_NOTE_ACCEPTANCE_PARAMETER)
                content.extend(bytearray(b'\xFF'))
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.CASH_COIN_SET_NOTE_ACCEPTANCE_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'setupCustomCashValue':
                cash_value = int(keyboard_value[1])
                print("Send Command")
                content = bytearray()
                content.extend(Constant.CASH_COIN_SET_NOTE_ACCEPTANCE_COMMAND)
                content.extend(
                    Constant.CASH_COIN_SET_NOTE_ACCEPTANCE_PARAMETER)
                content.extend(bytearray(cash_value.to_bytes(1, 'big')))
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.CASH_COIN_SET_NOTE_ACCEPTANCE_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'disableAllCashValue':
                print("Send Command")
                value = 0
                content = bytearray()
                content.extend(Constant.CASH_COIN_SET_NOTE_ACCEPTANCE_COMMAND)
                content.extend(
                    Constant.CASH_COIN_SET_NOTE_ACCEPTANCE_PARAMETER)
                content.extend(bytearray(value.to_bytes(1, 'big')))
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.CASH_COIN_SET_NOTE_ACCEPTANCE_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'setupCash':
                print("Send Command")
                content = bytearray()
                content.extend(Constant.CASH_DEVICE_SETUP_MODE)
                content.extend(Constant.CASH_COIN_DEVICE_ACCEPT_ALL)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.CASH_COIN_DEVICE_SETUP_COMMAND,
                                                          length=Constant.CASH_COIN_DEVICE_SETUP_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'readCoinType':
                # readCoinType
                print("Send Command")
                content = bytearray()
                content.extend(Constant.COIN_CONFIGURATION_COMMAND)
                content.extend(Constant.COIN_CONFIGURATION_READ_PARAMETER)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.COIN_CONFIGURATION_READ_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'setupCoinType':
                # setupCoinType coin
                coinType = keyboard_value[1]
                print("Send Command")
                content = bytearray()
                content.extend(Constant.COIN_CONFIGURATION_COMMAND)
                content.extend(Constant.COIN_CONFIGURATION_SET_PARAMETER)
                if coinType == 'coin':
                    content.extend(Constant.COIN_MACHINE_TYPE_NRI)
                else:
                    content.extend(Constant.COIN_MACHINE_TYPE_HOPPER)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.COIN_CONFIGURATION_SET_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'readCashMode':
                # readCashMode
                print("Send Command")
                content = bytearray()
                content.extend(
                    Constant.CASH_RECEIVE_MODE_CONFIGURATION_COMMAND)
                content.extend(
                    Constant.CASH_RECEIVE_MODE_CONFIGURATION_READ_PARAMETER)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.CASH_RECEIVE_MODE_CONFIGURATION_READ_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'setupCashMode':
                print("Send Command")
                content = bytearray()
                content.extend(
                    Constant.CASH_RECEIVE_MODE_CONFIGURATION_COMMAND)
                content.extend(
                    Constant.CASH_RECEIVE_MODE_CONFIGURATION_SET_PARAMETER)
                content.extend(Constant.CASH_RECEIVE_MODE_TYPE_ALWAYS_RECEIVE)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.CASH_RECEIVE_MODE_CONFIGURATION_SET_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'readLifterPosition':
                machine = keyboard_value[1]  # main or sub
                row_number = int(keyboard_value[2])  # 0 - 9
                print("Send Command")
                content = bytearray()
                content.extend(Constant.LIFTER_SETTING_POSITION_COMMAND)
                content.extend(Constant.LIFTER_SETTING_GET_POSITION_PARAMETER)
                if machine == 'main':
                    content.extend(Constant.LIFTER_MAIN_MACHINE)
                else:
                    content.extend(Constant.LIFTER_SUB_MACHINE)
                content.extend(bytearray(row_number.to_bytes(1, 'big')))
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.LIFTER_SETTING_GET_POSITION_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'setLifterPosition':
                machine = keyboard_value[1]  # main or sub
                row_number = int(keyboard_value[2])  # 0 - 9
                steps = int(keyboard_value[3])  # 0 - 4000
                print("Send Command")
                content = bytearray()
                content.extend(Constant.LIFTER_SETTING_POSITION_COMMAND)
                content.extend(Constant.LIFTER_SETTING_POSITION_PARAMETER)
                if machine == 'main':
                    content.extend(Constant.LIFTER_MAIN_MACHINE)
                else:
                    content.extend(Constant.LIFTER_SUB_MACHINE)
                content.extend(bytearray(row_number.to_bytes(1, 'big')))
                content.extend(bytearray(steps.to_bytes(2, 'big')))
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.LIFTER_SETTING_POSITION_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'clearLifterFault':
                print("Send Command")
                content = bytearray()
                content.extend(Constant.LIFTER_CLEAR_FAULT_COMMAND)
                content.extend(Constant.LIFTER_CLEAR_FAULT_PARAMETER)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.LIFTER_CLEAR_FAULT_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'readLifterSetting':
                machine = keyboard_value[1]  # main or sub
                print("Send Command")
                content = bytearray()
                content.extend(Constant.LIFTER_CONFIGURATION_COMMAND)
                content.extend(Constant.LIFTER_SETTING_READ_PARAMETER)
                if machine == 'main':
                    content.extend(Constant.LIFTER_MAIN_MACHINE)
                else:
                    content.extend(Constant.LIFTER_SUB_MACHINE)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.LIFTER_SETTING_READ_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'writeLifterSetting':
                # writeLifterSetting main 1 1
                machine = keyboard_value[1]  # main or sub
                lifter_enable = keyboard_value[2] == '1'
                over_current_protection_enable = keyboard_value[3] == '1'
                print("Send Command")
                content = bytearray()
                content.extend(Constant.LIFTER_CONFIGURATION_COMMAND)
                content.extend(Constant.LIFTER_SETTING_WRITE_PARAMETER)
                if machine == 'main':
                    content.extend(Constant.LIFTER_MAIN_MACHINE)
                else:
                    content.extend(Constant.LIFTER_SUB_MACHINE)
                if lifter_enable:
                    content.extend(Constant.LIFTER_SETTING_ENABLE_LIFTER)
                else:
                    content.extend(Constant.LIFTER_SETTING_DISABLE_LIFTER)
                if over_current_protection_enable:
                    content.extend(
                        Constant.LIFTER_SETTING_ENABLE_OVER_PROTECTION)
                else:
                    content.extend(
                        Constant.LIFTER_SETTING_DISABLE_OVER_PROTECTION)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.LIFTER_SETTING_WRITE_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'refund':
                print("Send Command")
                content = bytearray()
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.REFUND_COMMAND,
                                                          length=Constant.REFUND_COMMAND_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'getMachineInfo':
                print("Send Command")
                content = bytearray()
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.MACHINE_INFO_COMMAND,
                                                          length=Constant.MACHINE_INFO_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'deductBalance':
                print("Send command")
                full_amount = int(keyboard_value[1])
                content = bytearray()
                content.extend(Constant.PAYMENT_TYPE_ACCEPT)
                content.extend(bytearray(full_amount.to_bytes(4, 'big')))
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.MACHINE_UPDATE_BALANCE_COMMAND,
                                                          length=Constant.MACHINE_UPDATE_BALANCE_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'updateBalance':
                print("Send command")
                full_amount = int(keyboard_value[1])
                content = bytearray()
                content.extend(Constant.PAYMENT_TYPE_CARD)
                content.extend(bytearray(full_amount.to_bytes(4, 'big')))
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.MACHINE_UPDATE_BALANCE_COMMAND,
                                                          length=Constant.MACHINE_UPDATE_BALANCE_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'readTemperatureController':
                print("Send Command")
                machine = keyboard_value[1]  # main or sub
                content = bytearray()
                content.extend(Constant.TEMPERATURE_CONTROLLER_SETUP_COMMAND)
                content.extend(Constant.TEMPERATURE_CONTROLLER_READ_PARAMETER)
                if machine == 'main':
                    content.extend(Constant.MAIN_MACHINE)
                else:
                    content.extend(Constant.SUB_MACHINE)
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.TEMPERATURE_CONTROLLER_READ_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'setTemperatureController':
                # setTemperatureController main 10
                print("Send Command")
                machine = keyboard_value[1]  # main or sub
                temperature = int(keyboard_value[2])
                content = bytearray()
                content.extend(Constant.TEMPERATURE_CONTROLLER_SETUP_COMMAND)
                content.extend(Constant.TEMPERATURE_CONTROLLER_SET_PARAMETER)
                if machine == 'main':
                    content.extend(Constant.MAIN_MACHINE)
                else:
                    content.extend(Constant.SUB_MACHINE)
                content.extend(bytearray(b'\x02'))  # 制冷模式
                content.extend(bytearray(temperature.to_bytes(1, 'big')))
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.TEMPERATURE_CONTROLLER_SET_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            elif keyboard_value[0] == 'readTemperatureStatus':
                print("Send Command")
                content = bytearray()
                content.extend(Constant.TEMPERATURE_CONTROLLER_STATUS_COMMAND)
                content.extend(b'\x00\x00')
                full_command = self.generate_full_command(stx=Constant.STX,
                                                          command=Constant.SETTING_COMMAND,
                                                          length=Constant.TEMPERATURE_CONTROLLER_STATUS_LENGTH,
                                                          content=content)
                self.serial_device.write(full_command)
            self.is_command_receive = False
        self.serial_device.flush()

    def decode_serial(self, message: []):
        # Convert str array to bytearray
        actual_byte_array = bytearray()
        for i in message:
            value = '0x' + i
            actual_byte_array.extend(bytearray(bytes([int(value, 16)])))

        if actual_byte_array == Constant.VMC_ACK:
            print("Command Received")
            self.is_command_receive = True
            self.keyboard_input.set_value('')
            # if self.keyboard_input.get_value().split(' ')[0] != 'runSpiralMotor' and self.keyboard_input.get_value().split(' ')[0] != 'readLifterSetting' and self.keyboard_input.get_value().split(' ')[0] != 'checkMotorStatus' and self.keyboard_input.get_value().split(' ')[0] != 'deductBalance':
            #     self.keyboard_input.set_value('')
            self.write_to_VMC()
        else:
            command = actual_byte_array[2:3]  # Take the third from bytearray
            if command == Constant.MOTOR_DISPENSING_STATUS_COMMAND:
                self.keyboard_input.set_value('')
                print("Motor dispensing command...")
                dispense_status = actual_byte_array[5:6]
                if dispense_status == Constant.MOTOR_DISPENSING_STATUS_DISPENSING:
                    print("Motor dispensing...")
                    self.set_is_dispensing(is_dispensing=1)
                    self.set_dispense_status(dispense_status=-1)
                elif dispense_status == Constant.MOTOR_DISPENSING_STATUS_DISPENSE_SUCCESS:
                    print("Motor dispense success.")
                    self.set_is_dispensing(is_dispensing=0)
                    self.set_dispense_status(dispense_status=1)
                elif dispense_status == Constant.MOTOR_DISPENSING_STATUS_DISPENSE_FAILED:
                    print("Motor dispense failed.")
                    self.set_is_dispensing(is_dispensing=0)
                    self.set_dispense_status(dispense_status=0)
                elif dispense_status == Constant.MOTOR_DISPENSING_STATUS_MOTOR_NOT_EXIST:
                    print("Motor does not exist.")
                    self.set_is_dispensing(is_dispensing=0)
                    self.set_dispense_status(dispense_status=0)
            elif command == Constant.MOTOR_CHECK_STATUS_RESPONSE_COMMAND:
                self.keyboard_input.set_value('')
                print("Motor checked responded")
                motor_status = actual_byte_array[5:6]
                if motor_status == Constant.MOTOR_CHECK_STATUS_RESPONSE_NORMAL or motor_status == Constant.MOTOR_CHECK_STATUS_RESPONSE_OUT_OF_STOCK or motor_status == Constant.MOTOR_CHECK_STATUS_RESPONSE_STOP_SALES:
                    print("Motor normal")
                    self.set_is_motor_checking(is_motor_checking=0)
                    self.set_motor_status(motor_status=1)
                elif motor_status == Constant.MOTOR_CHECK_STATUS_RESPONSE_DISPENSE_DOOR_OPEN:
                    print("Door is opening")
                    self.set_is_motor_checking(is_motor_checking=0)
                    self.set_motor_status(motor_status=2)
                elif motor_status == Constant.MOTOR_CHECK_STATUS_RESPONSE_ITEM_IN_LIFTER:
                    print("Something in the lifter")
                    self.set_is_motor_checking(is_motor_checking=0)
                    self.set_motor_status(motor_status=3)
                elif motor_status == Constant.MOTOR_CHECK_STATUS_RESPONSE_LIFTER_ERROR:
                    print("Lifter error")
                    self.set_is_motor_checking(is_motor_checking=0)
                    self.set_motor_status(motor_status=4)
                else:
                    print("Motor abnormal")
                    self.set_is_motor_checking(is_motor_checking=0)
                    self.set_motor_status(motor_status=0)
            elif command == Constant.MACHINE_STATUS_RESPONSE_COMMAND:
                print("Getting machine info...")
                self.set_door_status(door_status=actual_byte_array[10])
                self.set_main_temperature(temperature=actual_byte_array[9])
                if len(actual_byte_array) > 29:
                    if actual_byte_array[30:31] == Constant.SUB_MACHINE_TEMPERATURE_NOT_EXIST:
                        self.set_sub_temperature(temperature=-1)
                    else:
                        self.set_sub_temperature(
                            temperature=actual_byte_array[30])
                else:
                    self.set_sub_temperature(temperature=-1)
                print("Send ACK")
                self.serial_device.write(Constant.ACK)
            elif command == Constant.SETTING_COMMAND_RESPONSE:
                print("Setting command response")
                command_type = actual_byte_array[5:6]
                if command_type == Constant.TRACK_INSPECTION_SETTING_COMMAND:
                    print("Track inspection command response")
                    motor_status = actual_byte_array[7:8]
                    print("motor_status")
                    print(motor_status)
                    if motor_status == Constant.TRACK_INSPECTION_STATUS_MOTOR_NORMAL:
                        self.set_is_inspecting_track(is_inspecting_track=0)
                        self.set_track_status(track_status=1)
                    else:
                        self.set_is_inspecting_track(is_inspecting_track=0)
                        self.set_track_status(track_status=0)
                elif command_type == Constant.DROP_SENSOR_TEST_SETTING_COMMAND:
                    print("Drop sensor test response")
                    drop_sensor_setup_status = actual_byte_array[7]
                    drop_sensor_test_status = actual_byte_array[8]
                    self.set_is_checking_drop_sensor(is_checking_drop_sensor=0)
                    self.set_drop_sensor_status(
                        drop_sensor_status=drop_sensor_test_status)
                elif command_type == Constant.LIFTER_CONFIGURATION_COMMAND:
                    self.keyboard_input.set_value('')
                    print("Lifter configuration response")
                    configuration_type = actual_byte_array[6:7]
                    if configuration_type == Constant.LIFTER_SETTING_READ_PARAMETER:
                        read_status = actual_byte_array[7:8]
                        if read_status == Constant.LIFTER_SETTING_WRITE_READ_SUCCESS:
                            print("Read lifter configuration successfully")
                            is_lifter_enable = actual_byte_array[8:9]
                            if is_lifter_enable == Constant.LIFTER_SETTING_ENABLE_LIFTER:
                                print("Lifter is enabled")
                                self.set_is_lifter_enabled(is_lifter_enabled=1)
                            else:
                                print("Lifter is disabled")
                                self.set_is_lifter_enabled(is_lifter_enabled=0)
                            is_over_current_protection_enable = actual_byte_array[9:10]
                            if is_over_current_protection_enable == Constant.LIFTER_SETTING_ENABLE_OVER_PROTECTION:
                                print("Over current protection enabled")
                                self.set_is_lifter_over_current_protection_enabled(
                                    is_lifter_over_current_protection_enabled=1)
                            else:
                                print("Over current protection disabled")
                                self.set_is_lifter_over_current_protection_enabled(
                                    is_lifter_over_current_protection_enabled=0)
                            self.set_is_reading_or_setting(
                                is_reading_or_setting=0)
                        else:
                            print("Read lifter configuration failed")
                    elif configuration_type == Constant.LIFTER_SETTING_WRITE_PARAMETER:
                        set_status = actual_byte_array[7:8]
                        if set_status == Constant.LIFTER_SETTING_WRITE_READ_SUCCESS:
                            self.set_is_lifter_set_success(
                                is_lifter_set_success=1)
                        else:
                            self.set_is_lifter_set_success(
                                is_lifter_set_success=0)
                        self.set_is_reading_or_setting(is_reading_or_setting=0)
                elif command_type == Constant.LIFTER_SETTING_POSITION_COMMAND:
                    print("Lifter position setting response")
                    configuration_type = actual_byte_array[6:7]
                    if configuration_type == Constant.LIFTER_SETTING_READ_PARAMETER:
                        read_status = actual_byte_array[7:8]
                        if read_status == Constant.LIFTER_POSITION_READ_SET_SUCCESS:
                            print("Read success")
                            position_in_byte = actual_byte_array[8:10]
                            value_in_str = ""
                            for i in position_in_byte:
                                value_in_str += hex(i)
                            value_in_str = value_in_str.replace('0x', '')
                            actual_position = int(value_in_str, 16)
                            self.set_lifter_position(
                                lifter_position=actual_position)
                        else:
                            print("Read failed")
                            self.set_lifter_position(lifter_position=-1)
                    else:
                        setup_status = actual_byte_array[7:8]
                        if setup_status == Constant.LIFTER_POSITION_READ_SET_SUCCESS:
                            print("Setup success")
                        else:
                            print("Setup failed")
                    self.set_is_reading_or_setting(is_reading_or_setting=0)
                elif command_type == Constant.COIN_CONFIGURATION_COMMAND:
                    self.keyboard_input.set_value('')
                    print("Coin configuration response")
                    configuration_type = actual_byte_array[6:7]
                    if configuration_type == Constant.COIN_CONFIGURATION_READ_PARAMETER:
                        coin_machine_type = actual_byte_array[7:8]
                        if coin_machine_type == Constant.COIN_MACHINE_TYPE_NRI:
                            print("NRI Type")
                        elif coin_machine_type == Constant.COIN_MACHINE_TYPE_HOPPER:
                            print("Hopper")
                    else:
                        setup_response = actual_byte_array[7:8]
                        if setup_response == Constant.COIN_CONFIGURATION_SETUP_SUCCESS:
                            print("Setup successfully")
                        else:
                            print("Setup failed")
                elif command_type == Constant.CASH_DEVICE_TEST_SETTING_COMMAND:
                    status = actual_byte_array[7:8]
                    if status == Constant.CASH_DEVICE_STATUS_OK:
                        print("Cash device OK")
                        self.set_cash_device_status(cash_device_status=1)
                    else:
                        print("Cash device error")
                        self.set_cash_device_status(cash_device_status=0)
                    self.set_is_reading_or_setting(is_reading_or_setting=0)
                elif command_type == Constant.COIN_DEVICE_TEST_SETTING_COMMAND:
                    status = actual_byte_array[7:8]
                    if status == Constant.COIN_DEVICE_STATUS_OK:
                        print("Coin device OK")
                        self.set_coin_device_status(coin_device_status=1)
                    else:
                        print("Coin device error")
                        self.set_coin_device_status(coin_device_status=0)
                    self.set_is_reading_or_setting(is_reading_or_setting=0)
                elif command_type == Constant.LIFTER_CLEAR_FAULT_COMMAND:
                    status = actual_byte_array[7:8]
                    if status == Constant.LIFTER_CLEAR_FAULT_STATUS_SUCCESS:
                        print("Lifter clear fault OK")
                        self.set_lifter_clear_fault_status(
                            lifter_clear_fault_status=1)
                    else:
                        print("Lifter clear fault failed")
                        self.set_lifter_clear_fault_status(
                            lifter_clear_fault_status=0)
                    self.set_is_reading_or_setting(is_reading_or_setting=0)
            elif command == Constant.RECEIVE_MONEY_COMMAND:
                print("Money command received")
                print("Send ACK")
                self.serial_device.write(Constant.ACK)
                payment_type = actual_byte_array[5:6]
                if payment_type == Constant.RECEIVE_MONEY_METHOD_PAPER or payment_type == Constant.RECEIVE_MONEY_METHOD_COIN:
                    amount_in_byte = actual_byte_array[6:10]
                    value_in_str = ""
                    for i in amount_in_byte:
                        value_in_str += hex(i)
                    value_in_str = value_in_str.replace('0x', '')
                    actual_amount = int(value_in_str, 16)
                    full_amount = actual_amount
                    actual_amount = actual_amount / 100
                    print("Received amount: " + str(actual_amount))
                    HttpService.update_credit(credit=actual_amount)
                    print("Credit updated")
                    self.set_current_credit(
                        current_credit=self.get_current_credit() + actual_amount)
                    time.sleep(0.5)
                    self.keyboard_input.set_value("deductBalance " + str(0))
            elif command == Constant.REFUND_DONE_COMMAND:
                self.set_is_refunding(is_refunding=0)
                refund_amount_in_byte = actual_byte_array[9:13]
                print(refund_amount_in_byte)
                value_in_str = ""
                for i in refund_amount_in_byte:
                    if len(hex(i)) == 3:
                        value_in_str += "0" + hex(i)
                    else:
                        value_in_str += hex(i)
                print("value_in_str before replece: " + value_in_str)
                value_in_str = value_in_str.replace('0x', '')
                print("value_in_str: " + value_in_str)
                actual_refund_amount = int(value_in_str, 16)
                actual_refund_amount = actual_refund_amount / 100
                if actual_refund_amount >= self.get_current_credit():
                    self.set_current_credit(current_credit=0.0)
                else:
                    self.set_current_credit(
                        current_credit=self.get_current_credit() - actual_refund_amount)
                HttpService.update_credit(credit=-actual_refund_amount)
                print(self.get_current_credit())
                print("Refund amount: " + str(actual_refund_amount))
                print("Credit updated")
                print("Refund done")
            elif command == Constant.CURRENT_CREDIT_IN_VMC:
                print("Receive current credit")
                amount_in_byte = actual_byte_array[5:9]
                value_in_str = ""
                for i in amount_in_byte:
                    value_in_str += hex(i)
                value_in_str = value_in_str.replace('0x', '')
                actual_amount = int(value_in_str, 16)
                print("Current credit: " + str(actual_amount))
                if actual_amount == 0:
                    print("CREDIT IS 0")
                    self.set_is_clearing_credit(is_clearing_credit=0)
                    self.keyboard_input.set_value('')

            if command == Constant.MACHINE_STATUS_RESPONSE_COMMAND:
                print("Get machine info done")
            else:
                self.write_to_VMC()

    def run(self) -> None:
        try:
            while True:
                if not self.trigger_new_message:
                    print(self.new_message)

                    if not self.is_initial and len(self.new_message) == 0:
                        os.system("sudo systemctl restart xy_serial.service")

                    if len(self.new_message) > 0:
                        self.decode_serial(message=self.new_message)

                        # self.write_to_VMC()
                    else:
                        self.is_initial = False

                    i = 0
                    self.new_message = []
                    self.serial_device.flushInput()
                    self.serial_device.flushOutput()
                    self.byte_length = 9999

                message = self.serial_device.read()
                # self.serial_device.flushInput()
                # self.serial_device.flushOutput()

                if self.is_first_read:
                    self.keyboard_input.set_value("getMachineInfo")
                    self.is_first_read = False

                if message == b'\xFA':
                    self.trigger_new_message = True

                if self.trigger_new_message and i < self.byte_length + 4:
                    if len(self.new_message) == 3:
                        self.byte_length = int.from_bytes(message, "big")
                    self.new_message.append(message.hex())
                else:
                    self.trigger_new_message = False

                i = i + 1
        except KeyboardInterrupt:
            print("Serial Com process keyboard interrupted")
            self.serial_device.close()
            self.close()
            pass
        except Exception as e:
            print("[ERROR] SerialProcessError: Unknown error")
            print(e)
            self.serial_device.close()
            self.close()
            # os.system("sudo pm2 restart nubox-python-server")
            os.system("sudo systemctl restart xy_serial.service")
            pass

    @classmethod
    def generate_checksum(cls, value: bytearray) -> bytearray:
        # Convert into full sting \xfa\xfb....
        actual_word = ""
        for i in range(len(value)):
            if i < len(value) - 1:
                actual_word = actual_word + \
                    format(ord(chr(value[i])), '#04x') + ' '
            else:
                actual_word = actual_word + format(ord(chr(value[i])), '#04x')

        print(actual_word)

        actual_word = [chr(int(x, 16)) for x in actual_word.split(' ')]

        checksum = 0

        for i in actual_word:
            checksum ^= ord(i)

        return bytearray(checksum.to_bytes(1, 'big'))

    @classmethod
    def generate_full_command(cls, stx: bytearray, command: bytearray, length: bytearray,
                              content: bytearray) -> bytearray:
        full_command = bytearray()
        full_command.extend(stx)
        full_command.extend(command)
        full_command.extend(length)
        full_command.extend(bytearray(cls.signal.to_bytes(1, 'big')))
        full_command.extend(content)
        full_command.extend(cls.generate_checksum(value=full_command))

        if cls.signal < 255:
            cls.signal = cls.signal + 1
        else:
            cls.signal = 1

        return full_command
