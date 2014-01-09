-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2013 
-- =============================================================
-- Version 1.2 (21 JUN 2013)
-- =============================================================
local  w = display.contentWidth
local  h = display.contentHeight
local  centerX = w/2
local  centerY = h/2

local displayWidth   = (display.contentWidth - display.screenOriginX*2)
local displayHeight  = (display.contentHeight - display.screenOriginY*2)

local unusedWidth    = displayWidth - w
local unusedHeight   = displayHeight - h

local deviceWidth  = math.floor((displayWidth/display.contentScaleX) + 0.5)
local deviceHeight = math.floor((displayHeight/display.contentScaleY) + 0.5)

local leftBuffer  = 20 - unusedWidth/2
local rightBuffer = w - 20 + unusedWidth/2
local topBuffer   = 20 - unusedHeight/2
local botBuffer   = h - 20 + unusedHeight/2

-- easy color codes and string translations
local  _TRANSPARENT_ = {0, 0, 0, 0}
local  _WHITE_ = {255, 255, 255, 255}
local  _BLACK_ = {  0,   0,   0, 255}
local  _GREY_      = {128, 128, 128, 255}
local  _DARKGREY_  = { 64,  64,  64, 255}
local  _DARKERGREY_  = { 32,  32,  32, 255}
local  _LIGHTGREY_ = {192, 192, 192, 255}
local  _RED_   = {255,   0,   0, 255}
local  _GREEN_ = {  0, 255,   0, 255}
local  _BLUE_  = {  0,   0, 255, 255}
local  _CYAN_  = {  0,   255, 255, 255}
local  _YELLOW_       = {0xff, 0xff,    0, 255}
local  _ORANGE_       = {0xff, 0x66,    0, 255}
local  _BRIGHTORANGE_ = {0xff, 0x99,    0, 255}
local  _PURPLE_       = {0xa0, 0x20, 0xf0, 255}
local  _PINK_         = {0xff, 0x6e, 0xc7, 255}

local barGroup
local meters = {}
local buttons = {}
local averageWindow = 30
local updatePeriod = 11
local maxMainMem = 2048 -- KB ( i.e. 2MB)
local maxVidMem = system.getInfo( "maxTextureSize" )
local allowCollect = false
local fontSM = 1
local oldFontSM = 1
local pLogEnabled = false
local oldPrint 
local printLog  
local pLogMax = 150
local pLogLimit = pLogMax

-- ==
--    round(val, n) - Rounds a number to the nearest decimal places. (http://lua-users.org/wiki/FormattingNumbers)
--    val - The value to round.
--    n - Number of decimal places to round to.
-- ==
local function round(val, n)
  if (n) then
    return math.floor( (val * 10^n) + 0.5) / (10^n)
  else
    return math.floor(val+0.5)
  end
end


local function quickLabel( group, text, x, y, font, fontSize, fontColor )
	local font = font or  native.systemFontBold
	local fontSize = fontSize or 10
	local fontColor = fontColor or _WHITE_

	local label = display.newText( group, text, 0, 0, font, fontSize * fontSM )
	label.x = x
	label.y = y
	label:setTextColor( unpack( fontColor ) )

	return label
end


-- ==
--    FPS METER
-- ==

local fpsGroup
local fpsMeter
local fpsBack
local avgFPSLine
local avgFPSLabel
local minFPS = 999
local maxFPS = 0
local minFPSLabel
local maxFPSLabel

local fpsBars = {}
local targetFPS = display.fps
local fpsUpdateCount = 0
local lastFPSTime = -1
local fps = {}
local fpsIndex = 1

local function onFPSFrame( self, event )

	barGroup:toFront()

	local curTime = event.time
	local delta = curTime - lastFPSTime
	local curFPS 

	if(lastFPSTime ~= -1 ) then
		curFPS = 1000/delta
		if(fpsIndex > averageWindow) then
			fpsIndex = 1
		end
		fps[fpsIndex] = curFPS
		fpsIndex = fpsIndex + 1

		if( curFPS < minFPS ) then
			minFPS = curFPS
			minFPSLabel.text = "(" .. round(curFPS) .. ")"
		end 

		if( curFPS > maxFPS ) then
			maxFPS = curFPS
			maxFPSLabel.text = "(" .. round(curFPS) .. ")"
		end 

	end


	lastFPSTime = curTime

	fpsUpdateCount = fpsUpdateCount + 1

	if( fpsUpdateCount % updatePeriod ~= 0) then return false end

	local avgFPS = 0

	if( #fps > 0 ) then
		for i = 1, #fps do
			avgFPS = avgFPS + fps[i]
		end
		avgFPS = avgFPS / #fps
	end
	
	if( #fps > 0 ) then

		local linePos = fpsBack.bot - math.floor( ( (avgFPS/targetFPS) * (2 * fpsBack.height / 3 ) ) ) 

		if(linePos < fpsBack.top) then
			linePos = fpsBack.top
		end

		local tmpAvg = round(avgFPS)

		avgFPSLabel.text = "(" .. tmpAvg .. ")"
		avgFPSLine.y = linePos
		avgFPSLabel.y =  avgFPSLine.y
	end

	if(#fpsBars >= fpsBack.maxBars) then
		fpsBars[1]:removeSelf()
		table.remove( fpsBars, 1 )
	end

	for i = 1, #fpsBars do
		fpsBars[i].x = fpsBars[i].x - 4		
	end

	if(curFPS) then

		local fill = _RED_
		local width = 1
		local barHeight = math.floor( ( (curFPS/targetFPS) * (2 * fpsBack.height / 3 ) ) )

		if(barHeight > (fpsBack.height)) then
			barHeight = fpsBack.height
			fill = _PINK_
			width = 2
		elseif( barHeight < 1 ) then
			barHeight = 1
		end

		local bar = display.newRect( fpsMeter, 0, 0, width, barHeight-4 )
		bar.x = fpsBack.right-2
		bar.y = fpsBack.bot - barHeight/2- 1
		bar:setFillColor(unpack(fill))

		fpsBars[#fpsBars+1] = bar
	end

	return false
end

local function createFPSMeter( group, meterWidth, meterHeight )
	fpsGroup = display.newGroup()
	fpsMeter = display.newGroup()	
	local fpsLines = display.newGroup()

	barGroup:insert(fpsGroup)
	fpsGroup:insert(fpsMeter)
	fpsGroup:insert(fpsLines)

	fpsBars = {}

	fpsBack = display.newRect( fpsMeter, meterWidth * 0.025, meterHeight * 0.1, meterWidth * 0.675, meterHeight * 0.625 )
	fpsBack:setStrokeColor(255,255,0)
	fpsBack:setFillColor(32,32,32)
	fpsBack.strokeWidth = 2

	--print(fpsBack.width, fpsBack.height)

	fpsBack.left    = fpsBack.x - fpsBack.width/2
	fpsBack.right   = fpsBack.x + fpsBack.width/2
	fpsBack.bot     = fpsBack.y + fpsBack.height/2
	fpsBack.top     = fpsBack.y - fpsBack.height/2
	fpsBack.maxBars = math.floor(fpsBack.width/4)
	
	local topLabel = quickLabel(fpsMeter, 3 * targetFPS/2, 0, fpsBack.top, nil, 10, _YELLOW_ )
	topLabel.x = fpsBack.right + 0.5 * topLabel.width + 5 
	
	local midLineY = fpsBack.top + fpsBack.height/3
	midLine = display.newLine( fpsLines, fpsBack.left, midLineY, fpsBack.right, midLineY )
	midLine:setColor(255,255,0)
	midLine.width = 1
	local midLabel = quickLabel(fpsMeter, targetFPS, topLabel.x, midLine.y, nil, 10, _YELLOW_ )

	local lowLineY = fpsBack.top + 2 * fpsBack.height/3
	local lowLine = display.newLine( fpsLines, fpsBack.left, lowLineY, fpsBack.right, lowLineY )
	lowLine:setColor(255,255,0)
	lowLine.width = 1
	local lowLabel = quickLabel(fpsMeter, targetFPS/2, topLabel.x, lowLine.y, nil, 10, _YELLOW_ )

	avgFPSLine = display.newLine( fpsLines, fpsBack.left+1, fpsBack.bot - 1, fpsBack.right-1, fpsBack.bot - 1 )
	avgFPSLine:setColor(255,0,0)
	avgFPSLine.width = 2
	avgFPSLabel = quickLabel(fpsMeter, "(--)", topLabel.x + 25, avgFPSLine.y, nil, 12, _RED_ )
	avgFPSLabel.x =  meterWidth - (meterWidth - fpsBack.right)/2  + 5 -- fpsBack.right + 3.5 * avgFPSLabel.width

	maxFPSLabel = quickLabel(fpsMeter, "(000)", topLabel.x + 25, fpsBack.top + 10 , nil, 12, _RED_ )
	maxFPSLabel.x =  meterWidth - 0.5 * maxFPSLabel.width - 5 -- fpsBack.right + 4.25 * maxFPSLabel.width

	minFPSLabel = quickLabel(fpsMeter, "(000)", topLabel.x + 25, fpsBack.bot - 10 , nil, 12, _RED_ )
	minFPSLabel.x =  meterWidth - 0.5 * minFPSLabel.width - 5 -- fpsBack.right + 4.25 * minFPSLabel.width


	fpsGroup.enterFrame = onFPSFrame

	Runtime:addEventListener( "enterFrame", fpsGroup )

	--fpsGroup.isVisible = false

	return fpsGroup
end

local function destroyFPSMeter()
	Runtime:removeEventListener( "enterFrame", fpsGroup )

	fpsGroup = nil
	fpsMeter = nil
	fpsBack = nil
	avgFPSLine = nil
	topLabel = nil
	avgFPSLabel = nil
	fpsBars = nil
end

-- ==
--    MainMem METER
-- ==

local mainMemGroup
local mainMemMeter
local mainMemBack
local avgMainMemLine
local avgMainMemLabel

local minMainMemVal = 0xF000000
local maxMainMemVal = 0
local minMainMemLabel
local maxMainMemLabel


local mainMemBars = {}
local targetMainMem = maxMainMem
local mainMemUpdateCount = 0
local mainMem = {}
local mainMemIndex = 1

local function onMainMemFrame( self, event )

	if( allowCollect ) then
		collectgarbage()
	end
	local curMM = collectgarbage("count")

	if( curMM < minMainMemVal ) then
		minMainMemVal = curMM
		minMainMemLabel.text = "(" .. round(curMM) .. ")"
	end 

	if( curMM > maxMainMemVal ) then
		maxMainMemVal = curMM
		maxMainMemLabel.text = "(" .. round(curMM) .. ")"
	end 

	if(mainMemIndex > averageWindow) then
		mainMemIndex = 1
	end
	mainMem[mainMemIndex] = curMM
	mainMemIndex = mainMemIndex + 1

	mainMemUpdateCount = mainMemUpdateCount + 1

	if( mainMemUpdateCount % updatePeriod ~= 0 ) then return false end

	local avgMainMem = 0

	if( #mainMem > 0 ) then
		for i = 1, #mainMem do
			avgMainMem = avgMainMem + mainMem[i]
		end

		avgMainMem = avgMainMem / #mainMem

		local linePos = mainMemBack.bot - math.floor( ( (avgMainMem/targetMainMem) * (2 * mainMemBack.height / 3 ) ) ) 

		if(linePos < mainMemBack.top) then
			linePos = mainMemBack.top
		end

		avgMainMemLabel.text = "(" .. round(avgMainMem) .. ")"
		avgMainMemLine.y = linePos
		avgMainMemLabel.y =  avgMainMemLine.y
	end

	if(#mainMemBars >= mainMemBack.maxBars) then
		mainMemBars[1]:removeSelf()
		table.remove( mainMemBars, 1 )
	end

	for i = 1, #mainMemBars do
		mainMemBars[i].x = mainMemBars[i].x - 4		
	end

	if(curMM) then

		local fill = _GREEN_
		local width = 1
		local barHeight = math.floor( ( (curMM/targetMainMem) * (2 * mainMemBack.height / 3 ) ) )

		if(barHeight > (mainMemBack.height)) then
			barHeight = mainMemBack.height
			fill = _PINK_
			width = 2
		elseif( barHeight < 1 ) then
			barHeight = 1
		end

		local bar = display.newRect( mainMemMeter, 0, 0, width, barHeight-4 )
		bar.x = mainMemBack.right-2
		bar.y = mainMemBack.bot - barHeight/2- 1
		bar:setFillColor(unpack(fill))

		mainMemBars[#mainMemBars+1] = bar
	end

	return false
end

local function createMainMemMeter( group, meterWidth, meterHeight )
	mainMemGroup = display.newGroup()
	mainMemMeter = display.newGroup()	
	local mainMemLines = display.newGroup()

	barGroup:insert(mainMemGroup)
	mainMemGroup:insert(mainMemMeter)
	mainMemGroup:insert(mainMemLines)

	mainMemBars = {}

	mainMemBack = display.newRect( mainMemMeter, meterWidth * 0.025, meterHeight * 0.1, meterWidth * 0.675, meterHeight * 0.625 )
	mainMemBack:setStrokeColor(255,255,0)
	mainMemBack:setFillColor(32,32,32)
	mainMemBack.strokeWidth = 2

	mainMemBack.left    = mainMemBack.x - mainMemBack.width/2
	mainMemBack.right   = mainMemBack.x + mainMemBack.width/2
	mainMemBack.bot     = mainMemBack.y + mainMemBack.height/2
	mainMemBack.top     = mainMemBack.y - mainMemBack.height/2
	mainMemBack.maxBars = math.floor(mainMemBack.width/4)

	local topLabel = quickLabel(mainMemMeter, 3 * targetMainMem/2 .. " KB", 0, mainMemBack.top, nil, 10, _YELLOW_ )
	topLabel.x = mainMemBack.right + 0.5 * topLabel.width + 5
	
	local midLineY = mainMemBack.top + mainMemBack.height/3
	local midLine = display.newLine( mainMemLines, mainMemBack.left, midLineY, mainMemBack.right, midLineY )
	midLine:setColor(255,255,0)
	midLine.width = 1
	local midLabel = quickLabel(mainMemMeter, targetMainMem .. " KB", topLabel.x, midLine.y, nil, 10, _YELLOW_ )

	local lowLineY = mainMemBack.top + 2 * mainMemBack.height/3
	local lowLine = display.newLine( mainMemLines, mainMemBack.left, lowLineY, mainMemBack.right, lowLineY )
	lowLine:setColor(255,255,0)
	lowLine.width = 1
	local lowLabel = quickLabel(mainMemMeter, targetMainMem/2 .. " KB", topLabel.x, lowLine.y, nil, 10, _YELLOW_ )

	avgMainMemLine = display.newLine( mainMemLines, mainMemBack.left+1, mainMemBack.bot - 1, mainMemBack.right-1, mainMemBack.bot - 1 )
	avgMainMemLine:setColor(0,255,0)
	avgMainMemLine.width = 2
	avgMainMemLabel = quickLabel(mainMemMeter, "(---- KB)", 0, avgMainMemLine.y, nil, 11, _GREEN_ )
	avgMainMemLabel.x = meterWidth - (meterWidth - mainMemBack.right)/2  + 5

	maxMainMemLabel = quickLabel(mainMemMeter, "(0000)", topLabel.x + 25, mainMemBack.top + 10 , nil, 11, _GREEN_ )
	maxMainMemLabel.x = meterWidth - 0.5 * maxMainMemLabel.width - 5

	minMainMemLabel = quickLabel(mainMemMeter, "(0000)", topLabel.x + 25, mainMemBack.bot - 10 , nil, 11, _GREEN_ )
	minMainMemLabel.x = meterWidth - 0.5 * minMainMemLabel.width - 5


	mainMemGroup.enterFrame = onMainMemFrame

	Runtime:addEventListener( "enterFrame", mainMemGroup )

	return mainMemGroup
end

local function destroyMainMemMeter()
	Runtime:removeEventListener( "enterFrame", mainMemGroup )

	mainMemGroup = nil
	mainMemMeter = nil
	mainMemBack = nil
	avgMainMemLine = nil
	avgMainMemLabel = nil
	mainMemBars = nil
end



-- ==
--    VidMem METER
-- ==

local vidMemGroup
local vidMemMeter
local vidMemBack
local avgVidMemLine
local avgVidMemLabel

local minVidMemVal = 0xF000000
local maxVidMemVal = 0
local minVidMemLabel
local maxVidMemLabel

local vidMemBars = {}
local targetVidMem = maxVidMem
local vidMemUpdateCount = 0
local vidMem = {}
local vidMemIndex = 1

local function onVidMemFrame( self, event )

	local curVM = system.getInfo( "textureMemoryUsed" )/(1024 * 1024)

	if( curVM < minVidMemVal ) then
		minVidMemVal = curVM
		minVidMemLabel.text = "(" .. round(curVM,2) .. ")"
	end 

	if( curVM > maxVidMemVal ) then
		maxVidMemVal = curVM
		maxVidMemLabel.text = "(" .. round(curVM,2) .. ")"
	end 


	if(vidMemIndex > averageWindow) then
		vidMemIndex = 1
	end
	vidMem[vidMemIndex] = curVM
	vidMemIndex = vidMemIndex + 1

	vidMemUpdateCount = vidMemUpdateCount + 1

	if( vidMemUpdateCount % updatePeriod ~= 0 ) then return false end

	local avgVidMem = 0

	if( #vidMem > 0 ) then
		for i = 1, #vidMem do
			avgVidMem = avgVidMem + vidMem[i]
		end

		avgVidMem = avgVidMem / #vidMem

		local linePos = vidMemBack.bot - math.floor( avgVidMem/targetVidMem * vidMemBack.height ) 

		--print(linePos, avgVidMem, targetVidMem, avgVidMem/targetVidMem, vidMemBack.height )

		if(linePos < vidMemBack.top) then
			linePos = vidMemBack.top
		end

		avgVidMemLabel.text = "(" .. round(avgVidMem,1) .. ")"
		avgVidMemLine.y = linePos
		avgVidMemLabel.y =  avgVidMemLine.y
	end

	if(#vidMemBars >= vidMemBack.maxBars) then
		vidMemBars[1]:removeSelf()
		table.remove( vidMemBars, 1 )
	end

	for i = 1, #vidMemBars do
		vidMemBars[i].x = vidMemBars[i].x - 4		
	end

	if(curVM) then
		local fill = _CYAN_
		local width = 1
		local barHeight = math.floor( curVM/targetVidMem  * vidMemBack.height )

		if(barHeight > (vidMemBack.height)) then
			barHeight = vidMemBack.height
			fill = _PINK_
			width = 2
		elseif( barHeight < 1 ) then
			barHeight = 1
		end

		local bar = display.newRect( vidMemMeter, 0, 0, width, barHeight-4 )
		bar.x = vidMemBack.right-2
		bar.y = vidMemBack.bot - barHeight/2- 1
		bar:setFillColor(unpack(fill))

		vidMemBars[#vidMemBars+1] = bar
	end

	return false
end

local function createVidMemMeter( group, meterWidth, meterHeight )
	vidMemGroup = display.newGroup()
	vidMemMeter = display.newGroup()	
	local vidMemLines = display.newGroup()

	barGroup:insert(vidMemGroup)
	vidMemGroup:insert(vidMemMeter)
	vidMemGroup:insert(vidMemLines)

	vidMemBars = {}

	vidMemBack = display.newRect( vidMemMeter, meterWidth * 0.025, meterHeight * 0.1, meterWidth * 0.675, meterHeight * 0.625 )
	vidMemBack:setStrokeColor(255,255,0)
	vidMemBack:setFillColor(32,32,32)
	vidMemBack.strokeWidth = 2

	vidMemBack.left    = vidMemBack.x - vidMemBack.width/2
	vidMemBack.right   = vidMemBack.x + vidMemBack.width/2
	vidMemBack.bot     = vidMemBack.y + vidMemBack.height/2
	vidMemBack.top     = vidMemBack.y - vidMemBack.height/2
	vidMemBack.maxBars = math.floor(vidMemBack.width/4)

	local topLabel = quickLabel(vidMemMeter, targetVidMem .. " KB", 0, vidMemBack.top, nil, 10, _YELLOW_ )
	topLabel.x = vidMemBack.right + 0.75 * topLabel.width
	
	local midLineY = vidMemBack.top + vidMemBack.height/2
	local midLine = display.newLine( vidMemLines, vidMemBack.left, midLineY, vidMemBack.right, midLineY )
	midLine:setColor(255,255,0)
	midLine.width = 1
	local midLabel = quickLabel(vidMemMeter, targetVidMem/2 .. " KB", topLabel.x, midLine.y, nil, 10, _YELLOW_ )

	avgVidMemLine = display.newLine( vidMemLines, vidMemBack.left+1, vidMemBack.bot - 1, vidMemBack.right-1, vidMemBack.bot - 1 )
	avgVidMemLine:setColor(0,255,255)
	avgVidMemLine.width = 2
	avgVidMemLabel = quickLabel(vidMemMeter, "(--- KB)", topLabel.x + 45, avgVidMemLine.y, nil, 12, _CYAN_ )
	avgVidMemLabel.x = meterWidth - (meterWidth - vidMemBack.right)/2  + 5 

	maxVidMemLabel = quickLabel(vidMemMeter, "(00000)", topLabel.x + 25, vidMemBack.top + 10 , nil, 12, _CYAN_ )
	maxVidMemLabel.x =  meterWidth - 0.5 * maxVidMemLabel.width - 5

	minVidMemLabel = quickLabel(vidMemMeter, "(00000)", topLabel.x + 25, vidMemBack.bot - 10 , nil, 12, _CYAN_ )
	minVidMemLabel.x =  meterWidth - 0.5 * minVidMemLabel.width - 5


	vidMemGroup.enterFrame = onVidMemFrame

	Runtime:addEventListener( "enterFrame", vidMemGroup )

	return vidMemGroup
end

local function destroyVidMemMeter()
	Runtime:removeEventListener( "enterFrame", vidMemGroup )

	vidMemGroup = nil
	vidMemMeter = nil
	vidMemBack = nil
	avgVidMemLine = nil
	avgVidMemLabel = nil
	vidMemBars = nil
end


-- ==
--    Info METER
-- ==

local InfoGroup

local function createInfoMeter( group, meterWidth, meterHeight )
	InfoGroup = display.newGroup()
	barGroup:insert(InfoGroup)

	local infoValues = {}
	local infoStrings = {
		"architectureInfo",
		"build",
		"environment",
		"model",
		"name",
		"platformName",
		"platformVersion",
		"maxTextureSize",
		"maxTextureUnits",
	}

	for i = 1, #infoStrings do
		local tmp = infoStrings[i]
		infoValues[tmp] = system.getInfo(tmp)
		--print(i, tmp, infoValues[tmp] )
		
	end

	local y1 = barGroup.y - meterHeight/2 + meterHeight/5
	local y2 = y1 + meterHeight/8
	local y3 = y2 + meterHeight/8
	local y4 = y3 + meterHeight/8

	local x1 = barGroup.x - meterWidth/3 - meterWidth/22
	local x2 = x1  + meterWidth/3 - meterWidth/16
	local x3 = x2  + meterWidth/3

	local tmp =	quickLabel( InfoGroup, "RG Super Meter v1.3 (2013.06.25)", 0, 0, nil, 10, _WHITE_ )
	tmp.x = barGroup.x - meterWidth/2 + tmp.width/2 + 4
	tmp.y = barGroup.y - meterHeight/2 + tmp.height/2 + 4

	-- Column 1
	quickLabel( InfoGroup, infoValues.environment, x1, y1, nil, 11, _ORANGE_ )
	quickLabel( InfoGroup, infoValues.platformName, x1, y2, nil, 11, _ORANGE_ )
	quickLabel( InfoGroup, infoValues.platformVersion, x1, y3, nil, 11, _ORANGE_ )
	quickLabel( InfoGroup, infoValues.model, x1, y4, nil, 11, _ORANGE_ )

	-- Column 2
	if(#infoValues.architectureInfo == 0) then
		infoValues.architectureInfo = "n/a"
	end
	quickLabel( InfoGroup, "Arch: " .. infoValues.architectureInfo, x2, y1, nil, 11, _ORANGE_ )
	quickLabel( InfoGroup, "Build: " .. infoValues.build, x2, y2, nil, 11, _ORANGE_ )
	quickLabel( InfoGroup, "Max Texture Size: " .. infoValues.maxTextureSize, x2, y3, nil, 11, _ORANGE_ )
	quickLabel( InfoGroup, "Max Texture Units: " .. 0, x2, y4, nil, 11, _ORANGE_ )

	-- Column 3
	quickLabel( InfoGroup, "Design Size: < " .. w .. ", " .. h .. " >", x3, y1, nil, 11, _ORANGE_ )
	quickLabel( InfoGroup, "Display Size: < " .. displayWidth .. ", " .. displayHeight .. " >", x3, y2, nil, 11, _ORANGE_ )
	quickLabel( InfoGroup, "Excess Size: < " .. unusedWidth .. ", " .. unusedHeight .. " >", x3, y3, nil, 11, _ORANGE_ )
	quickLabel( InfoGroup, "Device Size: < " .. deviceWidth .. ", " .. deviceHeight .. " >", x3, y4, nil, 11, _ORANGE_ )


	return InfoGroup
end

local function destroyInfoMeter()
	Runtime:removeEventListener( "enterFrame", InfoGroup )

	InfoGroup = nil

end

-- ==
--    pLog METER
-- ==

--[[ EFM Disabled till I can fix this on all devices

local pLogGroup
local pLogMeter
local pLogTextObj
local logFont = native.systemFont
local logFontSize = 12
local ploggingPaused = false
local pLogTextScale = 1

local function createpLogMeter( group, meterWidth, meterHeight )
	pLogGroup = display.newGroup()
	pLogMeter = display.newGroup()	
	barGroup:insert(pLogGroup)
	pLogGroup:insert(pLogMeter)

	local tmpXScale = meterWidth/444
	local tmpYScale = meterHeight/144

	--local tmp = display.newRect( pLogMeter, 4, 4, 348, 100 )
	--tmp:setFillColor(32,32,32)

	pLogTextObj = display.newText(pLogMeter, "", 4,4, logFont, logFontSize)
	if(not pLogEnabled) then		
		pLogTextObj.text = "Print Logging Disabled\n\n" .. 
		                   "To enable, add this code before creating meter:\n\n" ..
						   "rgmeter.enablePrintLogging( true )"
		pLogTextObj.x =  pLogTextObj.xScale * pLogTextObj.width /2 + 4
		pLogTextObj.y = pLogTextObj.yScale * pLogTextObj.height/2 + 4 --100 - pLogTextObj.yScale * pLogTextObj.height/2 - 4
	end
	
	
	local mask = graphics.newMask( "rgmeter/mask3.png")
	pLogMeter:setMask( mask )
	pLogMeter.maskX = 175
	pLogMeter.maskY = 50

	pLogMeter.xScale = pLogTextScale * meterWidth/444
	pLogMeter.yScale = pLogTextScale * meterHeight/144

	pLogTextObj.x0Scale = pLogTextObj.xScale
	pLogTextObj.y0Scale = pLogTextObj.yScale
	
	-- Add buttons to pause output, increase/decrease font size
	--
	local pauseButton
	local scaleText
	local scaleMinusButton
	local scalePlusButton
	local function onTouch( self, event )
		if(event.phase == "ended") then
			if(self == pauseButton) then
				ploggingPaused = not ploggingPaused
				if(ploggingPaused) then
					self:setFillColor(255,0,0,128)
				else
					self:setFillColor(0,0,0)
				end
			
			elseif(self == scaleMinusButton) then
				pLogTextScale = pLogTextScale - 0.1
				if( pLogTextScale < 0.1) then pLogTextScale = 0.1 end
				scaleText.text = pLogTextScale
				
				pLogTextObj.xScale = pLogTextObj.x0Scale * pLogTextScale
				pLogTextObj.yScale = pLogTextObj.y0Scale * pLogTextScale


			elseif(self == scalePlusButton) then
				pLogTextScale = pLogTextScale + 0.1
				if( pLogTextScale > 2) then pLogTextScale = 2 end
				scaleText.text = pLogTextScale

				pLogTextObj.xScale = pLogTextObj.x0Scale * pLogTextScale
				pLogTextObj.yScale = pLogTextObj.y0Scale * pLogTextScale

			end
		end

		return true
	end

	pauseButton = display.newRect( pLogGroup, meterWidth - 70 * tmpXScale, 10 * tmpYScale, 60 * tmpXScale, 20 * tmpYScale )
	--pauseButton.x = centerX - 120
	--pauseButton.y = centerY + 70
	pauseButton:setStrokeColor(255,255,255)
	if(ploggingPaused) then
		pauseButton:setFillColor(255,0,0,128)
	else
		pauseButton:setFillColor(0,0,0)
	end
	pauseButton.strokeWidth = 1
	pauseButton.myMeter = meters.fps
	pauseButton.label = display.newText( pLogGroup, "Pause", 0, 0, native.systemFont, 12 * fontSM )
	pauseButton.label:setTextColor(255,255,255)
	pauseButton.label.x = pauseButton.x
	pauseButton.label.y = pauseButton.y
	pauseButton.touch = onTouch
	pauseButton:addEventListener( "touch", pauseButton )

	scaleMinusButton = display.newRect( pLogGroup, meterWidth - 70 * tmpXScale, 40 * tmpYScale, 60 * tmpXScale, 20 * tmpYScale )
	--scaleMinusButton.x = centerX - 120
	--scaleMinusButton.y = centerY + 70
	scaleMinusButton:setStrokeColor(255,255,255)
	scaleMinusButton:setFillColor(0,0,0)
	scaleMinusButton.strokeWidth = 1
	scaleMinusButton.myMeter = meters.fps
	scaleMinusButton.label = display.newText( pLogGroup, "Scale -", 0, 0, native.systemFont, 12 * fontSM )
	scaleMinusButton.label:setTextColor(255,255,255)
	scaleMinusButton.label.x = scaleMinusButton.x
	scaleMinusButton.label.y = scaleMinusButton.y
	scaleMinusButton.touch = onTouch
	scaleMinusButton:addEventListener( "touch", scaleMinusButton )

	scaleText = display.newText( pLogGroup, pLogTextScale, 0, 0, native.systemFont, 12 * fontSM )
	scaleText.x = scaleMinusButton.x
	scaleText.y = scaleMinusButton.y + 20 * tmpYScale

	scalePlusButton = display.newRect( pLogGroup, meterWidth - 70 * tmpXScale, 80 * tmpYScale, 60 * tmpXScale, 20 * tmpYScale )
	--scalePlusButton.x = centerX - 120
	--scalePlusButton.y = centerY + 70
	scalePlusButton:setStrokeColor(255,255,255)
	scalePlusButton:setFillColor(0,0,0)
	scalePlusButton.strokeWidth = 1
	scalePlusButton.myMeter = meters.fps
	scalePlusButton.label = display.newText( pLogGroup, "Scale +", 0, 0, native.systemFont, 12 * fontSM )
	scalePlusButton.label:setTextColor(255,255,255)
	scalePlusButton.label.x = scalePlusButton.x
	scalePlusButton.label.y = scalePlusButton.y
	scalePlusButton.touch = onTouch
	scalePlusButton:addEventListener( "touch", scalePlusButton )

	local function onDrag( self, event )
		if(event.phase == "began") then
			display.getCurrentStage():setFocus(event.target, event.id)
			self.x0 = self.x
			self.y0 = self.y
			self.inDrag = true

		elseif(event.phase == "moved" and self.inDrag ) then
			self.x = self.x0 + event.x - event.xStart
			self.y = self.y0 + event.y - event.yStart

		elseif(event.phase == "ended" and self.inDrag ) then
			display.getCurrentStage():setFocus(event.target, nil)
			self.x = self.x0 + event.x - event.xStart
			self.y = self.y0 + event.y - event.yStart
		
			self.inDrag = false
		end
		return true
	end
	pLogTextObj.touch = onDrag
	pLogTextObj:addEventListener( "touch", pLogTextObj )



	return pLogGroup
end

local function destroypLogMeter()
	Runtime:removeEventListener( "enterFrame", pLogGroup )

	pLogGroup = nil
	pLogMeter = nil

end
--]]


local shrinkToX = w - 40
local shrinkToY = h - 40

local function onShrink( self, event )
	if(event.phase == "ended") then
		barGroup.xScaleStart = barGroup.xScale
		barGroup.yScaleStart = barGroup.yScale

		barGroup.xHideStart = barGroup.x
		barGroup.yHideStart = barGroup.y

		--barGroup.icon.alpha = 1
		local xScale = 40 / (barGroup.w0/barGroup.xScale)
		local yScale = 40 / (barGroup.h0/barGroup.yScale)
		--print(xScale,yScale)
		transition.to(barGroup, {x = shrinkToX, y = shrinkToY, xScale = xScale, yScale = yScale, time = 250 } )
		transition.to(barGroup.icon, { alpha = 1, time = 250 } )

		barGroup.icon.touch = function(self, event)
			if(event.phase == "began") then
				display.getCurrentStage():setFocus(event.target, event.id)
				barGroup.x0 = barGroup.x
				barGroup.y0 = barGroup.y				

			elseif(event.phase == "moved" ) then
				if( event.x < leftBuffer or event.x  > rightBuffer or event.y < topBuffer or event.y > botBuffer ) then
					return true
				end

				if( not self.inDrag ) then
					local dx = event.x - event.xStart
					local dy = event.y - event.yStart

					if(dx * dx + dy * dy >= 100) then	
						self.inDrag = true
					end
				end

				if( self.inDrag ) then
					barGroup.x = barGroup.x0 + event.x - event.xStart
					barGroup.y = barGroup.y0 + event.y - event.yStart
				end

			elseif(event.phase == "ended" ) then
				display.getCurrentStage():setFocus(event.target, nil)

				if( not self.inDrag ) then
					shrinkToX = barGroup.x
					shrinkToY = barGroup.y
					self:removeEventListener( "touch", barGroup.icon )
					transition.to(barGroup, { x = barGroup.xHideStart, y = barGroup.yHideStart, xScale = barGroup.xScaleStart, yScale = barGroup.yScaleStart, time = 250 } )
					transition.to(barGroup.icon, { alpha = 0, time = 250 } )
				end

				self.inDrag = false
			end
			return true		
		end
		barGroup.icon:addEventListener( "touch", barGroup.icon )

	end

	return true
end


local function onTouch( self, event )
	if(event.phase == "ended") then

		for k,v in pairs(meters) do
			v.isVisible = false
		end

		for i = 1, #buttons do
			buttons[i]:setFillColor(0,0,0)
		end

		self:setFillColor(96,96,96)
		self.myMeter.isVisible = true

	end

	return true
end

local function onDrag( self, event )
	if(event.phase == "began") then
		display.getCurrentStage():setFocus(event.target, event.id)
		self.x0 = self.x
		self.y0 = self.y
		self.inDrag = true

	elseif(event.phase == "moved" and self.inDrag ) then
		if( event.x < leftBuffer or event.x  > rightBuffer or event.y < topBuffer or event.y > botBuffer ) then
			return true
		end
		self.x = self.x0 + event.x - event.xStart
		self.y = self.y0 + event.y - event.yStart

	elseif(event.phase == "ended" and self.inDrag ) then
		display.getCurrentStage():setFocus(event.target, nil)

		if( event.x < leftBuffer or event.x  > rightBuffer or event.y < topBuffer or event.y > botBuffer ) then
			return true
		end
		self.x = self.x0 + event.x - event.xStart
		self.y = self.y0 + event.y - event.yStart
		
		self.inDrag = false
	end
	return true
end

local function create( ... )

	local group
	local meterX = centerX
	local meterY = centerY
	local meterWidth = 444
	local meterHeight = 144

	oldFontSM = fontSM

	local firstArg = arg[1]
	if(firstArg and type(firstArg) == "table" and firstArg.insert ) then
		group = arg[1]
		meterX = arg[2] or meterX
		meterY = arg[3] or meterY
		meterWidth = arg[4] or meterWidth
		meterHeight = arg[5] or meterHeight * meterWidth/444 -- retain scale if not specified
	else
		group = display.getCurrentStage()
		meterX = arg[1] or meterX
		meterY = arg[2] or meterY
		meterWidth = arg[3] or meterWidth
		meterHeight = arg[4]  or meterHeight * meterWidth/444 -- retain scale if not specified
	end

	local meterXScale = meterWidth/444
	local meterYScale = meterHeight/144
	if(meterXScale > meterYScale) then
		fontSM = meterXScale * fontSM
	else
		fontSM = meterYScale * fontSM
	end

	barGroup = display.newGroup()

	if(group) then
		group:insert( barGroup )
	end

	--local backGround = display.newRect( barGroup, 0, 0, barGroup.width + 60, barGroup.height + 40 )
	local backGround = display.newRect( barGroup, 0, 0, meterWidth-2, meterHeight-2 )
	--backGround.x =  centerX + 50
	--backGround.y = centerY + 18
	backGround:setStrokeColor( unpack(_LIGHTGREY_) )
	backGround:setFillColor(16,16,16)
	backGround.strokeWidth = 2

barGroup:setReferencePoint( display.CenterReferencePoint )
	meters = {}
	buttons = {}

	meters.fps = createFPSMeter( group, meterWidth, meterHeight )
	meters.mainMem = createMainMemMeter( group, meterWidth, meterHeight )
	meters.vidMem = createVidMemMeter( group, meterWidth, meterHeight )
	meters.Info = createInfoMeter( group, meterWidth, meterHeight )
--	meters.pLog = createpLogMeter( group, meterWidth, meterHeight )

	--meters.fps.isVisible = false
	meters.mainMem.isVisible = false
	meters.vidMem.isVisible = false
	meters.Info.isVisible = false
--	meters.pLog.isVisible = false

	

	local bWidth  = meterWidth/6 - 10
	local bHeight = meterHeight / 6
	local tween   = (meterWidth - (4 * bWidth))/12
	local left    = tween/2
	local top     = meterHeight - bHeight - meterHeight/16

	--print( left, top, bWidth, bHeight )

	local fpsButton = display.newRect( barGroup, left, top, bWidth, bHeight )
	--fpsButton.x = centerX - 120
	--fpsButton.y = centerY + 70
	fpsButton:setStrokeColor(255,0,0)
	fpsButton:setFillColor(96,96,96)
	fpsButton.strokeWidth = 1
	fpsButton.myMeter = meters.fps
	fpsButton.label = display.newText( barGroup, "FPS", 0, 0, native.systemFont, 11 * fontSM )
	fpsButton.label:setTextColor(255,0,0)
	fpsButton.label.x = fpsButton.x
	fpsButton.label.y = fpsButton.y
	buttons[#buttons+1] = fpsButton
	fpsButton.touch = onTouch
	fpsButton:addEventListener( "touch", fpsButton )

	left = left + tween + bWidth

	local mainMemButton = display.newRect( barGroup, left, top, bWidth, bHeight )
	--mainMemButton.x = centerX - 20
	--mainMemButton.y = centerY + 70
	mainMemButton:setStrokeColor(0,255,0)
	mainMemButton:setFillColor(0,0,0)
	mainMemButton.strokeWidth = 1
	mainMemButton.myMeter = meters.mainMem
	mainMemButton.label = display.newText( barGroup, "MainMem", 0, 0, native.systemFont, 11 * fontSM )
	mainMemButton.label:setTextColor(0,255,0)
	mainMemButton.label.x = mainMemButton.x
	mainMemButton.label.y = mainMemButton.y
	buttons[#buttons+1] = mainMemButton
	mainMemButton.touch = onTouch
	mainMemButton:addEventListener( "touch", mainMemButton )

	left = left + tween + bWidth

	local vidMemButton = display.newRect( barGroup, left, top, bWidth, bHeight )
	--vidMemButton.x = centerX + 80
	--vidMemButton.y = centerY + 70
	vidMemButton:setStrokeColor(0,255,255)
	vidMemButton:setFillColor(0,0,0)
	vidMemButton.strokeWidth = 1
	vidMemButton.myMeter = meters.vidMem
	vidMemButton.label = display.newText( barGroup, "VideoMem", 0, 0, native.systemFont, 11 * fontSM )
	vidMemButton.label:setTextColor(0,255,255)
	vidMemButton.label.x = vidMemButton.x
	vidMemButton.label.y = vidMemButton.y
	buttons[#buttons+1] = vidMemButton
	vidMemButton.touch = onTouch
	vidMemButton:addEventListener( "touch", vidMemButton )

	left = left + tween + bWidth

	local InfoButton = display.newRect( barGroup, left, top, bWidth, bHeight )
	--InfoButton.x = centerX + 180
	--InfoButton.y = centerY + 70
	InfoButton:setStrokeColor(0xff, 0x66, 0)
	InfoButton:setFillColor(0,0,0)
	InfoButton.strokeWidth = 1
	InfoButton.myMeter = meters.Info
	InfoButton.label = display.newText( barGroup, "Info", 0, 0, native.systemFont, 11 * fontSM )
	InfoButton.label:setTextColor(0xff, 0x66, 0)
	InfoButton.label.x = InfoButton.x
	InfoButton.label.y = InfoButton.y
	buttons[#buttons+1] = InfoButton
	InfoButton.touch = onTouch
	InfoButton:addEventListener( "touch", InfoButton )

	left = left + tween + bWidth
--[[
	local pLogButton = display.newRect( barGroup, left, top, bWidth, bHeight )
	--pLogButton.x = centerX + 180
	--pLogButton.y = centerY + 70
	pLogButton:setStrokeColor(255,255,255)
	pLogButton:setFillColor(0,0,0)
	pLogButton.strokeWidth = 1
	pLogButton.myMeter = meters.pLog
	pLogButton.label = display.newText( barGroup, "Log", 0, 0, native.systemFont, 11 * fontSM )
	pLogButton.label:setTextColor(255,255,255)
	pLogButton.label.x = pLogButton.x
	pLogButton.label.y = pLogButton.y
	buttons[#buttons+1] = pLogButton
	pLogButton.touch = onTouch
	pLogButton:addEventListener( "touch", pLogButton )
--]]

	left = meterWidth - tween/2 - bHeight

	local shrinkButton = display.newRect( barGroup, left, top, bHeight, bHeight )
	--shrinkButton.x = centerX + 180
	--shrinkButton.y = centerY + 70
	shrinkButton:setStrokeColor(255,255,255)
	shrinkButton:setFillColor(0,0,0)
	shrinkButton.strokeWidth = 1
	shrinkButton.myMeter = meters.pLog
	shrinkButton.label = display.newText( barGroup, "-", 0, 0, native.systemFont, 11 * fontSM )
	shrinkButton.label:setTextColor(255,255,255)
	shrinkButton.label.x = shrinkButton.x
	shrinkButton.label.y = shrinkButton.y
	buttons[#buttons+1] = shrinkButton
	shrinkButton.touch = onShrink
	shrinkButton:addEventListener( "touch", shrinkButton )

	local tmp = display.newImageRect( barGroup, "rgmeter/icon.png", meterWidth, meterHeight)
	tmp.x = meterWidth/2
	tmp.y = meterHeight/2
	tmp.alpha = 0
	barGroup.icon = tmp

	barGroup.touch = onDrag
	barGroup:addEventListener( "touch", barGroup )

	barGroup.x = meterX
	barGroup.y = meterY

	barGroup.w0 = barGroup.width
	barGroup.h0 = barGroup.height


	return barGroup
end

local function destroy()

	destroyFPSMeter()
	destroyMainMemMeter()
	destroyVidMemMeter()

	barGroup:removeSelf()
	barGroup = nil

	meters = nil
	buttons = nil

	fontSM =  oldFontSM
end

public = {}
public.create = create
public.destroy = destroy

public.setAverageWindow = function( size )
	if(not size or size < 1) then	
		averageWindow = 30
	else
		averageWindow = size
	end
end

public.setUpdatePeriod = function( period )
	if(not period or period < 1) then	
		updatePeriod = 1
	else
		updatePeriod = period
	end
end

public.setMaxMainMem = function( size )
	if(not size or size < 1) then	
		maxMainMem = 2048 -- KB ( i.e. 2MB)
	else
		maxMainMem = size
	end

	targetMainMem = maxMainMem
end

public.setMaxVidMem = function( size )
	if(not size or size < 1) then	
		maxVidMem = system.getInfo( "maxTextureSize" )
	else
		maxVidMem = size
	end

	targetVidMem = maxVidMem
end

public.enableCollection = function( enable )
	allowCollect = enable or false
end

public.setFontScale = function( scale )
	fontSM = scale * fontSM or 1
end

public.setLoggingFont = function( font )
	logFont = font
end

public.setLoggingFontSize = function( size )
	logFontSize = size
end

public.pauseLogging = function( pause )
	ploggingPaused = pause
end

public.enablePrintLogging = function( enable, limit )

--[[ EFM disabled till I can fix print logging on all devices

	if(limit) then 
		pLogLimit = limit 
		if(pLogLimit > pLogMax) then
			pLogLimit = pLogMax
		end
		if(pLogLimit < 1 ) then 
			pLogLimit = 1
		end
	end

	if( not pLogEnabled ) then
		pLogEnabled = true
		oldPrint = _G.print
		printLog = {}

		local newPrint = function( ... )
			oldPrint( unpack(arg) )

			local tmp = ""
			for i = 1, #arg do
				tmp = tmp .. tostring(arg[i]) .. " "				
			end
			printLog[#printLog+1] = tmp

			if(#printLog > pLogLimit) then
				table.remove( printLog, 1 )
			end
			if(pLogTextObj and not ploggingPaused) then
				pLogTextObj.text = ""
				local startLine = 1
				for i = 1, #printLog do
					pLogTextObj.text = pLogTextObj.text .. printLog[i] .. "\n"
				end
				pLogTextObj.x =  pLogTextObj.xScale * pLogTextObj.width /2 + 4
				pLogTextObj.y =  100 - pLogTextObj.yScale * pLogTextObj.height/2 - 4

			end
		end

		_G.print = newPrint
				
	else
		pLogEnabled = false
		_G.print = oldPrint		
	end
--]]
end


return public
