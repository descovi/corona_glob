local Glob = {}

Glob.new = function(self, vocale)

  self.glob = {}

  self.glob.path_to_animation = function (self, vocale)
    local origin_path = "media/vocali/"
    local path = origin_path..vocale ..".png"
    return path
  end

  self.glob.path_to_coords = function (self, vocale)
    local origin_path = "media.vocali."
    local path = origin_path..vocale
    return path
  end

  self.glob.setupAnimationPath = function(self, vocale)
    local sheet_png = self:path_to_animation(vocale)
    local coords_path = self:path_to_coords(vocale)
    
    local SheetInfo = require(coords_path)
   
    local image_sheet = graphics.newImageSheet(sheet_png, SheetInfo:getSheet())
    local frames_ = {}
    local total_frames = 37
    
    for i=0,total_frames do
      table.insert(frames_,total_frames-i)
    end

    local duration_anim_totale = 2000
    local sequence_data = {
      
      {name="standard", start=1,count=total_frames,loopCount=1,time=duration_anim_totale},
      
      {name="reverse",frames= frames_, loopCount=1,time=duration_anim_totale}

    }
    local sprite_sheet = display.newSprite(image_sheet, sequence_data)
    sprite_sheet.duration_anim_totale = duration_anim_totale
    sprite_sheet:setSequence("standard")
    sprite_sheet.not_yet_started = true
    sprite_sheet.x = 100
    sprite_sheet.y = 100
    self.movieclip = sprite_sheet
  end


  self.glob.createMovieClip = function(self, _anim_list)
    self.movieclip.name = "glob-movieclip"

    -- playGlob (sound and animation)
    self.movieclip.playGlob = function (self)
      self:playAnimation()
      self:playSound()
      self:dispatchEvent({name="GlobStartPlay",target=self})
    end

    self.movieclip.playAnimation = function ( self )
      self:play()
    end

    self.movieclip.playSound = function (self)

      if self.sequence == "standard" then
        -- 1° ANIMATION
        timer.performWithDelay(470,function()
          audio.play(self.audio_s)
        end)
        -- 
        timer.performWithDelay(1650,function()
          audio.play(self.audio_l)
        end)

      else
        -- 2° ANIMATION
        timer.performWithDelay(470,function()
          audio.play(self.audio_l)
        end)
        
        timer.performWithDelay(1360,function()
          audio.play(self.audio_s)
        end)

      end
      
    end

    -- posizion

    self.movieclip.setPosition = function(self,size)
      self.y = display.contentHeight / 2
      self.x = display.contentWidth / 2
    end

    self.movieclip.chooseSequence = function(self)
      if self.sequence == "reverse" then
        self:setSequence("standard")
      elseif self.sequence == "standard" and self.not_yet_started == false then
        self:setSequence("reverse")
      end
      self.not_yet_started = false
    end

    self.movieclip:setPosition()
  end

  self.glob.setupSound = function(self,_vocale)
    local sound_path_l = _vocale:upper()..'_L.mp3'
    local sound_path_s = _vocale:upper()..'_S.mp3'
    local path_audio_l = 'media/audio/vocali/' .. sound_path_l
    local path_audio_s = 'media/audio/vocali/' .. sound_path_s
    self.movieclip.audio_l = audio.loadSound(path_audio_l)  
    self.movieclip.audio_s = audio.loadSound(path_audio_s)  
  end


  self.glob.tapped = function(event)
    print("---> TAPPED")
    local movie_clip = event.target
    if (event.y < 544 and movie_clip.isPlaying == false) then
      
      movie_clip:chooseSequence()

      movie_clip:playGlob()
    end
  end

  self.glob.create = function(self, _vocale)
    
    self:setupAnimationPath(_vocale, _long_or_short)

    self:createMovieClip()
    self:setupSound(_vocale)
    self.movieclip:addEventListener("tap", self.tapped)
   
    local stage = display.getCurrentStage()
    --_view:insert(self.movieclip)
    return self.movieclip
  end

  return self.glob:create(vocale)

end

return Glob