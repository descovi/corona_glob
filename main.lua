require('src.utils.button_to_go_back')

_G.vocale = "a"
_G.tipo = "lunga"
_G.combinazione = "a_e"
_G.font = "HiraMaruPro-W4"
_G.font_bold = "HiraKakuStdN-W8"

local storyboard = require "storyboard"
display.setStatusBar( display.HiddenStatusBar )

-- Create a storyboard scene for this module
local scene = storyboard.newScene()
storyboard.isDebug = false
storyboard.gotoScene( "src.intro" )

local gurgle = audio.loadSound('media/audio/GURGLE.wav')
audio.play( gurgle,{channel=2} )
audio.setVolume( 0.15, { channel=2 } ) 