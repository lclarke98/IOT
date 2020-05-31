pinLED1 = 4
gpio.mode(pinLED1, gpio.OUTPUT)
interval1 = {500, 300}
indT = 0;

dc = 1023

pwm.setup(pinLED1, 1000, dc)
pwm.start(pinLED1)

mytimer = tmr.create()
mytimer:register(100, 1, function() blinkLED(pinLED1, interval1) end)
mytimer:start()

function blinkLED(pinBlink, intervalBlink)
    if type(intervalBlink) == "table" then
        indT = indT % tablelength(intervalBlink) + 1
        mytimer:interval(intervalBlink[indT] + 1)
        gpio.write(pinBlink, (indT + 1) % 2)
        dc = dc - 10
        print(dc)
        pwm.setduty(pinDim, dc)
        if (dc < 10) then dc = 1023 end
    else
        gpio.write(pinBlink, intervalBlink or gpio.HIGH)
    end
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
