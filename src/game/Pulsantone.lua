local Pulsantone = {}
local coords = require('src.game.coords')
Pulsantone.new = function()
  local pulsantone = {}
  pulsantone.timing = 500
  pulsantone.group = display.newGroup()
  pulsantone.sprite = {}
  pulsantone.glow = {}
  pulsantone.setupAnimation = function(self)
    local path = "media/game/globo_asker/coords.png"
    self.sheet = graphics.newImageSheet(path, coords:getSheet())
    self.sheet_data = {
      name="standard", start=1,count=13,loopCount=1,time=500
    }
    self.sprite = display.newSprite(self.group, self.sheet,self.sheet_data)
  end

  pulsantone.setupGlow = function(self)
    self.glow = display.newImage(self.group,"media/game/globo_asker/glow.png")
    self.glow.x = 400
    self.glow.y = 415
    self.glow.alpha = 0
  end

  pulsantone.fadeInOutGlow = function ( self )
    local time = 300
    transition.to(self.glow, { time=time, alpha=.8 })
    transition.to(self.glow, { time=time, alpha=0, delay=time })
  end

  pulsantone.setupPositionAndSizeSprite = function(self)
    local size_pulsantone = 180
    self.sprite.xScale = .5
    self.sprite.yScale = .5
    self.sprite.x = display.contentWidth/2 - self.sprite.width/4
    self.sprite.y = display.contentHeight/2+40
  end
  pulsantone.tapped = function ( event )
    print("bella di badella")
    pulsantone.group.play()
    
  end
  pulsantone.group.play = function(self)
    pulsantone.sprite:play()
    pulsantone:fadeInOutGlow()
  end
  pulsantone.setupListener = function(self)
    self.sprite:addEventListener("tap", self.tapped)
  end

  pulsantone:setupGlow()
  pulsantone:setupAnimation()
  
  pulsantone:setupPositionAndSizeSprite()
  pulsantone:setupListener()

  return pulsantone.group
end
return Pulsantone