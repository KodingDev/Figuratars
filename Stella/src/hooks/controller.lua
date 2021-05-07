--! @depends hooks/hook

HookController = {
    ---@type table<number, Hook>
    hooks = {
        Hook:new(nil, 'player:sneaking', function() return player.getAnimation() == 'CROUCHING' end),
        Hook:new(nil, 'boolean:true', function() return true end)
    }
}

---@param name string
---@return boolean
function HookController.test(name)
    for _, hook in pairs(HookController.hooks) do
        if hook.name == name then
            return hook.criteria()
        end
    end
    return false
end