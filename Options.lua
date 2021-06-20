local addonName, QOLUtils = ...

QOLUtils.OPT = {}
local opt = QOLUtils.OPT

function opt.LoadDefaults()
	if not QOL_Config then
		QOL_Config = {}
		QOL_Config.QuietModeActive = false
		QOL_Config.AutoConfirmActive = false
		QOL_Config.VCLevels = { 80, 20, 5 }
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
	opt.CreateCheckBox(panel, 30, -30, 'Auto confirm when equipping Tradeable or Refundable equipment.', QOL_Config.AutoConfirmActive, QOLUtils.AC.ToggleAutoConfirm(false))
	opt.CreateCheckBox(panel, 70, -30, 'Auto decline invites to join a party or to duel', QOL_Config.QuietModeActive, QOLUtils.QM.ToggleQuietMode(false))
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