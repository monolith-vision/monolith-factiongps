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
    if Config.WhitelistedJobs[k].collaborators
        and #Config.WhitelistedJobs[k].collaborators > 0
        and table.contains(Config.WhitelistedJobs[k].collaborators, job)
    then
      return true
    end
  end
  return false
end

RegisterUsableItem(Config.Item, function(source)
  local job = GetPlayerJob(source)
  local isCollab = isJobCollaborator(job.name)
  local jobName = isCollab and isCollab or job.name

  if isCollab then
    goto continue
  end

  if not Config.WhitelistedJobs[jobName] then
    return Config.Notify(source, "You are not allowed to use this item.")
  end

  ::continue::

  if trackers[jobName][source] then
    trackers[jobName][source] = nil
  else
    trackers[jobName][source] = GetCharName(source)
  end

  trackedUsers[source] = trackers[jobName][source] and jobName or nil

  Config.Notify(source, trackers[jobName][source] and "Tracker enabled." or "Tracker disabled.")

  TriggerClientEvent("tracker:update", source, trackedUsers[source] and trackers[jobName] or {})
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

function OnDeath(source)
  local isTracked = trackedUsers[source]

  if not isTracked then
    return
  end

  trackers[isTracked][source] = nil
  trackedUsers[source] = nil
end

function OnRemoveItem(source)
  local isTracked = trackedUsers[source]

  if not isTracked then
    return
  end

  trackers[isTracked][source] = nil
  trackedUsers[source] = nil
end

AddEventHandler("playerDropped", function()
  local source = source
  local isTracked = trackedUsers[source]

  if not isTracked then
    return
  end

  trackers[isTracked][source] = nil
  trackedUsers[source] = nil
end)
