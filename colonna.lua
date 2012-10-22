require 'sprite'

local storyboard = require( "storyboard" )
local colonna = storyboard.newScene()
local group
local anim_container = display.newGroup()
local background = display.newImage("media/sfondi/".._G.vocale..".png")
local torna_indietro_btn = button_to_go_back()


function go_next_anim(event)
  print("prossima animazione")
end

function generate_sprite()
  local _totalFrames = 11
  local sheet1_options = { width=1024, height=256, numFrames=_totalFrames }
  local sheet1 = graphics.newImageSheet("media/colonna/a_e/1/full.png", sheet1_options)
  local sequenceData = {
      name="vocal_change",
      start=1,
      count=_totalFrames,   -- Frame that count total frame.
      time=1000,            -- Optional. In ms.  If not supplied, then sprite is frame-based.
      loopCount = 1,        -- Optional. Default is 0 (loop indefinitely)
  }
  local instance1 = display.newSprite( sheet1, sequenceData )
  instance1:play()
  instance1.x = display.contentWidth / 2
  instance1.y = display.contentHeight / 2
  anim_container:insert(instance1)
  local function spriteListener( event )
    print (event.phase)
    if event.phase == "began" then
      print "startato"
    elseif event.phase == "ended" then
      print "finito"
    end
  end
  -- Add sprite listener
  instance1:addEventListener( "sprite", spriteListener )

end

function colonna:createScene( event )
  group = self.view
  -- background
  group:insert(background)
  -- anim
  generate_sprite()
  anim_container:addEventListener("tap", go_next_anim)
  group:insert(anim_container)
  -- torna indietro
  torna_indietro_btn:addEventListener("tap", torna_indietro)
end

colonna:addEventListener( "createScene" , scene )

function torna_indietro(event)
  storyboard.gotoScene("confronto")
end

return colonna