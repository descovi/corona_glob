require('utils.button_to_go')

local storyboard = require( "storyboard" )
local confronto = storyboard.newScene()
local size_torna_indietro = 80
local size_pulsantoni = 300

function play_sound( event )
  audio.play( event.target.audio )
end

function goto_menuiniziale(e)
  storyboard.gotoScene("menu_iniziale")
end

function go_to_confronto_lunga(event)
  storyboard.gotoScene("colonna")
end

function go_to_confronto_corto(event)
  storyboard.gotoScene("colonna")
end

function confronto:createScene( event )
  -- variabili generiche
  local group = self.view
  local path_audio = 'media/audio/vocali/'

  -- torna indietro
  local torna_indietro = display.newImage('media/torna_indietro.png')
  torna_indietro.width = size_torna_indietro
  torna_indietro.height = size_torna_indietro
  torna_indietro.x = display.contentWidth -size_torna_indietro*.5 - 20
  torna_indietro.y = size_torna_indietro +210

  -- mostra le lettere selezioante
  
  -- LUNGA
  local lettera_lunga = display.newImage( group, "media/menu_iniziale/long-a.png")
  lettera_lunga.width = size_pulsantoni
  lettera_lunga.height = size_pulsantoni
  lettera_lunga.x = 200
  lettera_lunga.y = 550
  lettera_lunga.audio = audio.loadSound( path_audio .. _G.vocale:upper() ..'_L.mp3' )
  lettera_lunga:addEventListener("tap", play_sound)
  create_button_to_go(lettera_lunga,'a')
  lettera_lunga.cerchio_container:addEventListener("tap", go_to_confronto_lunga)

  -- CORTA

  local lettera_corta = display.newImage( group, "media/menu_iniziale/short-a.png")
  lettera_corta.width = size_pulsantoni
  lettera_corta.height = size_pulsantoni
  lettera_corta.x = 550
  lettera_corta.y = 550
  lettera_corta.audio = audio.loadSound( path_audio.. _G.vocale:upper() .. '_S.mp3' )
  lettera_corta:addEventListener("tap", play_sound)
  create_button_to_go(lettera_corta,'a')
  lettera_corta.cerchio_container:addEventListener("tap", go_to_confronto_corto)

  torna_indietro:addEventListener("tap", goto_menuiniziale)
  group:insert(torna_indietro)
end

confronto:addEventListener( "createScene", confronto )

return confronto