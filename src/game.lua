local storyboard = require ( "storyboard" )
local game = storyboard.newScene()

local vocali = {"a","e","i","o","u"}

local x_pos = {0, 100, 200, 300, 400}
local y_pos = {550,100}
local all_globuli = {}
local path = 'media/menu_iniziale/'
local punteggio
local globulo_scelto
local score = 0
local punteggio = display.newText("0", 20,20,"Hiragino Maru Gothic Pro",40)

  -- Loading sound

function pulsantone_clicked()
  print "pulsantone clicked!!"
  globulo_scelto = all_globuli[ math.random(#all_globuli) ]
  --audio.play(a.path_audio)
  audio.play(globulo_scelto.audio)
end
function answer_clicked(event)
  if globulo_scelto == event.target then
    print "giusto!"
    score = score+1
    punteggio.text = score
  else
    print "cacca!"
    score = score-1
    punteggio.text = score
  end
  print(event.target)
end
function crea_fila(long_or_short)
  local group = display.newGroup()
  for i=1,5 do
    single_path = path .. long_or_short ..vocali[i] .. "-150/1.png"
    local globo = display.newImage(single_path)
    globo.x = x_pos[i]*1.5 + globo.width
    -- sound
    local path_audio = 'media/audio/vocali/'
    if (long_or_short=="long-") then
      local audio = audio.loadSound( path_audio .. string.upper(vocali[i]) .. '_L.mp3')
      globo.audio = audio
    else
      local audio = audio.loadSound( path_audio .. string.upper(vocali[i]) .. '_S.mp3')
      globo.audio = audio
    end
    -- tap
    globo:addEventListener("tap", answer_clicked)
    -- insert
    table.insert(all_globuli,globo)
    group:insert(globo)
  end
  return group
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
  fila_short.y = y_pos[2]
  fila_long.y = y_pos[1]

  crea_pulsantone()
  
end
game:addEventListener( "createScene", game_created )

return game