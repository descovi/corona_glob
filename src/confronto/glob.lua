local Movieclip = require 'src.utils.movieclip'
local Glob = {}
Glob.newMovieClip = function(self)

  local glob = {}

  glob.set_anim_path = function(self)
    -- "_L"
    -- "media/menu_iniziale/short-".. _G.vocale .."/1.png","_L"
    local origin_path = "media/menu_iniziale/"
    self.anim_path = origin_path.."long-".. _G.vocale .."/1.png"
  end

  glob.fill_anim_list = function(self)
    self.anim_list = {}
    for i=1,24 do
      self.anim_list[i] = string.gsub (self.anim_path, "1", i)
    end
  end

  glob.setMovieClip = function(self)
    self:set_anim_path()
    self:fill_anim_list()
    self.movieclip = Movieclip.newAnim(glob.anim_list)
  end

  glob.setPosition = function(self,size)
    self.movieclip.y = display.contentHeight / 2
    self.movieclip.x = display.contentWidth / 2
  end

  glob.setSize = function(self,size)
    self.movieclip.width = size
    self.movieclip.height = size
  end

  glob.playAnimation = function(event)
    local target = event.target
    local myclosure = function() 
      target:nextFrame()
    end
    timer.performWithDelay(5,myclosure,24)
  end

  function glob:create()
    self:setMovieClip()
    self:setSize(500)
    self:setPosition()
    self.movieclip:addEventListener("tap", self.playAnimation)
  end

  glob:create()

end
return Glob