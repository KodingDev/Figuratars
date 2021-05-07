--! @ignore

particle = {
    ---@param type string
    ---@param vector table
    addParticle = function(type, vector)
    end
}

---@class CustomModelPart
CustomModelPart = {
    ---@return table
    getPos = function()
    end,

    ---@param position table
    setPos = function(position)
    end,

    ---@return table
    getPivot = function()
    end,

    ---@param pivot table
    setPivot = function(pivot)
    end,

    ---@return table
    getColor = function()
    end,

    ---@param color table
    setColor = function(color)
    end,

    ---@return table
    getScale = function()
    end,

    ---@param scale table
    setScale = function(scale)
    end,

    ---@return table
    getRot = function()
    end,

    ---@param rotation table
    setRot = function(rotation)
    end,

    ---@return table
    getUV = function()
    end,

    ---@param uv table
    setUV = function(uv)
    end,

    ---@return string
    getParentType = function()
    end,

    ---@param parentType string
    setParentType = function(parentType)
    end,

    ---@return boolean
    getMimicMode = function()
    end,

    ---@param mimicMode boolean
    setMimicMode = function(mimicMode)
    end,

    ---@return boolean
    getEnabled = function()
    end,

    ---@param enabled boolean
    setEnabled = function(enabled)
    end,

    ---@return string
    getShader = function()
    end,

    ---@param name string
    setShader = function(name)
    end
}

---@class Entity
Entity = {
    ---@return table
    getPos = function()
    end,

    ---@return table
    getRot = function()
    end,

    ---@return string
    getType = function()
    end,

    ---@return table
    getVelocity = function()
    end,

    ---@return table
    getLookDir = function()
    end,

    ---@return string
    getUUID = function()
    end,

    ---@return number
    getFireTicks = function()
    end,

    ---@return number
    getAir = function()
    end,

    ---@return number
    getMaxAir = function()
    end,

    ---@return number
    getAirPercentage = function()
    end,

    ---@return string
    getWorldName = function()
    end,

    --- TODO: Add this
    ---@param index number
    getEquipmentItem = function(index)
    end,

    --- TODO: Make enum
    ---@return string
    getAnimation = function()
    end,

    ---@return LivingEntity
    getVehicle = function()
    end,

    ---@return boolean
    isGrounded = function()
    end,

    ---@return number
    getEyeHeight = function()
    end,

    ---@return table
    getBoundingBox = function()
    end,

    --- TODO: Add
    ---@param path string
    getNbtValue = function(path)
    end
}

---@class LivingEntity : Entity
LivingEntity = {
    ---@return number
    getBodyYaw = function()
    end,

    ---@return number
    getHealth = function()
    end,

    ---@return number
    getMaxHealth = function()
    end,

    ---@return number
    getHealthPercentage = function()
    end,

    ---@return number
    getArmor = function()
    end,

    ---@return number
    getDeathTime = function()
    end,

    --- TODO: Add
    getStatusEffectTypes = function()
    end,

    --- TODO: Add
    ---@param identifier string
    getStatusEffect = function(identifier)
    end,

    ---@return boolean
    isSneaky = function()
    end
}

---@class PlayerEntity : LivingEntity
PlayerEntity = {
    --- TODO: Implement
    ---@param hand number
    getHeldItem = function(hand)
    end,

    ---@return number
    getFood = function()
    end,

    ---@return number
    getSaturation = function()
    end,

    ---@return number
    getExperienceProgress = function()
    end,

    ---@return number
    getExperienceLevel = function()
    end
}

---@type PlayerEntity
player = nil