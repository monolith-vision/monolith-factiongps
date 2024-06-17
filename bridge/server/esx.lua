if Config.Framework ~= "esx" then
  return
end

Framework = {
  name = "esx",
  object = exports.es_extended:getSharedObject()
}

local DEFAULTS <const> = {
  job = {
    name = "unemployed"
  },
  name = "Unknown"
}

RegisterNetEvent("esx:onPlayerDeath", function()
  local source = source

  OnDeath(source)
end)

---@param itemName string
---@param cb fun(source: number, ...: any)
function RegisterUsableItem(itemName, cb)
  Framework.object.RegisterUsable(itemName, cb)
end

---@param source number
---@return { name: string }
function GetPlayerJob(source)
  local Player = Framework.object.GetPlayerFromId(source)

  return Player and Player.job or DEFAULTS.job
end

---@param source number
---@return string
function GetCharName(source)
  local Player = Framework.object.GetPlayerFromId(source)

  if not Player then
    return DEFAULTS.name
  end

  if Player.firstName then
    return Player.firstName .. " " .. Player.lastName
  end

  return Player.name
end
