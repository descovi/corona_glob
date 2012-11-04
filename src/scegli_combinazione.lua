require('src.utils.button_to_go_back')

local storyboard = require( "storyboard" )
local scegli_combinazione = storyboard.newScene()

goto_confronto = function ( event )
  storyboard.gotoScene("src.confronto")
end

goto_sopra = function ( event )
  storyboard.gotoScene("src.colonna")
end

goto_sotto = function ( event )
  storyboard.gotoScene("src.colonna")
end

function scegli_combinazione:createScene( event )
  
  local group           = self.view
  local group_sopra     = display.newGroup()
  local group_sotto     = display.newGroup()

  group:insert(group_sopra)
  group:insert(group_sotto)
  local white_circle_1  = display.newImage( group_sopra, "media/sfondi/white_circle.png")
  local white_circle_2  = display.newImage( group_sotto, "media/sfondi/white_circle.png")

  white_circle_1.x      = display.contentWidth / 2
  white_circle_2.x      = display.contentWidth / 2
  white_circle_1.y      = display.contentHeight / 2 - 150
  white_circle_2.y      = display.contentHeight / 2 + 150
  
  local _lettera_sx_0   = "a"
  local _plus           = "+"
  local _lettera_ml_1   = "i"
  local _lettera_ml_2   = "e"
  local _equal          = "="
  local _lettera_dx_1   = "a"
  local _lettera_dx_2   = "a"
  local _size           = 160
  local _font           = "Arial"

  local y1              = white_circle_1.y -white_circle_1.height/2
  local y2              = white_circle_2.y -white_circle_1.height/2

  local x1              = white_circle_1.x -300
  local x_plus          = white_circle_1.x -200
  local x2              = white_circle_1.x
  local x_equal         = white_circle_1.x +100
  local x3              = white_circle_1.x +200


  -- riga 1
  local lettera_sx_1    = display.newText(group_sopra, _lettera_sx_0, x1,      y1-10, _font, _size)
  local plus            = display.newText(group_sopra, _plus,         x_plus,  y1, _font, _size)
  local lettera_ml_1    = display.newText(group_sopra, _lettera_ml_1, x2-20,      y1, _font, _size)
  local equal           = display.newText(group_sopra, _equal,        x_equal, y1, _font, _size)
  local lettera_dx_1    = display.newText(group_sopra, _lettera_dx_1, x3,      y1-10, _font, _size)

  -- riga 2
  local lettera_sx_2    = display.newText(group_sotto, _lettera_sx_0, x1,      y2-10, _font, _size)
  local plus            = display.newText(group_sotto, _plus,         x_plus,  y2, _font, _size)
  local lettera_ml_2    = display.newText(group_sotto, _lettera_ml_2, x2-40,      y2, _font, _size)
  local equal           = display.newText(group_sotto, _equal,        x_equal, y2, _font, _size)
  local lettera_dx_2    = display.newText(group_sotto, _lettera_dx_2, x3,      y2-19, _font, _size)
  
  --- riga 1
  lettera_sx_1:setTextColor(200, 0, 0, 255)
  lettera_ml_1:setTextColor(0, 0, 0, 255)
  lettera_dx_1:setTextColor(0, 180, 0, 255)
  
  --- riga 2
  lettera_sx_2:setTextColor(200, 0, 0, 255)
  lettera_ml_2:setTextColor(0, 0, 0, 255)
  lettera_dx_2:setTextColor(0, 180, 0, 255)
  
  group_sopra:addEventListener("tap", goto_sopra)
  group_sotto:addEventListener("tap", goto_sotto)

  -- torna indietro
  local torna_indietro = button_to_go_back()
  torna_indietro:addEventListener("tap", goto_confronto)

end
  
scegli_combinazione:addEventListener( "createScene", scene )

return scegli_combinazione