require('src.utils.button_to_go')
require('src.utils.button_to_go_back')
local movieclip = require('src.utils.movieclip')
local storyboard = require( "storyboard" )
local confronto = storyboard.newScene()
local path_audio = 'media/audio/vocali/'
local torna_indietro

function play_sound( event )
  audio.play( event.target.audio )
end

function play_anim( event )
  event.target.play()
  
end

function goto_menuiniziale(e)
  storyboard.removeScene("src.menu_iniziale")
  storyboard.gotoScene("src.menu_iniziale")
end
function go_to(event)
  print("gotoooooo")
end

function go_to_confronto_lunga(event)
  _G.tipo = 'lunga'
  storyboard.removeScene("src.scegli_combinazione")
  storyboard.gotoScene("src.scegli_combinazione") 
end

function go_to_confronto_corto(event)
  _G.tipo = 'corta'
  storyboard.removeScene("src.scegli_combinazione")
  storyboard.gotoScene("src.scegli_combinazione")
end
local lettera_lunga
local lettera_corta 
local size_pulsantoni = 500
local group
function create_lettera(anim_path,audio_path)
  local lettera = movieclip.newAnim({anim_path})
  group:insert(lettera)
  local long_audio_path = path_audio .. _G.vocale:upper() .. audio_path ..'.mp3'
  lettera.width = size_pulsantoni
  lettera.height = size_pulsantoni
  lettera.y = display.contentHeight / 2 
  lettera.audio = audio.loadSound( long_audio_path )
  lettera:addEventListener("tap", play_sound)
  lettera:addEventListener("tap", play_anim)
  return lettera
end
function create_lettera_lunga()
  lettera_lunga = create_lettera("media/menu_iniziale/long-".. _G.vocale ..".png","_L")
  lettera_lunga.x = display.contentWidth / 2 - 250
  create_button_to_go(lettera_lunga,_G.vocale)
  lettera_lunga.cerchio_container:addEventListener("tap", go_to_confronto_lunga)
end
function create_lettera_corta()
  -- CORTA
  lettera_corta = create_lettera( "media/menu_iniziale/short-".._G.vocale..".png","_S")
  lettera_corta.x = display.contentWidth / 2 + 250 
  create_button_to_go(lettera_corta,_G.vocale)
  lettera_corta.cerchio_container:addEventListener("tap", go_to_confronto_corto)
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
