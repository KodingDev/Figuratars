Hook = {
    name = "",
    criteria = function() end
}

function Hook:new(o, name, criteria)
    o = o or {}
    setmetatable(o, self)

    self.__index = self
    self.name = name
    self.criteria = criteria

    return o
end