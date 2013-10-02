require('src.utils.button_to_go')
require('src.utils.button_to_go_back')

local movieclip = require('src.utils.movieclip')
local storyboard = require( "storyboard" )
local confronto = storyboard.newScene()
local path_audio = 'media/audio/vocali/'
local torna_indietro
local lettera_toogle = true
local lettera_clickable = true
local size_pulsantoni = 500
local group
function nextAnim()
  print("CIAO")
end

local renable_click = function(e)
  print("- RENABLE_CLICK -")
  lettera_clickable = true
  print(lettera_clickable)
end

function play_sound( event )

  function sound_listener()
    audio.play(event.target.audio,{
      onComplete=function()
        _time = 500
        if lettera_toogle == true then
          lettera_toogle = false
          transition.to(lettera_lunga, {time=_time, alpha=0.0, onComplete=renable_click})
          transition.to(lettera_corta, {time=_time, alpha=1.0})
        else
          lettera_toogle = true

          transition.to(lettera_lunga, {time=_time, alpha=1.0, onComplete=renable_click})
          transition.to(lettera_corta, {time=_time, alpha=0.0})
        end
      end
    })
  end

  timer.performWithDelay( 500, sound_listener )
end

function lettera_tapped(event)
  print("LETTERA TAPPED")
  if (lettera_clickable == true) then
    lettera_clickable = false
    play_anim(event)
    play_sound(event)
  end
end

function play_anim( event )
  local myclosure = function()
    event.target:nextFrame()
  end
  timer.performWithDelay(50,myclosure,24)
  -- event.target:play({loop=1})
end

function goto_menuiniziale(e)
  storyboard.removeAll()
  storyboard.gotoScene("src.menu_iniziale")
end

function go_to_confronto_lunga(event)
  _G.tipo = 'lunga'
  storyboard.removeAll()
  storyboard.gotoScene("src.colonna")
end

function go_to_confronto_corto(event)
  _G.tipo = 'corta'
  _G.combinazione = _G.vocale.."_".._G.vocale
  storyboard.removeAll()
  storyboard.gotoScene("src.colonna")
end

function go_to(event)
  print("gotoooooo")
end

function create_lettera(anim_path,audio_path)
  anim_list = {}
  for i=1,24 do
    anim_list[i] = string.gsub (anim_path, "1", i)
  end

  local lettera  = movieclip.newAnim(anim_list)
  group:insert(lettera)
  local long_audio_path = path_audio .. _G.vocale:upper() .. audio_path ..'.mp3'
  lettera.width  = size_pulsantoni
  lettera.height = size_pulsantoni
  lettera.y      = display.contentHeight / 2
  lettera.audio  = audio.loadSound( long_audio_path )
  lettera:addEventListener("tap", lettera_tapped)
  return lettera
end

function create_lettera_lunga()
  lettera_lunga = create_lettera("media/menu_iniziale/long-".. _G.vocale .."/1.png","_L")
  lettera_lunga.x = display.contentWidth / 2
  create_button_to_go(lettera_lunga,_G.vocale)
  lettera_lunga.cerchio_container:addEventListener("tap", go_to_confronto_lunga)
  lettera_lunga.alpha = 1.0
end

function create_lettera_corta()
  -- CORTA
  lettera_corta = create_lettera( "media/menu_iniziale/short-".._G.vocale.."/1.png","_S")
  lettera_corta.x = display.contentWidth / 2
  create_button_to_go(lettera_corta,_G.vocale)
  lettera_corta.cerchio_container:addEventListener("tap", go_to_confronto_corto)
  lettera_corta.alpha = 0.0
end

function confronto:createScene( event )
  print("confronto:createScene")
  print("VOCALE ATTUALE:")
  print(_G.vocale)
  -- variabili generiche
  group = self.view
  -- torna indietro
  torna_indietro = button_to_go_back()
  -- mostra le lettere selezioante
  create_lettera_lunga()
  create_lettera_corta()
  torna_indietro:addEventListener("tap", goto_menuiniziale)
  group:insert(torna_indietro)
end

confronto:addEventListener( "destroyScene", confronto )
confronto:addEventListener( "enterScene",  confronto )
confronto:addEventListener( "createScene", confronto )

return confronto
