ADC = 0
LED = 4
timer = tmr.create()
pwm.setup(LED, 500, 1023)
pwm.start(LED)

timer:register(200, 1, function()
    dc = adc.read(ADC)
    print(dc)
    pwm.setduty(LED, math.floor(dc / 2))
end)

timer:start()

