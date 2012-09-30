local storyboard = require( "storyboard" )
local confronto = storyboard.newScene()

function confronto:createScene( event )
  print "ho visto cose riservate"
  local globulo = display.newImage('media/torna_indietro.png')
  globulo.width = "30"
  globulo.height = "30"
end

confronto:addEventListener( "createScene", menu_iniziale )

return confronto