local addonName, RU = ...

RU.MM = {}
RU.MM.MM.CreateMiddleMarker = true
RU.MM.ShowMiddleMarker = false

function RU.MM.ToggleMiddleMarker()
	RU.MM.ShowMiddleMarker = not RU.MM.ShowMiddleMarker
	if RU.MM.CreateMiddleMarker then
		RU.MM.CreateMMFrame()
	end
	if RU.MM.ShowMiddleMarker then
		RU.MM.ShowMarkers()
	else
		RU.MM.HideMarkers()
	end
end

function RU.MM.CreateMMFrame()
	RU.MM.MMFrame = CreateFrame('Frame', nil, UIParent)
	RU.MM.MMFrame:SetAllPoints(UIParent)
	RU.MM.MMFrame:SetFrameStrata('BACKGROUND')
	RU.MM.MMFrame:SetFrameLevel(0)
	local screenWidth = GetScreenWidth()
	local screenHeight = GetScreenHeight()
	local widthMiddle = math.floor(screenWidth / 2)
	local heightMiddle = math.floor(screenHeight / 2)
	local verticalLineLength = math.floor(screenHeight / 3)
	local horizontalLineLength = math.floor(screenWidth / 3)
	-- topMarker
	RU.MM.CreateLine(widthMiddle, screenHeight, widthMiddle, screenHeight - verticalLineLength)
	-- bottomMarker
	RU.MM.CreateLine(widthMiddle, 0, widthMiddle, verticalLineLength)	
	-- leftMarker
	RU.MM.CreateLine(0, heightMiddle, horizontalLineLength, heightMiddle)	
	-- rightMarker
	RU.MM.CreateLine(screenWidth, heightMiddle, screenWidth - horizontalLineLength, heightMiddle)
	RU.MM.CreateMiddleMarker = false
end

function RU.MM.CreateLine(startX, startY, endX, endY)
	local line = RU.MM.MMFrame:CreateLine(nil, 'BACKGROUND')
	line:SetStartPoint('BOTTOMLEFT', startX, startY)
	line:SetEndPoint('BOTTOMLEFT', endX, endY)
	line:SetColorTexture(1, 0, 0, 0.4)
	line:SetThickness(3)
end

function RU.MM.ShowMarkers()
	RU.MM.MMFrame:Show()
end

function RU.MM.HideMarkers()
	RU.MM.MMFrame:Hide()
end
