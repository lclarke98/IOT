wifi.setmode(wifi.SOFTAP) -- set AP parameter
config = {}
config.ssid = "******"
config.pwd = "******"
wifi.ap.config(config)
bc = wifi.ap.getbroadcast()
print("AP Gateway Address: ", bc)

timer = tmr.create()
timer:register(3000, 1, function()
    table = {}
    table = wifi.ap.getclient()
    print("AP IP Address: " .. wifi.ap.getip())
    clientCount = 0
    for mac, ip in pairs(table) do
        clientCount = clientCount + 1
        print("Client No." .. clientCount)
        print("MAC: ", mac)
        print("IP: ", ip)
    end
    if clientCount > 0 then timer:stop() end
end)
timer:start()

pinLED = 4
gpio.mode(pinLED, gpio.OUTPUT)
svr = net.createServer(net.TCP)

function htmlUpdate(sck, flag)
    html = '<html>\r\n<head>\r\n<title>LED LAN Control</title>\r\n</head>\r\n'
    html = html ..
               '<body>\r\n<h1>LED</h1>\r\n<p>Click the button below to switch LED on and off.</p>\r\n<form method=\"get\">\r\n'
    if flag then
        strButton = 'LED_OFF'
    else
        strButton = 'LED_ON'
    end
    html = html .. "<input type=\"button\" value=\"" .. strButton ..
               "\" onclick=\"window.location.href='/" .. strButton .. "'\">\r\n"
    html = html .. "</form>\r\n</body>\r\n</html>\r\n"
    sck:send(html)
end

function setMode(sck, data)
    print(data)
    if string.find(data, "GET /LED_ON") then
        htmlUpdate(sck, true)
        gpio.write(pinLED, gpio.HIGH)
    elseif string.find(data, "GET / ") or string.find(data, "GET /LED_OFF") then
        htmlUpdate(sck, false)
        gpio.write(pinLED, gpio.LOW)
    else
        sck:send("<h2>Error, no matched string has been found!</h2>")
        sck:on("sent", function(conn) conn:close() end)
    end
end

if svr then svr:listen(80, function(conn) conn:on("receive", setMode) end) end
