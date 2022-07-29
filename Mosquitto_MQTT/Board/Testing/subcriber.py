import paho.mqtt.client as mqtt
import time

def on_message(client, userdata, message):
    print("received message: " ,str(message.payload.decode("utf-8")))

mqttBroker ="103.215.136.99"

client = mqtt.Client("Smartphone")
client.username_pw_set("mmwv2", "RnD_2022")
client.connect(mqttBroker) 

client.loop_start()

client.subscribe("MMWV2TOPIC")
client.on_message=on_message 

time.sleep(30)
client.loop_stop()