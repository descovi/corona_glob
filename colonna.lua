require 'sprite'

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
  local sheet1 = graphics.newImageSheet("media/colonna/a_e/1/full.png",{ width=1024, height=256, numFrames=8 })
  local instance1 = display.newSprite( sheet1, { name="cat", start=1, count=8, time=1000 } )
  instance1:play()
  instance1.x = 400
  instance1.y = 400
  group:insert(instance1)
  --anim:addEventListener("tap", go_next_anim)
  -- torna indietro
  local torna_indietro = button_to_go_back()
  torna_indietro:addEventListener("tap", torna_indietro)
end

colonna:addEventListener( "createScene" , scene )

return colonna
