pinPWM = 0
freq = 1000
dc = 1023
dc_threshold = 1023
bottomUp = 0
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
    pubPWM(client)
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
-- m:on

m:connect(HOST, PORT, false, false, function(conn) end, function(conn, reason)
    print("Fail! Failed reason is: " .. reason)
end)

function pubPWM(client)
    mytimerPublish = tmr.create()
    mytimerPublish:register(5000, 1, function()
        client:publish(PUBLISH_TOPIC, tostring(dc), 1, 0,
                       function(client) print("Duty cycle sent: ", dc) end)
    end)
    mytimerPublish:start()
end

function changingPWM()
    if (bottomUp == 1) then
        if (dc < dc_threshold) then
            dc = dc + 1
            pwm.setduty(pinPWM, dc)
        else
            bottomUp = 0
        end
    else
        if (dc > 0) then
            dc = dc - 1
            pwm.setduty(pinPWM, dc)
        else
            bottomUp = 1
        end
    end
end
mytimerPWM = tmr.create()
mytimerPWM:register(1, tmr.ALARM_AUTO, function() changingPWM() end)
mytimerPWM:start()