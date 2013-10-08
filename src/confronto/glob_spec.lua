package.path = package.path .. ";./confronto/?.lua"
describe("Start with glob", function()
    _G.vocale = 'a'
    Glob = require 'glob'
    g = Glob.newMovieClip()

end)
