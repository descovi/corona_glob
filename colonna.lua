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
  local sequence_data = {
    { name="forward", start=1, count=_totalFrames, time=1000,  loopCount = 1}, 
    { name="bounce",  start=1, count=_totalFrames, time=1000,  loopCount = 1, loopDirection = "bounce" },
    { name="counter", frames= {11,10,9,8,7,6,5,4,3,2,1}, time=1000,  loopCount = 1}
  }
  local anim = display.newSprite( sheet1, sequence_data )
  anim:setSequence( "forward" )
  anim:play()
  anim.x = display.contentWidth / 2
  anim.y = display.contentHeight / 2
  anim_container:insert(anim)

  local function intro( event )
    if event.phase == "began" then
      local gurgle = audio.loadSound('media/audio/a-e/fadfade/1.mp3')
      audio.play( gurgle )
    elseif event.phase == "ended" then
      local gurgle = audio.loadSound('media/audio/a-e/fadfade/2.mp3')
      
      audio.play( gurgle )
      local thisSprite = event.target
      thisSprite:setSequence( "counter" )
      thisSprite:play()
      anim:removeEventListener( "sprite", intro )
    end
  end
  -- Add sprite listener
  anim:addEventListener( "sprite", intro )

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