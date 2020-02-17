
dhtPin = 2



mytimer = tmr.create()

mytimer:register(100, 1, function()
    status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin)


if (srv ~= nil) then
    -- shut down old server instance
    srv:close()
else
    srv=net.createServer(net.TCP)
end
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = ""
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        buf = buf.."DHT Temperature:"..temp..";".."Humidity:"..humi
        client:send(buf)
    end)
    conn:on("sent", function(client)
        client:close()
    end)
end)
end)

mytimer:start()
