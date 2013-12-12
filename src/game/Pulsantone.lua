local Explainer = require('src.game.Explainer')

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
    self.glow.x = self.sprite.x
    self.glow.y = self.sprite.y
    self.glow.alpha = 0
  end

  pulsantone.setupHintMessage = function ( self )
    local size = 40
    self.hint_message = display.newText(self.group, "Vocal?", self.glow.x+150, self.glow.y-size, _G.font, size)
    self.hint_message.alpha = 0
  end

  pulsantone.hintMessageInOutGlow = function (self)
    local time = 300
    transition.to(self.hint_message, { time=time, alpha=0 })
    transition.to(self.hint_message, { time=time, alpha=1, delay=time })
  end
  pulsantone.fadeInOutGlow = function ( self )
    local time = 300
    transition.to(self.glow, { time=time, alpha=1 })
    transition.to(self.glow, { time=time, alpha=0, delay=time })
  end

  pulsantone.setupPositionAndSizeSprite = function(self)
    local size_pulsantone = 180
    self.sprite.xScale = .5
    self.sprite.yScale = .5
    self.sprite.x = 200 --display.contentWidth/2 - self.sprite.width/4
    --self.sprite.x = 200
    self.sprite.y = display.contentHeight/2-160
  end
  
  pulsantone.tapped = function ( event )
    pulsantone.group.play()    
  end

  pulsantone.group.play = function(self)
    pulsantone.sprite:play()
    pulsantone:fadeInOutGlow()
    pulsantone:hintMessageInOutGlow()
  end

  pulsantone.setupExplainer = function(self)

    self.group.explainer = Explainer.new( )
    
    self.group:insert(self.group.explainer)
    self.group.explainer[1].x = self.hint_message.x + self.hint_message.width + 60
    self.group.explainer[1].y = self.hint_message.y 

  end

  pulsantone.setupListener = function(self)
    self.sprite:addEventListener("tap", self.tapped)
  end

  pulsantone:setupAnimation()
  pulsantone:setupPositionAndSizeSprite()
  pulsantone:setupGlow()
  pulsantone:setupHintMessage()
  pulsantone:setupListener()
  pulsantone:setupExplainer()


  pulsantone.group:insert(pulsantone.sprite)

  return pulsantone.group
end
return Pulsantone