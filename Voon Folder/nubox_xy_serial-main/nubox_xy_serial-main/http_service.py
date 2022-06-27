import requests
from model.motor_result import MotorResult
from model.usb_port_info_result import UsbPortInfoResult
from constant import Constant


class HttpService:

    @staticmethod
    def get_motor_coordinate(motor_number) -> MotorResult:
        url = f"{Constant.SERVER_ADDRESS}/getMotorCoordinate"
        data = {"motor_number": motor_number}

        response = requests.post(url, json=data)

        result = response.json()

        return MotorResult.from_dict(result)

    @staticmethod
    def get_lifter_exist(row) -> bool:
        url = f"{Constant.SERVER_ADDRESS}/getLifterExist_V2"
        data = {"row": row}

        response = requests.post(url, json=data)
        result = response.json()

        if result["status"] == "OK":
            return result["is_lifter_exist"]
        else:
            return False

    @staticmethod
    def get_motor_number_list(row) -> bool:
        url = f"{Constant.SERVER_ADDRESS}/getRowMotorCoordinate"
        data = {"row_number": row}

        response = requests.post(url, json=data)
        result = response.json()

        if result["status"] == "OK":
            return result["motor_list"]
        else:
            return []

    @staticmethod
    def get_usb_port_info() -> UsbPortInfoResult:
        url = f"{Constant.SERVER_ADDRESS}/getUsbPort"
        data = {}

        response = requests.post(url, json=data)

        result = response.json()

        return UsbPortInfoResult.from_dict(result)

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
