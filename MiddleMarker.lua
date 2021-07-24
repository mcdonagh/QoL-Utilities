local addonName, QOLUtils = ...

QOLUtils.MM = {}
local mm = QOLUtils.MM
local configAcct = QOL_Config_Acct.MM
local configToon = QOL_Config_Toon.MM
local storage = QOLUtils.OPT.Storage.MM

function mm.IsEnabled()
	return QOLUtils.SettingIsTrue(configAcct.Enabled, configToon.Enabled)
end

function mm.ToggleEnabled()
	if configToon.Active then
		configToon.Enabled = storage.CheckBoxEnabled:GetChecked()
	else
		configAcct.Enabled = storage.CheckBoxEnabled:GetChecked()
	end
end

mm.InitialCreate = true
mm.ShowMiddleMarker = false

function mm.ToggleMiddleMarker()
	mm.ShowMiddleMarker = not mm.ShowMiddleMarker
	if mm.InitialCreate then
		mm.InitialCreate = false
		mm.CreateMMFrame()
	end
	if mm.ShowMiddleMarker then
		mm.ShowMarkers()
	else
		mm.HideMarkers()
	end
end

function mm.CreateMMFrame()
	mm.MMFrame = CreateFrame('Frame', nil, UIParent)
	mm.MMFrame:SetAllPoints(UIParent)
	mm.MMFrame:SetFrameStrata('BACKGROUND')
	mm.MMFrame:SetFrameLevel(0)
	local screenWidth = GetScreenWidth()
	local screenHeight = GetScreenHeight()
	local widthMiddle = math.floor(screenWidth / 2)
	local heightMiddle = math.floor(screenHeight / 2)
	local verticalLineLength = math.floor(screenHeight / 3)
	local horizontalLineLength = math.floor(screenWidth / 3)
	-- topMarker
	mm.CreateLine(widthMiddle, screenHeight, widthMiddle, screenHeight - verticalLineLength)
	-- bottomMarker
	mm.CreateLine(widthMiddle, 0, widthMiddle, verticalLineLength)	
	-- leftMarker
	mm.CreateLine(0, heightMiddle, horizontalLineLength, heightMiddle)	
	-- rightMarker
	mm.CreateLine(screenWidth, heightMiddle, screenWidth - horizontalLineLength, heightMiddle)
	mm.MMFrame:Hide()
end

function mm.CreateLine(startX, startY, endX, endY)
	local line = mm.MMFrame:CreateLine(nil, 'BACKGROUND')
	line:SetStartPoint('BOTTOMLEFT', startX, startY)
	line:SetEndPoint('BOTTOMLEFT', endX, endY)
	line:SetColorTexture(1, 0, 0, 0.4)
	line:SetThickness(3)
end

function mm.ShowMarkers()
	mm.MMFrame:Show()
end

function mm.HideMarkers()
	mm.MMFrame:Hide()
end
