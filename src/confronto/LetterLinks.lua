Combination = require('src.confronto.Combination')
local LetterLinks = {}
LetterLinks.new = function(vocale, number)
  local group = display.newGroup()
  
  group.setup_circle = function(letter_link)
    local widget = require( "widget" )
    local circle = widget.newButton
    {
        defaultFile = "media/menu_iniziale/background-button-white/default.png",
        overFile = "media/menu_iniziale/background-button-white/over.png",
    }
    circle:setFillColor(255,255,255)
    circle.x = letter_link.x
    circle.y = letter_link.y - 10
    group:insert(circle)
  end

  group.setup = function()
    local combination = Combination.get(vocale)
    local letter_link = display.newText(
      vocale,
      display.contentWidth/2,
      display.contentHeight-130,
      _G.font_bold,
      35
    )
    if number == 1 then
      letter_link.text = combination[number] .. "+"
      letter_link.x = letter_link.x - 170
      group.text_raw = combination[number]
    end
    if number == 2 then
      letter_link.text = "+" .. combination[number] 
      letter_link.x = letter_link.x + 150
      group.text_raw = combination[number]
    end
    
    letter_link:setTextColor(0,0,0)

    group.setup_circle(letter_link)
    
    group:insert(letter_link)
  end

  group.fadeOut = function(self)
    local time = 200
    transition.to(self, {time=time, alpha=.2})
  end

  group.fadeIn = function(self)
    local time = 200
    transition.to(self, {time=time, alpha=1})
  end

  group.fadeToogle = function(self)
    if self.alpha == 1 then
      self:fadeOut()
    else
      self:fadeIn()
    end
  end

  group.setup()
  
  return group
end

return LetterLinks