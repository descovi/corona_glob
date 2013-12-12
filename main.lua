require('src.utils.button_to_go_back')

inspect = require 'src.utils.inspect.inspect'
_G.vocale = "a"
_G.tipo = "lunga"
_G.combinazione = "a_e"
_G.font = "HiraMaruPro-W4"
_G.font_bold = "HiraKakuStdN-W8"

local storyboard = require "storyboard"
display.setStatusBar( display.HiddenStatusBar )

-- Create a storyboard scene for this module
local scene = storyboard.newScene()
storyboard.isDebug = true
storyboard.gotoScene( "src.menu_iniziale" )

local gurgle = audio.loadSound('media/audio/GURGLE.wav')
--audio.play( gurgle )









-- Code to have Corona display the font names found
local fonts = native.getFontNames()

for k, v in ipairs(fonts) do
     print(k, v)
end
---------------------------------------------------------