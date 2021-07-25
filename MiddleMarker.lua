local addonName, QOLUtils = ...

QOLUtils.MM = {}
local mm = QOLUtils.MM
local configAcct = QOL_Config_Acct.MM
local configToon = QOL_Config_Toon.MM
local storage = QOLUtils.OPT.Storage.MM
local feature = 'MM'

function mm.IsEnabled()
	return QOLUtils.SettingIsTrue(feature, 'Enabled')
end

function mm.CheckBoxEnabled_OnClick()
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

function mm.SliderRed_OnValueChanged(self, value, byUser)
	if byUser then
		storage.EditBoxRed:SetText(tostring(value))
		mm.UpdateSetting('Red', value)
	end
end

function mm.SliderGreen_OnValueChanged(self, value, byUser)
	if byUser then
		storage.EditBoxGreen:SetText(tostring(value))
		mm.UpdateSetting('Green', value)
	end
end

function mm.SliderBlue_OnValueChanged(self, value, byUser)
	if byUser then
		storage.EditBoxBlue:SetText(tostring(value))
		mm.UpdateSetting('Blue', value)
	end
end

function mm.SliderAlpha_OnValueChanged(self, value, byUser)
	if byUser then
		storage.EditBoxAlpha:SetText(tostring(value))
		mm.UpdateSetting('Alpha', value)
	end
end

function mm.SliderThickness_OnValueChanged(self, value, byUser)
	if byUser then
		storage.EditBoxThickness:SetText(tostring(value))
		mm.UpdateSetting('Thickness', value)
	end
end

function mm.EditBoxRed_OnEditFocusLost(self)
	local value = mm.GetEditBoxNum(self, storage.SliderRed)
	storage.SliderRed:SetValue(value)
	self:SetText(tostring(value))
	mm.UpdateSetting('Red', value)
end

function mm.EditBoxGreen_OnEditFocusLost(self)
	local value = mm.GetEditBoxNum(self, storage.SliderGreen)
	storage.SliderGreen:SetValue(value)
	self:SetText(tostring(value))
	mm.UpdateSetting('Green', value)
end

function mm.EditBoxBlue_OnEditFocusLost(self)
	local value = mm.GetEditBoxNum(self, storage.SliderBlue)
	storage.SliderBlue:SetValue(value)
	self:SetText(tostring(value))
	mm.UpdateSetting('Blue', value)
end

function mm.EditBoxAlpha_OnEditFocusLost(self)
	local value = mm.GetEditBoxNum(self, storage.SliderAlpha)
	storage.SliderAlpha:SetValue(value)
	self:SetText(tostring(value))
	mm.UpdateSetting('Alpha', value)
end

function mm.EditBoxThickness_OnEditFocusLost(self)
	local value = mm.GetEditBoxNum(self, storage.SliderThickness)
	storage.SliderThickness:SetValue(value)
	self:SetText(tostring(value))
	mm.UpdateSetting('Thickness', value)
end

function mm.GetEditBoxNum(editBox, slider)
	local value = slider:GetValue()
	if editBox then
		local nums = QOLUtils.StrToTable(editBox:GetText(), QOLUtils.Patterns.Numbers)
		if nums and nums[1] then
			local num = tonumber(nums[1])
			if num >= 0 and num <= 100 then
				value = num
			end
		end
	end
	return value
end

function mm.UpdateSetting(setting, value)
	if QOL_Config_Toon.Active then
		configToon[setting] = value
	else
		configAcct[setting] = value
	end
	mm.UpdateLines()
end

function mm.UpdateLines()
	local config = QOL_Config_Toon.Active and configToon or configAcct
	local red = config.Red / 100
	local green = config.Green / 100
	local blue = config.Blue / 100
	local alpha = config.Alpha / 100
	local thickness = config.Thickness
	for line in pairs(mm.Lines) do
		line:SetColorTexture(red, green, blue, alpha)
		line:SetThickness(thickness)
	end
	for line in pairs(storage.PreviewLines) do
		line:SetColorTexture(red, green, blue, alpha)
		line:SetThickness(thickness)
	end
end