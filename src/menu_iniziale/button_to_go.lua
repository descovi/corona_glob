ButtonToGo = {}
ButtonToGo.new = function(view,vocale,x_pos,index)
  button_to_go = {}
  button_to_go.cerchio_container = display.newGroup()
  button_to_go.vocale = vocale[index]
  button_to_go.change_color_text = function (self)
    if self.vocale == "a" then
      local g = graphics.newGradient(
  { 252, 39, 69 },
  {252, 39, 69 },
  "top" )
      local h = graphics.newGradient(
  { 252, 39, 69 },
  { 159,  250, 11 },
  "left" )
      self.testo:setTextColor(g)
      self.racconto:setTextColor( 159,  250, 11 )
    elseif self.vocale == "e" then
      self.testo:setTextColor(16,  79,  253)
      self.racconto:setTextColor(253, 78, 18)
      self.racconto.text = "bed bead"
    elseif self.vocale == "i" then
      self.testo:setTextColor(38,  213, 14)
      self.racconto:setTextColor( 255 , 45 , 132  )
      self.racconto.text = "bit bite"
    elseif self.vocale == "o" then
      self.testo:setTextColor(250, 49,  168)
      self.racconto:setTextColor( 40, 160, 253 )
      self.racconto.text = "hop hope"
    elseif self.vocale == "u" then
      self.testo:setTextColor(233, 224, 6)
      self.racconto:setTextColor(114, 62,  255)
      self.racconto.text = "cub cube"
    end
  end
  button_to_go.setup_text = function (self )
    self.testo = display.newText(
      self.vocale, 
      self.cerchio.x-30, 
      self.cerchio.y-60, 
      "Hiragino Maru Gothic Pro", 
      80
    )
    self.racconto = display.newText("fad fade",
      self.cerchio.x-60,
      self.cerchio.y+80,
      "Hiragino Maru Gothic Pro",
      30
    )
    self.racconto:setReferencePoint(display.CenterLeftReferencePoint)

    self.testo:setTextColor(0, 0, 0)
    self.testo:setReferencePoint( display.CenterReferencePoint )
    self.testo.x = self.cerchio.x
    self.testo.y = self.cerchio.y + 16
  end
  button_to_go.setup = function (self,x_pos,index)
    self.cerchio = display.newCircle(x_pos[index]+75, 500, 60)
    self.cerchio:setFillColor(255, 255, 255, 255)
    self.cerchio.strokeWidth = 0
  end
  button_to_go.setup_display_list = function(self,view)
    view:insert(self.cerchio_container)
    view:insert(self.racconto)
    self.cerchio_container:insert(self.cerchio)
    self.cerchio_container:insert(self.testo)
    self.cerchio_container.vocale = vocale[index]
    self.cerchio_container:addEventListener("tap", go_to)
  end
  button_to_go:setup(x_pos,index)
  button_to_go:setup_text(vocale)
  button_to_go:change_color_text()
  button_to_go:setup_display_list(view)
  return button_to_go.cerchio_container
end
return ButtonToGo