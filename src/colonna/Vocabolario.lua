local Vocabolario = {}

Vocabolario.newSprite = function()

  local w = display.contentWidth
  local h = display.contentHeight

  local group = display.newGroup()
  group.animation_path_counter = ""
  
  group.create_icon = function ( container )
    icon = display.newImage("media/vocabolario.png")
    container:insert(icon)
    container.icon = icon
    icon.x = 80
    icon.y = h - 80    
  end


  group.create_white_screen = function(container)
    local white_screen = display.newRect( container, 0, 0, w, h)
    white_screen:setFillColor(0, 0, 0)
    white_screen.alpha = 0
    container.white_screen = white_screen
    container:insert(white_screen)
  end

  group.hide_show = function(object)
    local alpha = .8
    if (object.alpha == alpha) then
      object.alpha = 0
      group:remove(group.numChildren)
    else
      object.alpha = alpha
      local path_vocabolario = group.animation_path_counter..'/vocabolario.png'
      group.image = display.newImage(path_vocabolario)
      group:insert(group.image)
    end
  end

  group.tapped = function(event)
    group.hide_show(group.white_screen)
  end

  group.setup = function()
    group:create_icon()
    group:create_white_screen()
  end

  group.update_current_path = function(path)
    group.animation_path_counter = path
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


