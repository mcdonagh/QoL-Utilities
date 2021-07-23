local addonName, QOLUtils = ...

QOLUtils.OPT = {}
QOLUtils.OPT.Storage = {}
local opt = QOLUtils.OPT
local storage = opt.Storage
local spacing = QOLUtils.ConfigSpacing
local labels = QOLUtils.Labels

function opt.LoadDefaults()
	if QOL_Config_Acct == nil then
		QOL_Config_Acct = QOL_Config or {}
	end
	opt.GenerateDefaults(QOL_Config_Acct)
	if QOL_Config_Toon == nil then
		QOL_Config_Toon = {}
	end
	opt.GenerateDefaults(QOL_Config_Toon)
	if QOL_Config_Toon.Active == nil then
		QOL_Config_Toon.Active = false
	end
end

function opt.GenerateDefaults(config)
	if config.ATC == nil then
		config.ATC = {}
	end
	if config.ATC.Enabled == nil then
		config.ATC.Enabled = false
	end
	if config.AT == nil then
		config.AT = {}
	end
	if config.AT.Enabled == nil then
		config.AT.Enabled = false
	end
	if config.AC == nil then
		config.AC = {}
	end
	if config.AC.Enabled == nil then
		config.AC.Enabled = false
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
		config.MM.Enabled = false
	end
	if config.QM == nil then
		config.QM = {}
	end
	if config.QM.Enabled == nil then
		config.QM.Enabled = false
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
		config.SMN.Enabled = false
	end
	if config.SMN.ReportAtLogon == nil then
		config.SMN.ReportAtLogon = false
	end
	if config.SMN.OnlyFavoritePets == nil then
		config.SMN.OnlyFavoritePets = false
	end
	if config.SMN.OnlyFavoriteMounts == nil then
		config.SMN.OnlyFavoriteMounts = false
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

function opt.OpenConfig()
	InterfaceOptionsFrame_Show()
	InterfaceOptionsFrame_OpenToCategory(opt.Panel)
end

function opt.CreateConfig()
	local scroller, scrollchild = opt.CreateScrollFrame(labels.Header)
	storage.CheckBoxToonActive = opt.CreateCheckBox(scrollchild, scrollchild, spacing.Indent, -spacing.SectionGap, labels.UseToon, QOL_Config_Toon.Active, opt.ToggleToonSpecific)
	storage.ATC = {}
	local atcHeader = opt.CreateHeader(scrollchild, storage.CheckBoxToonActive, 0, spacing.SectionGap, labels.ATC.Header)
	storage.ATC.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, atcHeader, spacing.Indent, -spacing.ItemGap, labels.Enabled, QOLUtils.ATC.ToggleEnabled)
	storage.AT = {}
	local atHeader = opt.CreateHeader(scrollchild, storage.ATC.CheckBoxEnabled, -spacing.Indent, -spacing.HeaderGap, labels.AT.Header)
	storage.AT.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, atHeader, spacing.Indent, -spacing.ItemGap, labels.Enabled,, QOLUtils.AT.ToggleEnabled)
	storage.AC = {}
	local acHeader = opt.CreateHeader(scrollchild, storage.AT.CheckBoxEnabled, -spacing.Indent, -spacing.HeaderGap, labels.AC.Header)
	storage.AC.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, acHeader, spacing.Indent, -spacing.ItemGap, labels.Enabled, QOLUtils.AC.ToggleEnabled)
	storage.AC.CheckBoxReport = opt.CreateCheckBox(scrollchild, storage.AC.CheckBoxEnabled, 0, -spacing.ItemGap, labels.AC.Report, QOLUtils.AC.ToggleLogonReportOnClick)
	storage.AC.CheckBoxRefundable = opt.CreateCheckBox(scrollchild, storage.AC.CheckBoxReport, 0, -spacing.ItemGap, labels.AC.Refundable, QOLUtils.AC.ToggleRefundableOnClick)
	storage.AC.CheckBoxTradeable = opt.CreateCheckBox(scrollchild, storage.AC.CheckBoxRefundable, 0, -spacing.ItemGap, labels.AC.Tradeable, QOLUtils.AC.ToggleTradeableOnClick)
	storage.AC.CheckBoxBindable = opt.CreateCheckBox(scrollchild, storage.AC.CheckBoxTradeable, 0, -spacing.ItemGap, labels.AC.Bindable, QOLUtils.AC.ToggleBindableOnClick)
	storage.MM = {}
	local mmHeader = opt.CreateHeader(scrollchild, storage.AC.CheckBoxBindable, -spacing.Indent, -spacing.HeaderGap, labels.MM.Header)
	storage.MM.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, mmHeader, spacing.Indent, -spacing.ItemGap, labels.Enabled, QOLUtils.MM.ToggleEnabled)
	storage.QM = {}
	local qmHeader = opt.CreateHeader(scrollchild, storage.MM.CheckBoxEnabled, -spacing.Indent, -spacing.HeaderGap, labels.QM.Header)
	storage.QM.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, qmHeader, spacing.Indent, -spacing.ItemGap, labels.Enabled, QOLUtils.QM.ToggleEnabled)
	storage.QM.CheckBoxReport = opt.CreateCheckBox(scrollchild, storage.QM.CheckBoxEnabled, 0, -spacing.ItemGap, labels.QM.Report, QOLUtils.QM.ToggleLogonReportOnClick)
	storage.QM.CheckBoxParty = opt.CreateCheckBox(scrollchild, storage.QM.CheckBoxReport, 0, -spacing.ItemGap, labels.QM.Party, QOLUtils.QM.TogglePartyOnClick)
	storage.QM.CheckBoxDuel = opt.CreateCheckBox(scrollchild, storage.QM.CheckBoxParty, 0, -spacing.ItemGap, labels.QM.Duel, QOLUtils.QM.ToggleDuelOnClick)
	storage.SMN = {}
	local smnHeader = opt.CreateHeader(scrollchild, storage.QM.CheckBoxDuel, -spacing.Indent, -spacing.HeaderGap, labels.SMN.Header)
	storage.SMN.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, smnHeader, spacing.Indent, -spacing.ItemGap, labels.Enabled, QOLUtils.SMN.ToggleEnabled)
	storage.SMN.CheckBoxReport = opt.CreateCheckBox(scrollchild, storage.SMN.CheckBoxEnabled, 0, -spacing.ItemGap, labels.SMN.Report, QOLUtils.SMN.ToggleLogonReportOnClick)
	storage.SMN.CheckBoxPets = opt.CreateCheckBox(scrollchild, storage.SMN.CheckBoxReport, 0, -spacing.ItemGap, labels.SMN.OnlyFavoritePets, QOLUtils.SMN.ToggleFavoritePetsOnClick)
	storage.SMN.CheckBoxMounts = opt.CreateCheckBox(scrollchild, storage.SMN.CheckBoxPets, 0, -spacing.ItemGap, labels.SMN.OnlyFavoriteMounts, QOLUtils.SMN.ToggleFavoriteMountsOnClick)
	storage.VC = {}
	local vcHeader = opt.CreateHeader(scrollchild, storage.SMN.CheckBoxMounts, -spacing.Indent, -spacing.HeaderGap, labels.VC.Header)
	storage.VC.CheckBoxEnabled = opt.CreateCheckBox(scrollchild, vcHeader, spacing.Indent, -spacing.ItemGap, labels.Enabled, QOLUtils.VC.ToggleEnabled)
	local vcLabel = opt.CreateLabel(scrollchild, vcHeader, spacing.Indent, -spacing.ItemGap, labels.VC.Levels)
	storage.VC.EditBoxLevels = opt.CreateEditBox(scrollchild, vcLabel, spacing.Indent, -10, opt.ParseVolumeLevels)
	opt.Panel = scroller
	InterfaceOptions_AddCategory(opt.Panel)
end

function opt.UpdateConfig()
	-- Character Specific CheckBox
	opt.UpdateCheckBox(storage.CheckBoxToonActive, QOL_Config_Toon.Active)
	-- Achievement Tracker Cleaner
	opt.UpdateCheckBox(storage.ATC.CheckBoxEnabled, QOLUtils.SettingIsTrue(QOL_Config_Acct.ATC.Enabled, QOL_Config_Toon.ATC.Enabled))
	-- Announce Target
	opt.UpdateCheckBox(storage.AT.CheckBoxEnabled, QOLUtils.SettingIsTrue(QOL_Config_Acct.AT.Enabled, QOL_Config_Toon.AT.Enabled))
	-- Auto Confirm
	opt.UpdateCheckBox(storage.AC.CheckBoxEnabled, QOLUtils.SettingIsTrue(QOL_Config_Acct.AC.Enabled, QOL_Config_Toon.AC.Enabled))
	opt.UpdateCheckBox(storage.AC.CheckBoxReport, QOLUtils.SettingIsTrue(QOL_Config_Acct.AC.ReportAtLogon, QOL_Config_Toon.AC.ReportAtLogon))
	opt.UpdateCheckBox(storage.AC.CheckBoxRefundable, QOLUtils.SettingIsTrue(QOL_Config_Acct.AC.RefundableActive, QOL_Config_Toon.AC.RefundableActive))
	opt.UpdateCheckBox(storage.AC.CheckBoxTradeable, QOLUtils.SettingIsTrue(QOL_Config_Acct.AC.TradeableActive, QOL_Config_Toon.AC.TradeableActive))
	opt.UpdateCheckBox(storage.AC.CheckBoxBindable, QOLUtils.SettingIsTrue(QOL_Config_Acct.AC.BindableActive, QOL_Config_Toon.AC.BindableActive))
	-- Middle Marker
	opt.UpdateCheckBox(storage.MM.CheckBoxEnabled, QOLUtils.SettingIsTrue(QOL_Config_Acct.MM.Enabled, QOL_Config_Toon.MM.Enabled))
	-- Quiet Mode
	opt.UpdateCheckBox(storage.QM.CheckBoxEnabled, QOLUtils.SettingIsTrue(QOL_Config_Acct.QM.Enabled, QOL_Config_Toon.QM.Enabled))
	opt.UpdateCheckBox(storage.QM.CheckBoxReport, QOLUtils.SettingIsTrue(QOL_Config_Acct.QM.ReportAtLogon, QOL_Config_Toon.QM.ReportAtLogon))
	opt.UpdateCheckBox(storage.QM.CheckBoxParty, QOLUtils.SettingIsTrue(QOL_Config_Acct.QM.PartyActive, QOL_Config_Toon.QM.PartyActive))
	opt.UpdateCheckBox(storage.QM.CheckBoxDuel, QOLUtils.SettingIsTrue(QOL_Config_Acct.QM.DuelActive, QOL_Config_Toon.QM.DuelActive))
	-- Summon
	opt.UpdateCheckBox(storage.SMN.CheckBoxEnabled, QOLUtils.SettingIsTrue(QOL_Config_Acct.SMN.Enabled, QOL_Config_Toon.SMN.Enabled))
	opt.UpdateCheckBox(storage.SMN.CheckBoxReport, QOLUtils.SettingIsTrue(QOL_Config_Acct.SMN.ReportAtLogon, QOL_Config_Toon.SMN.ReportAtLogon))
	opt.UpdateCheckBox(storage.SMN.CheckBoxPets, QOLUtils.SettingIsTrue(QOL_Config_Acct.SMN.OnlyFavoritePets, QOL_Config_Toon.SMN.OnlyFavoritePets))
	opt.UpdateCheckBox(storage.SMN.CheckBoxMounts, QOLUtils.SettingIsTrue(QOL_Config_Acct.SMN.OnlyFavoriteMounts, QOL_Config_Toon.SMN.OnlyFavoriteMounts))
	-- Volume Cycler
	opt.UpdateCheckBox(storage.VC.CheckBoxEnabled, QOLUtils.SettingIsTrue(QOL_Config_Acct.VC.Enabled, QOL_Config_Toon.VC.Enabled))
	storage.VC.EditBoxLevels:SetText(QOLUtils.TableToStr(QOL_Config_Toon.Active and QOL_Config_Toon.VC.Levels or QOL_Config_Acct.VC.Levels))
end

function opt.CreateScrollFrame(name)
	local scroller = CreateFrame('Frame', 'QOL_Utils_Frame_' .. opt.GetUniqueID(), UIParent)
	scroller.name = name
	scroller.ScrollFrame = CreateFrame('ScrollFrame', 'QOL_Utils_ScrollFrame_' .. opt.GetUniqueID(), scroller, 'UIPanelScrollFrameTemplate')
	scroller.ScrollFrame:SetPoint('TOPLEFT', scroller, 'TOPLEFT')
	scroller.ScrollFrame:SetPoint('BOTTOMRIGHT', scroller, 'BOTTOMRIGHT')
	scroller.ScrollFrame.ScrollBar:ClearAllPoints()
	scroller.ScrollFrame.ScrollBar:SetPoint('TOPRIGHT', scroller.ScrollFrame, 'TOPRIGHT', -5, -22)
	scroller.ScrollFrame.ScrollBar:SetPoint('BOTTOMRIGHT', scroller.ScrollFrame, 'BOTTOMRIGHT', -5, 22)
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

function opt.CreateCheckBox(parent, relativeParent, x, y, text, callback)
	local checkBox = CreateFrame('CheckButton', 'QOLUtils_CheckBox_' .. opt.GetUniqueID(), parent, 'ChatConfigCheckButtonTemplate')
	checkBox:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	getglobal(checkBox:GetName() .. 'Text'):SetText(text)
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

function opt.CreateEditBox(parent, relativeParent, x, y, callback)
	local editBox = CreateFrame('EditBox', 'QOLUtils_EditBox_' .. opt.GetUniqueID(), parent, 'InputBoxTemplate')
	editBox:SetPoint('TOPLEFT', relativeParent, 'TOPLEFT', x, y)
	editBox:SetSize(200, 30)
	editBox:SetMultiLine(false)
	editBox:SetAutoFocus(false)
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
	opt.UpdateConfig()
end

function opt.ParseVolumeLevels(self)
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

function opt.UpdateCheckBox(checkBox, checked)
	checkBox:SetChecked(checked)
end