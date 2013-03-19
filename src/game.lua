local Storyboard = require("storyboard")
local game = Storyboard.newScene()

local vocali = {"a","e","i","o","u"}
local x_pos = {0, 100, 200, 300, 400}
local y_pos = {550,100}
local all_globuli = {}
local path = 'media/menu_iniziale/'

local globulo_scelto
local score = 0
local back_btn = button_to_go_back()

-- punteggio / score
local punteggio = display.newText("0", 100,350,"Hiragino Maru Gothic Pro",40)
local short = display.newText("short", 830,140,"Hiragino Maru Gothic Pro",40)
local long = display.newText("long", 830,580,"Hiragino Maru Gothic Pro",40)

-- punteggio massimo / record
local record_group = display.newGroup()
local punteggio_massimo = 0
local record_label = display.newText(record_group,"record", 0, 0, "Hiragino Maru Gothic Pro", 40)
local record = display.newText(record_group,"0", record_label.x + 90, 0, "Hiragino Maru Gothic Pro", 40)

-- audio - right - wrong
local audio_right= audio.loadSound("media/audio/right.mp3")
local audio_wrong = audio.loadSound("media/audio/wrong.mp3")

-- tentativi
local tentativo_debug = display.newText("3", 200, 350, "Hiragino Maru Gothic Pro", 40)
tentativo_debug.alpha = 0
local tentativi_rimasti = 3

-- blocco
local blocca_interazione = false

-- Loading sound
function choose_random_globulo_and_play_audio()
  blocca_interazione = false
  tentativi_rimasti = 3
  tentativo_debug.text = tentativi_rimasti
  globulo_scelto = all_globuli[math.random(#all_globuli)]
  print("NEW RANDOM LETTER !! -->"..globulo_scelto.vocale)
  play_audio_globulo_attuale()
end
function play_audio_globulo_attuale()
  audio.play(globulo_scelto.audio)
end

function fx_true_or_right_handler(event)
  tentativi_rimasti = tentativi_rimasti -1
  if tentativi_rimasti == 0 then
    tentativo_debug.text = tentativi_rimasti
    choose_random_globulo_and_play_audio()
  else
    tentativo_debug.text = tentativi_rimasti
    play_audio_globulo_attuale()
  end
  blocca_interazione = false
end

function answer_clicked(event)
  if blocca_interazione == false then
    blocca_interazione = true
    print("- obbiettivo:")
    print(globulo_scelto.vocale)
    print("- scelto:")
    print(event.target.vocale)
    print(" ")
    if globulo_scelto == event.target then
      print "giusto!"
      score = score+1
      if score > punteggio_massimo then
        punteggio_massimo = score
        record.text = punteggio_massimo
      end
      audio.play(audio_right, {onComplete=choose_random_globulo_and_play_audio })
      punteggio.text = score
    else
      print "cacca!"
      if score > 0 then
        score = score-1
      end
      audio.play(audio_wrong, {onComplete=fx_true_or_right_handler })
      punteggio.text = score
    end
  end
end

function crea_fila(long_or_short)
  local group = display.newGroup()
  for i=1,5 do
    single_path = path .. long_or_short ..vocali[i] .. "-150/1.png"
    local globo = display.newImage(single_path)
    globo.x = x_pos[i]*1.5 + globo.width
    globo.vocale = long_or_short..vocali[i]
    -- label
    local label = display.newText(vocali[i], 100,480,"Hiragino Maru Gothic Pro",40)
    label.x = globo.x
    -- sound
    local path_audio = 'media/audio/vocali/'
    if (long_or_short=="long-") then
      local audio = audio.loadSound( path_audio .. string.upper(vocali[i]) .. '_L.mp3')
      globo.audio = audio
      label.y = globo.y+100
    else
      local audio = audio.loadSound( path_audio .. string.upper(vocali[i]) .. '_S.mp3')
      globo.audio = audio
      label.y = globo.y-100
    end
    -- tap
    globo:addEventListener("tap", answer_clicked)
    -- insert
    table.insert(all_globuli,globo)
    group:insert(globo)
    group:insert(label)
  end
  return group
end

function crea_pulsantone()
  local size_pulsantone = 200
  pulsantone = display.newImage("media/menu_iniziale/long-a/1.png")
  pulsantone:addEventListener("tap", play_audio_globulo_attuale)
  pulsantone.width = size_pulsantone
  pulsantone.height = size_pulsantone
  pulsantone.x = display.contentWidth - pulsantone.width
  pulsantone.y = display.contentHeight /2
  choose_random_globulo_and_play_audio()
  return pulsantone
end

local function go_bk(event) 
  Storyboard.gotoScene( "src.colonna" )
end

function game:createScene(event)
  fila_short = crea_fila("short-")
  fila_long = crea_fila("long-")
  self.view:insert(fila_short)
  self.view:insert(fila_long)
  self.view:insert(punteggio)
  self.view:insert(short)
  self.view:insert(long)
  self.view:insert(record_group)
  fila_short.y = y_pos[2]
  fila_long.y = y_pos[1]
  self.view:insert(crea_pulsantone())
  
  back_btn:addEventListener("tap", go_bk)
end
game:addEventListener( "createScene", game_created )

return game