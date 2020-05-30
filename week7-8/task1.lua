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
        print("IP Info: \nIP Address: ", ip)
        sntp.sync(tmsrv, function()
            print("Sync succeeded")
            mytimer:stop()
            stampTime()
        end, function() print("Synchronization failed!") end, 1)

    end
end)
mytimer:start()

function stampTime()
    sec, microsec, rate = rtctime.get()
    tm = rtctime.epoch2cal(sec, microsec, rate)
    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"],
                        tm["day"], tm["hour"], tm["min"], tm["sec"]))
end
