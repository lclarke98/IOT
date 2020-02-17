wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="TP-Link_2854"
station_cfg.pwd="Leo_Clarke1998"
station_cfg.save=false
wifi.sta.config(station_cfg)
wifi.sta.connect()

if wifi.sta.getip()== nil then
print("IP unavaiable, Waiting...")
else

print("Connected, IP is "..wifi.sta.getip())
dofile("server.lua")
end
