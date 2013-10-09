require('src.utils.button_to_go')
require('src.utils.button_to_go_back')

local storyboard = require( "storyboard" )
local glob = require("src.confronto.glob")
local confronto = storyboard.newScene()
local torna_indietro

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

function confronto:createScene( event )
  print("confronto:createScene")
  print("VOCALE ATTUALE:")
  print(_G.vocale)
  -- variabili generiche
  group = self.view
  -- torna indietro
  torna_indietro = button_to_go_back()
  -- mostra le lettere selezioante
  -- create_lettera_lunga()
  -- create_lettera_corta()
  glob_l = glob:newMovieClip(_G.vocale,'L')
  glob_s = glob:newMovieClip(_G.vocale,'S')
  torna_indietro:addEventListener("tap", goto_menuiniziale)
  group:insert(torna_indietro)
end

confronto:addEventListener( "destroyScene", confronto )
confronto:addEventListener( "enterScene",  confronto )
confronto:addEventListener( "createScene", confronto )

return confronto
