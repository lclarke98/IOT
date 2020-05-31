buttonPin = 1
gpio.mode(buttonPin, gpio.INPUT)
gpio.write(buttonPin, gpio.LOW)
pushed = 0
mytimer = tmr.create()

-- This one can only allow you to detect push for once and only once
mytimer:register(100, 1, function()
    if gpio.read(buttonPin) == 1 and pushed == 0 then
        pushed = 1
        print("Button detected")
    end
end)

-- We will keep detecting the Button pushed with this one
-- mytimer:register(100, 1, function() 
-- if gpio.read(buttonPin)==1 and pushed == 0 then 
--    pushed = 1
--    print("Button detected")
-- end 
-- end)

mytimer:start()

-- How can you solve the problem ?
-- Think of a solution by yourself
