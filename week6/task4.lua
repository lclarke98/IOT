wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="******"
station_cfg.pwd="******"
station_cfg.save=false
wifi.sta.config(station_cfg)
timer=tmr.create()
timer:register(3000, 1, function() 
   if wifi.sta.getip()==nil then
        print("Connecting to AP...\n")
   else
        ip, nm, gw=wifi.sta.getip()
        print("IP Info: \nIP Address: ",ip)
        print("Netmask: ",nm)
        print("Gateway Addr: ",gw,"\n")
   end 
end)
timer:start()

pinDHT=3
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(conn,request)           
        local status, temp, humi , temp_dec, humi_dec = dht.read11(pinDHT)
        local buf = ""
        if status == dht.OK then
            print("DHT Temperature:"..temp.." Humidity:"..humi.."\n")
        end
        buf=buf.."<html>"      
        buf=buf.."<head> <title>Temp/Humi</title> <meta http-equiv=\"refresh\" content=\"3\"> </head>"  
        buf=buf.."<body><p>Temperature: "..temp.."."..temp_dec.."C</p>"  
        buf=buf.."<p>Humidity: "..humi.."."..humi_dec.."%RH</p>" 
        conn:send(buf)
        conn:on("sent",function(conn) conn:close() end)         
    end)
end)
