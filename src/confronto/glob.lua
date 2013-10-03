local Glob = {}
Glob.newSprite = function()

  local glob = {}
  glob.anim_list = {}
  glob.anim_path = ''
  glob.size

  function glob.set_anim_path()
    origin_path = "media/menu_iniziale/"
    glob.anim_path = origin_path.."long-".. _G.vocale .."/1.png"

    -- "_L"

    -- "media/menu_iniziale/short-".. _G.vocale .."/1.png","_L"
  end

  function glob.fill_anim_list()
    for i=1,24 do
      glob.anim_list[i] = string.gsub (glob.anim_path, "1", i)
    end
  end

  function glob.setMovieClip()
    glob.set_anim_path()
    glob.fill_anim_list()
    glob = movieclip.newAnim(glob.anim_list)
  end

  function glob.setPosition()
    glob.y = display.contentHeight / 2
    glob.x = display.contentWidth / 2
  end

  function glob.setSize(size)
    glob.width = size
    glob.height = size
  end

  function glob.create()
    glob.setMovieClip()
    glob.setSize(500)
    glob.setPosition()
  end

  glob.create()

end
return Lettera