local Arrow = {}
Arrow.newSprite = function()
  local group = display.newGroup()
  local myRectangle = display.newRect(0, 0, 150, 150)
  myRectangle.strokeWidth = 3
  if _G.vocale == 'a' then
    -- 252  5 69  
    myRectangle:setFillColor(252, 5, 69)
  end
  myRectangle:setStrokeColor(180, 180, 180,0)
  group:insert(myRectangle)
  function group.show()
    myRectangle.alpha = 0.1
  end
  function group.hide()
    myRectangle.alpha = 1
  end
  group:addEventListener("touch", group)
  group.x = display.contentWidth / 2 - group.width / 2
  return group
end
return Arrow