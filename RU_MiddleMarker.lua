local markerOn = 0
local container = CreateFrame("Frame", nil, UIParent)

SLASH_MIDDLEMARKER1 = "/middlemarker"
SLASH_MIDDLEMARKER2 = "/mm"
SlashCmdList["MIDDLEMARKER"] = function (msg)
	markerOn = (markerOn + 1) % 2
	if markerOn == 1 then
		DrawMarkers()
	else
		HideMarkers()
	end
end

function DrawMarkers()
	container = CreateFrame("Frame", nil, UIParent)
	container:SetAllPoints(UIParent)
	container:SetFrameStrata("BACKGROUND")
	container:SetFrameLevel(0)
	local screenWidth = GetScreenWidth()
	local screenHeight = GetScreenHeight()
	local widthMiddle = math.floor(screenWidth / 2)
	local heightMiddle = math.floor(screenHeight / 2)
	local verticalLineLength = math.floor(screenHeight / 3)
	local horizontalLineLength = math.floor(screenWidth / 3)
	local topMarker = container:CreateLine(nil, "BACKGROUND")
	
	topMarker:SetStartPoint("BOTTOMLEFT", widthMiddle, screenHeight)
	topMarker:SetEndPoint("BOTTOMLEFT", widthMiddle, screenHeight - verticalLineLength)
	topMarker:SetColorTexture(1, 0, 0, 0.4)
	topMarker:SetThickness(3)
	
	local bottomMarker = container:CreateLine(nil, "BACKGROUND")
	bottomMarker:SetStartPoint("BOTTOMLEFT", widthMiddle, 0)
	bottomMarker:SetEndPoint("BOTTOMLEFT", widthMiddle, verticalLineLength)
	bottomMarker:SetColorTexture(1, 0, 0, 0.4)
	bottomMarker:SetThickness(3)
	
	local leftMarker = container:CreateLine(nil, "BACKGROUND")
	leftMarker:SetStartPoint("BOTTOMLEFT", 0, heightMiddle)
	leftMarker:SetEndPoint("BOTTOMLEFT", horizontalLineLength, heightMiddle)
	leftMarker:SetColorTexture(1, 0, 0, 0.4)
	leftMarker:SetThickness(3)
	
	local rightMarker = container:CreateLine(nil, "BACKGROUND")
	rightMarker:SetStartPoint("BOTTOMLEFT", screenWidth, heightMiddle)
	rightMarker:SetEndPoint("BOTTOMLEFT", screenWidth - horizontalLineLength, heightMiddle)
	rightMarker:SetColorTexture(1, 0, 0, 0.4)
	rightMarker:SetThickness(3)
	
	container:Show(self)
end

function HideMarkers()
	container:Hide(self)
end