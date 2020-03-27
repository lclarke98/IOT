import MySQLdb
import subprocess
import re
import sys
import time
import datetime
import Adafruit_DHT
sensor = Adafruit_DHT.DHT11
pin = 4  # GPIO numbering (Pin # 7)
# Open database connection
dbconn = MySQLdb.connect("35.189.72.7", "root", "root", "climateSensor") or die("could not connect to database")
cursor = dbconn.cursor()
# Continuously append data
while True:
    timestamp = datetime.datetime.now()
    today = timestamp.strftime("%d/%m/%Y %H:%M:%S")
    print (today)
    # Run the DHT program to get the humidity and temperature readings!
    humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
    print('Temp: {0:0.1f} C  Humidity: {1:0.1f} %'.format(temperature, humidity))
    # MYSQL DATA Processing
    print("SQL Injected!")
    cursor.execute("INSERT INTO data (datetime,humidity,tempC ) VALUES (%s, %s, %s)",
                   (timestamp, 55.45, 28.64))
    dbconn.commit()
    # cursor.close()
    time.sleep(5)


