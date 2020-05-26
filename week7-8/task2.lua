tmsrv = "uk.pool.ntp.org"
sntp.sync(tmsrv, function()
    print("Sync succeeded")
    stampTime()
end, function() print("Synchronization failed!") end, 1)

function stampTime()
    sec, microsec, rate = rtctime.get()
    tm = rtctime.epoch2cal(sec, microsec, rate)
    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"],
                        tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

cron.schedule("* * * * *", function(e)
    print("once every min")
end)

cron.schedule("*/5 * * * *", function(e)
    print("once every 5 min")
end)

cron.schedule("2 7 * * *", function(e)
    print("\n Alarm \n 07:02!!! \n It Worked! \n")
end)
