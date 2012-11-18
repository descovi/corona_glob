function create_button_to_go(globulo, vocale)
  local cerchio_container = display.newGroup()
  local cerchio = display.newCircle(globulo.x, 600, 30)
  local testo = display.newText(vocale, cerchio.x-30, cerchio.y-14, "Courier New", 100)
  testo:setTextColor(255, 255, 255)
  testo:setReferencePoint( display.CenterLeftReferencePoint )
  cerchio:setFillColor(0, 0, 0, 0)
  cerchio_container:insert(cerchio)
  cerchio_container:insert(testo)
  cerchio_container.vocale = vocale
  cerchio_container:addEventListener("tap", go_to)
  globulo.parent:insert(cerchio_container)
  globulo.cerchio_container = cerchio_container
end