local Anim = {}
Anim.newSprite = function()
  local anim = {}
  local totalFrames = 11
  local sheet_options  = { width=1024, height=256, numFrames=totalFrames }
  local counter = 1
  local toogle = true
  local audio_1 = audio.loadSound('media/audio/a-e/fadfade/1.mp3')
  local audio_2 = audio.loadSound('media/audio/a-e/fadfade/2.mp3')

  function anim.image_sheet_load()
    local sheet = graphics.newImageSheet("media/colonna/a_e/"+counter+"/full.png", sheet_options)
    local sequence_data = {
      { name="forward", start=1, count=totalFrames, time=1000,  loopCount = 1}, 
      { name="bounce",  start=1, count=totalFrames, time=1000,  loopCount = 1, loopDirection = "bounce" },
      { name="counter", frames= {11,10,9,8,7,6,5,4,3,2,1}, time=1000,  loopCount = 1}
    }
    anim = display.newSprite( sheet1, sequence_data )
  end
  
  function anim.prev()
    counter = counter -1
    --anim.image_sheet_load()
  end

  function anim.next()
    print "ciao"
    --counter++
    --anim.image_sheet_load()
  end

  local function go_next_anim(event)
    if toogle == true then
      toogle = false
      audio.play( audio_1 )
      anim:setSequence( "forward" )
      anim:play()
    else
      toogle = true
      audio.play( audio_2 )
      anim:setSequence("counter")
      anim:play()
    end
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
    end
  end

  anim.image_sheet_load()
  anim.x = display.contentWidth / 2
  anim.y = display.contentHeight / 2
  anim:addEventListener("sprite", intro)
  anim:addEventListener("tap", go_next_anim)
  anim:play()

  return anim
end

return Anim