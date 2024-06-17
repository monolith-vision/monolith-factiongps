Framework = {}

Config = {}

Config.Framework = "esx" -- esx | qbcore | custom

Config.Interval = 5 -- seconds

Config.Item = "bread"

Config.WhitelistedJobs = {
  ["test"] = {
    collaborators = {} -- only jobs which do not have their own tracker
  }
}

if IsDuplicityVersion() then
  ---@param source number
  ---@param message string
  function Config.Notify(source, message)
    TriggerClientEvent('esx:showNotification', source, message)
  end
else
  ---@param message string
  function Config.Notify(message)
    TriggerEvent('esx:showNotification', message)
  end
end
