require 'src.utils.button_to_go'

local storyboard = require ( "storyboard" )
local menu_iniziale = storyboard.newScene()

local counter = 1

local vocali = {"a","e","i","o","u"}
local group

function create_globulo( file_name , vocale)
  local x_pos = {0, 100, 200, 300, 400, 0, 100, 200, 300, 400}
  local y_pos = {350,150}
  local globulo_size = 100
  -- dati
  local path = 'media/menu_iniziale/'
  local end_path = '.png'
  local final_path = path .. file_name .. end_path
  local globulo = display.newImage(final_path)
  -- posizionamento
  globulo.width = globulo_size
  globulo.height = globulo_size

  local pos_x = x_pos[counter]*2
  globulo.x = pos_x + globulo_size
  if counter > 5 then
    globulo.y = y_pos[1]
  else
    globulo.y = y_pos[2]
  end
  globulo:addEventListener('tap',play_sound)
  counter = counter+1
  group:insert(globulo)
  return globulo
end

function play_sound(event)
  local url = event.target.audio_url
  audio.play( url ) 
end

-- imposta un evento che deriva da utils.button_to_go
function go_to(event)
  _G.vocale = event.target.vocale
  storyboard.removeScene("src.confronto")
  storyboard.gotoScene("src.confronto")
end

--Create the scene
function menu_iniziale:createScene( event )

  group = self.view

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
  -- a
  a_long = create_globulo('long-a',vocali[1])
  a_long.audio_url = a_l
  create_button_to_go(a_long, vocali[1])
  -- e
  e_long = create_globulo('long-e',vocali[2])
  e_long.audio_url = e_l
  create_button_to_go(e_long, vocali[2])
  -- i
  i_long = create_globulo('long-i',vocali[3]) 
  i_long.audio_url = i_l
  create_button_to_go(i_long, vocali[3])
  -- o
  o_long = create_globulo('long-o',vocali[4])
  o_long.audio_url = o_l
  create_button_to_go(o_long, vocali[4])
  -- u
  u_long = create_globulo('long-u',vocali[5])
  u_long.audio_url = u_l
  create_button_to_go(u_long, vocali[5])

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

end

--Add the createScene listener
menu_iniziale:addEventListener( "createScene", menu_iniziale )

return menu_iniziale
