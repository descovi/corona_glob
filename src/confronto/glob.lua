local Glob = {}

Glob.newMovieClip = function(self, vocale, long_or_short, view)

  self.glob = {}

  self.glob.transform_l_to_long_and_r_to_short = function(long_or_short)
    local result
    if long_or_short == "L" then
      result = "long"
    else
      result = "short"
    end
    return result
  end

  self.glob.path_to_animation = function (self, long_or_short, vocale)
    local origin_path = "media/menu_iniziale/"
    local vocal_type = self.transform_l_to_long_and_r_to_short(long_or_short)
    local path = origin_path..vocal_type.."-".. vocale .."/full.png"
    return path
  end

  self.glob.path_to_coords = function (self, long_or_short, vocale)
    local origin_path = "media.menu_iniziale."

    local vocal_type = self.transform_l_to_long_and_r_to_short(long_or_short)

    
    local path = origin_path..vocal_type.."-".. vocale ..".coords"
    
    return path
  end

  self.glob.setupAnimationPath = function(self, vocale, long_or_short)
    local sheet_png = self:path_to_animation(long_or_short, vocale)
    local coords_path = self:path_to_coords(long_or_short, vocale)
    
    local SheetInfo = require(coords_path)
   
    local image_sheet = graphics.newImageSheet(sheet_png, SheetInfo:getSheet())
    local sequence_data = {name="standard", start=1,count=24,loopCount=1,time=1000}
    local sprite_sheet = display.newSprite(image_sheet, sequence_data)
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
      audio.play(self.audio, {onComplete=function(m)
        self.is_going = false
      end})
    end

    -- posizion and size

    self.movieclip.setPosition = function(self,size)
      self.y = display.contentHeight / 2
      self.x = display.contentWidth / 2
    end

    self.movieclip.setSize = function(self,size)
      self.width = size
      self.height = size
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

    --self.movieclip:setPosition()
    --self.movieclip:setSize(500)
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
        movie_clip:fadeOutWithDelay()
      end
    end
  end

  self.glob.create = function(self, _vocale, _long_or_short, _view)
    local vocale_upper = _vocale:upper()
    local sound_path = vocale_upper..'_'.._long_or_short..'.mp3'   
    self:setupAnimationPath(_vocale, _long_or_short)

    self:createMovieClip()
    
    self:setupSound(sound_path)
    self.movieclip:addEventListener("tap", self.tapped)
   
    local stage = display.getCurrentStage()
    _view:insert(self.movieclip)
    return self.movieclip
  end

  return self.glob:create(vocale, long_or_short, view)

end

return Glob