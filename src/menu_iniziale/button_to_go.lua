ButtonToGo = {}
ButtonToGo.new = function(view,vocale,x_pos,index)
  button_to_go = {}
  button_to_go.cerchio_container = display.newGroup()
  button_to_go.vocale = vocale[index]
  button_to_go.change_color_text = function (self)
    local h = {}
    if self.vocale == "a" then
      local g = graphics.newGradient({ 252, 39, 69 },{252, 39, 69 }, "top")
      h = graphics.newGradient({ 252, 39, 69 },{ 159,  250, 11 }, "left")
      --self.testo:setTextColor(g)
      self.racconto:setTextColor(h)
    elseif self.vocale == "e" then
      h = graphics.newGradient({16,  79,  253},{253, 78, 18}, "left")
      --self.testo:setTextColor(16,  79,  253)
      self.racconto:setTextColor(h)
      self.racconto.text = "bed bead\ncheck cheek"
    elseif self.vocale == "i" then
      h = graphics.newGradient({38,  213, 14},{255 , 45 , 132 }, "left")
      --self.testo:setTextColor(38,  213, 14)
      self.racconto:setTextColor(h)
      self.racconto.text = "bit bite"
    elseif self.vocale == "o" then
      h = graphics.newGradient({250, 49,  168},{40, 160, 253 }, "left")
      --self.testo:setTextColor(250, 49,  168)
      self.racconto:setTextColor(h)
      self.racconto.text = "block bloke\nboss boast"
    elseif self.vocale == "u" then
      h = graphics.newGradient({233, 224, 6},{114, 62,  255}, "left")
     -- self.testo:setTextColor(233, 224, 6)
      self.racconto:setTextColor(h)
      self.racconto.text = "cub cube"
    end
    self.racconto.align = "center"
  end
  
  button_to_go.setup_text = function (self )
    
    local options_testo = 
    {
      text = self.vocale,
      x = 0,
      y = 0,
      font = _G.font_bold,
      fontSize = 30

    }
    
    local options_racconto = 
    {
      text = "fad fade\nbat bait",     
      x = self.cerchio.x,
      y = self.cerchio.y+80,
      width = 300,
      height = 100,
      font = _G.font_bold,
      fontSize = 20,
      align = "center"
    }
    
    self.testo = display.newText(options_testo)
    self.testo:setReferencePoint( display.CenterReferencePoint )
    self.testo.x = self.cerchio.x + 2
    self.testo.y = self.cerchio.y

    self.racconto = display.newText(options_racconto)
    self.racconto:setReferencePoint( display.CenterReferencePoint )
    self.racconto.x = self.cerchio.x
    self.racconto.y = self.cerchio.y + 120

    self.testo:setTextColor(0, 0, 0)
    
  end
  button_to_go.setup = function (self,x_pos,index)
    --self.cerchio = display.newCircle(x_pos[index]+75, 450, 60)
    --self.cerchio:setFillColor(255, 255, 255, 255)
    --self.cerchio.strokeWidth = 0
    local widget = require( "widget" )


     self.cerchio = widget.newButton
    {
        defaultFile = "media/menu_iniziale/background-button-white/default.png",
        overFile = "media/menu_iniziale/background-button-white/over.png",
    }

    self.cerchio.x = x_pos[index]+75
    self.cerchio.y = 450

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