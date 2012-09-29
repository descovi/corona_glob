local storyboard = require ( "storyboard" )
local movieclip = require("movieclip")
local menu_iniziale = storyboard.newScene()

--Create the scene
function menu_iniziale:createScene( event )

  -- Creazioni globuli
  local counter = 1
  x_pos = {0, 100, 200, 300, 400, 0, 100, 200, 300, 400}
  y_pos = {400, 600}
  globulo_size = 100
  function create_globulo( file_name )
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
    print "---"
    print (globulo.x)
    print (globulo.y)
    counter = counter+1
    return globulo
  end
  local group = self.view
  
  a_long = create_globulo('long-a')
  a_short = create_globulo('short-a')
  
  e_long = create_globulo('long-e')
  e_short = create_globulo('short-e')

  i_long = create_globulo('long-i')
  i_short = create_globulo('short-i')

  o_long = create_globulo('long-o')
  o_short = create_globulo('short-o')

  u_long = create_globulo('long-u')
  u_short = create_globulo('short-u')



end

--Add the createScene listener
menu_iniziale:addEventListener( "createScene", menu_iniziale )


return menu_iniziale