local Movieclip = require 'src.utils.movieclip'
local Glob = {}
Glob.newMovieClip = function(self, vocale, long_or_short)

  self.glob = {}

  self.glob.setupAnimationPath = function(self,vocale,long_or_short)
    -- "_L"
    -- "media/menu_iniziale/short-".. _G.vocale .."/1.png","_L"
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

  self.glob.createMovieClip = function(self, _anim_list)
    
    self.movieclip = Movieclip.newAnim(_anim_list)
    self.movieclip.name = "glob-movieclip"
    self.movieclip.is_going = false

    self.movieclip.playAnimation = function ( self )

      local myclosure = function() 
        self:nextFrame()
      end
      timer.performWithDelay(5,myclosure,24)
    end
    
    self.movieclip.audio_played = function ( bog )
      self.movieclip.is_going = false
    end

    self.movieclip.playSound = function (self)
      audio.play(self.audio, {onComplete = self.audio_played} ) 
    end

    self.movieclip.setPosition = function(self,size)
      self.y = display.contentHeight / 2
      self.x = display.contentWidth / 2
    end

    self.movieclip.setSize = function(self,size)
      self.width = size
      self.height = size
    end

    self.movieclip:setPosition()
    self.movieclip:setSize(500)

  end

  self.glob.setupSound = function(self,path)
    local path_audio = 'media/audio/vocali/' .. path
    self.movieclip.audio = audio.loadSound(path_audio)
  end

  self.glob.tapped = function(event)
    local target = event.target
    if (target.is_going == false) then
      target:playAnimation()
      target:playSound()
      target.is_going = true
    end
  end

  self.glob.create = function(self, vocale, long_or_short)
    local vocale_upper = vocale:upper()
    local sound_path = vocale_upper..'_'..long_or_short..'.mp3'
    self:setupAnimationPath(vocale, long_or_short)
    self:createMovieClip(self.anim_list)
    self:setupSound(sound_path)
    self.movieclip:addEventListener("tap", self.tapped)
  end

  self.glob:create(vocale, long_or_short)

end
return Glob