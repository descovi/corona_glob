require 'src.utils.button_to_go'
require 'src.menu_iniziale.manipulate_order'


local storyboard = require ( "storyboard" )
local menu_iniziale = storyboard.newScene()

local vocali = {"a","e","i","o","u"}
local group
local group_1 = display.newGroup()
local group_2 = display.newGroup()
local counter = 1
local y_pos = {350,150}
local x_pos = {0, 100, 200, 300, 400, 0, 100, 200, 300, 400}
local all_globuli = {}
local all_globuli_order_inverted = {}

local ascolta_tutti_label = {}

local animazione_partita = false



function create_globulo( file_name , vocale)
  local globulo_size = 150
  -- dati
  local path = 'media/menu_iniziale/'
  local final_path = path .. file_name .. "-150/1.png"
  local globulo = display.newImage(final_path)
  -- posizionamento
  globulo.width  = globulo_size
  globulo.height = globulo_size
  local pos_x = (x_pos[counter]*2) - 50
  globulo.x = pos_x + globulo_size
  if counter > 5 then
    group_1:insert(globulo)
  else
    group_2:insert(globulo)
  end
  table.insert(all_globuli,globulo)
  
  globulo:addEventListener('tap',play_sound)
  globulo:addEventListener('tap',play_anim)
  counter = counter+1
  return globulo
end

function play_sound(event)
  if animazione_partita == false then
    local url = event.target.audio_url
    audio.play( url ) 
  end
end

function anim_completed(event)
  animazione_partita = false
end

function go_anim(target)
  print("go_anim")
  y_start = target.y
  difference = 20
  _time = 350
  transition.to(target, { time=_time, y=y_start+difference, transition })
  transition.to(target, { time=_time, y=y_start-difference, delay=_time, transition})
  transition.to(target, { time=_time, y=y_start, delay=_time*2, onComplete=anim_completed })
end

function play_anim(event)
  if animazione_partita == false then
    animazione_partita = true
    go_anim(event.target)
  end
end


-- imposta un evento che deriva da utils.button_to_go
function go_to(event)
  _G.vocale = event.target.vocale
  storyboard.removeScene("src.confronto")
  storyboard.gotoScene("src.confronto")
end

-- timeline audio
local audio_anim_number = 0
local function onSoundComplete(event)
  audio_anim_number = audio_anim_number+1
  if audio_anim_number < 11 then
    audio.play(all_globuli_order_inverted[audio_anim_number].audio_url, {onComplete=onSoundComplete})
    go_anim(all_globuli_order_inverted[audio_anim_number])
  else
    audio_anim_number = 0
  end
end

-- quando si clicca
local function ascolta_tutti(event)
  if audio_anim_number == 0 then
    audio_anim_number = 1
    audio.play(all_globuli_order_inverted[audio_anim_number].audio_url, {onComplete=onSoundComplete})
    go_anim(all_globuli_order_inverted[audio_anim_number]) 
  end
end

--Create the scene
function menu_iniziale:createScene( event )

  group = self.view
  group:insert(group_1)
  group:insert(group_2)
  group_1.y = 50
  group_2.y = 250

  -- Loading sound
  local path_audio = 'media/audio/vocali/'
  local a_l = audio.loadSound( path_audio .. 'A_L.mp3' )
  local a_s = audio.loadSound( path_audio .. 'A_S.mp3' )
  local e_l = audio.loadSound( path_audio .. 'E_L.mp3' )
  local e_s = audio.loadSound( path_audio .. 'E_S.mp3' )
  local i_l = audio.loadSound( path_audio .. 'I_L.mp3' )
  local i_s = audio.loadSound( path_audio .. 'I_S.mp3' )
  local o_l = audio.loadSound( path_audio .. 'O_L.mp3' )
  local o_s = audio.loadSound( path_audio .. 'O_S.mp3' )
  local u_l = audio.loadSound( path_audio .. 'U_L.mp3' )
  local u_s = audio.loadSound( path_audio .. 'U_S.mp3' )


  -- LONG
  y_pos_letter = 360
  -- a
  a_long = create_globulo('long-a',vocali[1])
  a_long.audio_url = a_l
  create_button_to_go(a_long, vocali[1], y_pos_letter)
  -- e
  e_long = create_globulo('long-e',vocali[2])
  e_long.audio_url = e_l
  create_button_to_go(e_long, vocali[2], y_pos_letter)
  -- i
  i_long = create_globulo('long-i',vocali[3]) 
  i_long.audio_url = i_l
  create_button_to_go(i_long, vocali[3], y_pos_letter)
  -- o
  o_long = create_globulo('long-o',vocali[4])
  o_long.audio_url = o_l
  create_button_to_go(o_long, vocali[4], y_pos_letter)
  -- u
  u_long = create_globulo('long-u',vocali[5])
  u_long.audio_url = u_l
  create_button_to_go(u_long, vocali[5], y_pos_letter)

  -- SHORT
  -- a
  a_short = create_globulo('short-a',vocali[1])
  a_short.audio_url = a_s
  -- e
  e_short = create_globulo('short-e',vocali[2])
  e_short.audio_url = e_s
  -- i
  i_short = create_globulo('short-i',vocali[3])
  i_short.audio_url = i_s
  -- o
  o_short = create_globulo('short-o',vocali[4])
  o_short.audio_url = o_s
  -- u
  u_short = create_globulo('short-u',vocali[5])
  u_short.audio_url = u_s

  -- ascolta tutti
  ascolta_tutti_label = display.newImage(group,"media/ascolta_tutti.png")
  ascolta_tutti_label:addEventListener("tap",ascolta_tutti)
  local size = 100
  ascolta_tutti_label.width = size
  ascolta_tutti_label.height = size
  ascolta_tutti_label.x = 500
  ascolta_tutti_label.y = 500

  manipulate_order_invert_group(all_globuli, all_globuli_order_inverted)

end

--Add the createScene listener
menu_iniziale:addEventListener( "createScene", menu_iniziale )

return menu_iniziale
