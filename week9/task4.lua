pinADC = 0
digitV = 0

wifi.sta.sethostname("uopNodeMCU")
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
    print("MQTT client connected to" .. HOST)
    client:subscribe(SUBSCRIBE_TOPIC, 1,
                     function(client) print("Subscribe successfully") end)
    pubADC(client)
end)
m:on("offline", function(client) print("Client offline") end)

m:connect(HOST, PORT, false, false, function(conn) end, function(conn, reason)
    print("Fail! Failed reason is: " .. reason)
end)

mytimerADC = tmr.create()
mytimerADC:register(400, 1, function()
    digitV = adc.read(pinADC)
    print(digitV)
end)
mytimerADC:start()

function pubADC(client)
    mytimerPublish = tmr.create()
    mytimerPublish:register(2000, 1, function()
        client:publish(PUBLISH_TOPIC, tostring(digitV), 1, 0,
                       function(client) print("reading sent: ", digitV) end)
    end)
    mytimerPublish:start()
end

