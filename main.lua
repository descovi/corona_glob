require ('src.scegli_combinazione')
local storyboard = require "storyboard"
display.setStatusBar( display.HiddenStatusBar )

_G.vocale = "a"
_G.tipo = "lunga"

-- Create a storyboard scene for this module
local scene = storyboard.newScene()
storyboard.gotoScene( "src.scegli_combinazione" )

local gurgle = audio.loadSound('media/audio/GURGLE.wav')
audio.play( gurgle )
