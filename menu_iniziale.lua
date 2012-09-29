local storyboard = require ( "storyboard" )
local movieclip = require("movieclip")
local menu_iniziale = storyboard.newScene()

--Create the scene
function menu_iniziale:createScene( event )

  -- Creazioni globuli
  local counter = 1
  x_pos = {0, 100, 200, 300, 400, 0, 100, 200, 300, 400}
  y_pos = {350, 550}
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
  function create_globulo( file_name , vocale)
    local path = 'media/menu_iniziale/'
    local end_path = '.png'
    local final_path = path .. file_name .. end_path
    local globulo = display.newImage(final_path)
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
    return globulo
  end
  
  
  a_long = create_globulo('long-a','a')
  create_button_to_go(a_long, 'a')
  
  e_long = create_globulo('long-e','e')
  create_button_to_go(e_long, 'e')
  
  i_long = create_globulo('long-i','i')  
  create_button_to_go(i_long, 'i')
  
  o_long = create_globulo('long-o','o')
  create_button_to_go(o_long, 'o')
  
  u_long = create_globulo('long-u','u')
  create_button_to_go(u_long, 'u')

  a_short = create_globulo('short-a','a')
  e_short = create_globulo('short-e','e')
  i_short = create_globulo('short-i','i')
  o_short = create_globulo('short-o','o')
  u_short = create_globulo('short-u','u')
  

end

--Add the createScene listener
menu_iniziale:addEventListener( "createScene", menu_iniziale )


return menu_iniziale