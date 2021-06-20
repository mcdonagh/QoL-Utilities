local addonName, QOLUtils = ...

QOLUtils.OPT = {}
local opt = QOLUtils.OPT

function opt.LoadDefaults()
	if QOL_Config == nil then
		QOL_Config = {}
	end
	if QOL_Config.QuietModeActive == nil then
		QOL_Config.QuietModeActive = false
	end
	if QOL_Config.AutoConfirmActive == nil then
		QOL_Config.AutoConfirmActive = false
	end
	if QOL_Config.VCLevels == nil then
		QOL_Config.VCLevels = {}
		table.insert(QOL_Config.VCLevels, 80)
		table.insert(QOL_Config.VCLevels, 20)
		table.insert(QOL_Config.VCLevels, 5)
	end
	if QOL_Config.VCIndex == nil then
		QOL_Config.VCIndex = 1
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
	local acCheckBox = opt.CreateCheckBox(panel, 30, -30, 'Auto confirm when equipping Tradeable or Refundable equipment.', QOL_Config.AutoConfirmActive, QOLUtils.AC.ToggleAutoConfirm)
	opt.CreateCheckBox(acCheckBox, 0, -30, 'Auto decline invites to join a party or to duel', QOL_Config.QuietModeActive, QOLUtils.QM.ToggleQuietMode)
	opt.Panel = panel	
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