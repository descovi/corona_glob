require('src.utils.button_to_go')
require('src.utils.button_to_go_back')

local Storyboard = require( "storyboard" )
local Glob = require("src.confronto.glob")
local Letter = require("src.confronto.letter")

-- elements
local letter = {}
local glob_s = {}
local glob_l = {}

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
  glob_l = Glob:newMovieClip(_G.vocale,'L',group)
  glob_s = Glob:newMovieClip(_G.vocale,'S',group)
  glob_l.opposto = glob_s
  glob_s.opposto = glob_l
  glob_l.alpha = 0
end

function createLetters( group )
  letter = Letter:new(_G.vocale)
  group:insert(letter)
end

function setupListener()
  glob_s:addEventListener("fadeOut50%",function()glob_l:fadeInAndPlay()end)
  glob_l:addEventListener("fadeOut50%",function()glob_s:fadeInAndPlay()end)
  glob_s:addEventListener("startPlay",function()letter:zoom()end)
  glob_l:addEventListener("startPlay",function()letter:zoom()end)
end

function confronto:createScene( event )
  
  createGlobs(self.view)
  createLetters(self.view)
  setupListener()
  createTornaIndietro(self.view)
end

confronto:addEventListener( "destroyScene", confronto )
confronto:addEventListener( "enterScene",  confronto )
confronto:addEventListener( "createScene", confronto )

return confronto
