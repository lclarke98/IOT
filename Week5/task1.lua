wifi.sta.autoconnect(1)
--autoconnect
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="TP-Link_2854"
station_cfg.pwd="Leo_Clarke1998"
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
