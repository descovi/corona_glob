inspect = require 'src.utils.inspect.inspect'
_G.vocale = "a"
_G.tipo = "lunga"
_G.combinazione = "a_e"

local storyboard = require "storyboard"
display.setStatusBar( display.HiddenStatusBar )

-- Create a storyboard scene for this module
local scene = storyboard.newScene()
storyboard.isDebug = true
storyboard.gotoScene( "src.confronto" )

local gurgle = audio.loadSound('media/audio/GURGLE.wav')
-- audio.play( gurgle )