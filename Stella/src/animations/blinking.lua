-- Settings
BLINK_MIN_DELAY = 5
BLINK_CHANCE = 0.1
BLINK_TEXTURE_HEIGHT = 4
BLINK_TEXTURE_WIDTH = 6
BLINK_TEXTURE_OFFSET_X = 64
BLINK_TEXTURE_AMOUNT = 4

local function blink_tick(data)
    if data.delay >= BLINK_MIN_DELAY then
        if data.blinking then
            data.time = data.time + 1
            if data.time >= BLINK_TEXTURE_AMOUNT - 1 then
                data.delay = 0
                data.time = 0
                data.blinking = false
            end
        elseif math.random() < BLINK_CHANCE then
            data.blinking = true
        end
    else
        data.delay = data.delay + 1
    end
end

local function blink_render(data)
    model.Base.Head.Eyes.setUV({
        data.time / (TEXTURE_WIDTH / BLINK_TEXTURE_WIDTH) +
            BLINK_TEXTURE_OFFSET_X, 0
    })
end

BLINK_ANIMATION = {
    data = {delay = 0, time = 0, blinking = false},
    every = 2,
    criteria = function() return true; end,
    tick = blink_tick,
    render = blink_render
}