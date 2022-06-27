class LifterEnableResult:

    def __init__(self, status, main_lifter_enable, sub_lifter_enable):
        self.status = status
        self.main_lifter_enable = main_lifter_enable
        self.sub_lifter_enable = sub_lifter_enable

    @staticmethod
    def from_dict(obj):
        if obj["status"] != 'error':
            return LifterEnableResult(status=obj["status"], main_lifter_enable=obj["main_lifter_enable"] == 1,
                                      sub_lifter_enable=obj["sub_lifter_enable"] == 1)
        else:
            return LifterEnableResult(status=obj["status"], main_lifter_enable=False, sub_lifter_enable=False)
