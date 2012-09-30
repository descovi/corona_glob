local storyboard = require( "storyboard" )
local colonna = storyboard.newScene()
local group 

function generate_background()
  local background = display.newImage("media/sfondi/".._G.vocale..".png")
  group:insert(background)
end

function go_to_confronto(event)
  storyboard.gotoScene("confronto")
end

function colonna:createScene( event )
  group = self.view
  generate_background()
  local anim1 = display.newImage(group,"media/colonna/a-e/fadfade/full.png")
  local torna_indietro = button_to_go_back()
  torna_indietro:addEventListener("tap", go_to_confronto)
end

colonna:addEventListener( "createScene", scene )

return colonna