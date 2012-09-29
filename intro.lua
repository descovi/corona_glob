
local storyboard = require( "storyboard" )
local intro = storyboard.newScene()

function intro:createScene( event )
  local group = self.view
  local video = native.newVideo(0,0,1024,768)
  video:load("media/video.m4v")
  local click_over_video = function( event )
    storyboard.gotoScene("menu_iniziale")
  end
  local bkgd = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
  bkgd:setFillColor( 255, 0, 0 )
  bkgd:addEventListener("tap", click_over_video )
  group:insert( bkgd )
end

intro:addEventListener( "createScene", scene )

return intro