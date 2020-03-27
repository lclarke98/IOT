import dht
import machine

d = dht.DHT11(machine.Pin(4))
d.measure()
temp = d.temperature() # eg. 23 (°C)
humi = d.humidity()    # eg. 41 (% RH)

print(temp, humi)
