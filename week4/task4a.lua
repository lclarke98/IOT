buttonPin = 1
gpio.mode(buttonPin, gpio.INPUT)
gpio.write(buttonPin, gpio.LOW)
pushed = 0
mytimer = tmr.create()

ADC = 0
LED = 4
timer = tmr.create()
pwm.setup(LED, 500, 10)
pwm.start(LED)

-- This one can only allow you to detect push for once and only once
mytimer:register(100, 1, function()
    if gpio.read(buttonPin) == 1 and pushed == 0 then
        print("here")
        
        timer:start()
        pushed = 1
    elseif gpio.read(buttonPin) == 1 and pushed == 1 then
        pushed = 0
        pwm.setup(LED, 500, 0)
        timer:stop()
    end
end)

timer:register(200, 1, function()
    dc = adc.read(ADC)
    print(dc)
    pwm.setduty(LED, math.floor(dc / 2))
end)

mytimer:start()


