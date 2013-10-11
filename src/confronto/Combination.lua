local Combination ={}
Combination.get = function(vocale)
  if vocale == "a" then
    combination = {"e","i"} 
  end
  if vocale == "e" then
    combination = {"a","e"} 
  end
  if vocale == "i" then
    combination = {"e"} 
  end
  if vocale == "o" then
    combination = {"e","a"} 
  end
  if vocale == "u" then
    combination = {"u"} 
  end
  return combination
end
return Combination