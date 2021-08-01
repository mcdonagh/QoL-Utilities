local addonName, QOLUtils = ...

QOLUtils.OPT = {}
QOLUtils.OPT.Storage = {}
local opt = QOLUtils.OPT
local storage = opt.Storage
local spacing = QOLUtils.ConfigSpacing
local labels = QOLUtils.Labels
local points = QOLUtils.Points

function opt.LoadDefaults()
	if QOL_Config_Acct == nil then
		QOL_Config_Acct = QOL_Config or {}
	end
	opt.GenerateDefaults(QOL_Config_Acct)
	opt.SetupAttention()
	if QOL_Config_Toon == nil then
		QOL_Config_Toon = {}
	end
	opt.GenerateDefaults(QOL_Config_Toon)
	if QOL_Config_Toon.Active == nil then
		QOL_Config_Toon.Active = false
	end
end

function opt.SetupAttention()
	if QOL_Config_Acct.Attention == nil then
		QOL_Config_Acct.Attention = {}
	end
	if QOL_Config_Acct.Attention.FeatureEnabling == nil then
		QOL_Config_Acct.Attention.FeatureEnabling = 3
	end
end

function opt.GenerateDefaults(config)
	if config.ATC == nil then
		config.ATC = {}
	end
	if config.ATC.Enabled == nil then
		config.ATC.Enabled = true
	end
	if config.AT == nil then
		config.AT = {}
	end
	if config.AT.Enabled == nil then
		config.AT.Enabled = true
	end
	if config.AC == nil then
		config.AC = {}
	end
	if config.AC.Enabled == nil then
		config.AC.Enabled = true
	end
	if config.AC.ReportAtLogon == nil then
		config.AC.ReportAtLogon = true
	end
	if config.AC.RefundableActive == nil then
		config.AC.RefundableActive = false
	end
	if config.AC.TradeableActive == nil then
		config.AC.TradeableActive = false
	end
	if config.AC.BindableActive == nil then
		config.AC.BindableActive = false
	end
	if config.MM == nil then
		config.MM = {}
	end
	if config.MM.Enabled == nil then
		config.MM.Enabled = true
	end
	if config.MM.Red == nil then
		config.MM.Red = 100
	end
	if config.MM.Green == nil then
		config.MM.Green = 0
	end
	if config.MM.Blue == nil then
		config.MM.Blue = 0
	end
	if config.MM.Alpha == nil then
		config.MM.Alpha = 40
	end
	if config.MM.Thickness == nil then
		config.MM.Thickness = 0.3
	end
	if config.QM == nil then
		config.QM = {}
	end
	if config.QM.Enabled == nil then
		config.QM.Enabled = true
	end
	if config.QM.ReportAtLogon == nil then
		config.QM.ReportAtLogon = true
	end
	if config.QM.PartyActive == nil then
		config.QM.PartyActive = false
	end
	if config.QM.DuelActive == nil then
		config.QM.DuelActive = false
	end
	if config.SMN == nil then
		config.SMN = {}
	end
	if config.SMN.Enabled == nil then
		config.SMN.Enabled = true
	end
	if config.SMN.IgnoredMounts == nil then
		config.SMN.IgnoredMounts = {}
	end
	if config.SMN.OnlyFavoritePets == nil then
		config.SMN.OnlyFavoritePets = false
	end
	if config.SMN.OnlyFavoriteMounts == nil then
		config.SMN.OnlyFavoriteMounts = false
	end
	if config.SMN.ReportAtLogon == nil then
		config.SMN.ReportAtLogon = false
	end
	if config.VC == nil then
		config.VC = {}
	end
	if config.VC.Enabled == nil then
		config.VC.Enabled = false
	end
	if config.VC.Levels == nil then
		config.VC.Levels = {}
		table.insert(config.VC.Levels, 80)
		table.insert(config.VC.Levels, 20)
		table.insert(config.VC.Levels, 5)
	end
	if config.VC.Index == nil then
		config.VC.Index = 1
	end
end

function opt.LoadFeatures()
	QOLUtils.ATC.Load()
	QOLUtils.AT.Load()
	QOLUtils.AC.Load()
	QOLUtils.MM.Load()
	QOLUtils.QM.Load()
	QOLUtils.SMN.Load()
	QOLUtils.VC.Load()	
end

function opt.OpenConfig()
	InterfaceOptionsFrame_Show()
	InterfaceOptionsFrame_OpenToCategory(opt.Panel)
end

function opt.CreateConfig()
	local scroller, scrollchild = opt.CreateScrollFrame(labels.Header, UIParent)
	storage.CheckBoxToonActive = opt.CreateCheckBox(scrollchild, points.TL, scrollchild, points.TL, spacing.Indent, -spacing.GapHuge, labels.UseToon, opt.CheckBoxToonActive_OnClick)
	storage.ATC = {}
	local atcHeader = opt.CreateHeader(scrollchild, points.TL, storage.CheckBoxToonActive, points.BL, 0, -spacing.GapLarge, labels.ATC.Header)
	storage.ATC.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, points.TL, atcHeader, points.BL, spacing.Indent, -spacing.GapSmall, labels.Enabled, QOLUtils.ATC.CheckBoxEnabled_OnClick)
	storage.AT = {}
	local atHeader = opt.CreateHeader(scrollchild, points.TL, storage.ATC.CheckBoxEnabled, points.BL, -spacing.Indent, -spacing.GapMedium, labels.AT.Header)
	storage.AT.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, points.TL, atHeader, points.BL, spacing.Indent, -spacing.GapSmall, labels.Enabled, QOLUtils.AT.CheckBoxEnabled_OnClick)
	storage.AC = {}
	local acHeader = opt.CreateHeader(scrollchild, points.TL, storage.AT.CheckBoxEnabled, points.BL, -spacing.Indent, -spacing.GapMedium, labels.AC.Header)
	storage.AC.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, points.TL, acHeader, points.BL, spacing.Indent, -spacing.GapSmall, labels.Enabled, QOLUtils.AC.CheckBoxEnabled_OnClick)
	storage.AC.CheckBoxReport = opt.CreateCheckBox(scrollchild, points.TL, storage.AC.CheckBoxEnabled, points.BL, 0, -spacing.GapSmall, labels.AC.Report, QOLUtils.AC.CheckBoxReport_OnClick)
	storage.AC.CheckBoxRefundable = opt.CreateCheckBox(scrollchild, points.TL, storage.AC.CheckBoxReport, points.BL, 0, -spacing.GapSmall, labels.AC.Refundable, QOLUtils.AC.CheckBoxRefundable_OnClick)
	storage.AC.CheckBoxTradeable = opt.CreateCheckBox(scrollchild, points.TL, storage.AC.CheckBoxRefundable, points.BL, 0, -spacing.GapSmall, labels.AC.Tradeable, QOLUtils.AC.CheckBoxTradeable_OnClick)
	storage.AC.CheckBoxBindable = opt.CreateCheckBox(scrollchild, points.TL, storage.AC.CheckBoxTradeable, points.BL, 0, -spacing.GapSmall, labels.AC.Bindable, QOLUtils.AC.CheckBoxBindable_OnClick)
	storage.MM = {}
	local mmHeader = opt.CreateHeader(scrollchild, points.TL, storage.AC.CheckBoxBindable, points.BL, -spacing.Indent, -spacing.GapMedium, labels.MM.Header)
	storage.MM.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, points.TL, mmHeader, points.BL, spacing.Indent, -spacing.GapSmall, labels.Enabled, QOLUtils.MM.CheckBoxEnabled_OnClick)
	local rLabel = opt.CreateLabel(scrollchild, points.TL, storage.MM.CheckBoxEnabled, points.BL, 0, -spacing.GapMedium, labels.MM.Red)
	local gLabel = opt.CreateLabel(scrollchild, points.TL, rLabel, points.BL, 0, -spacing.Indent, labels.MM.Green)
	local bLabel = opt.CreateLabel(scrollchild, points.TL, gLabel, points.BL, 0, -spacing.Indent, labels.MM.Blue)
	local aLabel = opt.CreateLabel(scrollchild, points.TL, bLabel, points.BL, 0, -spacing.Indent, labels.MM.Alpha)
	local tLabel = opt.CreateLabel(scrollchild, points.TL, aLabel, points.BL, 0, -spacing.Indent, labels.MM.Thickness)
	local sliderX, sliderY, sliderPoint, sliderRelPoint = 15, 0, points.L, points.R
	local editBoxX, editBoxY, editBoxW, editBoxPoint, editBoxRelPoint = 20, 0, 50, points.L, points.R
	storage.MM.SliderRed = opt.CreateSlider(scrollchild, sliderPoint, rLabel, sliderRelPoint, sliderX, sliderY, QOLUtils.MM.SliderRed_OnValueChanged)
	storage.MM.SliderGreen = opt.CreateSlider(scrollchild, sliderPoint, gLabel, sliderRelPoint, sliderX, sliderY, QOLUtils.MM.SliderGreen_OnValueChanged)
	storage.MM.SliderBlue = opt.CreateSlider(scrollchild, sliderPoint, bLabel, sliderRelPoint, sliderX, sliderY, QOLUtils.MM.SliderBlue_OnValueChanged)
	storage.MM.SliderAlpha = opt.CreateSlider(scrollchild, sliderPoint, aLabel, sliderRelPoint, sliderX, sliderY, QOLUtils.MM.SliderAlpha_OnValueChanged)
	storage.MM.SliderThickness = opt.CreateSlider(scrollchild, sliderPoint, tLabel, sliderRelPoint, sliderX, sliderY, QOLUtils.MM.SliderThickness_OnValueChanged)
	storage.MM.EditBoxRed = opt.CreateEditBox(scrollchild, editBoxPoint, storage.MM.SliderRed, editBoxRelPoint, editBoxX, editBoxY, editBoxW, QOLUtils.MM.EditBoxRed_OnEditFocusLost)
	storage.MM.EditBoxGreen = opt.CreateEditBox(scrollchild, editBoxPoint, storage.MM.SliderGreen, editBoxRelPoint, editBoxX, editBoxY, editBoxW, QOLUtils.MM.EditBoxGreen_OnEditFocusLost)
	storage.MM.EditBoxBlue = opt.CreateEditBox(scrollchild, editBoxPoint, storage.MM.SliderBlue, editBoxRelPoint, editBoxX, editBoxY, editBoxW, QOLUtils.MM.EditBoxBlue_OnEditFocusLost)
	storage.MM.EditBoxAlpha = opt.CreateEditBox(scrollchild, editBoxPoint, storage.MM.SliderAlpha, editBoxRelPoint, editBoxX, editBoxY, editBoxW, QOLUtils.MM.EditBoxAlpha_OnEditFocusLost)
	storage.MM.EditBoxThickness = opt.CreateEditBox(scrollchild, editBoxPoint, storage.MM.SliderThickness, editBoxRelPoint, editBoxX, editBoxY, editBoxW, QOLUtils.MM.EditBoxThickness_OnEditFocusLost)
	storage.MM.Preview, storage.MM.PreviewLines = opt.CreatePreview(scrollchild, points.L, storage.MM.EditBoxBlue, points.R, 10, 0)
	storage.QM = {}
	local qmHeader = opt.CreateHeader(scrollchild, points.TL, tLabel, points.BL, -spacing.Indent, -spacing.GapLarge, labels.QM.Header)
	storage.QM.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, points.TL, qmHeader, points.BL, spacing.Indent, -spacing.GapSmall, labels.Enabled, QOLUtils.QM.CheckBoxEnabled_OnClick)
	storage.QM.CheckBoxReport = opt.CreateCheckBox(scrollchild, points.TL, storage.QM.CheckBoxEnabled, points.BL, 0, -spacing.GapSmall, labels.QM.Report, QOLUtils.QM.CheckBoxReport_OnClick)
	storage.QM.CheckBoxParty = opt.CreateCheckBox(scrollchild, points.TL, storage.QM.CheckBoxReport, points.BL, 0, -spacing.GapSmall, labels.QM.Party, QOLUtils.QM.CheckBoxParty_OnClick)
	storage.QM.CheckBoxDuel = opt.CreateCheckBox(scrollchild, points.TL, storage.QM.CheckBoxParty, points.BL, 0, -spacing.GapSmall, labels.QM.Duel, QOLUtils.QM.CheckBoxDuel_OnClick)
	storage.SMN = {}
	local smnHeader = opt.CreateHeader(scrollchild, points.TL, storage.QM.CheckBoxDuel, points.BL, -spacing.Indent, -spacing.GapMedium, labels.SMN.Header)
	storage.SMN.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, points.TL, smnHeader, points.BL, spacing.Indent, -spacing.GapSmall, labels.Enabled, QOLUtils.SMN.CheckBoxEnabled_OnClick)
	storage.SMN.CheckBoxReport = opt.CreateCheckBox(scrollchild, points.TL, storage.SMN.CheckBoxEnabled, points.BL, 0, -spacing.GapSmall, labels.SMN.Report, QOLUtils.SMN.CheckBoxReport_OnClick)
	storage.SMN.CheckBoxPets = opt.CreateCheckBox(scrollchild, points.TL, storage.SMN.CheckBoxReport, points.BL, 0, -spacing.GapSmall, labels.SMN.OnlyFavoritePets, QOLUtils.SMN.CheckBoxPets_OnClick)
	storage.SMN.CheckBoxMounts = opt.CreateCheckBox(scrollchild, points.TL, storage.SMN.CheckBoxPets, points.BL, 0, -spacing.GapSmall, labels.SMN.OnlyFavoriteMounts, QOLUtils.SMN.CheckBoxMounts_OnClick)
	local ignoredLabel = opt.CreateLabel(scrollchild, points.TL, storage.SMN.CheckBoxMounts, points.BL, 0, -spacing.GapSmall, labels.SMN.IgnoredList)
	local ignoredScroller, ignoredScrollChild = opt.CreateScrollFrame(labels.SMN.IgnoredList, scrollchild)
	local ignoredListHeight = 150
	ignoredScroller:SetSize(400, ignoredListHeight)
	ignoredScroller:SetPoint(points.TL, ignoredLabel, points.BL, spacing.Indent, -spacing.GapSmall)
	ignoredScrollChild:SetSize(290, 100)
	storage.SMN.IgnoredList = ignoredScrollChild
	storage.VC = {}
	local vcHeader = opt.CreateHeader(scrollchild, points.TL, ignoredScroller, points.BL, -spacing.Indent * 2, -spacing.GapMedium, labels.VC.Header)
	storage.VC.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, points.TL, vcHeader, points.BL, spacing.Indent, -spacing.GapSmall, labels.Enabled, QOLUtils.VC.CheckBoxEnabled_OnClick)
	local vcLabel = opt.CreateLabel(scrollchild, points.TL, storage.VC.CheckBoxEnabled, points.BL, 0, -spacing.GapMedium, labels.VC.Levels)
	storage.VC.EditBoxLevels = opt.CreateEditBox(scrollchild, points.TL, vcLabel, points.BL, spacing.Indent, 0, 200, opt.EditBoxLevels_OnEditFocusLost)
	opt.Panel = scroller
	InterfaceOptions_AddCategory(opt.Panel)
end

function opt.UpdateConfig()
	-- Character Specific CheckBox
	opt.UpdateCheckBox(storage.CheckBoxToonActive)
	-- Achievement Tracker Cleaner
	opt.UpdateCheckBox(storage.ATC.CheckBoxEnabled, 'ATC','Enabled')
	-- Announce Target
	opt.UpdateCheckBox(storage.AT.CheckBoxEnabled, 'AT','Enabled')
	-- Auto Confirm
	opt.UpdateCheckBox(storage.AC.CheckBoxEnabled, 'AC','Enabled')
	opt.UpdateCheckBox(storage.AC.CheckBoxReport, 'AC','ReportAtLogon')
	opt.UpdateCheckBox(storage.AC.CheckBoxRefundable, 'AC','RefundableActive')
	opt.UpdateCheckBox(storage.AC.CheckBoxTradeable, 'AC','TradeableActive')
	opt.UpdateCheckBox(storage.AC.CheckBoxBindable, 'AC','BindableActive')
	-- Middle Marker
	opt.UpdateCheckBox(storage.MM.CheckBoxEnabled, 'MM','Enabled')
	opt.UpdateSlider(storage.MM.SliderRed, 'MM', 'Red')
	opt.UpdateSlider(storage.MM.SliderGreen, 'MM', 'Green')
	opt.UpdateSlider(storage.MM.SliderBlue, 'MM', 'Blue')
	opt.UpdateSlider(storage.MM.SliderAlpha, 'MM', 'Alpha')
	-- opt.UpdateSlider(storage.MM.SliderThickness, 'MM', 'Thickness')
	opt.UpdateEditBoxWithNumber(storage.MM.EditBoxRed, 'MM', 'Red', QOLUtils.Formats.NumberPrecision2)
	opt.UpdateEditBoxWithNumber(storage.MM.EditBoxGreen, 'MM', 'Green', QOLUtils.Formats.NumberPrecision2)
	opt.UpdateEditBoxWithNumber(storage.MM.EditBoxBlue, 'MM', 'Blue', QOLUtils.Formats.NumberPrecision2)
	opt.UpdateEditBoxWithNumber(storage.MM.EditBoxAlpha, 'MM', 'Alpha', QOLUtils.Formats.NumberPrecision2)
	opt.UpdateEditBoxWithNumber(storage.MM.EditBoxThickness, 'MM', 'Thickness', QOLUtils.Formats.NumberPrecision2)
	opt.UpdatePreviewLines()
	QOLUtils.MM.UpdateLines()
	-- Quiet Mode
	opt.UpdateCheckBox(storage.QM.CheckBoxEnabled, 'QM','Enabled')
	opt.UpdateCheckBox(storage.QM.CheckBoxReport, 'QM','ReportAtLogon')
	opt.UpdateCheckBox(storage.QM.CheckBoxParty, 'QM','PartyActive')
	opt.UpdateCheckBox(storage.QM.CheckBoxDuel, 'QM','DuelActive')
	opt.UpdateIgnoredMounts()
	-- Summon
	opt.UpdateCheckBox(storage.SMN.CheckBoxEnabled, 'SMN','Enabled')
	opt.UpdateCheckBox(storage.SMN.CheckBoxReport, 'SMN','ReportAtLogon')
	opt.UpdateCheckBox(storage.SMN.CheckBoxPets, 'SMN','OnlyFavoritePets')
	opt.UpdateCheckBox(storage.SMN.CheckBoxMounts, 'SMN','OnlyFavoriteMounts')
	-- Volume Cycler
	opt.UpdateCheckBox(storage.VC.CheckBoxEnabled, 'VC','Enabled')
	opt.UpdateEditBox(storage.VC.EditBoxLevels, 'VC', 'Levels')
end

function opt.CreateScrollFrame(name, parent)
	local scroller = CreateFrame('Frame', 'QOL_Utils_Frame_' .. opt.GetUniqueID(), parent)
	scroller.name = name
	scroller.ScrollFrame = CreateFrame('ScrollFrame', 'QOL_Utils_ScrollFrame_' .. opt.GetUniqueID(), scroller, 'UIPanelScrollFrameTemplate')
	scroller.ScrollFrame:SetPoint('TOPLEFT', scroller, 'TOPLEFT')
	scroller.ScrollFrame:SetPoint('BOTTOMRIGHT', scroller, 'BOTTOMRIGHT')
	scroller.ScrollFrame.ScrollBar:ClearAllPoints()
	scroller.ScrollFrame.ScrollBar:SetPoint('TOPRIGHT', scroller.ScrollFrame, 'TOPRIGHT', -5, -22)
	scroller.ScrollFrame.ScrollBar:SetPoint('BOTTOMRIGHT', scroller.ScrollFrame, 'BOTTOMRIGHT', -5, 22)
	scroller.ScrollFrame.bg = scroller.ScrollFrame:CreateTexture(nil, 'BACKGROUND')
	scroller.ScrollFrame.bg:SetAllPoints(true)
	scroller.ScrollFrame.bg:SetColorTexture(0, 0, 0, 0.4)
	local scrollchild = CreateFrame('Frame', 'QOL_Utils_ScrollChild_' .. opt.GetUniqueID(), scroller.ScrollFrame)
	-----------------------------
	-- scrollchild.bg = scrollchild:CreateTexture(nil, 'BACKGROUND')
	-- scrollchild.bg:SetAllPoints(true)
	-- scrollchild.bg:SetColorTexture(0.4, 0, 0, 0.4)
	-----------------------------
	scrollchild:SetSize(400, 900)
	scrollchild:SetPoint('TOPLEFT', scroller.ScrollFrame, 'TOPLEFT', -30, 30)
	scroller.ScrollFrame:SetScrollChild(scrollchild)
	return scroller, scrollchild
end

function opt.CreateHeader(parent, point, relativeParent, relativePoint, x, y, text)
	local fontFrame = CreateFrame('Frame', 'QOL_Utils_FontFrame_' .. opt.GetUniqueID(), parent)
	fontFrame:SetPoint(point, relativeParent, relativePoint, x, y)
	fontFrame:SetSize(500, 10)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. opt.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function opt.CreateCheckBox(parent, point, relativeParent, relativePoint, x, y, text, callback)
	local checkBox = CreateFrame('CheckButton', 'QOLUtils_CheckBox_' .. opt.GetUniqueID(), parent, 'ChatConfigCheckButtonTemplate')
	checkBox:SetPoint(point, relativeParent, relativePoint, x, y)
	getglobal(checkBox:GetName() .. 'Text'):SetText(text)
	checkBox:SetScript('OnClick', callback)
	return checkBox
end

function opt.CreateLabel(parent, point, relativeParent, relativePoint, x, y, text)
	local fontFrame = CreateFrame('Frame', 'QOLUtils_FontFrame_' .. opt.GetUniqueID(), parent)
	fontFrame:SetPoint(point, relativeParent, relativePoint, x, y)
	fontFrame:SetSize(80, 10)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. opt.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function opt.CreateEditBox(parent, point, relativeParent, relativePoint, x, y, w, callback)
	local editBox = CreateFrame('EditBox', 'QOLUtils_EditBox_' .. opt.GetUniqueID(), parent, 'InputBoxTemplate')
	editBox:SetPoint(point, relativeParent, relativePoint, x, y)
	editBox:SetSize(w, 30)
	editBox:SetMultiLine(false)
	editBox:SetAutoFocus(false)
	editBox:SetCursorPosition(0)
	editBox:SetScript('OnEditFocusLost', callback)
	editBox:SetScript('OnEnterPressed', callback)
	return editBox
end

function opt.CreateSlider(parent, point, relativeParent, relativePoint, x, y, callback)
	local slider = CreateFrame('Slider', 'QOLUtils_Slider_' .. opt.GetUniqueID(), parent, 'OptionsSliderTemplate')
	slider:SetPoint(point, relativeParent, relativePoint, x, y)
	slider:SetSize(150, 20)
	slider:SetOrientation('HORIZONTAL')
	slider:SetMinMaxValues(0, 100)
	getglobal(slider:GetName() .. 'Low'):SetText('0')
	getglobal(slider:GetName() .. 'High'):SetText('100')
	slider:SetScript('OnValueChanged', callback)
	return slider
end

function opt.CreatePreview(parent, point, relativeParent, relativePoint, x, y)
	local preview = CreateFrame('Frame', 'QOL_Utils_Frame_' .. opt.GetUniqueID(), parent)
	preview:SetPoint(point, relativeParent, relativePoint, x, y)
	preview:SetSize(200, 150)
	-- scrollchild.bg = scrollchild:CreateTexture(nil, 'BACKGROUND')
	-- scrollchild.bg:SetAllPoints(true)
	-- scrollchild.bg:SetColorTexture(0.4, 0, 0, 0.4)
	preview.bg = preview:CreateTexture(nil, 'BACKGROUND')
	preview.bg:SetAllPoints(preview)
	preview.bg:SetColorTexture(0, 0, 0, 1)
	preview.bg:SetGradient('HORIZONTAL', 0, 1, 1, 1, 1, 0)
	local maxWidth, maxHeight = preview:GetSize()
	local widthMiddle = math.floor(maxWidth / 2)
	local heightMiddle = math.floor(maxHeight / 2)
	local verticalLineLength = math.floor(maxHeight / 3)
	local horizontalLineLength = math.floor(maxWidth / 3)
	local previewLines = {}
	table.insert(previewLines, opt.CreateLine(preview, widthMiddle, maxHeight, widthMiddle, maxHeight - verticalLineLength, maxWidth))
	table.insert(previewLines, opt.CreateLine(preview, widthMiddle, 0, widthMiddle, verticalLineLength, maxWidth))
	table.insert(previewLines, opt.CreateLine(preview, 0, heightMiddle, horizontalLineLength, heightMiddle, maxHeight))
	table.insert(previewLines, opt.CreateLine(preview, maxWidth, heightMiddle, maxWidth - horizontalLineLength, heightMiddle, maxHeight))
	return preview, previewLines
end

function opt.CreateLine(parent, startX, startY, endX, endY, maxThickness)
	local line = parent:CreateLine(nil, 'BACKGROUND')
	line:SetStartPoint('BOTTOMLEFT', startX, startY)
	line:SetEndPoint('BOTTOMLEFT', endX, endY)
	line:SetColorTexture(1, 0, 0, 0.4)
	line.QOL_MaxThickness = maxThickness
	line:SetThickness(line.QOL_MaxThickness * ((QOL_Config_Toon.Active and QOL_Config_Toon.MM.Thickness or QOL_Config_Acct.MM.Thickness) / 100))
	return line
end

local uniqueID = 0
function opt.GetUniqueID()
	uniqueID = uniqueID + 1
	return uniqueID
end

function opt.CheckBoxToonActive_OnClick()
	QOL_Config_Toon.Active = not QOL_Config_Toon.Active
	opt.UpdateConfig()
end

function opt.EditBoxLevels_OnEditFocusLost(self)
	local configLevels = self == opt.Acct.VC.EditBoxLevels and QOL_Config_Acct.VC.Levels or QOL_Config_Toon.VC.Levels
	local enteredPresets = QOLUtils.StrToTable(self:GetText(), QOLUtils.Patterns.Numbers)
	local validPresets = {}
	for i = 1, table.getn(enteredPresets) do
		if QOLUtils.VC.ValidLevel(enteredPresets[i]) then
			table.insert(validPresets, enteredPresets[i])
		end
	end
	configLevels = validPresets
	self:SetText(QOLUtils.TableToStr(configLevels))
end

function opt.UpdateCheckBox(checkBox, feature, setting)
	local checked = QOL_Config_Toon.Active
	if feature and setting then
		checked = QOLUtils.SettingIsTrue(feature, setting)
	end
	checkBox:SetChecked(checked)
end

function opt.UpdateSlider(slider, feature, setting)
	local value = QOL_Config_Acct[feature][setting]
	if QOL_Config_Toon.Active then
		value = QOL_Config_Toon[feature][setting]
	end
	slider:SetValue(value)
end

function opt.UpdateEditBox(editBox, feature, setting)
	local value = QOL_Config_Acct[feature][setting]
	if QOL_Config_Toon.Active then
		value = QOL_Config_Toon[feature][setting]
	end
	if type(value) == 'table' then
		value = QOLUtils.TableToStr(value)
	end
	editBox:SetText(tostring(value))
	editBox:SetCursorPosition(0)
end

function opt.UpdateEditBoxWithNumber(editBox, feature, setting, numberFormat)
	local value = QOL_Config_Acct[feature][setting]
	if QOL_Config_Toon.Active then
		value = QOL_Config_Toon[feature][setting]
	end
	editBox:SetText(format(numberFormat, value))
	editBox:SetCursorPosition(0)
end

function opt.UpdatePreviewLines()
	local config = QOL_Config_Toon.Active and QOL_Config_Toon.MM or QOL_Config_Acct.MM
	local red = config.Red / 100
	local green = config.Green / 100
	local blue = config.Blue / 100
	local alpha = config.Alpha / 100
	local thickness = config.Thickness / 100
	for k, line in pairs(storage.MM.PreviewLines) do
		line:SetColorTexture(red, green, blue, alpha)
		local finalThickness = line.QOL_MaxThickness * thickness
		line:SetThickness(finalThickness < 1 and 1 or finalThickness)
	end
end

function opt.UpdateIgnoredMounts()
	local config = QOLUtils.GetConfig('SMN')
	local orderedMounts = {}
	if storage.SMN.IgnoredList.OrderedMounts == nil then
		storage.SMN.IgnoredList.OrderedMounts = {}
	end
	if storage.SMN.IgnoredList.CheckBoxes == nil then
		storage.SMN.IgnoredList.CheckBoxes = {}
	end
	for mountID in pairs(config.IgnoredMounts) do
		local mountName = C_MountJournal.GetMountInfoByID(mountID)
		storage.SMN.IgnoredList.OrderedMounts[mountName] = mountID
	end	
	local relParent = storage.SMN.IgnoredList
	for _, mountName, mountID in ipairs(storage.SMN.IgnoredList.OrderedMounts) do
		print(mountName, mountID)
		if mountID then
			local checkbox = opt.CreateCheckBox(storage.SMN.IgnoredList, points.TL, relParent, points.TL, 0, 0, format('%s (ID: %d)', mountName, mountID), opt.AdjustIgnoredMounts)
			checkbox.relParent = relParent
			relParent.relChild = checkbox
			checkbox:SetChecked(true)
			checkbox.mountID = mountID
			storage.SMN.IgnoredList.CheckBoxes[mountID] = checkbox
			relParent = checkbox
		end
	end
end

function opt.RemoveIgnoredMount(checkbox)
	if checkbox.relChild and checkbox.relParent then
		checkbox.relChild:ClearAllPoints()
		checkbox.relChild:SetPoint(storage.SMN.IgnoredList, points.TL, checkbox.relParent, points.TL, 0, 0)
		checkbox:Hide()
	end
end

function opt.AddIgnoredMount(mountID)
	
end