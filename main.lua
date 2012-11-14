require ('src.scegli_combinazione')
require ('src.confronto')
local storyboard = require "storyboard"
display.setStatusBar( display.HiddenStatusBar )

_G.vocale = "a"
_G.tipo = "lunga"

-- Create a storyboard scene for this module
local scene = storyboard.newScene()
storyboard.isDebug = true
storyboard.gotoScene( "src.menu_iniziale" )

local gurgle = audio.loadSound('media/audio/GURGLE.wav')
--audio.play( gurgle )
