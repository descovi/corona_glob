local Storyboard = require("storyboard")
local game = Storyboard.newScene()
local Stat = require('src.utils.Stat')
local Pulsantone = require('src.game.Pulsantone')

require('src.game.CreaFila')

local pulsantone = {}
local vocali = {"a","e","i","o","u"}
local x_pos = {0, 100, 200, 300, 400}
local all_globuli = {}

local path = 'media/menu_iniziale/'

local globulo_scelto
local score = 0
local back_btn = button_to_go_back()
--back_btn.y = 50
--back_btn.width = 60
--back_btn.height = 60



-- punteggio massimo / record
local size_table_score        = 20
local font_table_score        = _G.font
local record_punteggio_group  = display.newGroup()

local punteggio_massimo       = 0
local punteggio_label         = display.newText(record_punteggio_group, "score",  0,   0,  font_table_score, size_table_score)
local punteggio               = display.newText(record_punteggio_group, "0",      punteggio_label.width+10,  0, font_table_score, size_table_score)
local record_label            = display.newText(record_punteggio_group, "record", punteggio.x+punteggio.width+20, 0,  font_table_score, size_table_score)
local record_from_data        = Stat.read()
local record                  = display.newText(record_punteggio_group, record_from_data, record_label.x+40, 0,  font_table_score, size_table_score)
record_punteggio_group.x      = 100 
record_punteggio_group.y      = 30

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

function animate_score()
  local time = 200
  local function restore()
     transition.to(punteggio,{time=time,xScale=1,yScale=1})
  end

  transition.to(punteggio,{time=time,xScale=1.5,yScale=1.5,onComplete=restore})

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


      -- score
      
      animate_score()
      -- # score
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
  pulsantone.explainer:fade_in_out(globulo_scelto.vocale)
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
  
  return pulsantone
end

local function go_bk(event) 
  if user_from_menu_iniziale == "false" then
    Storyboard.gotoScene( "src.colonna",{effect = "slideDown" } )
  else
    Storyboard.gotoScene( "src.menu_iniziale",{effect = "zoomOutInFade" })
  end
end

function game:createScene(event)
  
  fila_short = CreaFila("short-", vocali, path, x_pos, all_globuli)
  fila_long = CreaFila("long-", vocali, path, x_pos, all_globuli)
  fila_group = display.newGroup()
  fila_group:insert(fila_short)
  fila_group:insert(fila_long)
  fila_group.y = 300

  pulsantone = crea_pulsantone()
  --pulsantone:play()

  self.view:insert(back_btn)
  self.view:insert(fila_group)
  

  self.view:insert(pulsantone)
  self.view:insert(record_punteggio_group)
  fila_short.y = 140
  fila_long.y = 300
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

function game:enterScene (event )
  local params = event.params
  user_from_menu_iniziale = params.user_from_menu_iniziale
  timer.performWithDelay( 400, choose_random_globulo_and_play_audio)
end

game:addEventListener( "createScene", game_created )
game:addEventListener( "enterScene", game_entered )

return game