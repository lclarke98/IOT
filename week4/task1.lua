pinADC = 0
mytimer = tmr.create()

mytimer:register(500, 1, function()
    digitV = adc.read(pinADC)
    print(digitV)
end)
mytimer:start()
