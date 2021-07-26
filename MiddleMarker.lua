local addonName, QOLUtils = ...

QOLUtils.MM = {}
local mm = QOLUtils.MM
local feature = 'MM'
local configAcct, configToon, storage

function mm.Load()
	configAcct = QOL_Config_Acct.MM
	configToon = QOL_Config_Toon.MM
	storage = QOLUtils.OPT.Storage.MM
	mm.CreateMMFrame()
end

function mm.IsEnabled()
	return QOLUtils.SettingIsTrue(feature, 'Enabled')
end

function mm.CheckBoxEnabled_OnClick()
	local config = QOL_Config_Toon.Active and configToon or configAcct
	local enabled = storage.CheckBoxEnabled:GetChecked()
	config.Enabled = enabled
	if not enabled then
		mm.ShowMiddleMarker = false
		mm.HideMarkers()
	end
end

mm.ShowMiddleMarker = false

function mm.ToggleMiddleMarker()
	mm.ShowMiddleMarker = not mm.ShowMiddleMarker
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
	table.insert(mm.Lines, mm.CreateLine(widthMiddle, screenHeight, widthMiddle, screenHeight - verticalLineLength, screenWidth))
	table.insert(mm.Lines, mm.CreateLine(widthMiddle, 0, widthMiddle, verticalLineLength, screenWidth))
	table.insert(mm.Lines, mm.CreateLine(0, heightMiddle, horizontalLineLength, heightMiddle, screenHeight))
	table.insert(mm.Lines, mm.CreateLine(screenWidth, heightMiddle, screenWidth - horizontalLineLength, heightMiddle, screenHeight))
	mm.MMFrame:Hide()
end

function mm.CreateLine(startX, startY, endX, endY, maxThickness)
	local line = mm.MMFrame:CreateLine(nil, 'BACKGROUND')
	line:SetStartPoint('BOTTOMLEFT', startX, startY)
	line:SetEndPoint('BOTTOMLEFT', endX, endY)
	line:SetColorTexture(1, 0, 0, 0.4)
	line.QOL_MaxThickness = maxThickness
	line:SetThickness(line.QOL_MaxThickness * ((QOL_Config_Toon.Active and QOL_Config_Toon.MM.Thickness or QOL_Config_Acct.MM.Thickness) / 100))
	return line
end

function mm.ShowMarkers()
	mm.MMFrame:Show()
end

function mm.HideMarkers()
	mm.MMFrame:Hide()
end

function mm.SliderRed_OnValueChanged(self, value, byUser)
	mm.Slider_OnValueChanged(value, byUser, 'EditBoxRed', 'Red')
end

function mm.SliderGreen_OnValueChanged(self, value, byUser)
	mm.Slider_OnValueChanged(value, byUser, 'EditBoxGreen', 'Green')
end

function mm.SliderBlue_OnValueChanged(self, value, byUser)
	mm.Slider_OnValueChanged(value, byUser, 'EditBoxBlue', 'Blue')
end

function mm.SliderAlpha_OnValueChanged(self, value, byUser)
	mm.Slider_OnValueChanged(value, byUser, 'EditBoxAlpha', 'Alpha')
end

function mm.SliderThickness_OnValueChanged(self, value, byUser)
	mm.Slider_OnValueChanged(value, byUser, 'EditBoxThickness', 'Thickness')
end

function mm.Slider_OnValueChanged(value, byUser, editBox, setting)
	if byUser then
		storage[editBox]:SetText(format(QOLUtils.Formats.NumberPrecision2, value))
		storage[editBox]:SetCursorPosition(0)
		mm.UpdateSetting(setting, value)
	end
end

function mm.EditBoxRed_OnEditFocusLost(self)
	mm.EditBox_OnEditFocusLost(self, storage.SliderRed, 'Red')
end

function mm.EditBoxGreen_OnEditFocusLost(self)
	mm.EditBox_OnEditFocusLost(self, storage.SliderGreen, 'Green')
end

function mm.EditBoxBlue_OnEditFocusLost(self)
	mm.EditBox_OnEditFocusLost(self, storage.SliderBlue, 'Blue')
end

function mm.EditBoxAlpha_OnEditFocusLost(self)
	mm.EditBox_OnEditFocusLost(self, storage.SliderAlpha, 'Alpha')
end

function mm.EditBoxThickness_OnEditFocusLost(self)
	mm.EditBox_OnEditFocusLost(self, storage.SliderThickness, 'Thickness')
end

function mm.EditBox_OnEditFocusLost(editBox, slider, setting)
	local value = mm.GetEditBoxNum(editBox, slider)
	slider:SetValue(value)
	editBox:SetText(format(QOLUtils.Formats.NumberPrecision2, value))
	editBox:SetCursorPosition(0)
	mm.UpdateSetting(setting, value)
end

function mm.GetEditBoxNum(editBox, slider)
	local value = slider:GetValue()
	if editBox then
		local nums = QOLUtils.StrToTable(editBox:GetText(), QOLUtils.Patterns.Decimals)
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
	if configAcct and configToon then
		local config = QOL_Config_Toon.Active and configToon or configAcct
		local red = config.Red / 100
		local green = config.Green / 100
		local blue = config.Blue / 100
		local alpha = config.Alpha / 100
		local thickness = config.Thickness / 100
		for k, line in pairs(mm.Lines) do
			line:SetColorTexture(red, green, blue, alpha)
			line:SetThickness(line.QOL_MaxThickness * thickness)
		end
		for k, line in pairs(storage.PreviewLines) do
			line:SetColorTexture(red, green, blue, alpha)
			local finalThickness = line.QOL_MaxThickness * thickness
			line:SetThickness(finalThickness < 1 and 1 or finalThickness)
		end
	end
end