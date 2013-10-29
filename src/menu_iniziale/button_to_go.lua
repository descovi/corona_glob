ButtonToGo = {}
ButtonToGo.new = function(view,vocale,x_pos,index)
  button_to_go = {}
  button_to_go.cerchio_container = display.newGroup()
  button_to_go.setup = function (self,view,vocale,x_pos,index)
    y_pos = y_pos or 600
    local cerchio = display.newCircle(x_pos[index]+75, 500, 60)
    local testo = display.newText(vocale[index], cerchio.x-30, cerchio.y-60, "Hiragino Maru Gothic Pro", 80)
    testo:setTextColor(0, 0, 0)
    testo:setReferencePoint( display.CenterReferencePoint )
    testo.x = cerchio.x
    testo.y = cerchio.y + 16
    cerchio:setFillColor(255, 255, 255, 255)
    view:insert(self.cerchio_container)
    self.cerchio_container:insert(cerchio)
    self.cerchio_container:insert(testo)
    self.cerchio_container.vocale = vocale[index]
    self.cerchio_container:addEventListener("tap", go_to)
  end
  button_to_go:setup(view,vocale,x_pos,index)
  return button_to_go.cerchio_container
end
return ButtonToGo