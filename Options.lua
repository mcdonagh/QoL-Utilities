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
	if QOL_Config.QM.PartyActive == nil then
		QOL_Config.QM.PartyActive = false
	end
	if QOL_Config.QM.DuelActive == nil then
		QOL_Config.QM.DuelActive = false;
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
	if QOL_Config_Toon.QM.PartyActive == nil then
		QOL_Config_Toon.QM.PartyActive = false
	end
	if QOL_Config_Toon.QM.DuelActive == nil then
		QOL_Config_Toon.QM.DuelActive = false;
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

function opt.Okay()

end

function opt.Cancel()

end

local uniqueID = 0

function opt.CreateConfig()
	local panel = CreateFrame('Frame', 'QoL Utilities', UIParent);
	panel.name = 'QoL Utilities'
	opt.Panel = panel
	opt.Acct = {}
	opt.Acct.AC = {}
	opt.Acct.QM = {}
	opt.Acct.VC = {}
	local acctHeader = opt.CreateHeader(panel, 30, -30, QOLUtils.Labels.Acct)
	local acctACHeader = opt.CreateHeader(acctHeader, 30, -60, QOLUtils.Labels.AC.Header)
	opt.Acct.AC.CheckBoxRefundable = opt.CreateCheckBox(acctACHeader, 30, -40, QOLUtils.Labels.AC.Refundable, QOL_Config.AC.RefundableActive, QOLUtils.AC.ToggleRefundable)
	opt.Acct.AC.CheckBoxTradeable = opt.CreateCheckBox(opt.Acct.AC.CheckBoxRefundable, 0, -40, QOLUtils.Labels.AC.Tradeable, QOL_Config.AC.TradeableActive, QOLUtils.AC.ToggleTradeable)
	opt.Acct.AC.CheckBoxBindable = opt.CreateCheckBox(opt.Acct.AC.CheckBoxTradeable, 0, -40, QOLUtils.Labels.AC.Bindable, QOL_Config.AC.BindableActive, QOLUtils.AC.ToggleBindable)
	local acctQMHeader = opt.CreateHeader(opt.Acct.AC.CheckBoxBindable, -30, -60, QOLUtils.Labels.QM.Header)
	opt.Acct.QM.CheckBoxParty = opt.CreateCheckBox(acctQMHeader, 30, -40, QOLUtils.Labels.QM.Party, QOL_Config.QM.PartyActive, QOLUtils.QM.ToggleParty)
	opt.Acct.QM.CheckBoxDuel = opt.CreateCheckBox(opt.Acct.QM.CheckBoxParty, 0, -40, QOLUtils.Labels.QM.Duel, QOL_Config.QM.DuelActive, QOLUtils.QM.ToggleDuel)
	local acctVCHeader = opt.CreateHeader(opt.Acct.QM.CheckBoxDuel, -30, -60, QOLUtils.Labels.VC.Header)
	local acctVCLabel = opt.CreateLabel(acctVCHeader, 30, -40, QOLUtils.Labels.OPT_VCL)
	opt.Acct.VC.EditBoxLevels = opt.CreateEditBox(acctVCLabel, 30, -10, opt.TableToStr(QOL_Config.VCLevels), opt.ParseVolumeLevels)
	opt.Toon = {}
	opt.Toon.AC = {}
	opt.Toon.QM = {}
	opt.Toon.VC = {}
	local toonHeader = opt.CreateHeader(opt.Toon.VC.EditBoxLevels, -90, -60, QOLUtils.Labels.Toon)
	opt.Toon.Active = opt.CreateCheckBox(toonHeader, 30, -40, QOLUtils.Labels.UseToon, QOL_Config_Toon.Active, opt.ToggleToonSpecific)
	local toonACHeader = opt.CreateHeader(opt.Toon.Active, 0, -60, QOLUtils.Labels.AC.Header)
	opt.Toon.AC.CheckBoxRefundable = opt.CreateCheckBox(toonACHeader, 30, -40, QOLUtils.Labels.AC.Refundable, QOL_Config.AC.RefundableActive, QOLUtils.AC.ToggleRefundable)
	opt.Toon.AC.CheckBoxTradeable = opt.CreateCheckBox(opt.Toon.AC.CheckBoxRefundable, 0, -40, QOLUtils.Labels.AC.Tradeable, QOL_Config.AC.TradeableActive, QOLUtils.AC.ToggleTradeable)
	opt.Toon.AC.CheckBoxBindable = opt.CreateCheckBox(opt.Toon.AC.CheckBoxTradeable, 0, -40, QOLUtils.Labels.AC.Bindable, QOL_Config.AC.BindableActive, QOLUtils.AC.ToggleBindable)
	local toonQMHeader = opt.CreateHeader(opt.Toon.AC.CheckBoxBindable, -30, -60, QOLUtils.Labels.QM.Header)
	opt.Toon.QM.CheckBoxParty = opt.CreateCheckBox(toonQMHeader, 30, -40, QOLUtils.Labels.QM.Party, QOL_Config.QM.PartyActive, QOLUtils.QM.ToggleParty)
	opt.Toon.QM.CheckBoxDuel = opt.CreateCheckBox(opt.Toon.QM.CheckBoxParty, 0, -40, QOLUtils.Labels.QM.Duel, QOL_Config.QM.DuelActive, QOLUtils.QM.ToggleDuel)
	local toonVCHeader = opt.CreateHeader(opt.Toon.QM.CheckBoxDuel, -30, -60, QOLUtils.Labels.VC.Header)
	local toonVCLabel = opt.CreateLabel(toonVCHeader, 30, -40, QOLUtils.Labels.OPT_VCL)
	opt.Toon.VC.EditBoxLevels = opt.CreateEditBox(toonVCLabel, 30, -10, opt.TableToStr(QOL_Config.VCLevels), opt.ParseVolumeLevels)
	InterfaceOptions_AddCategory(opt.Panel);
end

function opt.CreateHeader(parent, x, y, text)
	uniqueID = uniqueID + 1
	local fontFrame = CreateFrame('Frame', 'QOL_Utils_FontFrame_' .. uniqueID, parent)
	fontFrame:SetPoint('TOPLEFT', x, y)
	fontFrame:SetSize(500, 30)
	uniqueID = uniqueID + 1
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. uniqueID, 'ARTWORK', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	local underline = fontFrame:CreateLine(nil, 'BACKGROUND')
	underline:SetStartPoint('TOPLEFT', x + 30, 0)
	underline:SetEndPoint('TOPLEFT', x + 30, 50)
	underline:SetColorTexture(0, 0, 0, 1)
	underline:SetThickness(1)
end

function opt.CreateCheckBox(parent, x, y, text, checked, callback)
	uniqueID = uniqueID + 1
	local checkBox = CreateFrame('CheckButton', 'QOLUtils_CheckBox_' .. uniqueID, parent, 'ChatConfigCheckButtonTemplate')
	checkBox:SetPoint('TOPLEFT', x, y)
	getglobal(checkBox:GetName() .. 'Text'):SetText(text)
	checkBox:SetChecked(checked)
	checkBox:SetScript('OnClick', callback)
	return checkBox
end

function opt.CreateLabel(parent, x, y, text)
	uniqueID = uniqueID + 1
	local fontFrame = CreateFrame('Frame', 'QOLUtils_FontFrame_' .. uniqueID, parent)
	fontFrame:SetPoint('TOPLEFT', x, y)
	fontFrame:SetSize(500, 30)
	uniqueID = uniqueID + 1
	local fontString = fontFrame:CreateFontString('QOLUtils_FontString_' .. uniqueID, 'ARTWORK', 'GameFontWhite')
	fontString:SetPoint('TOPLEFT')
	fontString:SetText(text)
	fontFrame.text = fontString
	return fontFrame
end

function opt.CreateEditBox(parent, x, y, text, callback)
	uniqueID = uniqueID + 1
	local editBox = CreateFrame('EditBox', 'QOLUtils_EditBox_' .. uniqueID, parent, 'InputBoxTemplate')
	editBox:SetPoint('TOPLEFT', x, y)
	editBox:SetSize(200, 30)
	editBox:SetMultiLine(false)
	editBox:SetAutoFocus(false)
	editBox:SetText(text)
	editBox:SetCursorPosition(0)
	editBox:SetScript('OnEditFocusLost', callback)
	return editBox
end

function opt.ToggleToonSpecific()
	QOL_Config_Toon.Active = not QOL_Config_Toon.Active
	opt.UpdateCheckBox(opt.Toon.Active, QOL_Config_Toon.Active)
end

function opt.ParseVolumeLevels()
	local enteredPresets = opt.StrToTable(opt.VCLEditBox:GetText(), QOLUtils.Patterns.Numbers)
	local validPresets = {}
	for i = 1, #enteredPresets do
		if QOLUtils.VC.ValidLevel(enteredPresets[i]) then
			table.insert(validPresets, enteredPresets[i])
		end
	end
	QOL_Config.VCLevels = validPresets
	opt.VCLEditBox:SetText(opt.TableToStr(QOL_Config.VCLevels))
end

function opt.StrToTable(str, pattern)
	local args = {}
	for num in str:gmatch(QOLUtils.Patterns.Numbers) do
		table.insert(args, num)
	end
	return args
end

function opt.TableToStr(t)
	local s = ''
	for i = 1, #t do
		s = s .. t[i] .. ' '
	end
	s = s:gsub(QOLUtils.Patterns.WhiteSpaceStart, ''):gsub(QOLUtils.Patterns.WhiteSpaceEnd, '')
	return s
end

function opt.UpdateCheckBox(checkBox, checked)
	checkBox:SetChecked(checked)
end