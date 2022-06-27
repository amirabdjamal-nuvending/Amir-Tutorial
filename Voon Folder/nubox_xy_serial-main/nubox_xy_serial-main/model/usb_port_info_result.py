class UsbPortInfoResult:

    def __init__(self, status, port_info):
        self.status = status
        self.port_info = port_info

    @staticmethod
    def from_dict(obj):
        if obj["status"] != 'error':
            return UsbPortInfoResult(status=obj["status"], port_info=obj["result"])
        else:
            return UsbPortInfoResult(status=obj["status"], port_info=[])
