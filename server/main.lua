local next = next

local trackers = (function()
  local tbl = {}
  for k, v in next, Config.WhitelistedJobs do
    tbl[k] = {}
  end
  return tbl
end)()

local trackedUsers = {}

---@param job string
---@return boolean
local function isJobCollaborator(job)
  for k, v in next, Config.WhitelistedJobs do
    if #Config.WhitelistedJobs[k].collaborators < 1 then
      return false
    end

    if table.contains(Config.WhitelistedJobs[k].collaborators, job) then
      return true
    end
  end
  return false
end

ESX.RegisterUsableItem(Config.Item, function(source)
  local source = source
  local xPlayer = ESX.GetPlayerFromId(source) or {
    job = { name = "Unknown" },
    getName = function() return "Unknown Player" end
  }
  local isCollab = isJobCollaborator(xPlayer.job.name)
  local jobName = isCollab and isCollab or xPlayer.job.name

  if isCollab then
    goto continue
  end

  if not Config.WhitelistedJobs[jobName] then
    return TriggerClientEvent("esx:showNotification", source, "You are not allowed to use this item.")
  end

  ::continue::

  trackers[jobName][source] = trackers[jobName][source] and nil or xPlayer?.getName() or "Unknown Player"
  trackedUsers[source] = trackers[jobName][source] and jobName or nil
  TriggerClientEvent("esx:showNotification", source,
    trackers[jobName][source] and "Tracker enabled." or "Tracker disabled.")
  xPlayer.triggerEvent("tracker:update", trackedUsers[source] and trackers[jobName] or {})
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(Config.Interval * 1000)

    for job, players in next, trackers do
      local tracked = {}

      for k, _ in next, players do
        local coords = GetEntityCoords(GetPlayerPed(k))

        if not coords then
          trackers[job][k] = nil
          goto skip
        end

        tracked[#tracked + 1] = {
          coords = coords,
          name = trackers[job][k] or "Unknown"
        }

        ::skip::
      end

      for k, v in next, players do
        TriggerClientEvent("tracker:update", k, tracked)
      end
    end
  end
end)

RegisterNetEvent("esx:onPlayerDeath")
AddEventHandler("esx:onPlayerDeath", function()
  local source = source
  local isTracked = trackedUsers[source]

  if not isTracked then
    return
  end

  trackers[isTracked][source] = nil
  trackedUsers[source] = nil
end)

AddEventHandler("playerDropped", function()
  local source = source
  local isTracked = trackedUsers[source]

  if not isTracked then
    return
  end

  trackers[isTracked][source] = nil
  trackedUsers[source] = nil
end)
