class MotorResult:

    def __init__(self, status, need_drop_sensor, is_quarter_enabled, continue_purchase, row, column, new_motor_number):
        self.status = status
        self.need_drop_sensor = need_drop_sensor
        self.is_quarter_enabled = is_quarter_enabled
        self.continue_purchase = continue_purchase
        self.row = row
        self.column = column
        self.new_motor_number = new_motor_number

    @staticmethod
    def from_dict(obj):
        if obj["status"] != 'error':
            return MotorResult(status=obj["status"], need_drop_sensor=obj["drop_sensor"] == 1, is_quarter_enabled=obj["quarter_turn"] == 1, continue_purchase=obj["continue_order"] == 1, row=int(obj["tray_number"]) - 1, column=int(obj["slot_number"]) + 5, new_motor_number=int(obj["new_motor_number"]))
        else:
            return MotorResult(status=obj["status"], need_drop_sensor=False, is_quarter_enabled=False, continue_purchase=False, row=-1, column=-1, new_motor_number=99)
