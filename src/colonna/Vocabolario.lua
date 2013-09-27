local Vocabolario = {}

Vocabolario.newSprite = function()

  local a_e = {}
  local a_i = {}
  local e_a = {}
  local e_e = {}
  local i_e = {}
  local o_a = {}
  local o_e = {}
  local u_e = {}
  
  local data = {}
  
  data["a_e"] = a_e
  data["a_i"] = a_i

  data["e_a"] = e_a
  data["e_e"] = e_e

  data["i_e"] = i_e

  data["o_a"] = o_a
  data["o_e"] = o_e

  data["u_e"] = u_e


  a_e[1] = {
    {eng = "fad",   ita = "moda passagera"},
    {eng = "fade",  ita = "scomparire"}
  }
  a_e[2] = {
    {eng = "fat",   ita="grasso"},
    {eng = "fate",  ita="destino"}
  }
  a_e[3] = {
    {eng = "gap",   ita = "buco, fessura"},
    {eng = "gape",  ita = "restare a bocca aperta"}
  }
  a_e[4] = {
    {eng = "hat",   ita = "cappello"},
    {eng = "hate",  ita = "odio"}
  }
  a_e[5] = {
    {eng = "rat", ita = "ratto"},
    {eng = "rate",  ita = "proporzione"}
  }
  --
  a_i[1] = {
    {eng = "bat",   ita = "pippistrello"},
    {eng = "bait",  ita = "esca"}
  }
  a_i[2] = {
    {eng = "lad",   ita = "giovanotto"},
    {eng = "laid",  ita = "sepolto"}
  }
  a_i[3] = {
    {eng = "mad",   ita = "arrabiato, pazzo"},
    {eng = "maid",  ita = "domestica"}
  }
  a_i[4] = {
    {eng = "pan",   ita = "padella"},
    {eng = "pain",  ita = "dolore"}
  }
  a_i[5] = {
    {eng = "tan",   ita = "abbronzatura"},
    {eng = "taint",  ita = "macchia"}
  }
  --
  e_a[1] = {
    {eng = "bed",   ita = "letto"},
    {eng = "bead",  ita = "perline"}
  }
  e_a[2] = {
    {eng = "hell",   ita = "inferno"},
    {eng = "heal",  ita = "guarire"}
  }
  e_a[3] = {
    {eng = "led",   ita = "prevalso"},
    {eng = "lead",  ita = "prevalere"}
  }
  e_a[4] = {
    {eng = "net",   ita = "rete"},
    {eng = "neat",  ita = "ottimo"}
  }
  e_a[5] = {
    {eng = "peck",   ita = "beccare"},
    {eng = "peak",  ita = "punta, cima"}  
  }
  --
  e_e[1] = {
    {eng = "check",   ita = "controllo"},
    {eng = "cheek",  ita = "guancia"}  
  }
  e_e[2] = {
    {eng = "chess",   ita = "scacchi"},
    {eng = "cheese",  ita = "fai un bel sorriso"}  
  }
  e_e[3] = {
    {eng = "met",   ita = "incontrato"},
    {eng = "meet",  ita = "incontrare"}  
  }
  e_e[4] = {
    {eng = "step",   ita = "passo, gradino"},
    {eng = "steep",  ita = "ripido"}  
  }
  e_e[5] = {
    {eng = "ten",   ita = "dieci"},
    {eng = "teen",  ita = "numeri da 13 a 19"}  
  }
  --
  i_e[1] = {
    {eng = "bit",   ita = "morso"},
    {eng = "bite",  ita = "mordere"}  
  }
  i_e[2] = {
    {eng = "fill",   ita = "riempire"},
    {eng = "file",  ita = "cassetti da ufficio"}  
  }
  i_e[3] = {
    {eng = "pin",   ita = "spillo"},
    {eng = "pine",  ita = "pino"}  
  }
  i_e[4] = {
    {eng = "slim",   ita = "magro, sottile"},
    {eng = "slime",  ita = "bava"}  
  }
  i_e[5] = {
    {eng = "win",   ita = "vincere"},
    {eng = "wine",  ita = "vino"}  
  }
  o_a[1] = {
    {eng = "boss",   ita = "capo"},
    {eng = "boast",  ita = "vantarsi"}   
  }
  o_a[2] = {
    {eng = "cost",   ita = "costo"},
    {eng = "coast",  ita = "costa"}    
  }
  o_a[3] = {
    {eng = "long",   ita = "lungo"},
    {eng = "loan",  ita = "prestito, mutuo"}    
  }
  o_a[4] = {
    {eng = "rock",   ita = "roccia"},
    {eng = "roach",  ita = "scarafaggio"}    
  }
  o_a[5] = {
    {eng = "sock",   ita = "calza"},
    {eng = "soak",  ita = "bagnato fradicio"}  
  }
  o_e[1] = {
    {eng = "hop",   ita = "moda passagera"},
    {eng = "hope",  ita = "speranza"}  
  }
  o_e[2] = {
    {eng = "jock",   ita = "fusto"},
    {eng = "joke",  ita = "buffone, scherzo"}  
  }
  o_e[3] = {
    {eng = "posh",   ita = "snob, di lusso"},
    {eng = "pose",  ita = "posa"}  
  }
  o_e[4] = {
    {eng = "rob",   ita = "rubare"},
    {eng = "robe",  ita = "mantello"}  
  }  
  u_e[1] = {
    {eng = "cub",   ita = "cucciolo di leone"},
    {eng = "cube",  ita = "cubo"}    
  }
  u_e[2] = {
    {eng = "cut",   ita = "tagliare"},
    {eng = "cute",  ita = "carino"}    
  }
  u_e[3] = {
    {eng = "duck",   ita = "anatra"},
    {eng = "duke",  ita = "duca"}    
  }
  u_e[4] = {
    {eng = "hug",   ita = "abbraccio"},
    {eng = "huge",  ita = "enorme"}    
  }
  u_e[5] = {
    {eng = "tub",   ita = "vasca da bagno"},
    {eng = "tube",  ita = "tubo"}    
  }

 
  local group = display.newGroup()
  group.counter = 1
  local myRectangle = display.newRect(group,0, display.contentHeight-150, 150, 150)
  local image = display.newImage("media/vocabolario.png")
  image.x = myRectangle.x
  image.y = myRectangle.y
  myRectangle.alpha = 0.01
  local show = false

  group:addEventListener("tap", function(event)
    if (show == false) then
      local spiegazione = display.newRect( event.target, 0, 0, display.contentWidth, display.contentHeight )
      local string_1_eng = data[_G.combinazione][group.counter][1].eng
      local string_1_ita = data[_G.combinazione][group.counter][1].ita
      local string_2_eng = data[_G.combinazione][group.counter][2].eng
      local string_2_ita = data[_G.combinazione][group.counter][2].ita
      local size_font = 40
      local group_text = display.newGroup()
      group_text.x = 100
      group_text.y = 200
      event.target:insert(group_text)
      local testo_1_eng = display.newText(group_text,string_1_eng, 0, 0, "Helvetica", size_font)
      local testo_1_ita = display.newText(group_text,string_1_ita, 500, 0, "Helvetica", size_font)
      local testo_2_eng = display.newText(group_text,string_2_eng, 0, 300, "Helvetica", size_font)
      local testo_2_ita = display.newText(group_text,string_2_ita, 500, 300, "Helvetica", size_font)
      testo_1_eng:setTextColor(255, 0, 0, 255)
      testo_1_ita:setTextColor(0, 0, 0, 255)
      testo_2_eng:setTextColor(255, 0, 0, 255)
      testo_2_ita:setTextColor(0, 0, 0, 255)
      spiegazione.alpha = 1
      show = true
    else
      show = false
      group:remove(group.numChildren)
      group:remove(group.numChildren)
      
    end

  end)
  function group.set(_counter)    
    group.counter = _counter
  end

  return group

end
return Vocabolario