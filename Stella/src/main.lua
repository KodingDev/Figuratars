--  ___ _____ ___ _    _      _
-- / __|_   _| __| |  | |    /_\
-- \__ \ | | | _|| |__| |__ / _ \
-- |___/ |_| |___|____|____/_/ \_\
--
-- Figura Character for KodingDev

-- General settings
TEXTURE_WIDTH = 64
TEXTURE_HEIGHT = 80

-- Variables
TICK_COUNT = 0

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
    runAnimations(true, 0)
end

function render(delta) runAnimations(false, delta) end
