irPin = 1
gpio.mode(irPin, gpio.INT)
motionstate = 0
print(gpio.read(irPin))
ledPin = 4
gpio.mode(ledPin, gpio.OUTPUT)
gpio.write(ledPin, gpio.HIGH)
mytimer = tmr:create()
mytimer:register(300, 1, function()
    level = gpio.read(irPin)
    if motionstate == 0 then
        print('no motion detected')
        gpio.write(ledPin, gpio.HIGH)
    else
        motionstate = 0
    end
    if level == gpio.HIGH then
        print('motion detected')
        gpio.write(ledPin, gpio.LOW)
        motionstate = 1
        tmr.delay(5000000)
    end
end)
mytimer:start()
