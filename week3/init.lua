dhtPin = 2
buttonPin = 7
gpio.mode(buttonPin, gpio.INPUT)
gpio.write(buttonPin, gpio.HIGH)
pushed = 0
mytimer = tmr.create()

mytimer:register(100, 1, function()
    if gpio.read(buttonPin)==0 then
        pushed = 1
        status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin)
        if status == dht.OK then
            print("DHT Temperature:"..temp..";".."Humidity:"..humi)
            elseif status == dht.ERROR_CHECKSUM then
            print( "DHT Checksum error." )
            elseif status == dht.ERROR_TIMEOUT then
            print( "DHT timed out." )
        end
    end
end)

mytimer:start()
