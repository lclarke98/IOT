wifi.setmode(wifi.STATIONAP)

enduser_setup.start()
print("AP IP:" .. wifi.ap.getip())
print("AP MAC:" .. wifi.ap.getmac())
print("STA MAC:" .. wifi.sta.getmac())
