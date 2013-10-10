local LetterLinks = {}
print "c"
LetterLinks.new = function(vocale, number)

  local group = display.newGroup()

  local circle = display.newCircle( 0 , 0, 60 )
  circle:setFillColor(255,255,255)

  local combination = {}
  if vocale == "a" then
    combination = {"a","e"} 
  end
  if vocale == "e" then
    combination = {"a","e"} 
  end
  if vocale == "i" then
    combination = {"i"} 
  end
  if vocale == "o" then
    combination = {"e","a"} 
  end
  if vocale == "u" then
    combination = {"u"} 
  end

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
  end

  if number == 2 then
    letter_link.text = "+" .. combination[number] 
    letter_link.x = letter_link.x + 150
  end

  circle.x = letter_link.x
  circle.y = letter_link.y - 10

  letter_link:setTextColor(0,0,0)

  group:insert(circle)
  group:insert(letter_link)

  
  return group
end

return LetterLinks