package.path = package.path .. ";./confronto/?.lua"
describe("Start with glob", function()
    -- _G.vocale = 'a'
    print(package.path)
    print("---")
    Glob = require 'glob'
    g = Glob.newMovieClip()
    print(g)
    print("PIANTARE IL DITO ")

end)
