button_to_go_back = function ()
  local graphics  = display.newImage('media/torna_indietro.png')
  local size_wh   = 80
  local margin    = 10
  graphics.x = display.contentWidth - (graphics.width/4) - margin
  graphics.y = 60
  graphics:scale(.5,.5)
  if (nascondi) then
    graphics.alpha = 0
  end
  return graphics
end