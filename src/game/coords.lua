--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:6ac04acc4e68dcaf009fede24f06a207:1/1$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- 1
            x=2,
            y=2,
            width=398,
            height=424,

            sourceX = 50,
            sourceY = 33,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 10
            x=402,
            y=2,
            width=398,
            height=424,

            sourceX = 50,
            sourceY = 33,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 11
            x=802,
            y=2,
            width=398,
            height=424,

            sourceX = 50,
            sourceY = 33,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 12
            x=1202,
            y=2,
            width=398,
            height=424,

            sourceX = 50,
            sourceY = 33,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 13
            x=1202,
            y=2,
            width=398,
            height=424,

            sourceX = 50,
            sourceY = 33,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 2
            x=1602,
            y=2,
            width=398,
            height=424,

            sourceX = 50,
            sourceY = 33,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 3
            x=2,
            y=428,
            width=418,
            height=446,

            sourceX = 40,
            sourceY = 21,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 4
            x=422,
            y=428,
            width=418,
            height=448,

            sourceX = 40,
            sourceY = 19,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 5
            x=842,
            y=428,
            width=418,
            height=448,

            sourceX = 40,
            sourceY = 19,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 6
            x=1262,
            y=428,
            width=408,
            height=436,

            sourceX = 45,
            sourceY = 26,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 7
            x=2,
            y=878,
            width=398,
            height=426,

            sourceX = 50,
            sourceY = 31,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 8
            x=402,
            y=878,
            width=398,
            height=424,

            sourceX = 50,
            sourceY = 33,
            sourceWidth = 500,
            sourceHeight = 500
        },
        {
            -- 9
            x=802,
            y=878,
            width=398,
            height=424,

            sourceX = 50,
            sourceY = 33,
            sourceWidth = 500,
            sourceHeight = 500
        },
    },
    
    sheetContentWidth = 2048,
    sheetContentHeight = 2048
}

SheetInfo.frameIndex =
{

    ["1"] = 1,
    ["10"] = 2,
    ["11"] = 3,
    ["12"] = 4,
    ["13"] = 5,
    ["2"] = 6,
    ["3"] = 7,
    ["4"] = 8,
    ["5"] = 9,
    ["6"] = 10,
    ["7"] = 11,
    ["8"] = 12,
    ["9"] = 13,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
