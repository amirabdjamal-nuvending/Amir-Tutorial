class Constant:
    SERVER_ADDRESS = 'http://192.168.0.2:3000'

    STX = bytearray(b'\xFA\xFB')
    ACK = bytearray(b'\xFA\xFB\x42\x00\x43')
    VMC_ACK = bytearray(b'\xFA\xFB\x42\x00')

    CONTROL_MOTOR_COMMAND = bytearray(b'\x06')
    CONTROL_MOTOR_LENGTH = bytearray(b'\x05')
    CONTROL_MOTOR_NEED_DROP_SENSOR = bytearray(b'\x01')
    CONTROL_MOTOR_NO_NEED_DROP_SENSOR = bytearray(b'\x00')
    CONTROL_MOTOR_NEED_LIFTER = bytearray(b'\x01')
    CONTROL_MOTOR_NO_NEED_LIFTER = bytearray(b'\x00')

    # ------------------ 4.3.1 上位机查询某个货道正常 (上位机发出) ------------------
    MOTOR_CHECK_STATUS_COMMAND = bytearray(b'\x01')
    MOTOR_CHECK_STATUS_LENGTH = bytearray(b'\x03')

    MOTOR_CHECK_STATUS_RESPONSE_COMMAND = bytearray(b'\x02')

    MOTOR_CHECK_STATUS_RESPONSE_NORMAL = bytearray(b'\x01')
    MOTOR_CHECK_STATUS_RESPONSE_OUT_OF_STOCK = bytearray(b'\x02')
    MOTOR_CHECK_STATUS_RESPONSE_NOT_EXIST = bytearray(b'\x03')
    MOTOR_CHECK_STATUS_RESPONSE_STOP_SALES = bytearray(b'\x04')
    MOTOR_CHECK_STATUS_RESPONSE_ITEM_IN_LIFTER = bytearray(b'\x05')
    MOTOR_CHECK_STATUS_RESPONSE_DISPENSE_DOOR_OPEN = bytearray(b'\x06')
    MOTOR_CHECK_STATUS_RESPONSE_LIFTER_ERROR = bytearray(b'\x07')
    MOTOR_CHECK_STATUS_RESPONSE_LIFTER_SELF_CHECK_ERROR = bytearray(b'\x08')
    # ---------------------------------- END ----------------------------------

    # -------------------- 4.3.3 VMC 出货状态提示(VMC 发出) --------------------
    MOTOR_DISPENSING_STATUS_COMMAND = bytearray(b'\x04')

    MOTOR_DISPENSING_STATUS_DISPENSING = bytearray(b'\x01')
    MOTOR_DISPENSING_STATUS_DISPENSE_SUCCESS = bytearray(b'\x02')
    MOTOR_DISPENSING_STATUS_DISPENSE_FAILED = bytearray(b'\x03')
    MOTOR_DISPENSING_STATUS_DISPENSE_ABNORMAL_STOP = bytearray(b'\x04')
    MOTOR_DISPENSING_STATUS_MOTOR_NOT_EXIST = bytearray(b'\x06')

    MOTOR_DISPENSING_STATUS_LIFTER_BROKEN = bytearray(b'\x07')
    MOTOR_DISPENSING_STATUS_LIFTER_RISING = bytearray(b'\x10')
    MOTOR_DISPENSING_STATUS_LIFTER_FALLING = bytearray(b'\x11')
    MOTOR_DISPENSING_STATUS_LIFTER_RISING_FAILURE = bytearray(b'\x12')
    MOTOR_DISPENSING_STATUS_LIFTER_FALLING_FAILURE = bytearray(b'\x13')
    # ---------------------------------- END ----------------------------------

    # ----------------- 4.1.5 上位机请求获取 VMC 状态信息 ----------------
    REQUEST_MACHINE_STATUS_COMMAND = bytearray(b'\x51')
    MACHINE_STATUS_RESPONSE_COMMAND = bytearray(b'\x52')
    SUB_MACHINE_TEMPERATURE_NOT_EXIST = bytearray(b'\xaa')
    # ----------------------------- END ------------------------------

    # ---------------------- 4.2.2 设置货道的价格 ----------------------
    SETUP_SLOT_PRICE_COMMAND = bytearray(b'\x12')
    SETUP_SLOT_PRICE_LENGTH = bytearray(b'\x07')
    # ----------------------------- END ------------------------------

    SETTING_COMMAND = bytearray(b'\x70')
    SETTING_COMMAND_RESPONSE = bytearray(b'\x71')

    # ---------------------- 4.5.1 设置硬币系统 ----------------------
    COIN_CONFIGURATION_COMMAND = bytearray(b'\x01')

    COIN_CONFIGURATION_READ_PARAMETER = bytearray(b'\x00')
    COIN_CONFIGURATION_SET_PARAMETER = bytearray(b'\x01')

    COIN_CONFIGURATION_READ_LENGTH = bytearray(b'\x03')
    COIN_CONFIGURATION_SET_LENGTH = bytearray(b'\x04')

    COIN_MACHINE_TYPE_NRI = bytearray(b'\x01')
    COIN_MACHINE_TYPE_HOPPER = bytearray(b'\x02')

    COIN_CONFIGURATION_SETUP_SUCCESS = bytearray(b'\x00')
    COIN_CONFIGURATION_SETUP_FAILED = bytearray(b'\x01')
    # ----------------------------- END ----------------------------

    # -------------------- 4.5.19 设置纸币收币模式 -------------------
    CASH_RECEIVE_MODE_CONFIGURATION_COMMAND = bytearray(b'\x19')

    CASH_RECEIVE_MODE_CONFIGURATION_READ_PARAMETER = bytearray(b'\x00')
    CASH_RECEIVE_MODE_CONFIGURATION_SET_PARAMETER = bytearray(b'\x01')

    CASH_RECEIVE_MODE_CONFIGURATION_READ_LENGTH = bytearray(b'\x03')
    CASH_RECEIVE_MODE_CONFIGURATION_SET_LENGTH = bytearray(b'\x04')

    CASH_RECEIVE_MODE_TYPE_ALWAYS_RECEIVE = bytearray(b'\x03')

    CASH_RECEIVE_MODE_CONFIGURATION_SETUP_SUCCESS = bytearray(b'\x00')
    CASH_RECEIVE_MODE_CONFIGURATION_SETUP_FAILED = bytearray(b'\x01')
    # ----------------------------- END ---------------------------

    # ---------------------- 4.5.12 设置连接升降机 ----------------------
    LIFTER_CONFIGURATION_COMMAND = bytearray(b'\x12')

    LIFTER_SETTING_READ_PARAMETER = bytearray(b'\x00')
    LIFTER_SETTING_WRITE_PARAMETER = bytearray(b'\x01')

    LIFTER_SETTING_READ_LENGTH = bytearray(b'\x04')
    LIFTER_SETTING_WRITE_LENGTH = bytearray(b'\x06')

    LIFTER_SETTING_MAIN_MACHINE = bytearray(b'\x00')
    LIFTER_SETTING_SUB_MACHINE = bytearray(b'\x00')

    LIFTER_SETTING_ENABLE_LIFTER = bytearray(b'\x01')
    LIFTER_SETTING_DISABLE_LIFTER = bytearray(b'\x02')

    LIFTER_SETTING_DISABLE_OVER_PROTECTION = bytearray(b'\x00')
    LIFTER_SETTING_ENABLE_OVER_PROTECTION = bytearray(b'\x01')

    LIFTER_SETTING_WRITE_READ_SUCCESS = bytearray(b'\x00')
    LIFTER_SETTING_WRITE_READ_FAILED = bytearray(b'\x01')
    # ----------------------------- END ------------------------------

    # ----------------------- 4.5.34 升降机故障清除 ---------------------
    LIFTER_CLEAR_FAULT_COMMAND = bytearray(b'\x34')
    LIFTER_CLEAR_FAULT_LENGTH = bytearray(b'\x03')
    LIFTER_CLEAR_FAULT_PARAMETER = bytearray(b'\x01')

    LIFTER_CLEAR_FAULT_STATUS_SUCCESS = bytearray(b'\x00')
    LIFTER_CLEAR_FAULT_STATUS_FAILED = bytearray(b'\x01')
    # ------------------------------- END ----------------------------

    # ----------------------------- 4.5.38 货道测试 -----------------------------
    TRACK_INSPECTION_SETTING_COMMAND = bytearray(b'\x38')
    TRACK_INSPECTION_SETTING_LENGTH = bytearray(b'\x06')

    TRACK_INSPECTION_SETTING_MOTOR_ROTATE = bytearray(b'\x01\x01')
    TRACK_INSPECTION_SETTING_MOTOR_NOT_ROTATE = bytearray(b'\x01\x02')

    TRACK_INSPECTION_STATUS_MOTOR_NORMAL = bytearray(b'\x00')
    TRACK_INSPECTION_STATUS_MOTOR_NON_STOP = bytearray(b'\x01')
    TRACK_INSPECTION_STATUS_MOTOR_NOT_EXIST = bytearray(b'\x02')
    TRACK_INSPECTION_STATUS_MOTOR_COM_ERROR = bytearray(b'\x03')
    TRACK_INSPECTION_STATUS_MOTOR_SHORT_CIRCUIT = bytearray(b'\x04')
    # ---------------------------------- END ----------------------------------

    # ----------------------------- 4.5.50 出货检测测试 -----------------------------
    DROP_SENSOR_TEST_SETTING_COMMAND = bytearray(b'\x50')
    DROP_SENSOR_TEST_SETTING_LENGTH = bytearray(b'\x05')

    DROP_SENSOR_TEST_MAIN_MACHINE = bytearray(b'\x01\x00')
    DROP_SENSOR_TEST_SUB_MACHINE = bytearray(b'\x01\x01')

    DROP_SENSOR_TEST_AUTO_MODE = bytearray(b'\x00')
    DROP_SENSOR_TEST_MANUAL_MODE = bytearray(b'\x01')

    DROP_SENSOR_TEST_SETUP_SUCCESS = bytearray(b'\x00')
    DROP_SENSOR_TEST_SETUP_FAILED = bytearray(b'\x01')

    DROP_SENSOR_TEST_SUCCESS = bytearray(b'\x00')
    DROP_SENSOR_TEST_FAILED = bytearray(b'\x01')
    # ---------------------------------- END ----------------------------------

    # ----------------------------- 4.5.54 升降机测试 -----------------------------
    LIFTER_TEST_COMMAND = bytearray(b'\x54')
    LIFTER_TEST_PARAMETER = bytearray(b'\x01')
    LIFTER_TEST_LENGTH = bytearray(b'\x05')
    # ---------------------------------- END ------------------------------------

    # ----------------------------- 4.5.61 纸币器诊断 -----------------------------
    CASH_DEVICE_TEST_SETTING_COMMAND = bytearray(b'\x61')
    CASH_DEVICE_TEST_SETTING_LENGTH = bytearray(b'\x03')
    CASH_DEVICE_TEST_SETTING_PARAMETER = bytearray(b'\x01')

    CASH_DEVICE_STATUS_OK = bytearray(b'\x00')
    CASH_DEVICE_STATUS_ERROR = bytearray(b'\x01')
    # ---------------------------------- END ----------------------------------

    # ----------------------------- 4.5.62 硬币器诊断 -----------------------------
    COIN_DEVICE_TEST_SETTING_COMMAND = bytearray(b'\x62')
    COIN_DEVICE_TEST_SETTING_LENGTH = bytearray(b'\x03')
    COIN_DEVICE_TEST_SETTING_PARAMETER = bytearray(b'\x01')

    COIN_DEVICE_STATUS_OK = bytearray(b'\x00')
    COIN_DEVICE_STATUS_ERROR = bytearray(b'\x01')
    # ---------------------------------- END ----------------------------------

    # ----------------------------- 4.1.6 上位机设置纸币硬币是否接收 (上位机发出) -----------------------------
    CASH_COIN_DEVICE_SETUP_COMMAND = bytearray(b'\x28')
    CASH_COIN_DEVICE_SETUP_LENGTH = bytearray(b'\x04')
    CASH_DEVICE_SETUP_MODE = bytearray(b'\x00')
    COIN_DEVICE_SETUP_MODE = bytearray(b'\x01')
    CASH_COIN_DEVICE_ACCEPT_ALL = bytearray(b'\xFF\xFF')
    # ---------------------------------- END ----------------------------------

    # ----------------------------- 4.1.1 VMC 收钱通知 (VMC 发出) -----------------------------
    RECEIVE_MONEY_COMMAND = bytearray(b'\x21')
    # ---------------------------------- END ----------------------------------

    # ---------------------- 4.1.2 VMC报告当前金额 (VMC发出) ---------------------
    CURRENT_CREDIT_IN_VMC = bytearray(b'\x23')
    # ---------------------------------- END ----------------------------------

    # ----------------------------- 4.1.5 上位机请求获取 VMC 状态信息  -----------------------------
    MACHINE_INFO_COMMAND = bytearray(b'\x51')
    MACHINE_INFO_LENGTH = bytearray(b'\x01')
    # ---------------------------------- END ------------------------------

    # ----------------------------- 4.1.5 上位机收到钱币 (上位机发出)  -----------------------------
    MACHINE_UPDATE_BALANCE_COMMAND = bytearray(b'\x27')
    MACHINE_UPDATE_BALANCE_LENGTH = bytearray(b'\x06')

    PAYMENT_TYPE_NOTE = bytearray(b'\x01')
    PAYMENT_TYPE_COIN = bytearray(b'\x02')
    PAYMENT_TYPE_ACCEPT = bytearray(b'\x08')
    # ---------------------------------- END ------------------------------

    # ----------------------------- 4.1.4 上位机找零请求 (上位机发出) -----------------------------
    REFUND_COMMAND = bytearray(b'\x25')
    REFUND_COMMAND_LENGTH = bytearray(b'\x01')

    REFUND_DONE_COMMAND = bytearray(b'\x26')
    # ---------------------------------- END ----------------------------------

    # ----------------------- 4.5.51 升降机层定位  -------------------------
    LIFTER_SETTING_POSITION_COMMAND = bytearray(b'\x51')

    LIFTER_SETTING_POSITION_PARAMETER = bytearray(b'\x01')
    LIFTER_SETTING_GET_POSITION_PARAMETER = bytearray(b'\x00')

    LIFTER_SETTING_POSITION_LENGTH = bytearray(b'\x07')
    LIFTER_SETTING_GET_POSITION_LENGTH = bytearray(b'\x05')

    LIFTER_POSITION_READ_SET_SUCCESS = bytearray(b'\x00')
    LIFTER_POSITION_READ_SET_FAILED = bytearray(b'\x01')

    LIFTER_MAIN_MACHINE = bytearray(b'\x00')
    LIFTER_SUB_MACHINE = bytearray(b'\x01')
    # ---------------------------------- END ------------------------------

    # ----------------------- 4.5.28 设置温控仪  -------------------------
    TEMPERATURE_CONTROLLER_SETUP_COMMAND = bytearray(b'\x28')

    TEMPERATURE_CONTROLLER_READ_PARAMETER = bytearray(b'\x00')
    TEMPERATURE_CONTROLLER_SET_PARAMETER = bytearray(b'\x01')

    TEMPERATURE_CONTROLLER_READ_LENGTH = bytearray(b'\x04')
    TEMPERATURE_CONTROLLER_SET_LENGTH = bytearray(b'\x06')
    # -------------------------------- END ---------------------------------

    # ----------------------- 4.5.36 查询温控仪状态  -------------------------
    TEMPERATURE_CONTROLLER_STATUS_COMMAND = bytearray(b'\x36')
    TEMPERATURE_CONTROLLER_STATUS_PARAMETER = bytearray(b'\x00')

    TEMPERATURE_CONTROLLER_STATUS_LENGTH = bytearray(b'\x04')

    TEMPERATURE_CONTROLLER_STATUS_READ_SUCCESS = bytearray(b'\x00')
    TEMPERATURE_CONTROLLER_STATUS_READ_FAILED = bytearray(b'\x01')
    # -------------------------------- END ---------------------------------

    # ----------------------- 4.5.26 卡货转 1/4 圈设置  -------------------------
    QUARTER_TURN_COMMAND = bytearray(b'\x26')
    QUARTER_TURN_READ_SETTING_PARAMETER = bytearray(b'\x00')
    QUARTER_TURN_WRITE_SETTING_PARAMETER = bytearray(b'\x01')

    QUARTER_TURN_READ_SETTING_LENGTH = bytearray(b'\x05')
    QUARTER_TURN_WRITE_SETTING_LENGTH = bytearray(b'\x06')

    QUARTER_TURN_WRITE_ENABLE_MAIN_MACHINE = bytearray(b'\x01')
    QUARTER_TURN_WRITE_DISABLE_MAIN_MACHINE = bytearray(b'\x00')

    QUARTER_TURN_WRITE_ENABLE_SUB_MACHINE = bytearray(b'\x00')
    QUARTER_TURN_WRITE_DISABLE_SUB_MACHINE = bytearray(b'\x01')

    QUARTER_TURN_SETTING_SUCCESS = bytearray(b'\x00')
    QUARTER_TURN_SETTING_FAILED = bytearray(b'\x01')
    # -------------------------------- END ---------------------------------

    CHECK_SLOT_COMMAND = bytearray(b'\x01')
    CHECK_SLOT_LENGTH = bytearray(b'\x05')

    MAIN_MACHINE = bytearray(b'\x00')
    SUB_MACHINE = bytearray(b'\x01')
