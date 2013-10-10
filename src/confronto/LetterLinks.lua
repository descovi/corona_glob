local LetterLinks = {}
print "c"
LetterLinks.new = function(vocale, number)
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
    letter_link.text = combination[number]
    letter_link.x = letter_link.x - 170
  end

  if number == 2 then
    letter_link.text = combination[number]
    letter_link.x = letter_link.x + 150
  end
  
  return letter_link
end

return LetterLinks