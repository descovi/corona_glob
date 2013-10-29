function create_button_to_go(globulo, vocale, y_pos)
  y_pos = y_pos or 600
  local cerchio_container = display.newGroup()
  local cerchio = display.newCircle(globulo.x, y_pos, 60)
  
  local testo = display.newText(vocale, cerchio.x-30, cerchio.y-60, "Hiragino Maru Gothic Pro", 80)
  testo:setTextColor(0, 0, 0)
  testo:setReferencePoint( display.CenterReferencePoint )
  --local testo = display.newImage('media/vocali/'..vocale..'.png')
  testo.x = cerchio.x
  testo.y = cerchio.y + 16
  
  cerchio:setFillColor(255, 255, 255, 255)
  cerchio_container:insert(cerchio)
  cerchio_container:insert(testo)
  cerchio_container.vocale = vocale
  cerchio_container:addEventListener("tap", go_to)
  globulo.parent:insert(cerchio_container)
  globulo.cerchio_container = cerchio_container
end