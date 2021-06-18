local addonName, RU = ...

RU.CreateMiddleMarker = true
RU.ShowMiddleMarker = false

function RU.ToggleMiddleMarker()
	RU.ShowMiddleMarker = not RU.ShowMiddleMarker
	if RU.CreateMiddleMarker then
		RU.CreateMMFrame()
	end
	if RU.ShowMiddleMarker then
		RU.ShowMarkers()
	else
		RU.HideMarkers()
	end
end

function RU.CreateMMFrame()
	RU.MMFrame = CreateFrame('Frame', nil, UIParent)
	RU.MMFrame:SetAllPoints(UIParent)
	RU.MMFrame:SetFrameStrata('BACKGROUND')
	RU.MMFrame:SetFrameLevel(0)
	local screenWidth = GetScreenWidth()
	local screenHeight = GetScreenHeight()
	local widthMiddle = math.floor(screenWidth / 2)
	local heightMiddle = math.floor(screenHeight / 2)
	local verticalLineLength = math.floor(screenHeight / 3)
	local horizontalLineLength = math.floor(screenWidth / 3)
	-- topMarker
	RU.CreateLine(widthMiddle, screenHeight, widthMiddle, screenHeight - verticalLineLength)
	-- bottomMarker
	RU.CreateLine(widthMiddle, 0, widthMiddle, verticalLineLength)	
	-- leftMarker
	RU.CreateLine(0, heightMiddle, horizontalLineLength, heightMiddle)	
	-- rightMarker
	RU.CreateLine(screenWidth, heightMiddle, screenWidth - horizontalLineLength, heightMiddle)
	RU.CreateMiddleMarker = false
end

function RU.CreateLine(startX, startY, endX, endY)
	local line = RU.MMFrame:CreateLine(nil, 'BACKGROUND')
	line:SetStartPoint('BOTTOMLEFT', startX, startY)
	line:SetEndPoint('BOTTOMLEFT', endX, endY)
	line:SetColorTexture(1, 0, 0, 0.4)
	line:SetThickness(3)
end

function RU.ShowMarkers()
	RU.MMFrame:Show()
end

function RU.HideMarkers()
	RU.MMFrame:Hide()
end