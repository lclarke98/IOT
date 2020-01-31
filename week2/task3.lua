dc=0
pinDim = 3
pwm.setup(pinDim,1000,dc)
pwm.start(pinDim)
mytimer = tmr.create()


function fromBottom()
    dc=0
    dc=dc+10
    print(dc)
    pwm.setduty(pinDim,dc)
    if (dc > 1010) then
        fromTop()
    end
end

function fromTop()
    dc=1023
    dc=dc-10
    print(dc)
    pwm.setduty(pinDim,dc)
    if (dc < 10) then
        fromBottom()
    end
end

mytimer:alarm(200,tmr.ALARM_AUTO,function()
    fromBottom()
end
)