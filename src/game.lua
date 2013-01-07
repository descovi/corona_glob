local storyboard = require ( "storyboard" )
local game = storyboard.newScene()

local vocali = {"a","e","i","o","u"}

local x_pos = {0, 100, 200, 300, 400}
local y_pos = {350,150}
local path = 'media/menu_iniziale/'
  -- Loading sound

function pulsantone_clicked()
  print "pulsantone clicked!!"
end
function crea_fila(long_or_short)
  for i=1,5 do
    single_path = path .. long_or_short ..vocali[i] .. "-150/1.png"
    a = display.newImage(single_path )
    a.x = x_pos[i]*1.5
  end
end
function crea_punteggio()
  punteggio = display.newText("0", 0,0,"Hiragino Maru Gothic Pro",40)
end
function game_created()
  crea_fila("short-")
  crea_fila("long-")

  crea_btn_risposte_fila2()
  crea_punteggio()
  pulsantone = display.newImage("media/menu_iniziale/long-a/1.png")
  pulsantone:addEventListener("tap", pulsantone_clicked)
  pulsantone.x = display.contentWidth - pulsantone.width/2 
  pulsantone.y = display.contentHeight - pulsantone.height
end
game:addEventListener( "createScene", game_created )

return game