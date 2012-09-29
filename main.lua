local storyboard = require "storyboard"
display.setStatusBar( display.HiddenStatusBar )
--Create a storyboard scene for this module
local scene = storyboard.newScene()
storyboard.gotoScene( "menu_iniziale" )

local gurgle = audio.loadSound('media/audio/GURGLE.wav')
audio.play( gurgle ) 
