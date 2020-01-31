dc=0
pinDim = 3
pwm.setup(pinDim,1000,dc)
pwm.start(pinDim)
mytimer = tmr.create()


function getDC(currentDC)
    if(currentDC > 1010) then
        dc = 1023
    elseif(currentDC < 10) then
        dc = 0
    else
        dc = currentDC
    end
    return dc
end

mytimer:alarm(200,tmr.ALARM_AUTO,function()
    dc=dc-10
    print(dc)
    pwm.setduty(pinDim,dc)
    if (dc<10) then
        dc=1023
    end
end
)