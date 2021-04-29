--! @depends util

-- Settings
HEALTH_TRIGGER = 5

local function lowHealthRender(_, delta)
    local health = player.getHealth()
    local lifeDuration = 10 + (HEALTH_TRIGGER * (health + 1))
    local intensity = lerp(0.3 + (health / 10), 1, (math.sin(lerp(-math.pi, math.pi, (TICK_COUNT + delta) / lifeDuration)) + 1) / 2)
    model.Base.setColor({ 1, intensity, intensity })
end

local function lowHealthCleanup()
    model.Base.setColor({ 1, 1, 1 })
end

LOW_HEALTH_ANIMATION = {
    name = "lowhealth",
    criteria = function() return player.getHealth() <= HEALTH_TRIGGER; end,
    render = lowHealthRender,
    cleanup = lowHealthCleanup
}