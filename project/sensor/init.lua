-- The sensor will connect to the hub and send the sensor data

wifi.sta.autoconnect(1)
-- autoconnect
wifi.sta.sethostname("uopNodeMCU")
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = "TP-Link_2854"
station_cfg.pwd = "Leo_Clarke1998"
station_cfg.save = true
wifi.sta.config(station_cfg)
-- wifi.sta.connect()
-- wifi.sta.disconnect()
-- manual connect and disconnect

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
        -- create a TCP based not encryped client
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
        -- on(event, function())
        -- event can be “connection”, “reconnection”, “disconnection”, “receive” or “sent”
        -- function(net.socket[, para]) is the callback function.
        -- The first parameter of callback is the socket.
        -- If event is “receive”, the second parameter is the received data as string.
        -- If event is “disconnection” or “reconnection”, the second parameter is error code.
        cl:connect(1990, "192.168.0.123")
        -- the local IP of your test server
    end
end)
mytimer:start()
