pinPWM = 3
freq = 1000
dc = 1023
pwm.setup(pinPWM, freq, dc)
pwm.start(pinPWM)

wifi.sta.sethostname("NodeMCU")
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = "******"
station_cfg.pwd = "******"
station_cfg.save = true
wifi.sta.config(station_cfg)
wifi.sta.connect()

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

HOST = "io.adafruit.com"
PORT = 1883
PUBLISH_TOPIC = 'lclarke98/feeds/iot'
SUBSCRIBE_TOPIC = "lclarke98/feeds/iot"
ADAFRUIT_IO_USERNAME = "lclarke98"
ADAFRUIT_IO_KEY = "DO NOT COMMIT"

m = mqtt.Client("Client1", 300, ADAFRUIT_IO_USERNAME, ADAFRUIT_IO_KEY)

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
        data = tonumber(data)
        if data > 1023 then
            dc = 1023
        else
            dc = math.floor(data)
        end
        pwm.setduty(pinPWM, dc)
    end
end)

m:connect(HOST, PORT, false, false, function(conn) end, function(conn, reason)
    print("Fail! Failed reason is: " .. reason)
end)
