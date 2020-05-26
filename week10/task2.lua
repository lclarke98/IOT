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
        post()
        mytimer:stop()
    end
end)
mytimer:start()

function post()
    http.post('http://httpbin.org/post', 'Content-Type: application/json\r\n',
              '{"IoT":"2020","This is":"Json Format","Please check":' ..
                  '"How the data are shaped"}', function(code, data)
        if (code < 0) then
            print("HTTP request failed")
        else
            print(code)
            print(data)
        end
    end)
end

function put()
    http.put('http://httpbin.org/put', 'Content-Type: text/plain\r\n',
             'IoT 2020 plain text', function(code, data)
        if (code < 0) then
            print("HTTP request failed")
        else
            print(code)
            print(data)
        end
    end)
end

function delete()
    http.delete('http://httpbin.org/delete', "", "", function(code, data)
        if (code < 0) then
            print("HTTP request failed")
        else
            print(code)
            print(data)
        end
    end)
end
