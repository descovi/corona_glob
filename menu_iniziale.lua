local storyboard = require ( "storyboard" )
local movieclip = require("movieclip")
local menu_iniziale = storyboard.newScene()

--Create the scene
function menu_iniziale:createScene( event )

  -- Creazioni globuli
  local counter = 1
  x_pos = {0, 100, 200, 300, 400, 0, 100, 200, 300, 400}
  y_pos = {550,350}
  vocali = {"a","e","i","o","u"}
  globulo_size = 100
  
  local group = self.view
  
  function create_button_to_go(globulo, vocale)
    local cerchio_container = display.newGroup()
    local cerchio = display.newCircle(globulo.x, 700, 30)
    local testo = display.newText(vocale, cerchio.x-6, cerchio.y-14, "Courier New", 18)
    testo:setTextColor(0, 0, 0)
    cerchio_container:insert(cerchio)
    cerchio_container:insert(testo)
    group:insert(cerchio_container)
  end

  function play_sound(event)
    local url = event.target.audio_url
    local path_audio = 'media/audio/vocali/'
  end
  
  function create_globulo( file_name , vocale)
    -- dati
    local path = 'media/menu_iniziale/'
    local end_path = '.png'
    local final_path = path .. file_name .. end_path
    local globulo = display.newImage(final_path)
    -- posizionamento
    globulo.width = globulo_size
    globulo.height = globulo_size
    pos_x = x_pos[counter] 
    globulo.x = pos_x + 180
    if counter > 5 then
      globulo.y = y_pos[1]
    else
      globulo.y = y_pos[2]
    end
    counter = counter+1
    globulo.audio_url = 'caio'
    return globulo
  end
  
  -- LONG
  -- a
  a_long = create_globulo('long-a',vocali[1])
  create_button_to_go(a_long, vocali[1])
  a_long:addEventListener('touch',play_sound)
  -- e
  e_long = create_globulo('long-e',vocali[2])
  create_button_to_go(e_long, vocali[2])
  e_long:addEventListener('touch',play_sound)
  -- i
  i_long = create_globulo('long-i',vocali[3])  
  create_button_to_go(i_long, vocali[3])
  i_long:addEventListener('touch',play_sound)
  -- o
  o_long = create_globulo('long-o',vocali[4])
  create_button_to_go(o_long, vocali[4])
  o_long:addEventListener('touch',play_sound)
  -- u
  u_long = create_globulo('long-u',vocali[5])
  create_button_to_go(u_long, vocali[5])
  u_long:addEventListener('touch',play_sound)

  -- SHORT
  -- a
  a_short = create_globulo('short-a',vocali[1])
  a_short:addEventListener('touch',play_sound)
  -- e
  e_short = create_globulo('short-e',vocali[2])
  e_short:addEventListener('touch',play_sound)
  -- i
  i_short = create_globulo('short-i',vocali[3])
  i_short:addEventListener('touch',play_sound)
  -- o
  o_short = create_globulo('short-o',vocali[4])
  o_short:addEventListener('touch',play_sound)
  -- u
  u_short = create_globulo('short-u',vocali[5])
  u_short:addEventListener('touch',play_sound)
end

--Add the createScene listener
menu_iniziale:addEventListener( "createScene", menu_iniziale )


return menu_iniziale