class MdbParameter:
    COMMAND_DISPENSE_10 = [0x0F, 0x02, 0x01]
    COMMAND_DISPENSE_20 = [0x0F, 0x02, 0x02]
    COMMAND_DISPENSE_50 = [0x0F, 0x02, 0x05]
    COMMAND_RESET_COIN = [0x08]
    COMMAND_DISABLE_COIN = [0x0C, 0x00, 0x00, 0x00, 0x00]
    COMMAND_ENABLE_COIN = [0x0C, 0xFF, 0xFF, 0xFF, 0xFF]
    COMMAND_SETUP_COIN = [0x09]
    COMMAND_GET_TUBE_STATUS = [0x0A]

    COMMAND_RESET_BILL = [0x30]
    COMMAND_DISABLE_BILL = [0x34, 0x00, 0x00, 0x00, 0x00]
    COMMAND_ENABLE_BILL = [0x34, 0x00, 0x1F, 0x00, 0x00]
    COMMAND_SETUP_BILL = [0x31]

    COIN_VALUE_10_OLD = {'Code': '50', 'Value': 0.10}  # Old 10 cents
    COIN_VALUE_20_NEW = {'Code': '53', 'Value': 0.20}  # New 20 cents
    COIN_VALUE_50_NEW = {'Code': '55', 'Value': 0.50}  # New 50 cents
    COIN_VALUE_10_NEW = {'Code': '51', 'Value': 0.10}  # New 10 cents
    COIN_VALUE_20_OLD = {'Code': '52', 'Value': 0.20}  # Old 20 cents
    COIN_VALUE_50_OLD = {'Code': '54', 'Value': 0.50}  # Old 50 cents
    COIN_VALUE_10_OLD_BIG = {'Code': '40', 'Value': 0.10}  # Old big 10 cents
    COIN_VALUE_20_OLD_BIG = {'Code': '42', 'Value': 0.20}  # Old big 20 cents
    COIN_VALUE_50_OLD_BIG = {'Code': '44', 'Value': 0.50}  # Old big 50 cents
    COIN_VALUE_ALL = [COIN_VALUE_10_OLD, COIN_VALUE_20_NEW, COIN_VALUE_50_NEW,
                      COIN_VALUE_10_NEW, COIN_VALUE_20_OLD, COIN_VALUE_50_OLD,
                      COIN_VALUE_10_OLD_BIG, COIN_VALUE_20_OLD_BIG, COIN_VALUE_50_OLD_BIG]

    BILL_VALUE_1 = {'Code': '80', 'Value': 1.00}  # RM1
    BILL_VALUE_5 = {'Code': '81', 'Value': 5.00}  # RM5
    BILL_VALUE_10 = {'Code': '82', 'Value': 10.00}  # RM10
    BILL_VALUE_20 = {'Code': '83', 'Value': 20.00}  # RM20
    BILL_VALUE_50 = {'Code': '84', 'Value': 50.00}  # RM20
    BILL_VALUE_1_NEW = {'Code': 'A0', 'Value': 1.00}  # RM1
    BILL_VALUE_5_NEW = {'Code': 'A1', 'Value': 5.00}  # RM5
    BILL_VALUE_10_NEW = {'Code': 'A2', 'Value': 10.00}  # RM10
    BILL_VALUE_20_NEW = {'Code': 'A3', 'Value': 20.00}  # RM20
    BILL_VALUE_50_NEW = {'Code': 'A4', 'Value': 50.00}  # RM20
    BILL_VALUE_ALL = [BILL_VALUE_1, BILL_VALUE_5,
                      BILL_VALUE_10, BILL_VALUE_20, BILL_VALUE_50,
                      BILL_VALUE_1_NEW, BILL_VALUE_5_NEW,
                      BILL_VALUE_10_NEW, BILL_VALUE_20_NEW, BILL_VALUE_50_NEW,]

    BILL_DEVICE_CODE = '30'
    COIN_DEVICE_CODE = '08'
