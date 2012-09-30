local storyboard = require( "storyboard" )
local confronto = storyboard.newScene()
local size_torna_indietro = "80"


function confronto:createScene( event )
  local group = self.view
  local torna_indietro = display.newImage('media/torna_indietro.png')
  torna_indietro.width = size_torna_indietro
  torna_indietro.height = size_torna_indietro
function goto_menuiniziale(e)
  storyboard.gotoScene("menu_iniziale")
end
  torna_indietro:addEventListener("tap", goto_menuiniziale)
  group:insert(torna_indietro)
end

confronto:addEventListener( "createScene", confronto )

return confronto