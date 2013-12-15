local ButtonToGo = require 'src.menu_iniziale.button_to_go'
require 'src.menu_iniziale.manipulate_order'

local storyboard = require ( "storyboard" )
local Globulo = require("src.menu_iniziale.Globulo")
local menu_iniziale = storyboard.newScene()
local vocali = {"a","e","i","o","u"}
local group
local group_1 = display.newGroup()
local group_2 = display.newGroup()
--local y_pos = {350,150}
local x_pos = {
  0, 90, 190, 290, 390, 
  0, 90, 190, 290, 390
}
local globulo_x_pos = {}
local all_globuli = {}
local all_globuli_order_inverted = {}
local ascolta_tutti_label = {}
local animazione_partita = false

function create_globulo(shor_or_long, vocale)
  --
  local filename = shor_or_long.."-"..vocale
  local short_or_long_convertita = string.sub(shor_or_long,1,1)
  local sound_filename = vocale:upper().."_"..short_or_long_convertita:upper()
  globulo = Globulo.new(filename,sound_filename)
  -- posizionamento
  local pos_x = (x_pos[#all_globuli+1]*2) - 50
  globulo.x = (pos_x + globulo.width/2)+10
  table.insert(globulo_x_pos,globulo.x)
  if #all_globuli+1 > 5 then
    group_1:insert(globulo)
  else
    group_2:insert(globulo)
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

function setup_ascolta_tutti()
  local widget = require( "widget" )
  ascolta_tutti_label = widget.newButton
  {
      defaultFile = "media/menu_iniziale/play-button/default.png",
      overFile = "media/menu_iniziale/play-button/over.png",
  }
  ascolta_tutti_label:addEventListener("tap",ascolta_tutti)
  group:insert(ascolta_tutti_label)
  local size = 100
  --ascolta_tutti_label.width = size
  --ascolta_tutti_label.height = size
  ascolta_tutti_label.x = 500
  ascolta_tutti_label.y = 700
  manipulate_order_invert_group(all_globuli, all_globuli_order_inverted)
end

--Create the scene
function menu_iniziale:createScene( event )
  group = self.view
  group:insert(group_1)
  group:insert(group_2)
  group_1.y = 50
  group_2.y = 230
  for i=1,#vocali do
    create_globulo('long',vocali[i])
  end
  for i=1,#vocali do
    create_globulo('short',vocali[i])
  end
  for i=1,5 do
    ButtonToGo.new(self.view, vocali, globulo_x_pos, i)
  end
  setup_ascolta_tutti()
  
end

--Add the createScene listener
menu_iniziale:addEventListener( "createScene", menu_iniziale )

return menu_iniziale