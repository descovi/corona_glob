local Life = {}
Life.new = function()
  local group = display.newGroup()
  group.life_count = 3
  group.audio_loser = audio.loadSound("media/audio/loser.wav")
  group.setup = function(self,element)
    local size = 8
    local margin = 20
    local path_circle = "media/game/circle.png"
    self.one   = display.newImage(group,path_circle, 0, 0)
    self.two   = display.newImage(group,path_circle, 0, 0)
    self.three = display.newImage(group,path_circle, 0, 0)
    self.one:scale(.5,.5)
    self.two:scale(.5,.5)
    self.three:scale(.5,.5)
    self.two.x = self.one.x+size+margin
    self.three.x = self.two.x+size+margin
    self.alpha = 0
  end

  group.set_life = function(self,_number)
    self.life_count = _number
    local show_value = 0.8
    local hide_value = 0.2
    if _number== 0 then
      self.one.alpha = hide_value
      self.two.alpha = hide_value
      self.three.alpha = hide_value
      audio.play(self.audio_loser)
    elseif _number== 1 then
      self.one.alpha = show_value
      self.two.alpha = hide_value
      self.three.alpha = hide_value
    elseif _number == 2 then
      self.one.alpha = show_value
      self.two.alpha = show_value
      self.three.alpha = hide_value
    elseif _number == 3 then
      self.one.alpha = show_value
      self.two.alpha = show_value
      self.three.alpha = show_value
      self.alpha = 1
    end
  end

  group:setup()
  return group
end
return Life