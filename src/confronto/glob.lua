local Movieclip = require 'src.utils.movieclip'
local Glob = {}

Glob.newMovieClip = function(self, vocale, long_or_short, view)

  self.glob = {}

  self.glob.setupAnimationPath = function(self,vocale,long_or_short)
    local origin_path = "media/menu_iniziale/"
    if long_or_short == 'L' then
      vocal_type = "long"
    else
      vocal_type = "short"
    end
    self.anim_path = origin_path..vocal_type.."-".. vocale .."/1.png"
    self:fill_anim_list()
  end

  self.glob.fill_anim_list = function(self)
    self.anim_list = {}
    for i=1,24 do
      self.anim_list[i] = string.gsub (self.anim_path, "1", i)
    end
  end

  -- -- START MOVIECLIP -- --

  self.glob.createMovieClip = function(self, _anim_list)
    
    self.movieclip = Movieclip.newAnim(_anim_list)
    self.movieclip.name = "glob-movieclip"
    self.movieclip.is_going = false

    -- playGlob (sound and animation)

    self.movieclip.playGlob = function (self)
      self.is_going = true
      self:playAnimation()
      self:playSound()
      self:dispatchEvent( { name="startPlay", target=self } )
    end

    self.movieclip.playAnimation = function ( self )
      local myclosure = function() 
        self:nextFrame()
      end
      timer.performWithDelay(5,myclosure,24)
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
        m:dispatchEvent( { name="fadeOut50%", target=m } )
      end})
    end

    -- fadeIn

    self.movieclip.fadeInAndPlay = function(self)
      transition.to(self, {time=100, alpha=1, onComplete=function(m)
        self:playGlob()
      end})
    end

    self.movieclip:setPosition()
    self.movieclip:setSize(500)
  end

  -- -- # END MOVIECLIP -- --

  self.glob.setupSound = function(self,path)
    local path_audio = 'media/audio/vocali/' .. path
    self.movieclip.audio = audio.loadSound(path_audio)
  end

  self.glob.tapped = function(event)
    if event.y < 544 then
      local movie_clip = event.target
      if (movie_clip.is_going == false and movie_clip.alpha == 1) then
        movie_clip:playGlob()
        movie_clip:fadeOutWithDelay()
      end
    end
  end

  self.glob.create = function(self, vocale, long_or_short, view)
    local vocale_upper = vocale:upper()
    local sound_path = vocale_upper..'_'..long_or_short..'.mp3'
    self:setupAnimationPath(vocale, long_or_short)
    self:createMovieClip(self.anim_list)
    self:setupSound(sound_path)
    self.movieclip:addEventListener("tap", self.tapped)
    
    view:insert(self.movieclip)
    return self.movieclip
  end

  return self.glob:create(vocale, long_or_short, view)

end

return Glob