--  ___ _____ ___ _    _      _
-- / __|_   _| __| |  | |    /_\
-- \__ \ | | | _|| |__| |__ / _ \
-- |___/ |_| |___|____|____/_/ \_\
--
-- Figura Character for KodingDev
-- Blinking Settings
BLINK_MIN_DELAY = 5
BLINK_CHANCE = 0.1
BLINK_TEXTURE_HEIGHT = 4
BLINK_TEXTURE_WIDTH = 6
BLINK_TEXTURE_OFFSET_X = 64
BLINK_TEXTURE_AMOUNT = 4

-- General settings
TEXTURE_WIDTH = 128
TEXTURE_HEIGHT = 64

-- Variables
TICK_COUNT = 0

--     _   _  _ ___ __  __   _ _____ ___ ___  _  _
--    /_\ | \| |_ _|  \/  | /_\_   _|_ _/ _ \| \| |
--   / _ \| .` || || |\/| |/ _ \| |  | | (_) | .` |
--  /_/ \_\_|\_|___|_|  |_/_/ \_\_| |___\___/|_|\_|
--
-- Handles transitioning between body animations.

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

-- TODO: Clean this up later
local animations = {
    -- Crying
    [1] = {
        criteria = function()
            return player.getRot()[1] > 30 and player.getAnimation() == 'CROUCHING';
        end,
        every = 4,
        priority = -1,
        tick = function(data)
            local player = player.getPos()
            for _ = 1, 2 do
                particle.addParticle("rain", {
                    player.x + math.random(-0.3, 0.3), player.y + 2, player.z + math.random(-0.3, 0.3), 0, 0, 0
                })
            end
        end,
        uv = {
            elements = {model.Base.Head.Eyes},
            textureWidth = 6,
            textureHeight = 4,
            frames = 2,
            uvStart = {0, 4}
        }
    },

    -- Blinking
    [0] = {
        data = {delay = 0, time = 0, blinking = false},
        every = 2,
        criteria = function() return true; end,
        tick = blink_tick,
        render = blink_render
    }
}

local function runAnimations(tick)
    for _, animation in pairs(animations) do
        if animation.criteria() then
            if TICK_COUNT % (animation.every or 1) == 0 then
                if animation.uv then
                    if animation.data == nil then
                        animation.data = {frame = 0}
                    end
                    local frame = (animation.data.frame or 0)

                    if tick then
                        frame = frame + 1
                        if frame >= animation.uv.frames then
                            frame = 0
                        end
                        animation.data.frame = frame
                    else
                        for index = 1, #animation.uv.elements do
                            local element = animation.uv.elements[index]
                            element.setUV(
                                {
                                    (animation.uv.textureWidth * frame +
                                        animation.uv.uvStart[1]) / TEXTURE_WIDTH,
                                    animation.uv.uvStart[2] / TEXTURE_HEIGHT
                                })
                        end
                    end
                end

                local func = tick and animation.tick or animation.render
                if func then func(animation.data or {}) end
            end
            return
        end
    end
end

--  ___ ___ ___ _   _ ___    _
-- | __|_ _/ __| | | | _ \  /_\
-- | _| | | (_ | |_| |   / / _ \
-- |_| |___\___|\___/|_|_\/_/ \_\
--
-- Implementations for the base figura methods.

-- Disable all vanilla model pieces
for _, value in pairs(vanilla_model) do value.setEnabled(false) end

function tick()
    TICK_COUNT = TICK_COUNT + 1
    runAnimations(true)
end

function render(delta) runAnimations(false) end
