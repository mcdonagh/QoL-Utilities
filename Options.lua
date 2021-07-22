local addonName, QOLUtils = ...

QOLUtils.OPT = {}
local opt = QOLUtils.OPT

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
		config.QM.DuelActive = false;
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
	local mainScroller, mainScrollChild = opt.CreateScrollFrame('QoL Utilities')
	local acScroller, acScrollChild = opt.CreateScrollFrame('Auto Confirm')
	acSroller.parent = mainScroller.name
	local qmScroller, qmScrollChild = opt.CreateScrollFrame('Quiet Mode')
	qmScroller.parent = mainScroller.name
	local smnScroller, smnScrollChild = opt.CreateScrollFrame('Summon')
	smnScroller.parent = mainScroller.name
	local vcScroller, vcScrollChild = opt.CreateScrollFrame('Volume Cycler')
	vcScroller.parent = mainScroller.name
	opt.Acct = {}
	local acctHeader = opt.CreateHeader(scrollchild, scrollchild, indent, -sectionGap, QOLUtils.Labels.Acct)
	local acctACHeader = opt.CreateHeader(scrollchild, acctHeader, indent, -itemGap, QOLUtils.Labels.AC.Header)
	opt.CreateMainPanel(scrollchild, acctACHeader, QOL_Config_Acct, opt.Acct, indent, headerGap, itemGap)
	opt.Toon = {}
	local toonHeader = opt.CreateHeader(scrollchild, opt.Acct.VC.EditBoxLevels, -indent * 3, -sectionGap, QOLUtils.Labels.Toon)
	opt.Toon.Active = opt.CreateCheckBox(scrollchild, toonHeader, indent, -itemGap, QOLUtils.Labels.UseToon, QOL_Config_Toon.Active, opt.ToggleToonSpecific)
	local toonACHeader = opt.CreateHeader(scrollchild, opt.Toon.Active, 0, -headerGap, QOLUtils.Labels.AC.Header)
	opt.CreateMainPanel(scrollchild, toonACHeader, QOL_Config_Toon, opt.Toon, indent, headerGap, itemGap)
	opt.Panel = mainScroller
	InterfaceOptions_AddCategory(opt.Panel)
	InterfaceOptions_AddCategory(acScroller)
	InterfaceOptions_AddCategory(qmScroller)
	InterfaceOptions_AddCategory(smnScroller)
	InterfaceOptions_AddCategory(vcScroller)
end

function opt.CreateMainPanelItems(parent, firstRelativeParent, config, storage, indent, headerGap, itemGap)
	storage.ATC = {}
	storage.AT = {}
	storage.AC = {}
	storage.MM = {}
	storage.QM = {}
	storage.SMN = {}
	storage.VC = {}
end

function opt.CreateACPanelItems(parent, firstRelativeParent, config, storage, indent, headerGap, itemGap)
	storage.AC = {}
	storage.AC.CheckBoxReport = opt.CreateCheckBox(scrollchild, firstRelativeParent, indent, -itemGap, QOLUtils.Labels.AC.Report, config.AC.ReportAtLogon, QOLUtils.AC.ToggleLogonReportOnClick)
	storage.AC.CheckBoxRefundable = opt.CreateCheckBox(scrollchild, storage.AC.CheckBoxReport, 0, -itemGap, QOLUtils.Labels.AC.Refundable, config.AC.RefundableActive, QOLUtils.AC.ToggleRefundableOnClick)
	storage.AC.CheckBoxTradeable = opt.CreateCheckBox(scrollchild, storage.AC.CheckBoxRefundable, 0, -itemGap, QOLUtils.Labels.AC.Tradeable, config.AC.TradeableActive, QOLUtils.AC.ToggleTradeableOnClick)
	storage.AC.CheckBoxBindable = opt.CreateCheckBox(scrollchild, storage.AC.CheckBoxTradeable, 0, -itemGap, QOLUtils.Labels.AC.Bindable, config.AC.BindableActive, QOLUtils.AC.ToggleBindableOnClick)
end

function opt.CreateQMPanelItems(parent, firstRelativeParent, config, storage, indent, headerGap, itemGap)
	storage.QM = {}
	local qmHeader = opt.CreateHeader(scrollchild, storage.AC.CheckBoxBindable, -indent, -headerGap, QOLUtils.Labels.QM.Header)
	storage.QM.CheckBoxReport = opt.CreateCheckBox(scrollchild, qmHeader, indent, -itemGap, QOLUtils.Labels.QM.Report, config.QM.ReportAtLogon, QOLUtils.QM.ToggleLogonReportOnClick)
	storage.QM.CheckBoxParty = opt.CreateCheckBox(scrollchild, storage.QM.CheckBoxReport, 0, -itemGap, QOLUtils.Labels.QM.Party, config.QM.PartyActive, QOLUtils.QM.TogglePartyOnClick)
	storage.QM.CheckBoxDuel = opt.CreateCheckBox(scrollchild, storage.QM.CheckBoxParty, 0, -itemGap, QOLUtils.Labels.QM.Duel, config.QM.DuelActive, QOLUtils.QM.ToggleDuelOnClick)
end

function opt.CreateSMNPanelItems(parent, firstRelativeParent, config, storage, indent, headerGap, itemGap)
	storage.SMN = {}
	local smnHeader = opt.CreateHeader(scrollchild, storage.QM.CheckBoxDuel, -indent, -headerGap, QOLUtils.Labels.SMN.Header)
	storage.SMN.CheckBoxReport = opt.CreateCheckBox(scrollchild, smnHeader, indent, -itemGap, QOLUtils.Labels.SMN.Report, config.SMN.ReportAtLogon, QOLUtils.SMN.ToggleLogonReportOnClick)
	storage.SMN.CheckBoxPets = opt.CreateCheckBox(scrollchild, storage.SMN.CheckBoxReport, 0, -itemGap, QOLUtils.Labels.SMN.OnlyFavoritePets, config.SMN.OnlyFavoritePets, QOLUtils.SMN.ToggleFavoritePetsOnClick)
	storage.SMN.CheckBoxMounts = opt.CreateCheckBox(scrollchild, storage.SMN.CheckBoxPets, 0, -itemGap, QOLUtils.Labels.SMN.OnlyFavoriteMounts, config.SMN.OnlyFavoriteMounts, QOLUtils.SMN.ToggleFavoriteMountsOnClick)
end

function opt.CreateVCPanelItems(parent, firstRelativeParent, config, storage, indent, headerGap, itemGap)
	storage.VC = {}
	local vcHeader = opt.CreateHeader(scrollchild, storage.SMN.CheckBoxMounts, -indent, -headerGap, QOLUtils.Labels.VC.Header)
	local toonVCLabel = opt.CreateLabel(scrollchild, vcHeader, indent, -itemGap, QOLUtils.Labels.VC.Levels)
	storage.VC.EditBoxLevels = opt.CreateEditBox(scrollchild, toonVCLabel, indent, -10, QOLUtils.TableToStr(config.VC.Levels), opt.ParseVolumeLevels)
end

function opt.CreateScrollFrame(name)
	local scroller = CreateFrame('Frame', 'QoL Utilities', UIParent)
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