pinLED = 4
gpio.mode(pinLED, gpio.OUTPUT)
gpio.write(pinLED, gpio.HIGH)


wifi.sta.sethostname("NodeMCU")
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = "******"
station_cfg.pwd = "******"
station_cfg.save = true
wifi.sta.config(station_cfg)
wifi.sta.connect()

HOST = "io.adafruit.com"
PORT = 1883
PUBLISH_TOPIC = 'lclarke98/feeds/iot'
SUBSCRIBE_TOPIC = "lclarke98/feeds/iot"
ADAFRUIT_IO_USERNAME = "lclarke98"
ADAFRUIT_IO_KEY = "DO NOT COMMIT"
m = mqtt.Client("Client1", 300, ADAFRUIT_IO_USERNAME, ADAFRUIT_IO_KEY)

mytimer = tmr.create()
mytimer:register(3000, 1, function()
    if wifi.sta.getip() == nil then
        print("Connecting to AP...\n")
    else
        ip, nm, gw = wifi.sta.getip()
        mac = wifi.sta.getmac()
        rssi = wifi.sta.getrssi()
        print("IP Info: \nIP Address: ", ip)
        print("Netmask: ", nm)
        print("Gateway Addr: ", gw)
        print("MAC: ", mac)
        print("RSSI: ", rssi, "\n")
        mytimer:stop()
    end
end)
mytimer:start()


m:lwt("/lwt", "Now offline", 1, 0)

m:on("connect", function(client)
    print("Client connected")
    print("MQTT client connected to " .. HOST)
    client:subscribe(SUBSCRIBE_TOPIC, 1,
                     function(client) print("Subscribe successfully") end)
end)

m:on("offline", function(client) print("Client offline") end)

m:on("message", function(client, topic, data)
    print(topic .. ":")
    if data ~= nil then
        print(data)
        if data == 'ON' then
            LEDOnOff = 0
        else
            LEDOnOff = 1
        end
        if LEDOnOff == 1 or LEDOnOff == 0 then
            gpio.write(pinLED, LEDOnOff)
        end
    end
end)

m:connect(HOST, PORT, false, false, function(conn) end, function(conn, reason)
    print("Fail! Failed reason is: " .. reason)
end)
