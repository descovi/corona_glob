local Vocabolario = {}
Vocabolario.newSprite = function()
  local group = display.newGroup()
  local myRectangle = display.newRect(group,0, display.contentHeight-50, 150, 50)
  local show = false
  group:addEventListener("tap", function(event)
    if (show == false) then
      local spiegazione = display.newRect( event.target, 0, 0, display.contentWidth, display.contentHeight )
      local testo = display.newText(event.target,"string", 0, 0, "Helvetica", 180)
      testo:setTextColor(255, 0, 0, 255)
      spiegazione.alpha = 0.9
      show = true
    else
      show = false
      group:remove(group.numChildren)
      group:remove(group.numChildren)
    end

  end)

  return group

end
return Vocabolario