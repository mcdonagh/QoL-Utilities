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
	local acCheckBox = opt.CreateCheckBox(panel, 30, -30, QOLUtils.Labels.OPT_AC, QOL_Config.AutoConfirmActive, QOLUtils.AC.ToggleAutoConfirm)
	local qmCheckBox = opt.CreateCheckBox(acCheckBox, 0, -40, QOLUtils.Labels.OPT_QM, QOL_Config.QuietModeActive, QOLUtils.QM.ToggleQuietMode)
	local vclEditBoxLabel = opt.CreateLabel(qmCheckBox, 0, -40, QOLUtils.Labels.OPT_VCL)
	local vclEditBox = opt.CreateEditBox(vclEditBoxLabel, 30, -15, opt.TableToStr(QOL_Config.VCLevels), opt.ParseVolumeLevels)
	opt.Panel = panel	
	opt.ACCheckBox = acCheckBox
	opt.QMCheckBox = qmCheckBox
	opt.VCLEditBox = vclEditBox
	InterfaceOptions_AddCategory(opt.Panel);
end

function opt.CreateHeader()

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