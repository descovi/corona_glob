local Vocabolario = {}

Vocabolario.newSprite = function()

  local w = display.contentWidth
  local h = display.contentHeight
  local group = display.newGroup()
  group.spiegazione = display.newRect( group, 0, 0, w, h)
  group.spiegazione.alpha = 0


  group.setup_icon = function ( self )
    image = display.newImage("media/vocabolario.png")
    self:insert(image)
    image.x = 80
    image.y = h - 80
    
  end

  group.tapped = function(event)
    if (group.spiegazione.alpha == 1) then
      group.spiegazione.alpha = 0
      
    else
      group.spiegazione.alpha = 1
      
    end
  end

  group.setup = function()
    group:setup_icon()
  end

  group:addEventListener("tap", group.tapped)


  -- used from external for update number slide
  group.set = function(_counter)    
    group.counter = _counter
  end

  group.setup()


  return group

end
return Vocabolario


