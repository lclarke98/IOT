-- variable declaration
ADC = 0
LED = 4
timer = tmr.create()
pwm.setup(pinLED, 500, 1023)
pwm.start(pinLED)

-- timer function
timer:register(200, 1, function() 
    dc = adc.read(ADC)
    print(dc)
    pwm.setduty(LED, math.floor(dc/2))
end
)

timer:start()
