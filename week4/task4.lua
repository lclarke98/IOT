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
        print("0")
        pushed = 1
        pwm.setup(LED, 500, 0)
        pwm.start(LED)
    elseif gpio.read(buttonPin) == 1 and pushed == 1 then
        print("1")
        pushed = 2
        pwm.setup(LED, 500, 250)
        pwm.start(LED)
    elseif gpio.read(buttonPin) == 1 and pushed == 2 then
        print("2")
        pushed = 3
        pwm.setup(LED, 500, 350)
        pwm.start(LED)
    elseif gpio.read(buttonPin) == 1 and pushed == 3 then
        print("3")
        pushed = 4
        pwm.setup(LED, 500, 450)
        pwm.start(LED)
    elseif gpio.read(buttonPin) == 1 and pushed == 4 then
        print("4")
        pushed = 5
        pwm.setup(LED, 500, 550)
        pwm.start(LED)
    elseif gpio.read(buttonPin) == 1 and pushed == 5 then
        print("5")
        pushed = 0
        pwm.setup(LED, 500, 650)
        pwm.start(LED)
    end
end)

mytimer:start()

