local Config = require "config.server"
local CD = {}

local function CheckCategory(category)
    if not Config[category] then
        return false, ("Category (%s) not found in Config!"):format(category)
    end

    for cooldownType, cooldown in pairs(Config[category]) do
        if cooldownType ~= "player" and cooldownType ~= "robbery" then
            return false, ("Cooldown type (%s) not valid in category (%s)!"):format(cooldownType, category)
        end
        if type(cooldown) ~= "number" or cooldown < 0 then
            return false, ("Cooldown (%s) for (%s) not valid in Config! Must be a positive number."):format(cooldownType, category)
        end
    end

    return true
end

local function RegisterCD(source, category, robberyId)
    if not source or not category or not robberyId then
        return print(("^1[ERROR]: Missing data in export use (%s, %s, %s)^0"):format(source, category, robberyId))
    end

    CD[category] = CD[category] or {}

    local isValid, errorMsg = CheckCategory(category)
    if not isValid then
        return print(("^1[ERROR]: %s^0"):format(errorMsg))
    end

    local license = GetPlayerIdentifierByType(source, "license2")

    CD[category][license] = os.time() + (Config[category].player or 300)
    CD[category][robberyId] = os.time() + (Config[category].robbery or 300)

    return true
end
exports("RegisterCD", RegisterCD)

local function CheckCooldown(source, category, robberyId)
    if not source or not category or not robberyId then
        return error("Missing data in export use")
    end

    local cooldowns = CD[category]
    if not cooldowns then
        return false, nil, nil
    end

    local license = GetPlayerIdentifierByType(source, "license2")
    local currentTime = os.time()
    local playerCooldown = cooldowns[license] or 0
    local robberyCooldown = cooldowns[robberyId] or 0

    if playerCooldown > currentTime then
        return true, "player", playerCooldown - currentTime
    elseif robberyCooldown > currentTime then
        return true, "robbery", robberyCooldown - currentTime
    end

    return false, nil, nil
end
exports("CheckCooldown", CheckCooldown)

local function CleanCooldowns()
    if not next(CD) then return end

    local currentTime = os.time()
    for category, cooldowns in pairs(CD) do
        if type(cooldowns) == "table" and next(cooldowns) then
            for key, expireTime in pairs(cooldowns) do
                if expireTime <= currentTime then
                    cooldowns[key] = nil
                end
            end
            if not next(cooldowns) then
                CD[category] = nil
            end
        end
    end
end

CreateThread(function()
    while true do
        Wait(1800000)
        CleanCooldowns()
    end
end)