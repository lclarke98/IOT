local startSetup = function()
    print("start setup")
    wifi.setmode(wifi.STATIONAP)
    wifi.ap.config({ssid = "TestSSID", auth = wifi.OPEN})
    enduser_setup.manual(true)
    enduser_setup.start()
end
