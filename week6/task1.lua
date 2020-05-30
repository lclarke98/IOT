wifi.sta.autoconnect(1)
wifi.sta.sethostname("NodeMCU")
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = "******"
station_cfg.pwd = "******"
station_cfg.save = true
wifi.sta.config(station_cfg)

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
        cl = net.createConnection(net.TCP, 0)
        cl:on("connection", function(conn, s)
            conn:send("Now in connection")
        end)
        cl:on("disconnection",
              function(conn, s) print("Now we are disconnected\n") end)
        cl:on("sent", function(conn, s)
            print("Message has been sent out\n")
        end)
        cl:on("receive", function(conn, s)
            print("What we receive from the server\n" .. s .. "\n")
        end)
        cl:connect(1990, "192.168.0.123")
    end
end)
mytimer:start()
