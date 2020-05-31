wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid = "******"
station_cfg.pwd = "******"
station_cfg.save = true
wifi.sta.config(station_cfg)
wifi.sta.connect()

wifi.setmode(wifi.SOFTAP)
ap_cfg = {}
ap_cfg.ssid = "test"
ap_cfg.pwd = "test1234"

wifi.ap.config(ap_cfg)
