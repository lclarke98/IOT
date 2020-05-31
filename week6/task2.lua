wifi.sta.autoconnect(1)
wifi.sta.sethostname("NodeMCU")
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = "******"
station_cfg.pwd = "******"
station_cfg.save = true
wifi.sta.config(station_cfg)
wifi.sta.connect()

srv = net.createServer(net.TCP, 30)

srv:listen(2020, function(conn)
    conn:send("Send to all clients who connect to Port 80, hello world! \n")
    conn:on("receive", function(conn, s)
        print(s)
        conn:send(s)
    end)
    conn:on("connection", function(conn, s) conn:send("In connection\n") end)
    conn:on("disconnection", function(conn, s) print("Disconnected\n") end)
    conn:on("sent",
            function(conn, s) print("Message sent out from Server\n") end)
    conn:on("receive", function(conn, s)
        print("Received from the Client\n" .. s .. "\n")
    end)
end)
