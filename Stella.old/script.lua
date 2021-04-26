-- Settings
BLINK_MIN_DELAY = 10
BLINK_CHANCE = 0.05
TEXTURE_WIDTH = 64
BLINK_TEXTURE_HEIGHT = 2

-- Blinking Variables
time = 0
blinking = 0
delay = 0
ticks = 0

function tick()
    ticks = ticks + 1
    if ticks % 2 == 0 then
        blink()
    end
end

function render(delta)
    uv_offset = {time/(TEXTURE_WIDTH/6), 0}
    model.HEAD.Eyes.setUV(uv_offset)
end

function blink()
    if delay >= BLINK_MIN_DELAY then
        if blinking == 0 then
            if math.random() < BLINK_CHANCE then
                blinking = 1
            end
        else
            time = time + 1
            if time >= 3 then
                time = 0
                blinking = 0
                delay = 0
            end
        end
    else
        delay = delay + 1
    end
end