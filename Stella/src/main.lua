--! @depends animation/controller

-- General settings
TEXTURE_WIDTH = 64
TEXTURE_HEIGHT = 80

-- Variables
TICK_COUNT = 0

-- Disable all vanilla model pieces
for _, value in pairs(vanilla_model) do
    value.setEnabled(false)
end

function tick()
    TICK_COUNT = TICK_COUNT + 1
    AnimationController:tick()
end

function render(delta)

end