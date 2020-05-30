wifi.sta.autoconnect(1)

wifi.sta.sethostname("NodeMCU")
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = "******"
station_cfg.pwd = "******"
station_cfg.save = true
wifi.sta.config(station_cfg)
wifi.sta.connect()

pinLED1 = 4
srv = net.createServer(net.TCP, 30)

srv:listen(2020, function(conn)
    conn:send("Connected \n")
    conn:on("receive", function(conn, s)
        print(s)
        conn:send(s)
    end)
    conn:on("connection", function(conn, s) conn:send("Now in connection") end)
    conn:on("disconnection",
            function(conn, s) print("Now we are disconnected\n") end)
    conn:on("sent", function(conn, s)
        print("Message has been sent out from the Server\n")
    end)
    conn:on("receive", function(conn, s)
        if s == "1" then
            gpio.mode(pinLED1, gpio.OUTPUT)
            gpio.write(pinLED1, gpio.LOW)
        else
            gpio.mode(pinLED1, gpio.OUTPUT)
            gpio.write(pinLED1, gpio.HIGH)
        end
        print("Received from the Client\n" .. s .. "\n")
    end)
end)
