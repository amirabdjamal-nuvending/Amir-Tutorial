import paho.mqtt.client as mqtt 
from random import randrange, uniform
import time

# mqttBroker ="192.168.1.23" 
mqttBroker ="103.215.136.99" 

client = mqtt.Client("Publisher_8")
client.username_pw_set("mmwv2", "RnD_2022")
client.connect(mqttBroker) 

# while True:
#     randNumber = uniform(20.0, 21.0)
#     client.publish("MMWV2TOPIC", randNumber)
#     print("Just published " + str(randNumber) + " to topic MMWV2TOPIC")
#     time.sleep(1)

while True:
    # randNumber = uniform(20.0, 21.0)
    client.publish("MMWV2TOPIC", "PUB_8")
    print("Just published " + "PUB_8" + " to topic MMWV2TOPIC")
    time.sleep(6)