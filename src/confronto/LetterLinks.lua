Combination = require('src.confronto.Combination')
local LetterLinks = {}
LetterLinks.new = function(vocale, number)
  local group = display.newGroup()
  group.setup = function()
    local circle = display.newCircle( 0 , 0, 60 )
    circle:setFillColor(255,255,255)
    local combination = Combination.get(vocale)
    local letter_link = display.newText(
      vocale,
      display.contentWidth/2,
      display.contentHeight-150,
      "Hiragino Maru Gothic Pro",
      60
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
    circle.x = letter_link.x
    circle.y = letter_link.y - 10
    letter_link:setTextColor(0,0,0)
    group:insert(circle)
    group:insert(letter_link)
  end

  group.fadeOut = function(self)
    local time = 200
    transition.to(self, {time=time, alpha=0})
  end

  group.setup()
  
  return group
end

return LetterLinks