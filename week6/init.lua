wifi.sta.autoconnect(1)
--autoconnect
wifi.sta.sethostname("NodeMCU")
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="TP-Link_2854" 
station_cfg.pwd="Leo_Clarke1998"
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.connect()
--wifi.sta.disconnect()
--manual connect and disconnect
pinLED1=4
srv = net.createServer(net.TCP,30)
--TCP, 30s for an inactive client to be disconnected
--try srv = net.createServer(net.UDP,10)
srv:listen(2020, function(conn)
    conn:send("Send to all clients who connect to Port 80, hello world! \n")
    conn:on("receive", function(conn, s)
        print(s)
        conn:send(s)
    end)
    conn:on("connection",function(conn, s)
        conn:send("Now in connection") 
    end)
    conn:on("disconnection", function(conn, s)
        print("Now we are disconnected\n")
    end)
    conn:on("sent",function(conn, s)
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
        print("What we receive from the Client\n" .. s .. "\n")
    end)
end
)
