wifi.setmode(wifi.STATIONAP)
wifi.ap.config({
    ssid = "nodeMCU",
    pwd = "test1234",
    auth = wifi.WPA2_PSK
})
print("AP IP:" .. wifi.ap.getip())
print("AP MAC:" .. wifi.ap.getmac())
print("STA MAC:" .. wifi.sta.getmac())
enduser_setup.manual(true)

enduser_setup.start()

mytimer = tmr.create()
mytimer:register(3000, 1, function()
    if wifi.sta.getip() == nil then
        print("Offline from any AP...\n")
    else
        ip, nm, gw = wifi.sta.getip()
        mac = wifi.sta.getmac()
        rssi = wifi.sta.getrssi()
        print("IP Info: \nIP Address: ", ip)
        print("Netmask: ", nm)
        print("Gateway Addr: ", gw)
        print("MAC: ", mac)
        print("RSSI: ", rssi, "\n")
    end
end)
mytimer:start()
