import time


class LifterComponent:
    data = ""
    m_previous_row_list = []
    # step_each_row[0] = step 1-2
    # step_each_row[1] = step 2-3
    # step_each_row[2] = step 3-4
    # step_each_row[3] = step 4-5
    # step_each_row[4] = step 5-6
    # step_each_row[5] = base step
    # change in NV and get from db
    step_each_row = []
    step_to_go = 0
    row_quantity_in_previous_machine = 0
    lift_motor_status = ""

    @classmethod
    def motor_stuck_back_home(cls, row, in_machine_list):
        print("rescuing...")
        cls.motor_back(row, in_machine_list)


    @classmethod
    # todo jwei have to test with lifter no drop sensor mode
    # todo check if step_to_go logic all correct on multiple sub machine
    def motor_forward(cls, row, in_machine_list, serial_com, tray_quantity_in_machine_list):
        print("row: "+str(row))
        print("in_machine_list: "+str(in_machine_list))
        print("tray_quantity_in_machine_list: "+str(tray_quantity_in_machine_list))

        if len(cls.m_previous_row_list) == 0:
            for item in tray_quantity_in_machine_list:
                cls.m_previous_row_list.append(-1)
        station_number = "0" + str(in_machine_list[row]) + " "

        # add previous row quantity if row is not in machine 1
        if in_machine_list[row] > 1:
            j = 1
            for item in tray_quantity_in_machine_list:
                if j < in_machine_list[row]:
                    cls.row_quantity_in_previous_machine += item
                j += 1
        # lifter motor
        try:
            print("lifter motor_forward...")
            print("row " + str(row))
            print("tray_in_machine: " + str(in_machine_list[row]))
            # from home
            if cls.m_previous_row_list[in_machine_list[row]-1] == -1:
                serial_com.write_serial(station_number + "moveLifterMotor F " + str(cls.step_each_row[row - cls.row_quantity_in_previous_machine]) + "\n")
            else:
                # case 1: same row
                if cls.m_previous_row_list[in_machine_list[row]-1] == (row - cls.row_quantity_in_previous_machine):
                    return True
                # case 2:
                elif cls.m_previous_row_list[in_machine_list[row]-1] > (row - cls.row_quantity_in_previous_machine):  # MOTOR FORWARD
                    cls.step_to_go = cls.step_each_row[row] - cls.step_each_row[cls.m_previous_row_list[row]]
                    serial_com.write_serial(station_number + "moveLifterMotor F " + str(cls.step_each_row[row - cls.row_quantity_in_previous_machine]) + "\n")
                # case 3:
                elif cls.m_previous_row_list[in_machine_list[row]-1] < (row - cls.row_quantity_in_previous_machine):  # MOTOR BACKWARD
                    cls.step_to_go = cls.step_each_row[cls.m_previous_row_list[in_machine_list[row]-1]] - cls.step_each_row[row]
                    serial_com.write_serial(station_number + "moveLifterMotor B " + str(cls.step_each_row[row - cls.row_quantity_in_previous_machine]) + "\n")
            status = cls.request_status_reply(station_number, serial_com)
            if cls.lift_motor_status == (station_number + "jam"):
                cls.row_quantity_in_previous_machine = 0
                cls.step_to_go = 0
                print("motor stuck")
                cls.motor_stuck_back_home(row, in_machine_list)
                return False
            else:
                cls.m_previous_row_list[in_machine_list[row]-1] = (row - cls.row_quantity_in_previous_machine)

            print("m_previous_row_list in motor forward")
            print(cls.m_previous_row_list)
            cls.row_quantity_in_previous_machine = 0
            cls.step_to_go = 0
            print("cls.step_each_row")
            print(cls.step_each_row)
            return True
        except KeyboardInterrupt:
            print("Motor interrupted")
            pass
        except Exception as e:
            print("[ERROR] MotorError: Unknown error")
            print(e)
            pass

    @classmethod
    def test_step(cls, which_lifter, step_number, serial_com):
        station_number = "0" + which_lifter + " "
        # lifter motor
        # todo jwei make sure setting app lock door before run
        try:
            serial_com.write_serial(station_number + "openActuator" + "\n")
            status = cls.request_status_reply(station_number, serial_com)
            print(status)
            serial_com.write_serial(station_number + "moveLifterMotor F " + str(step_number) + "\n")
            status = cls.request_status_reply(station_number, serial_com)
            if cls.lift_motor_status == (station_number + "jam"):
                return False
            cls.step_to_go = 0
            return True
        except Exception as e:
            print("[ERROR] MotorError: Unknown error in test")
            pass


    @classmethod
    def testLifterBackToHome(cls, which_lifter, serial_com):
        # lifter motor
        station_number = "0" + str(which_lifter) + " "
        try:
            serial_com.write_serial(station_number + "moveLifterMotor H\n")
            status = cls.request_status_reply(station_number, serial_com)
            print(status)
            # Motor stuck ask motor and actuator stop action immediately
            if cls.lift_motor_status == (station_number + "jam"):
                print("motor stuck")
                return False
            return True
        except Exception as e:
            print("[ERROR] MotorError: Unknown error in test back home")
            pass

    @classmethod
    def motor_back(cls, row, in_machine_list, serial_com):
        try:
            print("motor back")
            print("row " + str(row))
            print("tray_in_machine " + str(in_machine_list[row]))
            station_number = "0" + str(in_machine_list[row]) + " "
            serial_com.write_serial(station_number + "moveLifterMotor H\n")
            status = cls.request_status_reply(station_number, serial_com)
            # Motor stuck ask motor and actuator stop action immediately
            if cls.lift_motor_status == (station_number + "jam"):
                print("motor stuck")
                return False
            cls.m_previous_row_list[in_machine_list[row] - 1] = -1
            print("m_previous_row_list in motor back")
            print(cls.m_previous_row_list)
        except:
            pass
        print("motor back home done")
        return True

    # door
    @classmethod
    def door_unlock(cls, _which_lifter, serial_com):
        station_number = "0" + str(_which_lifter) + " "
        try:
            print("door_unlocking...")
            print("tray_in_machine " + str(_which_lifter))
            serial_com.write_serial(station_number + "unlockTheDoor" + "\n")
            time.sleep(0.05)
        except:
            pass
        print("door unlocked...")
        return True

    @classmethod
    def door_lock(cls, _which_lifter, serial_com):
        station_number = "0" + str(_which_lifter) + " "
        try:
            print("door_locking...")
            print("tray_in_machine " + str(_which_lifter))

            serial_com.write_serial(station_number + "lockTheDoor" + "\n")
            time.sleep(0.05)
        except:
            pass
        print("door locked...")
        return True

    @classmethod
    def actuator_back(cls, row, in_machine_list, serial_com):
        print("actuator_back")
        station_number = "0" + str(in_machine_list[row]) + " "
        try:
            serial_com.write_serial(station_number + "openActuator" + "\n")
            status = cls.request_status_reply(station_number, serial_com)
            print(status)
            return True
        except KeyboardInterrupt:
            print("Actuator process keyboard interrupted")
            pass
            return False
        except Exception as e:
            print("[ERROR] MotorError: Unknown error in Actuator back")
            pass
            return False

    @classmethod
    def home_check(cls, row, in_machine_list, serial_com):
        station_number = "0" + str(in_machine_list[row]) + " "
        try:
            print("home_checking.")
            print("row " + str(row))
            print("tray_in_machine: " + str(in_machine_list[row]))
            print("command send: " + station_number + "getLimitSensor" + "\n")
            serial_com.write_serial(station_number + "getLimitSensor" + "\n")
            status = cls.request_bool_reply(station_number, serial_com)
            print("limit check...")
            print(cls.lift_motor_status)
            if cls.lift_motor_status == (station_number + "false"):
                return False
            else:
                return True
        except KeyboardInterrupt:
            print("Home Check process keyboard interrupted")
            pass
            return False
        except Exception as e:
            print("[ERROR] MotorError: Unknown error in home check")
            print(e)
            pass
            return False

    @classmethod
    def inductor_check(cls, which_machine, serial_com):
        station_number = "0" + str(which_machine) + " "
        try:
            print("inductor_checking...")
            print("tray_in_machine: " + str(which_machine))
            serial_com.write_serial(station_number + "getInductiveSensor" + "\n")
            status = cls.request_bool_reply(station_number, serial_com)
            print(cls.lift_motor_status)
            if cls.lift_motor_status == (station_number + "false"):
                return False
            else:
                return True
        except KeyboardInterrupt:
            print("Home Check process keyboard interrupted")
            pass
            return False
        except Exception as e:
            print("[ERROR] MotorError: Unknown error in home check")
            print(e)
            pass
            return False

    @classmethod
    def request_bool_reply(cls, station_number, serial_com):
        status = serial_com.read_serial().rstrip()
        print("lifterCompoent:"+status)
        if status == (station_number + "true") or status == (station_number + "false"):
            cls.lift_motor_status = status
            return status
        else:
            cls.request_bool_reply(station_number, serial_com)


    @classmethod
    def request_status_reply(cls, station_number, serial_com):
        status = serial_com.read_serial().rstrip()
        print("lifterCompoent: "+status)
        if status == (station_number + "done") or status == (station_number + "jam") or status == (
                station_number + "error"):
            cls.lift_motor_status = status
            return status

        else:
            cls.request_status_reply(station_number, serial_com)
