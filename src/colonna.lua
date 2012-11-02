local Anim        = require('src.colonna.Anim')
local Arrow       = require('src.colonna.Arrow')
local Storyboard  = require( "storyboard" )
-- display objects
local colonna     = Storyboard.newScene()
local background  = display.newImage("media/sfondi/".._G.vocale..".png")
local go_back_btn = button_to_go_back()
local arrow_up    = Arrow.newSprite()
local arrow_down  = Arrow.newSprite()
local anim        = Anim.newSprite()

local function go_back(event) Storyboard.gotoScene( "src.scegli_combinazione" ) end
local function go_up(event) print "go up" end
local function go_down(event) print "go down" end

function colonna:createScene( event )
  self.view:insert(background)
  anim.test()
  go_back_btn:addEventListener("tap", go_back)
  arrow_up:addEventListener("tap", go_up)
  arrow_down:addEventListener("tap", go_down)
  arrow_down.y = display.contentHeight - arrow_down.height
end
colonna:addEventListener( "createScene" , scene )

return colonna