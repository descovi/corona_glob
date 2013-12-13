Globulo = {}
Globulo.anim_is_going = false

Globulo.new = function(file_name, _audio_url)

  globulo_container = display.newGroup()
  
  globulo_container.play_sound = function(target)
    audio.play( target.audio_url ) 
  end
  
  globulo_container.anim_completed = function(event)
    Globulo.anim_is_going = false
  end
  
  globulo_container.play_anim = function ( target )
    y_start = target.y
    difference = 20
    _time = 180
    transition.to(target, { time=_time, y=y_start+difference })
    transition.to(target, { time=_time, y=y_start-difference, delay=_time})
    transition.to(target, { time=_time, y=y_start, delay=_time*2, onComplete= globulo_container.anim_completed})
  end

  globulo_container.tapped = function(event)
    if Globulo.anim_is_going == false then
      event.target:play_sound()
      event.target:play_anim()
      Globulo.anim_is_going = true
    end
  end

  globulo_container.setup = function(file_name)  
    local globulo_size = 150
    -- dati
    local path = 'media/menu_iniziale/'
    local final_path = path .. file_name .. "-150/1.png"
    local globulo = display.newImage(globulo_container, final_path)
    globulo.width  = globulo_size
    globulo.height = globulo_size
    globulo_container:addEventListener('tap',globulo_container.tapped)
  end
  
  globulo_container.setup_audio = function(_audio_url)
    local path_audio = 'media/audio/vocali/'
    local audio_o = audio.loadSound( path_audio .. _audio_url .. '.mp3' )
    globulo_container.audio_url = audio_o
  end
  
  globulo_container.setup_audio(_audio_url)
  globulo_container.setup(file_name)

  return globulo_container

end

return Globulo