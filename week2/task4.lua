pinR = 1
pinY = 2
pinG = 3

onState = 1023
offState = 0

pwm.setup(pinR, 1000, offState)
pwm.setup(pinY, 1000, offState)
pwm.setup(pinG, 1000, offState)


pwm.start(pinR)
pwm.start(pinY)
pwm.start(pinG)

function trafficLight(dc_r,dc_y,dc_g)
    pwm.setduty(pinR,dc_r)
    pwm.setduty(pinY,dc_y)
    pwm.setduty(pinG,dc_g)
end

time = 100
mytimer = tmr.create()
mytimer:alarm(2000,tmr.ALARM_AUTO,function()
    time = time-20
    print(time)
    if(time == 80) then
        trafficLight(onState,offState,offState)
    elseif (time == 60) then 
        trafficLight(onState,onState,offState)
    elseif (time == 40) then
        trafficLight(offState,offState,onState)
    elseif (time == 20) then
        trafficLight(offState,onState,onState)
    else
        trafficLight(onState,offState,offState)
        time = 100
    end
end
)
