pinLED1=4
gpio.mode(pinLED1, gpio.OUTPUT)
--on for 2000ms, off for 1000ms, on for 1000ms, off for 300ms
interval1={2000,1000,1000,300}--variable type is table
--interval1=0 --0/1 for always on/off
indT=0;

mytimer=tmr.create()
mytimer:register(100, 1, function() 
    blinkLED(pinLED1,interval1)
end
)
mytimer:start()

function blinkLED(pinBlink,intervalBlink)
--change the interval of blinking {a,b,c,d...}, on for a ms, off for b ms, on for c ms, off for d ms,.....
    if type(intervalBlink)=="table" then
            indT=indT % tablelength(intervalBlink) + 1
            mytimer:interval(intervalBlink[indT]+1)--avoid 0 by +1 --Still blinking for 1ms. Can you think of an alternative to avoid this? 
            --A candy will be given to you by Dalin if you raise your hand and tell me or the teaching assistant your solution during the Week1 practical.
            gpio.write(pinBlink, (indT+1) % 2)   
    else
    --not a table, input as 0 always on, input as 1 or other always off
        gpio.write(pinBlink, intervalBlink or gpio.HIGH)
    end
end

function tablelength(T)
--function to return length of table
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
