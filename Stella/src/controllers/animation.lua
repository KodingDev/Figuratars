--! @depends animations/blinking animations/crying animations/lowhealth

--     _   _  _ ___ __  __   _ _____ ___ ___  _  _
--    /_\ | \| |_ _|  \/  | /_\_   _|_ _/ _ \| \| |
--   / _ \| .` || || |\/| |/ _ \| |  | | (_) | .` |
--  /_/ \_\_|\_|___|_|  |_/_/ \_\_| |___\___/|_|\_|
--
-- Handles transitioning between body animations.

local currentAnimation = ""
local animations = {
    LOW_HEALTH_ANIMATION,
    CRYING_ANIMATION,
    BLINK_ANIMATION,
}
local mappedAnimations = {}

for _, animation in pairs(animations) do
    mappedAnimations[animation.name] = animation
end

---@diagnostic disable-next-line: unused-function, unused-local
local function runAnimations(tick, delta)
    for _, animation in pairs(animations) do
        if animation.criteria() then
            if currentAnimation ~= animation.name then
                local current = mappedAnimations[currentAnimation]
                if current and current.cleanup then
                    current.cleanup()
                end
                currentAnimation = animation.name
            end

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
                if func then func(animation.data or {}, delta) end
            end
            return
        end
    end
end