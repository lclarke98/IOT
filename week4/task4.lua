-- variable declaration
ADC = 0
LED = 4
buttonPin = 1
timer = tmr.create()
timer1 = tmr.create()
pwm.setup(LED, 500, 1023)
pwm.start(LED)


timer1:register(100, 1, function()
    if gpio.read(buttonPin)==0 then
        timer:register(200, 1, function() 
            dc = adc.read(ADC)
            print(dc)
            pwm.setduty(LED, math.floor(dc/2))
        end
        )
        
    end
end)

timer:start()
timer1:start()
