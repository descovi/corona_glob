local storyboard = require( "storyboard" )
local intro = storyboard.newScene()

function intro:createScene( event )
  local group = self.view
  local video = native.newVideo(0,0,1024,768)
  function click_over_video( event )
  video:removeSelf()
  storyboard.removeScene("src.intro")
  storyboard.gotoScene("src.menu_iniziale")
end

local function videoListener( event )
  print( "Event phase: " .. event.phase )
  if event.phase == "ended" then
    video:play()
  end
  if event.errorCode then
    native.showAlert( "Error!", event.errorMessage, { "OK" } )
  end
end
  video:load("media/video.m4v")
  video:play()
  video:addEventListener( "video", videoListener )

  local bkgd = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
  bkgd:setFillColor( 0, 0, 0 )
  bkgd:addEventListener("tap", click_over_video )
  video:addEventListener("tap", click_over_video )
  group:insert(bkgd)
  group:insert(video)
end

intro:addEventListener( "createScene", scene )

return intro