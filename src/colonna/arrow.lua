local Arrow = {}
Arrow.newSprite = function()
  local group = display.newGroup()
  local myRectangle = display.newRect(0, 0, 150, 150)
  myRectangle.strokeWidth = 3
  if _G.vocale == 'a' then
    myRectangle:setFillColor(252, 5, 69)
  elseif _G.vocale == 'e' then
    myRectangle:setFillColor(17, 79, 253)
  elseif _G.vocale == 'i' then
    myRectangle:setFillColor(38, 213, 14)
  elseif _G.vocale == 'o' then
    myRectangle:setFillColor(250, 9, 168)
  elseif _G.vocale == 'u' then  
    myRectangle:setFillColor(253, 250, 5)
  end

  myRectangle:setStrokeColor(180, 180, 180,0)
  group:insert(myRectangle)
  function group.show()
    myRectangle.alpha = 0.1
  end
  function group.hide()
    myRectangle.alpha = 1
  end
  group:addEventListener("tap", group)
  group.x = display.contentWidth / 2 - group.width / 2
  return group
end
return Arrow