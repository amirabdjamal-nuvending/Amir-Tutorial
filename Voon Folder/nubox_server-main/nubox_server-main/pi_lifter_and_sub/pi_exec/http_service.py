import requests
from model.motor_result import MotorResult
from constant import Constant
from model.usb_port_info_result import UsbPortInfoResult


class HttpService:

    @staticmethod
    def get_motor_coordinate(motor_number) -> MotorResult:
        url = f"{Constant.SERVER_ADDRESS}/getMotorCoordinate"
        data = {"motor_number": motor_number}

        response = requests.post(url, json=data)

        result = response.json()

        return MotorResult.from_dict(result)

    # @staticmethod
    # def setup_lifter_enable(main_lifter_check, sub_lifter_check) -> str:
    #     url = f"{Constant.SERVER_ADDRESS}/setupLifterEnable"
    #     data = {"main_lifter_enable": main_lifter_check,
    #             "sub_lifter_enable": sub_lifter_check}

    #     response = requests.post(url, json=data)
    #     result = response.json()

    #     print("lifter_result")
    #     print(result["status"])

    #     return result["status"]

    @staticmethod
    def get_row_steps() -> int:
        url = f"{Constant.SERVER_ADDRESS}/getRowSteps"

        response = requests.post(url, {})
        result = response.json()

        print("row_result")

        print(result["status"])

        if result["status"] == "OK":
            return result["step_each_row"]
        else:
            print("got problem in get_row_steps")
            return []

    @staticmethod
    def get_row_in_machine_list() -> int:
        url = f"{Constant.SERVER_ADDRESS}/getRowInWhichMachine"

        response = requests.post(url, {})
        result = response.json()
        return result["in_which_machine_list"]

    @staticmethod
    def get_slot_list() -> int:
        url = f"{Constant.SERVER_ADDRESS}/getSlotList"

        response = requests.post(url, {})
        result = response.json()
        return result["slot_list"]

    @staticmethod
    def get_sub_exist() -> bool:
        url = f"{Constant.SERVER_ADDRESS}/getSubExist"

        response = requests.post(url, json={})
        result = response.json()

        if result["status"] == "OK":
            return result["is_sub_exist"]
        else:
            print("got problem in get_sub_exist")
            return False

    @staticmethod
    def get_usb_port_info() -> UsbPortInfoResult:
        url = f"{Constant.SERVER_ADDRESS}/getUsbPort"
        data = {}

        response = requests.post(url, json=data)

        result = response.json()

        return UsbPortInfoResult.from_dict(result)

    @staticmethod
    def get_lifter_enable() -> int:
        url = f"{Constant.SERVER_ADDRESS}/getLifterEnableList_V2"
        data = {}

        response = requests.post(url, json=data)

        result = response.json()

        return result["lifter_enable_list"]

    @staticmethod
    def get_lifter_exist(row) -> bool:
        # print("get_lifter_exist")
        url = f"{Constant.SERVER_ADDRESS}/getLifterExist_V2"
        data = {"row": row}

        response = requests.post(url, json=data)
        result = response.json()

        if result["status"] == "OK":
            # print(str(result["is_lifter_exist"]))
            return result["is_lifter_exist"]
        else:
            return False

    @staticmethod
    def get_any_lifter_exist() -> bool:
        url = f"{Constant.SERVER_ADDRESS}/getAnyLifterExist_V2"

        response = requests.post(url, json={})
        result = response.json()

        if result["status"] == "OK":
            return result["is_lifter_exist"]
        else:
            return False

    @staticmethod
    def update_credit(credit) -> str:
        url = f"{Constant.SERVER_ADDRESS}/updateCredit"
        data = {"credit": credit}

        response = requests.post(url, json=data)

        result = response.json()

        return result["status"]

    @staticmethod
    def get_credit() -> float:
        url = f"{Constant.SERVER_ADDRESS}/getCredit"

        response = requests.post(url, json={})

        result = response.json()

        if result["status"] == "OK":
            return result["result"]
        else:
            return 0.0
