-- AUDIO
-- local beepSound = audio.loadSound( "beep.wav" )

-- TESTO

-- IMMAGINI
-- local button = display.newImage( "button.png" )
-- button.x = display.contentWidth / 2
-- button.y = display.contentHeight - 50

display.setStatusBar( display.HiddenStatusBar )

local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true

local text = display.newText( "Ciao", 0, 0, nil, 100 )
text:setTextColor( 255, 255, 255 )
text.x = 0.5 * display.contentWidth
text.y = 0.5 * display.contentHeight

local bkgd = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
bkgd:setFillColor( 299, 0, 0 )
-- local video = native.newVideo(0,0,1024,768)
-- video:load("media/video.m4v")

local click_over_video = function( event )
  storyboard.gotoScene("screen1")
  
end
bkgd:addEventListener("tap", click_over_video )