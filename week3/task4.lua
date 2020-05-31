push_threshold = 1000
tmr_interval = 100
count_threshold = math.floor(push_threshold / tmr_interval)
dhtPin = 2
buttonPin = 7
gpio.mode(buttonPin, gpio.INPUT)
gpio.write(buttonPin, gpio.LOW)
pushed_count = 0
pushed = 0
long_pushed = 0
timerPush = tmr.create()
timerRelease = tmr.create()
timerSensor = tmr.create()

timerSensor:register(500, 1, function()
    if gpio.read(buttonPin) == 0 then
        pushed = 1
        status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin)
        if status == dht.OK then
            print("DHT Temperature:" .. temp .. ";" .. "Humidity:" .. humi)
        elseif status == dht.ERROR_CHECKSUM then
            print("DHT Checksum error.")
        elseif status == dht.ERROR_TIMEOUT then
            print("DHT timed out.")
        end
    end
end)

timerPush:register(tmr_interval, 1, function()
    if gpio.read(buttonPin) == 1 then
        pushed_count = pushed_count + 1
        pushed = 1
        print(pushed_count)
    end
end)

timerRelease:register(tmr_interval, 1, function()
    if gpio.read(buttonPin) == 0 and pushed == 1 then
        if pushed_count >= count_threshold then
            pushed_count = 0
            pushed = 0
            long_pushed = 1
            timerSensor:start()
        elseif gpio.read(buttonPin) == 0 and pushed == 0 then
            if pushed_count >= count_threshold then
                pushed_count = 0
                pushed = 1
                long_pushed = 1
                timerSensor:stop()
            end
        else
            pushed_count = 0
            long_pushed = 0
        end
    end
end)

timerPush:start()
timerRelease:start()
