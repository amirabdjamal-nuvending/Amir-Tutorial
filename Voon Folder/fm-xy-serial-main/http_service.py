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

    # -------------------------------------------- FOR GHL --------------------------------------------
    @staticmethod
    def insertGhlPayment(payment_method, amount):

        url = f"{Constant.SERVER_ADDRESS}/insertGhlPayment"
        print(amount)
        response = requests.post(
            url, json={"payment_method": payment_method, "amount": amount})

        result = response.json()
        print(result["status"])
        if result["status"] == "OK":
            return result
        else:
            return False

    @staticmethod
    def updateGhlPayment(id, transaction_trace, payment_method, amount, card_digits, order_number, batch_number, host_id, status, card_type_description, approval_code):
        url = f"{Constant.SERVER_ADDRESS}/updateGhlPayment"

        response = requests.post(url, json={"id": id, "payment_method": payment_method, "amount": amount,
                                            "order_number": order_number, "card_digits": card_digits,
                                            "transaction_trace": transaction_trace, "batch_number": batch_number,
                                            "host_id": host_id, "status": status, "approval_code": approval_code, "card_type_description": card_type_description})

        result = response.json()
        print(result["status"])
        if result["status"] == "OK":
            return result
        else:
            return False

    @staticmethod
    def updateGhlRefund(id, refund_amount, refund_status):
        url = f"{Constant.SERVER_ADDRESS}/updateGhlRefund"

        response = requests.post(url, json={
                                 "id": id, "refund_amount": refund_amount, "refund_status": refund_status})

        result = response.json()
        print(result["status"])
        if result["status"] == "OK":
            return result
        else:
            return False

    @staticmethod
    def getIdData(id):

        url = f"{Constant.SERVER_ADDRESS}/getIdData"

        response = requests.post(url, json={"id": id})

        result = response.json()
        print(result["status"])
        if result["status"] == "OK":

            return result["result"]
        else:
            return False
    # -------------------------------------------- END GHL --------------------------------------------
