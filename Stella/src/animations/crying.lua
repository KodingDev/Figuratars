local function cryingTick()
    local player = player.getPos()
    for _ = 1, 2 do
        particle.addParticle("rain", {
            player.x + math.random(-0.3, 0.3), player.y + 2,
            player.z + math.random(-0.3, 0.3), 0, 0, 0
        })
    end
end

CRYING_ANIMATION = {
    criteria = function()
        return player.getRot()[1] > 30 and player.getAnimation() ==
                   'CROUCHING';
    end,
    every = 4,
    priority = -1,
    tick = cryingTick,
    uv = {
        elements = {model.Base.Head.Eyes},
        textureWidth = 6,
        textureHeight = 4,
        frames = 2,
        uvStart = {0, 4}
    }
}