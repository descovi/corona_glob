require('src.utils.button_to_go')
require('src.utils.button_to_go_back')

local storyboard = require( "storyboard" )
local confronto = storyboard.newScene()


function play_sound( event )
  audio.play( event.target.audio )
end

function goto_menuiniziale(e)
  storyboard.gotoScene("src.menu_iniziale")
end

function go_to_confronto_lunga(event)
  _G.tipo = 'lunga'
  if _G.vocale == 'a' or _G.vocale == 'e' or _G.vocale == 'o' then
    storyboard.gotoScene("src.scegli_combinazione")
  else
    storyboard.gotoScene("src.colonna")
  end
end

function go_to_confronto_corto(event)
  _G.tipo = 'corta'
  if _G.vocale == 'a' or _G.vocale == 'e' or _G.vocale == 'o' then
    storyboard.gotoScene("src.scegli_combinazione")
  else
    storyboard.gotoScene("src.colonna")
  end
end

function confronto:enterScene( event )
  print "CIAO forno"
end

function confronto:createScene( event )
  -- variabili generiche
  local group = self.view
  local path_audio = 'media/audio/vocali/'

  -- torna indietro
  local torna_indietro = button_to_go_back()

  -- mostra le lettere selezioante
  local size_pulsantoni = 300
  -- LUNGA
  local lettera_lunga = display.newImage( group, "media/menu_iniziale/long-".. _G.vocale ..".png")
  lettera_lunga.width = size_pulsantoni
  lettera_lunga.height = size_pulsantoni
  lettera_lunga.x = display.contentWidth / 2 - size_pulsantoni 
  lettera_lunga.y = display.contentHeight / 2 
  lettera_lunga.audio = audio.loadSound( path_audio .. _G.vocale:upper() ..'_L.mp3' )
  lettera_lunga:addEventListener("tap", play_sound)
  create_button_to_go(lettera_lunga,_G.vocale)
  lettera_lunga.cerchio_container:addEventListener("tap", go_to_confronto_lunga)

  -- CORTA
  local lettera_corta = display.newImage( group, "media/menu_iniziale/short-a.png")
  lettera_corta.width = size_pulsantoni
  lettera_corta.height = size_pulsantoni
  lettera_corta.x = display.contentWidth / 2 + size_pulsantoni 
  lettera_corta.y = display.contentHeight / 2
  lettera_corta.audio = audio.loadSound( path_audio.. _G.vocale:upper() .. '_S.mp3' )
  lettera_corta:addEventListener("tap", play_sound)
  create_button_to_go(lettera_corta,_G.vocale)
  lettera_corta.cerchio_container:addEventListener("tap", go_to_confronto_corto)

  torna_indietro:addEventListener("tap", goto_menuiniziale)
  group:insert(torna_indietro)
end

confronto:addEventListener( "createScene", confronto )

return confronto
