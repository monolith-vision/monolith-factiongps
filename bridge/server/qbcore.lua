if Config.Framework ~= "qbcore" then
  return
end

Framework = {
  name = "qbcore",
  object = exports["qb-core"]:GetCoreObject()
}

local DEFAULTS <const> = {
  job = {
    name = "unemployed"
  },
  name = "Unknown"
}

RegisterNetEvent("hospital:server:SetDeathStatus", function(isDead)
  local source = source

  if isDead then
    OnDeath(source)
  end
end)

---@param itemName string
---@param cb fun(source: number, ...: any)
function RegisterUsableItem(itemName, cb)
  Framework.object.CreateUsableItem(itemName, cb)
end

---@param source number
---@return { name: string }
function GetPlayerJob(source)
  local Player = Framework.object.Functions.GetPlayer(source)

  if not Player then
    return DEFAULTS.job
  end

  return Player.PlayerData and Player.PlayerData.job or DEFAULTS.job
end

---@param source number
---@return string
function GetCharName(source)
  local Player = Framework.object.Functions.GetPlayer(source)

  if not Player then
    return DEFAULTS.name
  end

  local charInfo = Player.PlayerData.charinfo

  return charInfo.firstname .. " " .. charInfo.lastname
end
