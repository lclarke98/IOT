wifi.sta.autoconnect(1)
--autoconnect
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="uopiot2020"
station_cfg.pwd="2020a202"
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.connect()
--wifi.sta.disconnect()
--manual connect and disconnect



HOST = "io.adafruit.com"
PORT = 1883
ADAFRUIT_IO_USERNAME = "lclarke98"
ADAFRUIT_IO_KEY = "DONT COMMIT IT"
m = mqtt.Client("Client1", 300, ADAFRUIT_IO_USERNAME, ADAFRUIT_IO_KEY)
m:lwt("/lwt", "Now offline", 1, 0)
m:on("connect", function(client)
    print("Client connected")
    print("MQTT client connected to" .. HOST)
    client:subscribe(SUBSCRIBE_TOPIC, 1,
                     function(client) print("Subscribe successfully") end)
end)
m:on("offline", function(client) print("Client offline") end)
m:connect(HOST, PORT, false, false, function(conn) end, function(conn, reason)
    print("ERROR: " .. reason)
end)
