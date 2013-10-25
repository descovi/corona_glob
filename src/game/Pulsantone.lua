local Pulsantone = {}
local coords = require('src.game.coords')
Pulsantone.new = function()
  local pulsantone = {}
  pulsantone.timing = 500
  pulsantone.sprite = {}
  pulsantone.setupAnimation = function(self)
    local path = "media/game/globo_asker/coords.png"
    self.sheet = graphics.newImageSheet(path, coords:getSheet())
    self.sheet_data = {
      name="standard", start=1,count=13,loopCount=1,time=500
    }
    self.sprite = display.newSprite( self.sheet,self.sheet_data)
    --self.sprite:setSequence( "standard" )
    self.sprite:play()
  end

  pulsantone.setupPositionAndSize = function(self)
    local size_pulsantone = 180
    self.sprite.xScale = .5
    self.sprite.yScale = .5
    self.sprite.x = display.contentWidth/2 - self.sprite.width/4
    self.sprite.y = display.contentHeight/2+40
  end
  pulsantone.tapped = function ( event )
    print("bella di badella")
    event.target:play()
  end
  pulsantone.setupListener = function(self)
    self.sprite:addEventListener("tap", self.tapped)
  end

  pulsantone:setupAnimation()
  pulsantone:setupPositionAndSize()
  pulsantone:setupListener()
  return pulsantone.sprite
end
return Pulsantone