local Storyboard = require( "storyboard" )
local Glob = require("src.confronto.glob")
local glob = {}
local Letter = require("src.confronto.Letter")
local LetterLinks = require("src.confronto.LetterLinks")
local Combination = require('src.confronto.Combination')

-- elements
local letter = {}
local letter_links_1 = {}
local letter_links_2 = {}

local combination = Combination.get(_G.vocale)
-- storyboard
local confronto = Storyboard.newScene()

local renable_click = function(e)
  print("- RENABLE_CLICK -")
  lettera_clickable = true
  print(lettera_clickable)
end

function goto_menuiniziale(e)
  Storyboard.removeAll()
  Storyboard.gotoScene("src.menu_iniziale",{
    effect = "slideDown",
    time = 800})
end

function createTornaIndietro(group)
  torna_indietro = button_to_go_back()
  torna_indietro:addEventListener("tap", goto_menuiniziale)
  group:insert(torna_indietro)
end

function createGlobs(group)
  glob = Glob:new(_G.vocale)
  group:insert(glob)
  glob.alpha = 0
  glob:scale(0,0)
  transition.to(glob, { time=300, alpha=1, xScale=1,yScale=1,delay=1050 , transition=easing.outInSine})
end

function createLetters( group )
  letter = Letter.new(_G.vocale)
  group:insert(letter)
end


function createLinkLetters( group )
  letter_links_1 = LetterLinks.new(_G.vocale,1)
  group:insert(letter_links_1)
  letter_links_1:fadeOut()
  
  if (Combination.is_more_than_one()) then
    letter_links_2 = LetterLinks.new(_G.vocale,2)
    group:insert(letter_links_2)
    letter_links_2:fadeOut()  
  end
end


function links_clicked(event)
  _G.combinazione =  _G.vocale .. "_" .. event.target.text_raw
  Storyboard.removeScene("src.colonna")
  Storyboard.gotoScene("src.colonna",{effect="slideUp",time = 800})
end

function setupListener()
    -- setup link 1
  letter_links_1:addEventListener("tap",links_clicked)
  -- setup link 2
  if (Combination.is_more_than_one()) then
    letter_links_2:addEventListener("tap",links_clicked)
  end
  letter:addEventListener("tap",function(event)
    glob.genitore:start_sequence()
  end)
  glob:addEventListener("GlobStartPlay",globPlayedStart)
end

function globPlayedStart(event)
  letter:zoom(glob.duration_anim_totale/2)
  letter_links_1:fadeToogle(glob.duration_anim_totale/2) 
  if letter_links_2.alpha~=nil then
    letter_links_2:fadeToogle(glob.duration_anim_totale/2)
  end
end

function confronto:createScene( event )
  createGlobs(self.view)
  createLetters(self.view)
  createLinkLetters(self.view)
  setupListener()
  createTornaIndietro(self.view)

end

--confronto:addEventListener( "destroyScene", confronto )
--confronto:addEventListener( "enterScene",  confronto )
confronto:addEventListener("exitScene",function()
  print("Exit Scene <----")
end)
confronto:addEventListener( "createScene", confronto )

return confronto
