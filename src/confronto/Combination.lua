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
    combination = {"e"} 
  end
  return combination
end
Combination.is_more_than_one = function(vocale)
  combination = Combination.get(vocale)
  if (#combination > 1) then
    return true
  end
  return false
end
return Combination