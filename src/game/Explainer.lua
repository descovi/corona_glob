local Explainer = {}
Explainer.new = function()

  local explainer = {}
  explainer.group = display.newGroup()
  explainer.group.text_tf = {}

  explainer.group.choose_words = function(vocale)
    
    vocale = string.sub(vocale,-1)
    
    w = c
    if vocale == "a" then
      w = "fad - fade"
    elseif vocale == "e" then
      w = "bed - bead"
    elseif vocale == "i" then
      w = "bit - bite"
    elseif vocale == "o" then
      w = "hop - hope"
    elseif vocale == "u" then
      w = "cub - cube"
    end
    
    return w
  end

  explainer.group.fade_in_out = function(self, letter)
    self.text_tf.text = self.choose_words(letter)
    transition.to(self, { time=100, alpha=1})
    transition.to(self, { time=500, alpha=0, delay=2500 })
  end

  explainer.setup = function(self)
    self.group.text_tf = display.newText(self.group, "my text", 0,0,_G.font,40)
    self.group.text_tf:setTextColor(92,252,164)
    self.group.alpha = 0
  end

  explainer:setup()

  return explainer.group
end
return Explainer