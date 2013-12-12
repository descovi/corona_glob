local Storyboard = require("storyboard")
local game = Storyboard.newScene()
local Stat = require('src.utils.Stat')
local Pulsantone = require('src.game.Pulsantone')
local Explainer = require('src.game.Explainer')

require('src.game.CreaFila')

local pulsantone = {}
local vocali = {"a","e","i","o","u"}
local x_pos = {0, 100, 200, 300, 400}
local all_globuli = {}
local explainer = {}
local path = 'media/menu_iniziale/'

local globulo_scelto
local score = 0
local back_btn = button_to_go_back()
--back_btn.y = 50
--back_btn.width = 60
--back_btn.height = 60

-- short long
local short = display.newText("short", 830,140,_G.font,30)
local long = display.newText("long", 830,580,_G.font,30)

-- punteggio massimo / record
local size_table_score        = 20
local font_table_score        = _G.font
local record_punteggio_group  = display.newGroup()
record_punteggio_group.x      = 30 
record_punteggio_group.y      = 20
local punteggio_massimo       = 0
local punteggio_label         = display.newText(record_punteggio_group, "score",  0,   0,  font_table_score, size_table_score)
local punteggio               = display.newText(record_punteggio_group, "0",      90,  20, font_table_score, size_table_score)
local record_label            = display.newText(record_punteggio_group, "record", 150, 0,  font_table_score, size_table_score)
local record_from_data        = Stat.read()
local record                  = display.newText(record_punteggio_group, record_from_data,      220, 0,  font_table_score, size_table_score)

-- audio - right - wrong
local audio_right= audio.loadSound("media/audio/right.mp3")
local audio_wrong = audio.loadSound("media/audio/wrong.mp3")

-- tentativi
local tentativo_debug = display.newText("3", 200, 350, _G.font, 40)
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

function play_anim(target)
  if target ~= nil then
    local myclosure = function() 
      target:nextFrame()
    end
    timer.performWithDelay(5,myclosure,24)
  end
end

function play_anim_globulo_attuale(event)
  print("PLAY GLOBULO ATTUALE")
  play_anim(event.target)
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

function answer_clicked_is_correct()
  print "Giusto!"
  score = score+1
  if (score > punteggio_massimo) then
    punteggio_massimo = score
    record_saved = Stat.read()
    if (record_saved < punteggio_massimo) then
      Stat.write(punteggio_massimo)
      record.text = punteggio_massimo
    end
  end
  audio.play(audio_right, {onComplete=choose_random_globulo_and_play_audio })
  punteggio:setTextColor(0,255,0,255)
  punteggio.text = score
end

function answer_clicked_is_wrong()
  print "Sbagliato!"
  if score > 0 then
    score = score-1
  end
  print("answer_clicked_is_wrong")
  print(globulo_scelto.vocale)
  print("----")
  explainer:fade_in_out(globulo_scelto.vocale)
  audio.play(audio_wrong, {onComplete=fx_true_or_right_handler })
  punteggio:setTextColor(255,0,0,255)
  punteggio.text = score
end

function answer_clicked(event)
  if blocca_interazione == false then
    blocca_interazione = true
    print(" ")
    print("- obbiettivo: " .. globulo_scelto.vocale)
    print("- scelto: " .. event.target.vocale)
    print(" ")
    if (globulo_scelto == event.target) then
      answer_clicked_is_correct()
    else
      answer_clicked_is_wrong()
    end
  end
end

function crea_pulsantone()
  local pulsantone = Pulsantone.new()
  pulsantone:addEventListener("tap", play_audio_globulo_attuale)
  timer.performWithDelay( 1000, choose_random_globulo_and_play_audio)
  return pulsantone
end

local function go_bk(event) 
  Storyboard.gotoScene( "src.colonna" )
end

function game:createScene(event)
  print("game:createScene")
  fila_short = CreaFila("short-", vocali, path, x_pos, all_globuli)
  fila_long = CreaFila("long-", vocali, path, x_pos, all_globuli)
  pulsantone = crea_pulsantone()
  --pulsantone:play()

  explainer = Explainer.new()
  self.view:insert(back_btn)
  self.view:insert(fila_short)
  self.view:insert(fila_long)
  self.view:insert(punteggio)
  self.view:insert(short)
  self.view:insert(long)
  self.view:insert(pulsantone)
  self.view:insert(record_punteggio_group)
  fila_short.y = 140
  fila_long.y = 570
  back_btn:addEventListener("tap", go_bk)
end

function play_audio_globulo_attuale()
  print("play_anim_globulo_attuale")
  audio.play(globulo_scelto.audio)
  -- check if pulsantone is defined
  if pulsantone.x then
    pulsantone:play()
  end
end

game:addEventListener( "createScene", game_created )

return game