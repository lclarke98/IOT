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
        cl = net.createConnection(net.TCP, 0)
        -- create a TCP based not encryped client
        cl:on("connection", function(conn, s)
            dhtPin = 2
            status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin)
            if status == dht.OK then
                -- 3 different status
                -- dht.OK, dht.ERROR_CHECKSUM, dht.ERROR_TIMEOUT 
                conn:send("DHT Temperature:" .. temp .. ";" .. "Humidity:" .. humi)
                -- 2 dots are used for concatenation
            elseif status == dht.ERROR_CHECKSUM then
                conn:send("DHT Checksum error.")
            elseif status == dht.ERROR_TIMEOUT then
                conn:send("DHT timed out.")
            end
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

