dc=0
pinDim = 3
pwm.setup(pinDim,1000,dc)
pwm.start(pinDim)
mytimer = tmr.create()
mytimer:alarm(200,tmr.ALARM_AUTO,function()
 dc=dc+10
 print(dc)
 pwm.setduty(pinDim,dc)
 if (dc>1000) then
 dc=0
 end
end
)