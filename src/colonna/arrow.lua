local Arrow = {}
Arrow.newSprite = function()
  local group = display.newGroup()
  local myRectangle = display.newRect(0, 0, 150, 150)
  myRectangle.strokeWidth = 3
  if _G.vocale == 'a' then
    myRectangle:setFillColor(252/255, 5/255, 69/255)
  elseif _G.vocale == 'e' then
    myRectangle:setFillColor(17/255, 79/255, 253/255)
  elseif _G.vocale == 'i' then
    myRectangle:setFillColor(38/255, 213/255, 14/255)
  elseif _G.vocale == 'o' then
    myRectangle:setFillColor(250/255, 9/255, 168/255)
  elseif _G.vocale == 'u' then
    myRectangle:setFillColor(253/255, 250/255, 5/255)
  end

  myRectangle:setStrokeColor(180, 180, 180,0)
  group:insert(myRectangle)
  function group.show()
    myRectangle.alpha = 0.01
  end
  function group.hide()
    myRectangle.alpha = 1
  end
  group:addEventListener("tap", group)
  group.x = display.contentWidth / 2
  return group
end
return Arrow