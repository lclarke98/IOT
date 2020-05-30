wifi.sta.sethostname("NodeMCU")
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = "******"
station_cfg.pwd = "******"
station_cfg.save = true
wifi.sta.config(station_cfg)

tmsrv = "uk.pool.ntp.org"

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
        sntp.sync(tmsrv, function()
            print("Sync succeeded")
            mytimer:stop()
            stampTime()
        end, function() print("Synchronization failed!") end, 1)
    end
end)
mytimer:start()

keyAPI = "9f418d12e2c0f5e721197b55a91010a3"
lat = 50.80
lon = -1.09

urlAPI =
    "http://api.openweathermap.org/data/2.5/weather?lat=" .. lat .. "&lon=" ..
        lon .. "&APPID=" .. keyAPI
http.get(urlAPI, nil, function(code, data)
    if (code < 0) then

        print("http request failed")
    else
        print("http response code:" .. code)
        obj:write(data)
        weatherPrint(currentWeather)
    end
end)

currentWeather = {}
mt = {}
t = {metatable = mt}
mt.__newindex = function(table, key, value)
    if (key == "description") or (key == "temp") or (key == "temp_min") or
        (key == "temp_max") or (key == "humidity") or (key == "speed") or
        (key == "deg") or (key == "sunrise") or (key == "sunset") then
        rawset(currentWeather, key, value)
    end
end
obj = sjson.decoder(t)
-- from json to a readable table 

function weatherPrint(t)
    print("\nWeather Today: " .. t["description"])
    print("\nTemperature: " .. t["temp"] - 273.15)
    print("\nMin Temperature: " .. t["temp_min"] - 273.15)
    print("\nMax Temperature: " .. t["temp_max"] - 273.15)
    print("\nHumidity: " .. t["humidity"])
    print("\nWind Speed: " .. t["speed"])
    print("\nWind Degree: " .. t["deg"])
    tm = rtctime.epoch2cal(t["sunrise"])
    print("\nSunrise Time: " ..
              string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"],
                            tm["mon"], tm["day"], tm["hour"], tm["min"],
                            tm["sec"]))
    tm = rtctime.epoch2cal(t["sunset"])
    print("\nSunset Time: " ..
              string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"],
                            tm["mon"], tm["day"], tm["hour"], tm["min"],
                            tm["sec"]))
end

function stampTime()
    sec, microsec, rate = rtctime.get()
    tm = rtctime.epoch2cal(sec, microsec, rate)
    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"],
                        tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

function stampTime()
    sec, microsec, rate = rtctime.get()
    tm = rtctime.epoch2cal(sec, microsec, rate)
    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"],
                        tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

cron.schedule("0 7 * * *", function(e)
    print("\n Alarm Clock \n It is 07:00!!! \n Get UP! \n")
    weatherPrint()
end)
