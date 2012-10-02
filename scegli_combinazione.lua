require('utils.button_to_go_back')

local storyboard = require( "storyboard" )
local scegli_combinazione = storyboard.newScene()

function goto_confronto( event )
   storyboard.gotoScene("confronto")
end

function scegli_combinazione:createScene( event )
  
  local group = self.view
  local white_circle_1 = display.newImage( group, "media/sfondi/white_circle.png")
  local white_circle_2 = display.newImage( group, "media/sfondi/white_circle.png")
  
  white_circle_1.x = 380
  white_circle_2.x = 380
  white_circle_1.y = 400
  white_circle_2.y = 650
  
  local _lettera_sx = "a"
  local _lettera_middle_1 = "i"
  local _lettera_middle_2 = "e"
  local _lettera_dx_1 = "a"
  local _lettera_dx_2 = "a"
  local _size = 200
  local _font = "Arial"


  local y1 = 300
  local y2 = 500

  local x1 = 100
  local x2 = 300
  local x3 = 500
  
  -- riga 1
  local lettera_sx_1 = display.newText(group, _lettera_sx, x1, y1, _font, _size)
  local lettera_middle_1 = display.newText(group, _lettera_middle_1, x2, y1, _font, _size)
  local lettera_dx_1 = display.newText(group, _lettera_dx_1, x3, y1, _font, _size)

  -- riga 2
  local lettera_sx_2 = display.newText(group, _lettera_sx, x1, y2, _font, _size)
  local lettera_middle_2 = display.newText(group, _lettera_middle_2, x2, y2, _font, _size)
  local lettera_dx_2 = display.newText(group, _lettera_dx_2, x3, y2, _font, _size)
  
  lettera_sx_1:setTextColor(180, 0, 0, 255)
  lettera_sx_2:setTextColor(180, 0, 0, 255)
  lettera_middle_1:setTextColor(0, 0, 0, 255)
  lettera_middle_2:setTextColor(0, 0, 0, 255)
  lettera_dx_1:setTextColor(0, 180, 0, 255)
  lettera_dx_2:setTextColor(0, 180, 0, 255)
  
  -- torna indietro
  local torna_indietro = button_to_go_back()
  torna_indietro:addEventListener("tap", goto_confronto)

end
  
scegli_combinazione:addEventListener( "createScene", scene )

return scegli_combinazione