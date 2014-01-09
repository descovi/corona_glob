_G.vocale = "a"
_G.tipo = "lunga"
_G.combinazione = "a_e"
_G.font = "HiraMaruPro-W4"
_G.font_bold = "HiraKakuStdN-W8"

local storyboard = require "storyboard"
--storyboard.purgeOnSceneChange = true
--storyboard.disableAutoPurge = true
display.setStatusBar( display.HiddenStatusBar )

-- Create a storyboard scene for this module
local scene = storyboard.newScene()
storyboard.isDebug = false
storyboard.gotoScene( "src.intro" )

local gurgle = audio.loadSound('media/audio/gurgle.wav')
local drop = audio.loadSound('media/audio/drop.mp3')

function play_background_drop()
  local canale = 3
  audio.play( drop,{channel=canale, onComplete=function()
    timer.performWithDelay(math.random(1000,12000), function()
      play_background_drop()
    end)
  end} )
  audio.setVolume( 0.3, { channel=canale } ) 
end

function play_background_gurgle()
  audio.play( gurgle,{channel=4,loops=-1})
  audio.setVolume( 0.05, { channel=4 } ) 
end

play_background_drop()
play_background_gurgle()