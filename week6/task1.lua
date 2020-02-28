wifi.sta.autoconnect(1)
--autoconnect
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="changethat"
station_cfg.pwd="changethat"
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.connect()
--wifi.sta.disconnect()
--manual connect and disconnect

wifi.setmode(wifi.SOFTAP)
ap_cfg={}
ap_cfg.ssid="test"
ap_cfg.pwd="test1234"
--the rest have default value
--check them by yourself, which is helpful to know how it works - Dalin
wifi.ap.config(ap_cfg)





cl = net.createConnection(net.TCP, 0)
--create a TCP based not encryped client
cl:on("connection",function(conn, s)
conn:send("Now in connection")
end)
cl:on("disconnection",function(conn, s)
print(“Now we are disconnected\n”)
end)
cl:on("sent",function(conn, s)
print(“Message has been sent out\n”)
end)
cl:on("receive", function(conn, s)
print(“What we receive from the server\n” .. s .. “\n”)
end)
--on(event, function())
--event can be "connection", "reconnection", "disconnection", "receive" or "sent"
--function(net.socket[, para]) is the callback function.
--The first parameter of callback is the socket.
--If event is "receive", the second parameter is the received data as string.
--If event is "disconnection" or "reconnection", the second parameter is error code.
cl:connect(1990,”192.168.8.100”)
--the local IP of your test server