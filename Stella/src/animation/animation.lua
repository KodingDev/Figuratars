--! @depends hooks/controller

UVAnimation = {
    tickRate = 1,
    frames = 1,
    delay = 0,
    chance = 1,
    start = { 0, 0 },
    increment = { 0, 0 },
    data = { last = 0 }
}

function UVAnimation:new(o, start, increment, frames, delay, chance, tickRate)
    o = o or {}
    setmetatable(o, self)

    self.__index = self
    self.start = start
    self.increment = increment
    self.frames = frames or 1
    self.tickRate = tickRate or 1
    self.delay = delay or 0
    self.chance = chance or 1
    self.data = { frame = 0, delay = 0 }

    return o
end

function UVAnimation:tick(part)
    if TICK_COUNT % self.tickRate ~= 0 then
        return
    end

    -- If we need to wait a few more ticks, skip this run
    if self.data.frame == 0 then
        if self.delay > self.data.delay then
            self.data.delay = self.data.delay + 1
            return
        end
    end

    -- If the chance block was satisfied
    if math.random() > self.chance and self.data.frame == 0 then
        return
    end

    local u = (self.increment[1] * self.data.frame + self.start[1]) / TEXTURE_WIDTH
    local v = (self.increment[2] * self.data.frame + self.start[2]) / TEXTURE_HEIGHT
    part.setUV({ u, v })

    self.data.frame = (self.data.frame + 1) % (self.frames + 1)
    self.data.delay = 0
end

PositionFrame = {
    offset = {},
    rotation = {}
}

function PositionFrame:new(o, offset, rotation)
    o = o or {}
    setmetatable(o, self)

    self.__index = self
    self.offset = offset or {}
    self.rotation = rotation or {}

    return o
end

PositionAnimation = {
    tickRate = 1,
    frames = {}
}

PartAnimation = {
    uv = UVAnimation,
    position = PositionAnimation
}

function PartAnimation:new(o, uv, position)
    o = o or {}
    setmetatable(o, self)

    self.__index = self
    self.uv = uv
    self.position = position

    return o
end

function PartAnimation:tick(part)
    self.uv:tick(part)
end

Animation = {
    hook = "",
    parts = {}
}

function Animation:new(o, hook, parts)
    o = o or {}
    setmetatable(o, self)

    self.__index = self
    self.hook = hook
    self.parts = parts

    return o
end

function Animation:tick()
    if not HookController.test(self.hook) then
        return false
    end

    for part, animation in pairs(self.parts) do
        animation:tick(part)
    end
    return true
end