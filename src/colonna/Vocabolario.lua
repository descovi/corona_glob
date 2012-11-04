local Vocabolario = {}
Vocabolario.newSprite = function()
  local group = display.newGroup()
  local myRectangle = display.newRect(0, 0, 150, 50)
  return group
end
return Vocabolario