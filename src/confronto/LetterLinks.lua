Combination = require('src.confronto.Combination')
local LetterLinks = {}
LetterLinks.new = function(vocale, number)
  local group = display.newGroup()
  
  group.setup_circle = function(letter_link)
    local widget = require( "widget" )
    local circle = widget.newButton
    {
      defaultFile = "media/menu_iniziale/background-button-white/default-big.png",
      overFile = "media/menu_iniziale/background-button-white/over-big.png"
    }
    circle:setFillColor(255,255,255)
    circle:scale(.5,.5)
    circle.x = letter_link.x
    circle.y = letter_link.y + 3
    group.circle = circle
    group:insert(circle)
  end

  group.setup = function(_vocale)
    local combination = Combination.get(_vocale)
    local letter_link = display.newText(
      _vocale,
      display.contentWidth/2,
      display.contentHeight/2-50,
      _G.font_bold,
      35
    )
    if number == 1 then
      letter_link.text = vocale .. "+" .. combination[number]
      letter_link.x = letter_link.x - 370
      group.text_raw = combination[number]
    end
    if number == 2 then
      letter_link.text = vocale .. "+" .. combination[number] 
      letter_link.x = letter_link.x + 350
      group.text_raw = combination[number]
    end
    
    letter_link:setTextColor(0,0,0)

    group.setup_circle(letter_link)
    group.letter_link = letter_link
    group:insert(letter_link)
  end

  group.fadeOut = function(self,delay)
    local time = 200
    transition.to(self, {time=time, alpha=.5,delay=delay})
  end

  group.fadeIn = function(self,delay)
    local time = 200
    transition.to(self, {time=time, alpha=1,delay=delay})
  end

  group.fadeToogle = function(self, _delay)
    if self.alpha == 1 then
      self:fadeOut(_delay)
      self:zoom(0)
    else
      self:fadeIn(_delay)
      self:zoom(_delay)
    end
  end

  group.zoom = function( self, _delay )
  
    local timing = 200
    local delay = 1000
    
    local original_scale = 0.5
    local scale = 0.7

    local original_scale_text = 1
    local scale_text = 1.5
    
    -- CIRCLE
    transition.to(self.circle,{
      time=timing, 
      xScale=scale, 
      yScale=scale,
      delay=_delay+470
    })
    transition.to(self.circle,{ 
      time=timing,
      xScale=original_scale, 
      yScale=original_scale,
      delay=_delay+timing+470
    })

    -- TEXT
    transition.to(self.letter_link,{ 
      time=timing, 
      xScale=scale_text, 
      yScale=scale_text,
      delay=_delay+470
    })
    transition.to(self.letter_link, { 
      time=timing, 
      xScale=original_scale_text,
      yScale=original_scale_text,
      delay=_delay+timing+470
    })
    
  end

  group.setup(vocale)
  
  return group
end

return LetterLinks