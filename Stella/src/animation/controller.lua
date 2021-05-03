--! @depends animation/animation

AnimationController = {
    animations = {
        -- Idle animation
        Animation:new(nil, "boolean:true", {
            -- Blinking
            [model.Base.Head.Eyes] = PartAnimation:new(nil, UVAnimation:new(nil, { 64, 0 }, { 6, 0 }, 4, 10, 0.1, 2))
        })
    }
}

function AnimationController:tick()
    for _, animation in pairs(self.animations) do
        if animation:tick() then
            return
        end
    end
end