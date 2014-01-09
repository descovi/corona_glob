require('src.utils.button_to_go_back')


local ButtonToGo = require 'src.menu_iniziale.button_to_go'
require 'src.menu_iniziale.manipulate_order'

local widget = require( "widget" )

local storyboard = require ( "storyboard" )
local Globulo = require("src.menu_iniziale.Globulo")
local menu_iniziale = storyboard.newScene()
local vocali = {"a","e","i","o","u"}

--local y_pos = {350,150}
local x_pos = {
  0, 95, 190, 285, 375, 
  0, 95, 190, 285, 375
}
local globulo_x_pos = {}
local all_globuli = {}
local all_globuli_order_inverted = {}
local animazione_partita = false

function create_globulo(shor_or_long, vocale, _group_1, _group_2)
  --
  local filename = shor_or_long.."-"..vocale
  local short_or_long_convertita = string.sub(shor_or_long,1,1)
  local sound_filename = vocale:upper().."_"..short_or_long_convertita:upper()
  globulo = Globulo.new(filename,sound_filename)
  -- posizionamento
  local pos_x = (x_pos[#all_globuli+1]*2) - 50
  globulo.x = (pos_x + globulo.width/2)+25
  table.insert(globulo_x_pos,globulo.x)
  if #all_globuli+1 > 5 then
    _group_1:insert(globulo)
  else
    _group_2:insert(globulo)
  end
  table.insert(all_globuli,globulo)

  return globulo
end

-- imposta un evento che deriva da utils.button_to_go
function go_to(event)
  _G.vocale = event.target.vocale
  storyboard.removeScene("src.confronto")
  storyboard.gotoScene("src.confronto",{
    effect = "slideUp",
    time = 1100}
  )
end

-- timeline audio
local audio_anim_number = 0
local function onSoundComplete(event)
  audio_anim_number = audio_anim_number+1
  if audio_anim_number < 11 then
    audio.play(all_globuli_order_inverted[audio_anim_number].audio_url, {onComplete=onSoundComplete})
    all_globuli_order_inverted[audio_anim_number]:play_anim()
  else
    audio_anim_number = 0
  end
end

-- quando si clicca
local function ascolta_tutti(event)
  if audio_anim_number == 0 then
    audio_anim_number = 1
    audio.play(all_globuli_order_inverted[audio_anim_number].audio_url, {onComplete=onSoundComplete})
    all_globuli_order_inverted[audio_anim_number]:play_anim()
  end
end

function setup_ascolta_tutti(_group)
  local button = widget.newButton
  {
      defaultFile = "media/menu_iniziale/sound-button/default.png",
      overFile = "media/menu_iniziale/sound-button/over.png"
  }
  button:addEventListener("tap",ascolta_tutti)
  _group:insert(button)
  local size = 100
  button.x = display.contentWidth/2 - button.width/2 - 25
  button.y = display.contentHeight-button.height / 2 - 100
  manipulate_order_invert_group(all_globuli, all_globuli_order_inverted)
end

function setup_btn_game(_group)
  local button = widget.newButton{
    defaultFile = "media/menu_iniziale/game-button/default.png",
    overFile = "media/menu_iniziale/game-button/over.png"
  }
  _group:insert(button)
  button.x = display.contentWidth/2 + button.width/2 + 25
  button.y = display.contentHeight-button.height / 2 - 100
  button:addEventListener("tap",function( )
    storyboard.gotoScene("src.game",{
      effect = "zoomOutInFade",
      params = { user_from_menu_iniziale = "true" }
    })
  end)
end

local function create_coil(_group,_group_2,index)
  local coil = display.newImage("media/menu_iniziale/coil.png")
  local scale_v = .6
  coil:scale(.4,scale_v)
  coil.y = _group_2.y+_group_2[index].height/4
  local coil_x = _group_2[index].x + globulo.width/2 - 15
  coil.x = coil_x
  _group:insert(1,coil)
end

--Create the scene
function menu_iniziale:createScene( event )
  local group
local group_1 = display.newGroup()
local group_2 = display.newGroup()
  group = self.view
  group:insert(group_1)
  group:insert(group_2)
  group_1.y = 70
  group_2.y = 250

  for i=1,#vocali do
    create_globulo('long',vocali[i], group_1,group_2)
  end
  for i=1,#vocali do
    create_globulo('short',vocali[i], group_1,group_2)
  end

  for i=1,#vocali do
    create_coil(group,group_2,i)
  end
  
  for i=1,5 do
    ButtonToGo.new(self.view, vocali, globulo_x_pos, i)
  end
  
  setup_ascolta_tutti(group)
  setup_btn_game(group)
  --local rgmeter = require "rgmeter.rgmeter"
  --rgmeter.create()

end

--Add the createScene listener
menu_iniziale:addEventListener( "createScene", menu_iniziale )

return menu_iniziale