-- D1 is connected to green led
-- D2 is connected to blue led
-- D3 is connected to red led
pwm.setup(1, 500, 512)
pwm.setup(2, 500, 512)
pwm.setup(3, 500, 512)
pwm.start(1)
pwm.start(2)
pwm.start(3)
function led(r, g, b)
    pwm.setduty(1, g)
    pwm.setduty(2, b)
    pwm.setduty(3, r)
end
led(512, 0, 0) --  set led to red
led(0, 0, 512) -- set led to blue.