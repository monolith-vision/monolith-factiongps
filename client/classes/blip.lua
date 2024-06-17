Blip = {
  __index = Blip,
}

---@param x number
---@param y number
---@param z number
---@param name string
---@return number
function Blip:add(x, y, z, name)
  local blip = AddBlipForCoord(x, y, z)
  SetBlipSprite(blip, 280)
  SetBlipColour(blip, 1)
  SetBlipScale(blip, 0.8)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(name)
  EndTextCommandSetBlipName(blip)
  return blip
end

function Blip:remove(blipId)
  RemoveBlip(blipId)
end