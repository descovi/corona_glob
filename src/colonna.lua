local Anim        = require('src.colonna.Anim')
local Arrow       = require('src.colonna.Arrow')

local Vocabolario = require('src.colonna.Vocabolario')
local Storyboard  = require("storyboard")
-- display objects
local colonna     = Storyboard.newScene()
local background_path = "media/sfondi/".._G.vocale..".png"
local background  = display.newImage(background_path)
local back_btn    = button_to_go_back()
local arrow_up    = Arrow.newSprite()
local arrow_dn    = Arrow.newSprite()
local vocabolario = Vocabolario.newSprite()
local anim        = Anim.newSprite()
local gioca       = display.newText("game",100,480,_G.font,40)


local function go_bk(event) 
  -- Storyboard.removeAllScene()
  Storyboard.gotoScene( "src.confronto",{
    effect = "slideDown",
    time = 800} )
end

local function go_up(event)
  anim.prev()
  --vocabolario.set(anim.counter) # x quando il vocabolario non era ad immagini
  vocabolario.update_current_path(anim.animation_path_counter)
  if (anim.counter <= 1) then
    arrow_up.hide()
  end
  gioca.isVisible = false
  arrow_dn.show()
end

local function go_dn(event) 
  anim.next()
  --vocabolario.set(anim.counter) # x quando il vocabolario non era ad immagini
  vocabolario.update_current_path(anim.animation_path_counter)
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
  self.view:insert(arrow_up)
  self.view:insert(arrow_dn)
  self.view:insert(vocabolario)
  self.view:insert(gioca)
  self.view:insert(back_btn)
  back_btn:addEventListener("tap", go_bk)

  back_btn.alpha = 1
  arrow_dn:addEventListener("tap", go_dn)
  arrow_up:addEventListener("tap", go_up)
  arrow_dn.show()
  arrow_up.hide()
  arrow_up.y = 20
  arrow_dn.y = display.contentHeight - arrow_dn.height - 20
  gioca.x = arrow_dn.x + 80
  gioca.y = arrow_dn.y + 100
  gioca.isVisible = false
  gioca:addEventListener("tap", load_game)
  print("-------")
  print("_G.vocale")
  print(_G.vocale)
  print("_G.tipo")
  print(_G.tipo)
  print("_G.combinazione")
  print(_G.combinazione)
  print("-------")
  print("background_path")
  print(background_path)
  print("-------")
  print("")
  vocabolario.update_current_path(anim.animation_path_counter)

  anim.group.alpha = 0
  transition.to(anim.group, { time=800, alpha=1, delay=800 })
end

colonna:addEventListener( "createScene" , colonna )
colonna:addEventListener( "exitScene" , function (event)
  print("Exit Scene <----")
end )
colonna.name ="colonna"
return colonna