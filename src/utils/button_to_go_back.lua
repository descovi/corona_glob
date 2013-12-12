button_to_go_back = function ()
  local graphics  = display.newImage('media/torna_indietro.png')
  local size_wh   = 80
  local margin    = 5
  graphics.x = display.contentWidth - (graphics.width/2) - margin
  graphics.y = size_wh
  if (nascondi) then
    graphics.alpha = 0
  end
  return graphics
end