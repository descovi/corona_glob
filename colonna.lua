local storyboard = require( "storyboard" )
local colonna = storyboard.newScene()
local group 

function generate_background()
  local background = display.newImage("media/sfondi/a-e.png")
  group:insert(background)
end

function colonna:createScene( event )
  group = self.view
  generate_background()
end

colonna:addEventListener( "createScene", scene )

return colonna