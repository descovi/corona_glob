

local storyboard = require( "storyboard" )
local scegli_combinazione = storyboard.newScene()
local _lettera_sx_0   = "a"
local _plus           = "+"
local _lettera_ml_1   = "e"
local _lettera_ml_2   = "i"
local _equal          = "="
local _lettera_dx_1   = "a"
local _lettera_dx_2   = "a"
local _size           = 160
local _font           = "Arial"


function scegli_combinazione:createScene( event )
  print("scegli_combinazione:createScene")
  print("VOCALE ATTUALE:")
  print(_G.vocale)
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


  if _G.vocale == "e" then
    _lettera_sx_0 = "e"
    _lettera_ml_1 = "a"
    _lettera_ml_2 = "e"
    _lettera_dx_1 = "e"
    _lettera_dx_2 = "e"
  end

  if _G.vocale == "i" then
    _lettera_sx_0 = "i"
    _lettera_ml_1 = "e"
    _lettera_dx_1 = "i"
    print ("VA MOSTRATA UNA SOLA RIGA!!!")
  end

  if _G.vocale == "o" then
    _lettera_sx_0 = "o"
    _lettera_ml_1 = "e"
    _lettera_ml_2 = "a"
    _lettera_dx_1 = "o"
    _lettera_dx_2 = "o"
  end

  if _G.vocale == "u" then
    _lettera_sx_0 = "u"
    _lettera_dx_1 = "u"
  end

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
  lettera_sx_1:setFillColor(0, 0, 0, 1)
  lettera_ml_1:setFillColor(0, 0, 0, 1)
  lettera_dx_1:setFillColor(0, .7, 0, 1)
  if _lettera_ml_1 == "a" then
    lettera_ml_1.x = lettera_ml_1.x - 25
  elseif _lettera_ml_1 == "e" then
    lettera_ml_1.x = lettera_ml_1.x - 25
  elseif _lettera_ml_1 == "i" then
    lettera_ml_1.x = lettera_ml_2.x + 20
  elseif _lettera_ml_1 == "o" then
    lettera_ml_1.x = lettera_ml_2.x + 20
  end

  --- riga 2
  if _G.vocale == 'a' or _G.vocale == 'e' or _G.vocale == 'o' then
    local lettera_sx_2    = display.newText(group_sotto, _lettera_sx_0, x1,      y2-10, _font, _size)
    local plus            = display.newText(group_sotto, _plus,         x_plus,  y2, _font, _size)
    local lettera_ml_2    = display.newText(group_sotto, _lettera_ml_2, x2-40,      y2, _font, _size)
    local equal           = display.newText(group_sotto, _equal,        x_equal, y2, _font, _size)
    local lettera_dx_2    = display.newText(group_sotto, _lettera_dx_2, x3,      y2-19, _font, _size)
    lettera_sx_2:setFillColor(.7, 0, 0, 1)
    lettera_ml_2:setFillColor(0, 0, 0, 1)
    lettera_dx_2:setFillColor(0, .5, 0, 1)
    if _lettera_ml_2 == "a" then
      lettera_ml_2.x = lettera_ml_2.x
    elseif _lettera_ml_2 == "e" then
      lettera_ml_2.x = lettera_ml_2.x - 5
    elseif _lettera_ml_2 == "i" then
      lettera_ml_2.x = lettera_ml_2.x + 20
    elseif _lettera_ml_2 == "o" then
      lettera_ml_2.x = lettera_ml_2.x + 20
    end
  else
    white_circle_2.alpha = 0
    group_sopra.y = display.contentHeight / 2 - group_sopra.height
  end

  group_sopra:addEventListener("tap", goto_sopra)
  group_sotto:addEventListener("tap", goto_sotto)

  -- torna indietro
  local torna_indietro = button_to_go_back()
  torna_indietro:addEventListener("tap", goto_confronto)
  group:insert(torna_indietro)
end

scegli_combinazione:addEventListener( "createScene", scene )
goto_confronto = function ( event )
  storyboard.gotoScene("src.confronto")
end

goto_sopra = function ( event )
  _G.combinazione = _lettera_sx_0.."_".._lettera_ml_1
  storyboard.removeScene("src.colonna")
  storyboard.gotoScene("src.colonna")
end

goto_sotto = function ( event )
  _G.combinazione = _lettera_sx_0.."_".._lettera_ml_2
  storyboard.removeScene("src.colonna")
  storyboard.gotoScene("src.colonna")
end
return scegli_combinazione