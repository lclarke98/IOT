mytimer = tmr.create()
mytimer:register(2000, 1, function()
    pinLED1 = 4
    gpio.mode(pinLED1, gpio.OUTPUT)
    gpio.write(pinLED1, gpio.LOW)
    pinLED2 = 0
    gpio.mode(pinLED2, gpio.OUTPUT)
    gpio.write(pinLED2, gpio.HIGH)
end)
mytimer:start()
