local storyboard = require ( "storyboard" )
--Create a storyboard scene for this module
local menu_iniziale = storyboard.newScene()


--Create the scene
function menu_iniziale:createScene( event )
  local group = self.view
  local bkgd = display.newRect( 0, 0, 100, 100 )
  bkgd:setFillColor( 255, 255, 0 )
  --Create a text object that displays the current scene name and insert it into the scene's view
  local screenText = display.newText( "Screen 1", 0, 0, native.systemFontBold, 18 )
  screenText.x = display.contentCenterX
  screenText.y = display.contentCenterY
  group:insert( screenText )
  print "create scene"
end

--Add the createScene listener
menu_iniziale:addEventListener( "createScene", menu_iniziale )



return menu_iniziale