---@param t table
---@param val any
---@return boolean
function table.contains(t, val)
  for _, v in next, t do
    if v == val then
      return true
    end
  end
  return false
end