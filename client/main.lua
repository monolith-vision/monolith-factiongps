local knownBlips = {}

RegisterNetEvent('tracker:update', function(players)
  for _, v in next, knownBlips do
    Blip:remove(v)
  end

  knownBlips = {}

  for _, v in next, players do
    if v.coords then
      knownBlips[#knownBlips+1] = Blip:add(v.coords.x, v.coords.y, v.coords.z, v.name)
    end
  end
end)