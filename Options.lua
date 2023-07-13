local addonName, QOLUtils = ...

QOLUtils.OPT = {}
QOLUtils.OPT.Storage = {}
local opt = QOLUtils.OPT
local storage = opt.Storage
local spacing = QOLUtils.ConfigSpacing
local labels = QOLUtils.Labels
local points = QOLUtils.Points

function opt.LoadDefaults()
	QOL_Config_Acct = QOL_Config_Acct or QOL_Config or {}
	opt.GenerateDefaults(QOL_Config_Acct)
	opt.SetupAttention()
	QOL_Config_Toon = QOL_Config_Toon or {}
	opt.GenerateDefaults(QOL_Config_Toon)
	QOL_Config_Toon.Active = QOL_Config_Toon.Active or false
end

function opt.SetupAttention()
	QOL_Config_Acct.Attention = QOL_Config_Acct.Attention or {}	
	if QOLUtils.Alert and not QOL_Config_Acct.Attention[QOLUtils.Alert] then
		QOL_Config_Acct.Attention = {}
		QOL_Config_Acct.Attention[QOLUtils.Alert] = {}
		QOL_Config_Acct.Attention[QOLUtils.Alert].Count = 3
		QOL_Config_Acct.Attention[QOLUtils.Alert].Message = 'placeholder text; you should not be seeing this.'
	end
end

function opt.GenerateDefaults(config)
	-- Achievement Tracker Cleaner
	config.ATC = config.ATC or {}
	config.ATC.Enabled = config.ATC.Enabled or true
	-- Announce Target
	config.AT = config.AT or {}
	config.AT.Enabled = config.AT.Enabled or true
	-- Auto Confirm
	config.AC = config.AC or {}
	config.AC.Enabled = config.AC.Enabled or true
	config.AC.ReportAtLogon = config.AC.ReportAtLogon or true
	config.AC.RefundableActive = config.AC.RefundableActive or false
	config.AC.TradeableActive = config.AC.TradeableActive or false
	config.AC.BindableActive = config.AC.BindableActive or false
	-- Middle Marker
	config.MM = config.MM or {}
	config.MM.Enabled = config.MM.Enabled or true
	config.MM.Red = config.MM.Red or 100
	config.MM.Green = config.MM.Green or 0
	config.MM.Blue = config.MM.Blue or 0
	config.MM.Alpha = config.MM.Alpha or 40
	config.MM.Thickness = config.MM.Thickness or 0.3
	-- Quiet Mode
	config.QM = config.QM or {}
	config.QM.Enabled = config.QM.Enabled or true
	config.QM.ReportAtLogon = config.QM.ReportAtLogon or true
	config.QM.PartyActive = config.QM.PartyActive or false
	config.QM.DuelActive = config.QM.DuelActive or false
	-- Summon
	config.SMN = config.SMN or {}
	config.SMN.Enabled = config.SMN.Enabled or true
	config.SMN.ReportAtLogon = config.SMN.ReportAtLogon or false
	config.SMN.OnlyFavoritePets = config.SMN.OnlyFavoritePets or false
	config.SMN.OnlyFavoriteMounts = config.SMN.OnlyFavoriteMounts or false
	-- Volume Cycler
	config.VC = config.VC or {}
	config.VC.Enabled = config.VC.Enabled or false
	config.VC.Levels = config.VC.Levels or { 80, 20, 5}
	config.VC.Index = config.VC.Index or 1
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
	Settings.OpenToCategory(labels.Header)
end

function opt.CreateConfig()
	local scroller, scrollchild = opt.CreateScrollFrame(labels.Header, UIParent, false)
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
	local sliderX, sliderY, sliderPoint, sliderRelPoint = 0, 0, points.L, points.R
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
	storage.VC = {}
	local vcHeader = opt.CreateHeader(scrollchild, points.TL, storage.SMN.CheckBoxMounts, points.BL, -spacing.Indent, -spacing.GapMedium, labels.VC.Header)
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
	-- Summon
	opt.UpdateCheckBox(storage.SMN.CheckBoxEnabled, 'SMN','Enabled')
	opt.UpdateCheckBox(storage.SMN.CheckBoxReport, 'SMN','ReportAtLogon')
	opt.UpdateCheckBox(storage.SMN.CheckBoxPets, 'SMN','OnlyFavoritePets')
	opt.UpdateCheckBox(storage.SMN.CheckBoxMounts, 'SMN','OnlyFavoriteMounts')
	-- Volume Cycler
	opt.UpdateCheckBox(storage.VC.CheckBoxEnabled, 'VC','Enabled')
	opt.UpdateEditBox(storage.VC.EditBoxLevels, 'VC', 'Levels')
end

function opt.CreateScrollFrame(name, parent, setBG)
	local scroller = CreateFrame('Frame', 'QOL_Utils_Frame_' .. opt.GetUniqueID(), parent)
	scroller.name = name
	scroller.ScrollFrame = CreateFrame('ScrollFrame', 'QOL_Utils_ScrollFrame_' .. opt.GetUniqueID(), scroller, 'UIPanelScrollFrameTemplate')
	scroller.ScrollFrame:SetPoint('TOPLEFT', scroller, 'TOPLEFT')
	scroller.ScrollFrame:SetPoint('BOTTOMRIGHT', scroller, 'BOTTOMRIGHT')
	scroller.ScrollFrame.ScrollBar:ClearAllPoints()
	scroller.ScrollFrame.ScrollBar:SetPoint('TOPRIGHT', scroller.ScrollFrame, 'TOPRIGHT', -5, -22)
	scroller.ScrollFrame.ScrollBar:SetPoint('BOTTOMRIGHT', scroller.ScrollFrame, 'BOTTOMRIGHT', -5, 22)
	if setBG then
		scroller.ScrollFrame.bg = scroller.ScrollFrame:CreateTexture(nil, 'BACKGROUND')
		scroller.ScrollFrame.bg:SetAllPoints(true)
		scroller.ScrollFrame.bg:SetColorTexture(0, 0, 0, 0.4)
	end
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
	fontFrame:SetSize(500, 20)
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
	fontFrame:SetSize(100, 20)
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
	preview.bg:SetGradient('HORIZONTAL', CreateColor(0, 1, 1, 1), CreateColor(1, 1, 0, 1))
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
	local config = QOLUtils.GetConfig('VC')
	local enteredPresets = QOLUtils.StrToTable(self:GetText(), QOLUtils.Patterns.Numbers)
	local validPresets = {}
	for i = 1, #enteredPresets do
		if QOLUtils.VC.ValidLevel(enteredPresets[i]) then
			table.insert(validPresets, enteredPresets[i])
		end
	end
	config.Levels = validPresets
	self:SetText(QOLUtils.TableToStr(config.Levels))
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