require('src.utils.button_to_go')
require('src.utils.button_to_go_back')

local storyboard = require( "storyboard" )
local glob = require("src.confronto.glob")
local confronto = storyboard.newScene()
local torna_indietro
local group

local renable_click = function(e)
  print("- RENABLE_CLICK -")
  lettera_clickable = true
  print(lettera_clickable)
end

function play_sound( event )
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

function createTornaIndietro(group)
  torna_indietro = button_to_go_back()
  torna_indietro:addEventListener("tap", goto_menuiniziale)
  group:insert(torna_indietro)
end

function confronto:createScene( event )
  glob_l = glob:newMovieClip(_G.vocale,'L')
  glob_s = glob:newMovieClip(_G.vocale,'S')

  createTornaIndietro(self.view)
end

confronto:addEventListener( "destroyScene", confronto )
confronto:addEventListener( "enterScene",  confronto )
confronto:addEventListener( "createScene", confronto )

return confronto
