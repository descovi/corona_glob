function button_to_go_back()
  local size_torna_indietro = 80
  torna_indietro = display.newImage('media/torna_indietro.png')
  torna_indietro.width = size_torna_indietro
  torna_indietro.height = size_torna_indietro
  torna_indietro.x = display.contentWidth -size_torna_indietro*.5 - 20
  torna_indietro.y = size_torna_indietro +210
  return torna_indietro
end