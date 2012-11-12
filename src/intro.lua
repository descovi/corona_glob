local storyboard = require( "storyboard" )
local intro = storyboard.newScene()

function click_over_video( event )
  storyboard.removeScene("src.intro")
  storyboard.gotoScene("src.menu_iniziale")
end

function intro:createScene( event )
  local group = self.view
  local video = native.newVideo(0,0,1024,768)
  video:load("media/video.m4v")

  local bkgd = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
  bkgd:setFillColor( 255, 0, 0 )
  bkgd:addEventListener("tap", click_over_video )
  group:insert( bkgd )
end

intro:addEventListener( "createScene", scene )

return intro