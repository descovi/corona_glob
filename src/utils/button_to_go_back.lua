button_to_go_back = function ()
  local graphics  = display.newImage('media/torna_indietro.png')
  local size_wh   = 80
  local margin    = 20
  graphics.width  = size_wh
  graphics.height = size_wh
  graphics.x = display.contentWidth - (size_wh/2) - margin
  graphics.y = size_wh
  return graphics
end