function CreaFila(long_or_short, vocali, path, x_pos, all_globuli)
  local group = display.newGroup()
  for i=1,5 do
    local single_path = path .. long_or_short ..vocali[i] .. "-150/1.png"
    local globo = display.newImage(single_path)
    globo.x = x_pos[i]*1.5 + globo.width
    globo.vocale = long_or_short..vocali[i]
    -- label
    

    
    -- sound
    local path_audio = 'media/audio/vocali/'
    if (long_or_short=="long-") then
      local audio = audio.loadSound( path_audio .. string.upper(vocali[i]) .. '_L.mp3')
      globo.audio = audio
    
    else
      local audio = audio.loadSound( path_audio .. string.upper(vocali[i]) .. '_S.mp3')
      globo.audio = audio
      
    end


    -- tap
    globo:addEventListener("tap", answer_clicked)
    -- insert
    table.insert(all_globuli,globo)
    group:insert(globo)

    if long_or_short == "short-" then
    local label = display.newText(vocali[i], 100,480,_G.font_bold,30)
      label.x = globo.x
      label.y = globo.y+100
      label.y = globo.y-100
      group:insert(label)
    end

    
  end
  -- short long
  local label = display.newText(group, long_or_short:gsub("-",""), group.x+group.width+80,group.y+group.height/4,_G.font,20)

  return group
end