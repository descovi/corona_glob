require('src.utils.button_to_go')

local Storyboard = require( "storyboard" )
local Glob = require("src.confronto.glob")
local Letter = require("src.confronto.Letter")
local LetterLinks = require("src.confronto.LetterLinks")
local Combination = require('src.confronto.Combination')

-- elements
local letter = {}
local letter_links_1 = {}
local letter_links_2 = {}
local glob_2 = {}
local glob_1 = {}
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
  Storyboard.gotoScene("src.menu_iniziale")
end

function go_to_confronto_lunga(event)
  _G.tipo = 'lunga'
  Storyboard.removeAll()
  Storyboard.gotoScene("src.colonna")
end

function go_to_confronto_corto(event)
  _G.tipo = 'corta'
  _G.combinazione = _G.vocale.."_".._G.vocale
  Storyboard.removeAll()
  Storyboard.gotoScene("src.colonna")
end

function createTornaIndietro(group)
  torna_indietro = button_to_go_back()
  torna_indietro:addEventListener("tap", goto_menuiniziale)
  group:insert(torna_indietro)
end

function createGlobs(group)
  glob_1 = Glob:newMovieClip(_G.vocale,'L',group)
  glob_2 = Glob:newMovieClip(_G.vocale,'S',group)
  glob_1.opposto = glob_2
  glob_2.opposto = glob_1
  glob_1.alpha = 0
end

function createLetters( group )
  letter = Letter.new(_G.vocale)
  group:insert(letter)
end


function createLinkLetters( group )
  letter_links_1 = LetterLinks.new(_G.vocale,1)
  group:insert(letter_links_1)
  letter_links_1:fadeOut()
  letter_links_1.alpha = 0
  if (Combination.is_more_than_one()) then
    letter_links_2 = LetterLinks.new(_G.vocale,2)
    group:insert(letter_links_2)
    letter_links_2.alpha = 0
  end
end

function globPlayedStart(event)
  letter:zoom()
end

function links_clicked(event)
  _G.combinazione =  _G.vocale .. "_" .. event.target.text_raw
  Storyboard.removeScene("src.colonna")
  Storyboard.gotoScene("src.colonna")
end

function setupListener()
  glob_1:addEventListener("GlobFadeOut50%",function()
    letter_links_1:fadeOut()
    if (Combination.is_more_than_one()) then
      letter_links_2:fadeOut()
    end
    glob_2:fadeInAndPlay()
  end)
  glob_2:addEventListener("GlobFadeOut50%",function()
    letter_links_1:fadeIn()
    if (Combination.is_more_than_one()) then
      letter_links_2:fadeIn()
    end
    glob_1:fadeInAndPlay()
  end)

  glob_1:addEventListener("GlobStartPlay",globPlayedStart)
  glob_2:addEventListener("GlobStartPlay",globPlayedStart)

  -- setup link 1
  letter_links_1:addEventListener("tap",links_clicked)
  -- setup link 2
  if (Combination.is_more_than_one()) then
    letter_links_2:addEventListener("tap",links_clicked)
  end
  --
end

function confronto:createScene( event )
  createGlobs(self.view)
  createLetters(self.view)
  createLinkLetters(self.view)
  setupListener()
  createTornaIndietro(self.view)
end

confronto:addEventListener( "destroyScene", confronto )
confronto:addEventListener( "enterScene",  confronto )
confronto:addEventListener( "createScene", confronto )

return confronto
