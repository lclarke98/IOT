pinLED1=4
gpio.mode(pinLED1, gpio.OUTPUT)
interval1={2000,1000,1000,300}
indT=0;

mytimer=tmr.create()
mytimer:register(100, 1, function() 
    blinkLED(pinLED1,interval1)
end
)
mytimer:start()

function blinkLED(pinBlink,intervalBlink)
    if type(intervalBlink)=="table" then
            indT=indT % tablelength(intervalBlink) + 1
            mytimer:interval(intervalBlink[indT]+1)
            gpio.write(pinBlink, (indT+1) % 2)   
    else
        gpio.write(pinBlink, intervalBlink or gpio.HIGH)
    end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end