require 'sprite'

local storyboard = require( "storyboard" )
local colonna = storyboard.newScene()
local Arrow = require('src.colonna.Arrow')

-- dati
local group
local anim_container = display.newGroup()
local background = display.newImage("media/sfondi/".._G.vocale..".png")
local torna_indietro_btn = button_to_go_back()

-- dati anim
local totalFrames = 11
local sheet1_options = { width=1024, height=256, numFrames=totalFrames }
local sheet1 = graphics.newImageSheet("media/colonna/a_e/1/full.png", sheet1_options)
local sequence_data = {
    { name="forward", start=1, count=totalFrames, time=1000,  loopCount = 1}, 
    { name="bounce",  start=1, count=totalFrames, time=1000,  loopCount = 1, loopDirection = "bounce" },
    { name="counter", frames= {11,10,9,8,7,6,5,4,3,2,1}, time=1000,  loopCount = 1}
}
local anim = display.newSprite( sheet1, sequence_data )
-- dati audio
local audio_1 = audio.loadSound('media/audio/a-e/fadfade/1.mp3')
local audio_2 = audio.loadSound('media/audio/a-e/fadfade/2.mp3')
local anim_toogle = true


local function go_next_anim(event)
  if anim_toogle then
    anim_toogle = false
    audio.play( audio_1 )
    anim:setSequence( "forward" )
  else
    anim_toogle = true
    audio.play( audio_2 )
    anim:setSequence("counter")
  end
  anim:play()
end
local function intro( event )
  if event.phase == "began" then
    audio.play( audio_1 )
  elseif event.phase == "ended" then
    audio.play( audio_2 )
    local thisSprite = event.target
    thisSprite:setSequence( "counter" )
    thisSprite:play()
    anim:removeEventListener( "sprite", intro )
    anim_container:addEventListener("tap", go_next_anim)
  end
end
local function torna_indietro(event)
  storyboard.gotoScene( "src.scegli_combinazione" )
end
local function go_up(event)
  print "go up"
end
local function go_down(event)
  print "go down"
end

-- START
function colonna:createScene( event )
  group = self.view
  group:insert(background)
  group:insert(anim_container)

  -- anim
  anim:play()
  anim.x = display.contentWidth / 2
  anim.y = display.contentHeight / 2
  anim_container:insert(anim)
  anim:addEventListener( "sprite", intro )
  torna_indietro_btn:addEventListener("tap", torna_indietro)


  -- arrow
  arrow_up = Arrow.new()
  arrow_up:addEventListener("tap", go_up)
  arrow_down = Arrow.new()
  arrow_down:addEventListener("tap", go_down)
  --
end
colonna:addEventListener( "createScene" , scene )


return colonna