local Anim        = require('src.colonna.Anim')
local Arrow       = require('src.colonna.Arrow')
local Vocabolario = require('src.colonna.Vocabolario')
local Storyboard  = require("storyboard")
-- display objects
local colonna     = Storyboard.newScene()
local background  = display.newImage("media/sfondi/".._G.vocale..".png")
local back_btn    = button_to_go_back()
local arrow_up    = Arrow.newSprite()
local arrow_dn    = Arrow.newSprite()
local vocabolario = Vocabolario.newSprite()
local anim        = Anim.newSprite()
local gioca       = display.newText("gioca",100,480,"Hiragino Maru Gothic Pro",40)


local function go_bk(event) 
  Storyboard.gotoScene( "src.scegli_combinazione" ) 
end

local function go_up(event)
  anim.prev()
  vocabolario.set(anim.counter)
  if (anim.counter <= 1) then
    arrow_up.hide()
  end
  gioca.isVisible = false
  arrow_dn.show()
end

local function go_dn(event) 
  anim.next()
  vocabolario.set(anim.counter)
  if (anim.counter >= anim.limit) then
    arrow_dn.hide()
    gioca.isVisible = true
  end
  arrow_up.show()
end

local function load_game()
  Storyboard.gotoScene("src.game")
end

function colonna:createScene( event )
  self.view:insert(background)
  self.view:insert(anim.group)
  self.view:insert(back_btn)
  self.view:insert(arrow_up)
  self.view:insert(arrow_dn)
  self.view:insert(vocabolario)
  back_btn:addEventListener("tap", go_bk)
  back_btn.alpha = 0.01
  back_btn.width = 200
  back_btn.height = 200
  back_btn.y = 100
  back_btn.x = back_btn.x - 45
  arrow_dn:addEventListener("tap", go_dn)
  arrow_up:addEventListener("tap", go_up)
  arrow_dn.show()
  arrow_up.hide()
  arrow_up.y = 20
  arrow_dn.y = display.contentHeight - arrow_dn.height - 20
  gioca.x = arrow_dn.x + 80
  gioca.y = arrow_dn.y + 100
  gioca.isVisible = false
  self.view:insert(gioca)
  gioca:addEventListener("tap", load_game)
end

colonna:addEventListener( "createScene" , colonna )
colonna.name ="colonna"
return colonna