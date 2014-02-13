local Storyboard = require("storyboard")
local game = Storyboard.newScene()
local Stat = require('src.utils.Stat')
local Pulsantone = require('src.game.Pulsantone')
local Life = require('src.game.Life')
local life = {}
local stage_of_game
local fila_group
require('src.game.CreaFila')

local pulsantone = {}
local vocali = {"a"}
local current_level = 1
local x_pos = {0, 100, 200, 300, 400}
local all_globuli = {}

local path = 'media/menu_iniziale/'

local globulo_scelto
local score = 0
local back_btn = button_to_go_back()

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
local audio_level = audio.loadSound("media/audio/level.wav")

-- tentativi
local tentativo_debug = display.newText("3", display.contentWidth-100, display.contentHeight/2, _G.font, 40)
tentativo_debug.alpha = 0
local tentativi_rimasti = 3

-- blocco
local blocca_interazione = false

-- Loading sound
function choose_random_globulo_and_play_audio()
  blocca_interazione = false
  life:set_life(3)
  globulo_scelto = choose_random(globulo_scelto)
  
  print("NUMERIIIII:")
  print(#all_globuli)
  print("NEW RANDOM LETTER !! -->"..globulo_scelto.vocale)
  play_audio_globulo_attuale()
end

function choose_random(_globulo_old )

  if _globulo_old == nil then
    return all_globuli[math.random(#all_globuli)]
  end

  nuovo_globulo = all_globuli[math.random(#all_globuli)]
  if nuovo_globulo.vocale == _globulo_old.vocale then
    nuovo_globulo = choose_random(_globulo_old)
  end
  return nuovo_globulo
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

function question(_next_or_the_same)
  blocca_interazione = false
  
  if level_is_changed == true then
    level_is_changed = false
    return choose_random_globulo_and_play_audio()
  end 
  
  if _next_or_the_same == "next" then
    return choose_random_globulo_and_play_audio()
  end

  if _next_or_the_same == "same" then
    
    if life.life_count == 0 then
      choose_random_globulo_and_play_audio()
    else
      play_audio_globulo_attuale()
    end
  end
  
end

function animate_score()
  local time = 200
  local function restore()
    transition.to(punteggio,{time=time,xScale=1,yScale=1})
  end
  transition.to(punteggio,{time=time,xScale=1.5,yScale=1.5,onComplete=restore})
end

function change_level(_score)
   if _score == 1 or _score == 2 then
    actual_level = 1
    vocali = {"a"}
   elseif _score == 3 or _score == 5 then
    actual_level = 2
    vocali = {"a","e"}
  elseif _score == 6 or _score == 11 then
    actual_level = 3
    vocali = {"a","e","i"}
  elseif _score == 12 or _score == 15 then
    actual_level = 4
    vocali = {"a","e","i","o"}
  elseif _score == 16 then
    actual_level = 5
    vocali = {"a","e","i","o","u"}
  end

  if current_level ~= nil and actual_level ~= nil then
    if actual_level > current_level then
      audio.play(audio_level,{channel=2})
    end
  end

  if actual_level ~= current_level then
    level_is_changed= true
    current_level = actual_level
  end
  
  setup_pulsanti_per_rispondere(stage_of_game)
end

function update_score(answer_correct)
  if answer_correct == true then
    score = score+1
    if (score > punteggio_massimo) then
      punteggio_massimo = score
      record_saved = Stat.read()
      if (record_saved < punteggio_massimo) then
        Stat.write(punteggio_massimo)
        record.text = punteggio_massimo
      end
    end
    punteggio:setTextColor(0,255,0,255)
  elseif answer_correct == false then
    if score > 0 then
      score = score-1
    end
    punteggio:setTextColor(255,0,0,255)
  end
  punteggio.text = score
end

function answer_clicked_is_correct()
  print("answer_clicked_is_correct")
  update_score(true)
  animate_score()
  audio.play(audio_right,{channel=2})
end

function answer_clicked_is_wrong()
  print("answer_clicked_is_wrong")
  if current_level ~= 1 and current_level ~= 3 then
    local explainer = pulsantone.explainer
    explainer:fade_in_out(globulo_scelto.vocale)
  end
  update_score(false)
  audio.play(audio_wrong,{channel=2})
end

function answer_clicked(event)
  if blocca_interazione == false then
    blocca_interazione = true
    print(" ")
    print("- obbiettivo: " .. globulo_scelto.vocale)
    print("- scelto: " .. event.target.vocale)
    print(" ")
    if (globulo_scelto.vocale == event.target.vocale) then  
      answer_clicked_is_correct()
      change_level(score)
      timer.performWithDelay( 1000,function()
        question("next")
      end)
    else
      answer_clicked_is_wrong()
      change_level(score)
      life:set_life(life.life_count-1)
      timer.performWithDelay(1000,function (  )
        question("same")
      end)
      
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
function update_all_globuli_index()
  all_globuli = {}
  local short = update_index(all_globuli,fila_short)
  local long = update_index(all_globuli,fila_long)
  all_globuli = joinMyTables(short,long)
end
function update_index(_new_container,_from)
  _new_container = {}
  for i=1,_from.numChildren do
    local el = _from[i]
    if el.name == "glob" then
      table.insert(_new_container,el)
    end
  end
  return _new_container
end
function joinMyTables(t1, t2)
 
   for k,v in ipairs(t2) do
      table.insert(t1, v)
   end 
 
   return t1
end
function setup_pulsanti_per_rispondere(_group, _new_level)
  -- rimuovi se c'è fila group
  if fila_group ~= nil then
    _group:remove(fila_group)
  end

  -- crea la nuova file
  fila_short = CreaFila("short-", vocali, path, x_pos)
  fila_long = CreaFila("long-", vocali, path, x_pos)
  fila_group = display.newGroup()
  fila_group:insert(fila_short)
  fila_group:insert(fila_long)
  _group:insert(fila_group)
  
  update_all_globuli_index()

  fila_short.y = 140
  fila_long.y = 300
  fila_group.y = 300
  
  
end

function game:createScene(event)
  setup_pulsanti_per_rispondere(self.view)
  pulsantone = crea_pulsantone()
  --pulsantone:play()
  self.view:insert(pulsantone)
  self.view:insert(back_btn)
  self.view:insert(record_punteggio_group)
  life = Life.new()
  life.x = 340
  life.y = 239
  self.view:insert(life)
  stage_of_game = self.view
  globulo_scelto = choose_random(globulo_scelto)
  back_btn:addEventListener("tap", go_bk)
  audio.setVolume( 0.5, { channel=2 } ) 
end

function play_audio_globulo_attuale()
  audio.play(globulo_scelto.audio)
  pulsantone:play()
end

function game:enterScene (event)
  
  local params = event.params
  if params ~= nil then
    user_from_menu_iniziale = params.user_from_menu_iniziale
  end
  timer.performWithDelay( 1000, choose_random_globulo_and_play_audio)
  math.randomseed(os.time())
end

game:addEventListener( "createScene", game_created )
game:addEventListener( "enterScene", game_entered )

return game