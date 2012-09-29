local storyboard = require "storyboard"
display.setStatusBar( display.HiddenStatusBar )
--Create a storyboard scene for this module
local scene = storyboard.newScene()
storyboard.gotoScene( "intro" )