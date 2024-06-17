if Config.Framework ~= "custom" then
  return
end

Framework = {
  name = "custom",
  object = {}
}

local DEFAULTS <const> = {
  job = {
    name = "unemployed"
  },
  name = "Unknown"
}

-- TODO: Implement your own death event
RegisterNetEvent("YOUR_DEATH_EVENT", function()
  local source = source

  OnDeath(source)
end)

---@param itemName string
---@param cb fun(source: number, ...: any)
function RegisterUsableItem(itemName, cb)
  -- TODO: Implement your own function
end

---@param source number
---@return { name: string }
function GetPlayerJob(source)
  -- TODO: Implement your own function
  return DEFAULTS.job
end

---@param source number
---@return string
function GetCharName(source)
  -- TODO: Implement your own function
  return DEFAULTS.name
end
