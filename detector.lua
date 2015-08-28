STATUS = 0

function vibrationDetector()
    local sensorPin = 4
    local counter = 0

    gpio.mode(sensorPin, gpio.INT)

    function debounce(fn)
        local last = 0
        local delay = 200000

        return function()
            local now = tmr.now()
            if now - last < delay then return end

            last = now
            return fn()
        end
    end

    function incCounter(level)
        counter = counter + 1
        print('counter')
        print(counter)
    end

    function updateStatus()
        if(counter > 3) then
            STATUS = 1
        else
            STATUS = 0
        end
        print('status')
        print(STATUS)
        counter = 0
    end

    gpio.trig(sensorPin, "up", debounce(incCounter))
    tmr.alarm(0, 45000, 1, updateStatus)
end

vibrationDetector()
