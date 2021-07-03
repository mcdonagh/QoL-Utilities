local addonName, QOLUtils = ...

QOLUtils.OPT = {}
local opt = QOLUtils.OPT

function opt.LoadDefaults()
	opt.LoadAccountDefaults()
	opt.LoadToonDefaults()
end

function opt.LoadAccountDefaults()
	if QOL_Config == nil then
		QOL_Config = {}
	end
	if QOL_Config.AC == nil then
		QOL_Config.AC = {}
	end
	if QOL_Config.AC.ReportAtLogon == nil then
		QOL_Config.AC.ReportAtLogon = true
	end
	if QOL_Config.AC.RefundableActive == nil then
		QOL_Config.AC.RefundableActive = false
	end
	if QOL_Config.AC.TradeableActive == nil then
		QOL_Config.AC.TradeableActive = false
	end
	if QOL_Config.AC.BindableActive == nil then
		QOL_Config.AC.BindableActive = false
	end
	if QOL_Config.QM == nil then
		QOL_Config.QM = {}
	end
	if QOL_Config.QM.ReportAtLogon == nil then
		QOL_Config.QM.ReportAtLogon = true
	end
	if QOL_Config.QM.PartyActive == nil then
		QOL_Config.QM.PartyActive = false
	end
	if QOL_Config.QM.DuelActive == nil then
		QOL_Config.QM.DuelActive = false;
	end
	if QOL_Config.SMN == nil then
		QOL_Config.SMN = {}
	end
	if QOL_Config.SMN.OnlyFavoritePets == nil then
		QOL_Config.SMN.OnlyFavoritePets = false
	end
	if QOL_Config.VC == nil then
		QOL_Config.VC = {}
	end
	if QOL_Config.VC.Levels == nil then
		QOL_Config.VC.Levels = {}
		table.insert(QOL_Config.VC.Levels, 80)
		table.insert(QOL_Config.VC.Levels, 20)
		table.insert(QOL_Config.VC.Levels, 5)
	end
	if QOL_Config.VC.Index == nil then
		QOL_Config.VC.Index = 1
	end
end

function opt.LoadToonDefaults()
	if QOL_Config_Toon == nil then
		QOL_Config_Toon = {}
	end
	if QOL_Config_Toon.Active == nil then
		QOL_Config_Toon.Active = false
	end
	if QOL_Config_Toon.AC == nil then
		QOL_Config_Toon.AC = {}
	end
	if QOL_Config_Toon.AC.ReportAtLogon == nil then
		QOL_Config_Toon.AC.ReportAtLogon = true
	end
	if QOL_Config_Toon.AC.RefundableActive == nil then
		QOL_Config_Toon.AC.RefundableActive = false
	end
	if QOL_Config_Toon.AC.TradeableActive == nil then
		QOL_Config_Toon.AC.TradeableActive = false
	end
	if QOL_Config_Toon.AC.BindableActive == nil then
		QOL_Config_Toon.AC.BindableActive = false
	end
	if QOL_Config_Toon.QM == nil then
		QOL_Config_Toon.QM = {}
	end
	if QOL_Config_Toon.QM.ReportAtLogon == nil then
		QOL_Config_Toon.QM.ReportAtLogon = true
	end
	if QOL_Config_Toon.QM.PartyActive == nil then
		QOL_Config_Toon.QM.PartyActive = false
	end
	if QOL_Config_Toon.QM.DuelActive == nil then
		QOL_Config_Toon.QM.DuelActive = false;
	end
	if QOL_Config_Toon.SMN == nil then
		QOL_Config_Toon.SMN = {}
	end
	if QOL_Config_Toon.SMN.OnlyFavoritePets == nil then
		QOL_Config_Toon.SMN.OnlyFavoritePets = false
	end
	if QOL_Config_Toon.VC == nil then
		QOL_Config_Toon.VC = {}
	end
	if QOL_Config_Toon.VC.Levels == nil then
		QOL_Config_Toon.VC.Levels = {}
		table.insert(QOL_Config_Toon.VC.Levels, 80)
		table.insert(QOL_Config_Toon.VC.Levels, 20)
		table.insert(QOL_Config_Toon.VC.Levels, 5)
	end
	if QOL_Config_Toon.VC.Index == nil then
		QOL_Config_Toon.VC.Index = 1
	end
end

function opt.OpenConfig()
	InterfaceOptionsFrame_Show()
	InterfaceOptionsFrame_OpenToCategory(opt.Panel)
end

function opt.CreateConfig()
	opt.Panel = CreateFrame('Frame', 'QoL Utilities', UIParent)
	opt.Panel.name = 'QoL Utilities'	
	opt.Panel.ScrollFrame = CreateFrame('ScrollFrame', 'QOL_Utils_ScrollFrame_' .. opt.GetUniqueID(), opt.Panel, 'UIPanelScrollFrameTemplate')
	opt.Panel.ScrollFrame:SetPoint('TOPLEFT', opt.Panel, 'TOPLEFT')
	opt.Panel.ScrollFrame:SetPoint('BOTTOMRIGHT', opt.Panel, 'BOTTOMRIGHT')	
	opt.Panel.ScrollFrame.ScrollBar:ClearAllPoints()
	opt.Panel.ScrollFrame.ScrollBar:SetPoint('TOPRIGHT', opt.Panel.ScrollFrame, 'TOPRIGHT', -5, -22)
	opt.Panel.ScrollFrame.ScrollBar:SetPoint('BOTTOMRIGHT', opt.Panel.ScrollFrame, 'BOTTOMRIGHT', -5, 22)	
	local scrollchild = CreateFrame('Frame', 'QOL_Utils_ScrollChild_' .. opt.GetUniqueID(), opt.Panel.ScrollFrame)
	scrollchild:SetSize(400, 750)
	scrollchild:SetPoint('TOPLEFT', opt.Panel.ScrollFrame, 'TOPLEFT', -30, 30)
	opt.Panel.ScrollFrame:SetScrollChild(scrollchild)	
	opt.Acct = {}
	opt.Acct.AC = {}
	opt.Acct.QM = {}
	opt.Acct.VC = {}
	local acctHeader = opt.CreateHeader(scrollchild, scrollchild, 30, -30, QOLUtils.Labels.Acct)
	local acctACHeader = opt.CreateHeader(scrollchild, acctHeader, 30, -20, QOLUtils.Labels.AC.Header)
	opt.Acct.AC.CheckBoxReport = opt.CreateCheckBox(scrollchild, acctACHeader, 30, -20, QOLUtils.Labels.AC.Report, QOL_Config.AC.ReportAtLogon, QOLUtils.AC.ToggleLogonReport)
	opt.Acct.AC.CheckBoxRefundable = opt.CreateCheckBox(scrollchild, opt.Acct.AC.CheckBoxReport, 0, -20, QOLUtils.Labels.AC.Refundable, QOL_Config.AC.RefundableActive, QOLUtils.AC.ToggleRefundable)
	opt.Acct.AC.CheckBoxTradeable = opt.CreateCheckBox(scrollchild, opt.Acct.AC.CheckBoxRefundable, 0, -20, QOLUtils.Labels.AC.Tradeable, QOL_Config.AC.TradeableActive, QOLUtils.AC.ToggleTradeable)
	opt.Acct.AC.CheckBoxBindable = opt.CreateCheckBox(scrollchild, opt.Acct.AC.CheckBoxTradeable, 0, -20, QOLUtils.Labels.AC.Bindable, QOL_Config.AC.BindableActive, QOLUtils.AC.ToggleBindable)
	local acctQMHeader = opt.CreateHeader(scrollchild, opt.Acct.AC.CheckBoxBindable, -30, -30, QOLUtils.Labels.QM.Header)
	opt.Acct.QM.CheckBoxReport = opt.CreateCheckBox(scrollchild, acctQMHeader, 30, -20, QOLUtils.Labels.QM.Report, QOL_Config.QM.ReportAtLogon, QOLUtils.QM.ToggleLogonReport)
	opt.Acct.QM.CheckBoxParty = opt.CreateCheckBox(scrollchild, opt.Acct.QM.CheckBoxReport, 0, -20, QOLUtils.Labels.QM.Party, QOL_Config.QM.PartyActive, QOLUtils.QM.ToggleParty)
	opt.Acct.QM.CheckBoxDuel = opt.CreateCheckBox(scrollchild, opt.Acct.QM.CheckBoxParty, 0, -20, QOLUtils.Labels.QM.Duel, QOL_Config.QM.DuelActive, QOLUtils.QM.ToggleDuel)
	local acctVCHeader = opt.CreateHeader(scrollchild, opt.Acct.QM.CheckBoxDuel, -30, -30, QOLUtils.Labels.VC.Header)
	local acctVCLabel = opt.CreateLabel(scrollchild, acctVCHeader, 30, -20, QOLUtils.Labels.VC.Levels)
	opt.Acct.VC.EditBoxLevels = opt.CreateEditBox(scrollchild, acctVCLabel, 30, -10, opt.TableToStr(QOL_Config.VC.Levels), opt.ParseVolumeLevels)
	opt.Toon = {}
	opt.Toon.AC = {}
	opt.Toon.QM = {}
	opt.Toon.VC = {}
	local toonHeader = opt.CreateHeader(scrollchild, opt.Acct.VC.EditBoxLevels, -90, -40, QOLUtils.Labels.Toon)
	opt.Toon.Active = opt.CreateCheckBox(scrollchild, toonHeader, 30, -20, QOLUtils.Labels.UseToon, QOL_Config_Toon.Active, opt.ToggleToonSpecific)
	local toonACHeader = opt.CreateHeader(scrollchild, opt.Toon.Active, 0, -30, QOLUtils.Labels.AC.Header)
	opt.Toon.AC.CheckBoxReport = opt.CreateCheckBox(scrollchild, toonACHeader, 30, -20, QOLUtils.Labels.AC.Report, QOL_Config_Toon.AC.ReportAtLogon, QOLUtils.AC.ToggleLogonReport)
	opt.Toon.AC.CheckBoxRefundable = opt.CreateCheckBox(scrollchild, opt.Toon.AC.CheckBoxReport, 0, -20, QOLUtils.Labels.AC.Refundable, QOL_Config_Toon.AC.RefundableActive, QOLUtils.AC.ToggleRefundable)
	opt.Toon.AC.CheckBoxTradeable = opt.CreateCheckBox(scrollchild, opt.Toon.AC.CheckBoxRefundable, 0, -20, QOLUtils.Labels.AC.Tradeable, QOL_Config_Toon.AC.TradeableActive, QOLUtils.AC.ToggleTradeable)
	opt.Toon.AC.CheckBoxBindable = opt.CreateCheckBox(scrollchild, opt.Toon.AC.CheckBoxTradeable, 0, -20, QOLUtils.Labels.AC.Bindable, QOL_Config_Toon.AC.BindableActive, QOLUtils.AC.ToggleBindable)
	local toonQMHeader = opt.CreateHeader(scrollchild, opt.Toon.AC.CheckBoxBindable, -30, -30, QOLUtils.Labels.QM.Header)
	opt.Toon.QM.CheckBoxReport = opt.CreateCheckBox(scrollchild, toonQMHeader, 30, -20, QOLUtils.Labels.QM.Report, QOL_Config_Toon.QM.ReportAtLogon, QOLUtils.QM.ToggleLogonReport)
	opt.Toon.QM.CheckBoxParty = opt.CreateCheckBox(scrollchild, opt.Toon.QM.CheckBoxReport, 0, -20, QOLUtils.Labels.QM.Party, QOL_Config_Toon.QM.PartyActive, QOLUtils.QM.ToggleParty)
	opt.Toon.QM.CheckBoxDuel = opt.CreateCheckBox(scrollchild, opt.Toon.QM.CheckBoxParty, 0, -20, QOLUtils.Labels.QM.Duel, QOL_Config_Toon.QM.DuelActive, QOLUtils.QM.ToggleDuel)
	local toonVCHeader = opt.CreateHeader(scrollchild, opt.Toon.QM.CheckBoxDuel, -30, -30, QOLUtils.Labels.VC.Header)
	local toonVCLabel = opt.CreateLabel(scrollchild, toonVCHeader, 30, -20, QOLUtils.Labels.VC.Levels)
	opt.Toon.VC.EditBoxLevels = opt.CreateEditBox(scrollchild, toonVCLabel, 30, -10, opt.TableToStr(QOL_Config_Toon.VC.Levels), opt.ParseVolumeLevels)
	InterfaceOptions_AddCategory(opt.Panel);
end

function opt.CreateHeader(parent, relativeParent, x, y, text)
	local fontFrame = CreateFrame('Frame', 'QOL_Utils_FontFrame_' .. opt.GetUniqueID(), parent)
	fontFrame:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	fontFrame:SetSize(500, 10)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. opt.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function opt.CreateCheckBox(parent, relativeParent, x, y, text, checked, callback)
	local checkBox = CreateFrame('CheckButton', 'QOLUtils_CheckBox_' .. opt.GetUniqueID(), parent, 'ChatConfigCheckButtonTemplate')
	checkBox:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	getglobal(checkBox:GetName() .. 'Text'):SetText(text)
	checkBox:SetChecked(checked)
	checkBox:SetScript('OnClick', callback)
	return checkBox
end

function opt.CreateLabel(parent, relativeParent, x, y, text)
	local fontFrame = CreateFrame('Frame', 'QOLUtils_FontFrame_' .. opt.GetUniqueID(), parent)
	fontFrame:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	fontFrame:SetSize(500, 30)
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. opt.GetUniqueID(), 'BACKGROUND', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function opt.CreateEditBox(parent, relativeParent, x, y, text, callback)
	local editBox = CreateFrame('EditBox', 'QOLUtils_EditBox_' .. opt.GetUniqueID(), parent, 'InputBoxTemplate')
	editBox:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	editBox:SetSize(200, 30)
	editBox:SetMultiLine(false)
	editBox:SetAutoFocus(false)
	editBox:SetText(text)
	editBox:SetCursorPosition(0)
	editBox:SetScript('OnEditFocusLost', callback)
	return editBox
end

local uniqueID = 0
function opt.GetUniqueID()
	uniqueID = uniqueID + 1
	return uniqueID
end

function opt.ToggleToonSpecific()
	QOL_Config_Toon.Active = not QOL_Config_Toon.Active
	opt.UpdateCheckBox(opt.Toon.Active, QOL_Config_Toon.Active)
end

function opt.ParseVolumeLevels(self)
	local configLevels = self == opt.Acct.VC.EditBoxLevels and QOL_Config.VC.Levels or QOL_Config_Toon.VC.Levels
	local enteredPresets = opt.StrToTable(self:GetText(), QOLUtils.Patterns.Numbers)
	local validPresets = {}
	for i = 1, table.getn(enteredPresets) do
		if QOLUtils.VC.ValidLevel(enteredPresets[i]) then
			table.insert(validPresets, enteredPresets[i])
		end
	end
	configLevels = validPresets
	self:SetText(opt.TableToStr(configLevels))
end

function opt.StrToTable(str, pattern)
	local args = {}
	for num in str:gmatch(pattern) do
		table.insert(args, num)
	end
	return args
end

function opt.TableToStr(t)
	local s = ''
	for i = 1, table.getn(t) do
		s = s .. tostring(t[i]) .. ' '
	end
	s = s:gsub(QOLUtils.Patterns.WhiteSpaceStart, ''):gsub(QOLUtils.Patterns.WhiteSpaceEnd, '')
	return s
end

function opt.UpdateCheckBox(checkBox, checked)
	checkBox:SetChecked(checked)
end