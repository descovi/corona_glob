local storyboard = require ( "storyboard" )
local game = storyboard.newScene()

local vocali = {"a","e","i","o","u"}

local x_pos = {0, 100, 200, 300, 400}
local y_pos = {550,100}
local path = 'media/menu_iniziale/'
  -- Loading sound

function pulsantone_clicked()
  print "pulsantone clicked!!"
end
function crea_fila(long_or_short)
  local group = display.newGroup()
  for i=1,5 do
    single_path = path .. long_or_short ..vocali[i] .. "-150/1.png"
    a = display.newImage(single_path)
    a.x = x_pos[i]*1.5 + a.width
    group:insert(a)
  end
  return group
end
function crea_punteggio()
  punteggio = display.newText("0", 0,0,"Hiragino Maru Gothic Pro",40)
end
function crea_pulsantone()
  local size_pulsantone = 400
  pulsantone = display.newImage("media/menu_iniziale/long-a/1.png")
  pulsantone:addEventListener("tap", pulsantone_clicked)
  pulsantone.width = size_pulsantone
  pulsantone.height = size_pulsantone
  pulsantone.x = display.contentWidth - pulsantone.width/2 
  pulsantone.y = display.contentHeight - pulsantone.height + 50
end

function game:createScene(event)

  fila_short = crea_fila("short-")
  fila_long = crea_fila("long-")
  fila_short.y = y_pos[1]
  fila_long.y = y_pos[2]

  crea_punteggio()
  crea_pulsantone()
  
end
game:addEventListener( "createScene", game_created )

return game