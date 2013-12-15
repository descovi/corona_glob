button_to_go_back = function ()
  local graphics  = display.newImage('media/torna_indietro.png')
  local size_wh   = 80
  local margin    = 38
  graphics.x = display.contentWidth - (graphics.width/4) - margin
  graphics.y = 82
  graphics:scale(.8,.8)
  if (nascondi) then
    graphics.alpha = 0
  end
  return graphics
end