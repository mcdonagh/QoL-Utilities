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
	if QOL_Config_Toon.Active then
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
	mm.Lines = {}
	table.insert(mm.Lines, mm.CreateLine(widthMiddle, screenHeight, widthMiddle, screenHeight - verticalLineLength))
	table.insert(mm.Lines, mm.CreateLine(widthMiddle, 0, widthMiddle, verticalLineLength))
	table.insert(mm.Lines, mm.CreateLine(0, heightMiddle, horizontalLineLength, heightMiddle))
	table.insert(mm.Lines, mm.CreateLine(screenWidth, heightMiddle, screenWidth - horizontalLineLength, heightMiddle))
	mm.MMFrame:Hide()
end

function mm.CreateLine(startX, startY, endX, endY)
	local line = mm.MMFrame:CreateLine(nil, 'BACKGROUND')
	line:SetStartPoint('BOTTOMLEFT', startX, startY)
	line:SetEndPoint('BOTTOMLEFT', endX, endY)
	line:SetColorTexture(1, 0, 0, 0.4)
	line:SetThickness(3)
	return line
end

function mm.ShowMarkers()
	mm.MMFrame:Show()
end

function mm.HideMarkers()
	mm.MMFrame:Hide()
end

function mm.SliderChangedRed(self, value, byUser)
	if byUser then
		storage.EditBoxRed:SetText(tostring(value))
		if QOL_Config_Toon.Active then
			configToon.Red = value
			mm.UpdateLines(configToon)
		else
			configAcct.Red = value
			mm.UpdateLines(configAcct)
		end
	end
end

function mm.SliderChangedGreen()
	if byUser then
		storage.EditBoxRed:SetText(tostring(value))
		if QOL_Config_Toon.Active then
			configToon.Green = value
			mm.UpdateLines(configToon)
		else
			configAcct.Green = value
			mm.UpdateLines(configAcct)
		end
	end
end

function mm.SliderChangedBlue()
	if byUser then
		storage.EditBoxRed:SetText(tostring(value))
		if QOL_Config_Toon.Active then
			configToon.Blue = value
			mm.UpdateLines(configToon)
		else
			configAcct.Blue = value
			mm.UpdateLines(configAcct)
		end
	end
end

function mm.SliderChangedAlpha()
	if byUser then
		storage.EditBoxRed:SetText(tostring(value))
		if QOL_Config_Toon.Active then
			configToon.Alpha = value
			mm.UpdateLines(configToon)
		else
			configAcct.Alpha = value
			mm.UpdateLines(configAcct)
		end
	end
end

function mm.UpdateLines(config)
	for line in pairs(mm.Lines) do
		line:SetColorTexture(config.Red / 100, config.Green / 100, config.Blue / 100, config.Alpha / 100)
	end
end