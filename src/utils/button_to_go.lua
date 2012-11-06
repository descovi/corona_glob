function create_button_to_go(globulo, vocale)
  local cerchio_container = display.newGroup()
  local cerchio = display.newCircle(globulo.x, 700, 30)
  local testo = display.newText(vocale, cerchio.x-6, cerchio.y-14, "Courier New", 18)
  testo:setTextColor(0, 0, 0)
  cerchio_container:insert(cerchio)
  cerchio_container:insert(testo)
  cerchio_container.vocale = vocale
  globulo.parent:insert(cerchio_container)
  globulo.cerchio_container = cerchio_container
end