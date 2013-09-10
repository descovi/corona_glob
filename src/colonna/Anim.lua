local Anim = {}

Anim.newSprite = function()
  
  local anim = {}
  anim.totalFrames = 11
  anim.sheet_options  = { width=1024, height=256, numFrames=anim.totalFrames }
  anim.counter = 1
  anim.limit = 5
  anim.current_combination = "/".._G.combinazione.."/"
  anim.group = display.newGroup()

  -- path audio
  anim.audio_path = 'media/audio'..anim.current_combination
  anim.audio_1 = audio.loadSound(anim.audio_path..anim.counter..'/1.mp3')
  anim.audio_2 = audio.loadSound(anim.audio_path..anim.counter..'/2.mp3')
  -- path animation
  anim.animation_path = 'media/colonna'..anim.current_combination
  anim.path = anim.animation_path..anim.counter.."/full.png"
  
  function anim.load_image()
    -- reload path
    anim.animation_path = 'media/colonna'..anim.current_combination
    anim.path = anim.animation_path..anim.counter.."/full.png"
    anim.audio_path = 'media/audio'..anim.current_combination
    anim.audio_1 = audio.loadSound(anim.audio_path..anim.counter..'/1.mp3')
    anim.audio_2 = audio.loadSound(anim.audio_path..anim.counter..'/2.mp3')
    -- load image
    anim.sheet = graphics.newImageSheet(anim.path, anim.sheet_options)
    anim.sequence_data = {
      { name="forward", start=1, count=anim.totalFrames, time=1000,  loopCount = 1}, 
      { name="bounce",  start=1, count=anim.totalFrames, time=1000,  loopCount = 1, loopDirection = "bounce" },
      { name="counter", frames= {11,10,9,8,7,6,5,4,3,2,1}, time=1000,  loopCount = 1}
    }
    anim.sprite = display.newSprite( anim.sheet, anim.sequence_data )
    anim.group:insert(anim.sprite)
    anim.sprite.x = display.contentWidth / 2
    anim.sprite.y = display.contentHeight / 2
    anim.sprite:addEventListener("tap", anim.go_next_anim)
    -- if you want add animation when enter you can uncomment this line
    --- and change toogle from false to true
    -- anim.sprite:addEventListener("sprite", anim.intro)
    -- anim.sprite:play()
    anim.toogle = true
  end 
  
  function anim.prev()
    if (anim.counter > 1 ) then
      anim.counter = anim.counter -1
      anim.group:remove(anim.sprite)
      anim.load_image()
    end
  end
  
  function anim.next()
    if (anim.counter < anim.limit) then  
      anim.counter = anim.counter+1
      anim.group:remove(anim.sprite)
      anim.load_image()
    end
  end

  function anim.audio_ended_1_to_2(event)
    audio.play( anim.audio_2 )
  end
  function anim.audio_ended_2_to_1(event)
    audio.play( anim.audio_1 )
  end

  function anim.go_next_anim(event)
    if anim.toogle == true then
      anim.toogle = false
      anim.sprite:setSequence( "forward" )
      anim.sprite:play()

      audio.play( anim.audio_1 , {
        duration=800,
        onComplete=anim.audio_ended_1_to_2
      })

    else
      anim.toogle = true
      audio.play( anim.audio_2 , {
        duration=800,
        onComplete=anim.audio_ended_2_to_1
      })
      anim.sprite:setSequence("counter")
      anim.sprite:play()
    end
  end

  function anim.intro( event )
    if event.phase == "began" then
      audio.play( anim.audio_1 )
    elseif event.phase == "ended" then
      audio.play( anim.audio_2 )
      local thisSprite = event.target
      anim.toogle = false
      thisSprite:setSequence( "counter" )
      -- thisSprite:play()
      anim.sprite:removeEventListener( "sprite", anim.intro )
    end
  end

  anim.load_image()
  return anim
end

return Anim