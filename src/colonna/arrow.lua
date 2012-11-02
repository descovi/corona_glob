local Arrow = {}
Arrow.newSprite = function()
  local group = display.newGroup()
  local myRectangle = display.newRect(0, 0, 150, 50)
  myRectangle.strokeWidth = 3
  myRectangle:setFillColor(140, 140, 140)
  myRectangle:setStrokeColor(180, 180, 180)
  group:insert(myRectangle)
  function group:touch(event)
    print("toccato")
  end
  function group.show_rect_red()
    myRectangle.alpha = 1
  end
  function group.hide_rect_red()
    myRectangle.alpha = 0
  end
  group:addEventListener("touch", group)
  group.x = display.contentWidth / 2 - group.width / 2
  return group
end
return Arrow