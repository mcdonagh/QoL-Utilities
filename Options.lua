local addonName, QOLUtils = ...

QOLUtils.OPT = {}
local opt = QOLUtils.OPT

function opt.LoadDefaults()
	opt.GenerateDefaults(QOL_Config)
	opt.GenerateDefaults(QOL_Config_Toon)
	if QOL_Config_Toon.Active == nil then
		QOL_Config_Toon.Active = false
	end
end

function opt.GenerateDefaults(config)
	if config == nil then
		config = {}
	end
	if config.AC == nil then
		config.AC = {}
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
	if config.QM == nil then
		config.QM = {}
	end
	if config.QM.ReportAtLogon == nil then
		config.QM.ReportAtLogon = true
	end
	if config.QM.PartyActive == nil then
		config.QM.PartyActive = false
	end
	if config.QM.DuelActive == nil then
		config.QM.DuelActive = false;
	end
	if config.SMN == nil then
		config.SMN = {}
	end
	if config.SMN.ReportAtLogon == nil then
		config.SMN.ReportAtLogon = false
	end
	if config.SMN.OnlyFavoritePets == nil then
		config.SMN.OnlyFavoritePets = false
	end
	if config.SMN.OnlyFavoriteMounts == nil then
		config.SMN.OnlyFavoriteMounts = true
	end
	if config.VC == nil then
		config.VC = {}
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

function opt.OpenConfig()
	InterfaceOptionsFrame_Show()
	InterfaceOptionsFrame_OpenToCategory(opt.Panel)
end

function opt.CreateConfig()
	local sectionGap = 40
	local headerGap = 30
	local itemGap = 20
	local indent = 30
	local scrollchild = opt.CreateScrollFrame()
	opt.Acct = {}
	opt.Acct.AC = {}
	local acctHeader = opt.CreateHeader(scrollchild, scrollchild, indent, -sectionGap, QOLUtils.Labels.Acct)
	local acctACHeader = opt.CreateHeader(scrollchild, acctHeader, indent, -itemGap, QOLUtils.Labels.AC.Header)
	opt.CreateConfigItems(scrollchild, acctACHeader, QOL_Config, opt.Acct, indent, headerGap, itemGap)
	opt.Toon = {}
	local toonHeader = opt.CreateHeader(scrollchild, opt.Acct.VC.EditBoxLevels, -indent * 3, -sectionGap, QOLUtils.Labels.Toon)
	opt.Toon.Active = opt.CreateCheckBox(scrollchild, toonHeader, indent, -itemGap, QOLUtils.Labels.UseToon, QOL_Config_Toon.Active, opt.ToggleToonSpecific)
	local toonACHeader = opt.CreateHeader(scrollchild, storage.Active, 0, -headerGap, QOLUtils.Labels.AC.Header)
	opt.CreateConfigItems(scrollchild, toonACHeader, QOL_Config_Toon, opt.Toon, indent, headerGap, itemGap)
	InterfaceOptions_AddCategory(opt.Panel);
end

function opt.CreateScrollFrame()
	opt.Panel = CreateFrame('Frame', 'QoL Utilities', UIParent)
	opt.Panel.name = 'QoL Utilities'
	opt.Panel.ScrollFrame = CreateFrame('ScrollFrame', 'QOL_Utils_ScrollFrame_' .. opt.GetUniqueID(), opt.Panel, 'UIPanelScrollFrameTemplate')
	opt.Panel.ScrollFrame:SetPoint('TOPLEFT', opt.Panel, 'TOPLEFT')
	opt.Panel.ScrollFrame:SetPoint('BOTTOMRIGHT', opt.Panel, 'BOTTOMRIGHT')
	opt.Panel.ScrollFrame.ScrollBar:ClearAllPoints()
	opt.Panel.ScrollFrame.ScrollBar:SetPoint('TOPRIGHT', opt.Panel.ScrollFrame, 'TOPRIGHT', -5, -22)
	opt.Panel.ScrollFrame.ScrollBar:SetPoint('BOTTOMRIGHT', opt.Panel.ScrollFrame, 'BOTTOMRIGHT', -5, 22)
	local scrollchild = CreateFrame('Frame', 'QOL_Utils_ScrollChild_' .. opt.GetUniqueID(), opt.Panel.ScrollFrame)
	scrollchild:SetSize(400, 800)
	scrollchild:SetPoint('TOPLEFT', opt.Panel.ScrollFrame, 'TOPLEFT', -30, 30)
	opt.Panel.ScrollFrame:SetScrollChild(scrollchild)
	return scrollchild
end

function opt.CreateConfigItems(scrollchild, firstRelativeParent, config, storage, indent, headerGap, itemGap)
	storage.AC = {}
	storage.AC.CheckBoxReport = opt.CreateCheckBox(scrollchild, firstRelativeParent, indent, -itemGap, QOLUtils.Labels.AC.Report, config.AC.ReportAtLogon, QOLUtils.AC.ToggleLogonReport)
	storage.AC.CheckBoxRefundable = opt.CreateCheckBox(scrollchild, storage.AC.CheckBoxReport, 0, -itemGap, QOLUtils.Labels.AC.Refundable, config.AC.RefundableActive, QOLUtils.AC.ToggleRefundable)
	storage.AC.CheckBoxTradeable = opt.CreateCheckBox(scrollchild, storage.AC.CheckBoxRefundable, 0, -itemGap, QOLUtils.Labels.AC.Tradeable, config.AC.TradeableActive, QOLUtils.AC.ToggleTradeable)
	storage.AC.CheckBoxBindable = opt.CreateCheckBox(scrollchild, storage.AC.CheckBoxTradeable, 0, -itemGap, QOLUtils.Labels.AC.Bindable, config.AC.BindableActive, QOLUtils.AC.ToggleBindable)
	storage.QM = {}
	local qmHeader = opt.CreateHeader(scrollchild, storage.AC.CheckBoxBindable, -indent, -headerGap, QOLUtils.Labels.QM.Header)
	storage.QM.CheckBoxReport = opt.CreateCheckBox(scrollchild, qmHeader, indent, -itemGap, QOLUtils.Labels.QM.Report, config.QM.ReportAtLogon, QOLUtils.QM.ToggleLogonReport)
	storage.QM.CheckBoxParty = opt.CreateCheckBox(scrollchild, storage.QM.CheckBoxReport, 0, -itemGap, QOLUtils.Labels.QM.Party, config.QM.PartyActive, QOLUtils.QM.ToggleParty)
	storage.QM.CheckBoxDuel = opt.CreateCheckBox(scrollchild, storage.QM.CheckBoxParty, 0, -itemGap, QOLUtils.Labels.QM.Duel, config.QM.DuelActive, QOLUtils.QM.ToggleDuel)
	storage.SMN = {}
	local smnHeader = opt.CreateHeader(scrollchild, storage.QM.CheckBoxDuel, -indent, -headerGap, QOLUtils.Labels.SMN.Header)
	storage.SMN.CheckBoxReport = opt.CreateCheckBox(scrollchild, smnHeader, indent, -itemGap, QOLUtils.Labels.SMN.Report, config.SMN.ReportAtLogon, QOLUtils.SMN.ToggleLogonReport)
	storage.SMN.CheckBoxPets = opt.CreateCheckBox(scrollchild, storage.SMN.CheckBoxReport, 0, -itemGap, QOLUtils.Labels.SMN.OnlyFavoritePets, config.SMN.OnlyFavoritePets, QOLUtils.SMN.ToggleFavoritePets)
	storage.SMN.CheckBoxMounts = opt.CreateCheckBox(scrollchild, storage.SMN.CheckBoxPets, 0, -itemGap, QOLUtils.Labels.SMN.OnlyFavoriteMounts, config.SMN.OnlyFavoriteMounts, QOLUtils.SMN.ToggleFavoriteMounts)
	storage.VC = {}
	local vcHeader = opt.CreateHeader(scrollchild, storage.SMN.CheckBoxMounts, -indent, -headerGap, QOLUtils.Labels.VC.Header)
	local toonVCLabel = opt.CreateLabel(scrollchild, vcHeader, indent, -itemGap, QOLUtils.Labels.VC.Levels)
	storage.VC.EditBoxLevels = opt.CreateEditBox(scrollchild, toonVCLabel, indent, -10, QOLUtils.TableToStr(config.VC.Levels), opt.ParseVolumeLevels)
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

function opt.UpdateCheckBox(checkBox, checked)
	checkBox:SetChecked(checked)
end