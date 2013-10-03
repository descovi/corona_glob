local Lettera = {}
Lettera.newSprite = function()

  local lettera = {}
  lettera.anim_list = {}
  lettera.anim_path = ''
  lettera.

  function anim.fill_anim_list()
    for i=1,24 do
      lettera.anim_list[i] = string.gsub (lettera.anim_path, "1", i)
    end
  end

  function anim.create()
    lettera = movieclip.newAnim(anim_list)
  end

  anim.create()

end
return Lettera