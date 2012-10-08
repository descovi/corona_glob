local storyboard = require( "storyboard" )
local colonna = storyboard.newScene()
local group

function torna_indietro(event)
  storyboard.gotoScene("confronto")
end

function go_next_anim(event)
  print "prossima animazione"
end

function colonna:createScene( event )
  group = self.view
  -- background
  local background = display.newImage("media/sfondi/".._G.vocale..".png")
  group:insert(background)
  -- anim
  local anim = display.newImage(group, "media/colonna/a_e/1/full.png")
  anim:addEventListener("tap", go_next_anim)
  -- torna indietro
  local torna_indietro = button_to_go_back()
  torna_indietro:addEventListener("tap", torna_indietro)
end

colonna:addEventListener( "createScene" , scene )

return colonna
