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
    local time = 1000
    local frames_ = {}
    for i=1,37 do
      table.insert(frames_,i)
    end
    local sequence_data = {
      {name="standard", start=1,count=37,loopCount=1,time=time},
      {name="reverse",frames= frames_,time=time, loopCount=1}
    }
    local sprite_sheet = display.newSprite(image_sheet, sequence_data)
    sprite_sheet:setSequence("reverse")
    sprite_sheet.x = 100
    sprite_sheet.y = 100
    self.movieclip = sprite_sheet
  end


  self.glob.createMovieClip = function(self, _anim_list)
    self.movieclip.name = "glob-movieclip"
    self.movieclip.is_going = false

    -- playGlob (sound and animation)
    self.movieclip.playGlob = function (self)
      self.is_going = true
      self:playAnimation()
      self:playSound()
      self:dispatchEvent({name="GlobStartPlay",target=self})
    end

    self.movieclip.playAnimation = function ( self )
      self:play()
    end

    self.movieclip.playSound = function (self)
      timer.performWithDelay(100,function()
        audio.play(self.audio, {onComplete=function(m)
          self.is_going = false
        end})
      end)
      
    end

    -- posizion

    self.movieclip.setPosition = function(self,size)
      self.y = display.contentHeight / 2
      self.x = display.contentWidth / 2
    end

    -- fadeOuting

    self.movieclip.fadeOutWithDelay = function(self)
      local time = 500
      timer.performWithDelay(500, function()
        self:fadeOut()
      end)
    end

    self.movieclip.fadeOut = function ()
      local time = 200
      transition.to(self.movieclip, {time=time, alpha=.7, onComplete=function(m)
        transition.to(self.movieclip, {time=time*2, alpha=0})
        m:dispatchEvent( { name="GlobFadeOut50%", target=m } )
      end})
    end

    -- fadeIn

    self.movieclip.fadeInAndPlay = function(self)
      transition.to(self, {time=100, alpha=1, onComplete=function(m)
        self:playGlob()
      end})
    end

    self.movieclip:setPosition()
  end

  self.glob.setupSound = function(self,path)
    local path_audio = 'media/audio/vocali/' .. path
    self.movieclip.audio = audio.loadSound(path_audio)  
  end

  self.glob.tapped = function(event)
    print("---> TAPPED")
    if event.y < 544 then
      local movie_clip = event.target
      if (movie_clip.is_going == false and movie_clip.alpha == 1) then
        movie_clip:playGlob()
        --movie_clip:fadeOutWithDelay()
      end
    end
  end

  self.glob.create = function(self, _vocale)
    --local sound_path = vocale_upper..'_'....'.mp3'   
    self:setupAnimationPath(_vocale, _long_or_short)

    self:createMovieClip()
    
    --self:setupSound(sound_path)
    self.movieclip:addEventListener("tap", self.tapped)
   
    local stage = display.getCurrentStage()
    --_view:insert(self.movieclip)
    return self.movieclip
  end

  return self.glob:create(vocale)

end

return Glob