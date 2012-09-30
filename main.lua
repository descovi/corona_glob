local storyboard = require "storyboard"
display.setStatusBar( display.HiddenStatusBar )

_G.vocale = "a"

-- Create a storyboard scene for this module
local scene = storyboard.newScene()
storyboard.gotoScene( "colonna" )

local gurgle = audio.loadSound('media/audio/GURGLE.wav')
audio.play( gurgle )

