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
	local acCheckBox = opt.CreateCheckBox(panel, 30, -30, QOLUtils.Labels.OPT_AC, QOL_Config.AutoConfirmActive, QOLUtils.AC.ToggleAutoConfirm)
	local qmCheckBox = opt.CreateCheckBox(acCheckBox, 0, -30, QOLUtils.Labels.OPT_QM, QOL_Config.QuietModeActive, QOLUtils.QM.ToggleQuietMode)
	local vclEditBox = opt.CreateEditBox(qmCheckBox, 0, -30, QOLUtils.Labels.OPT_VCL, opt.TableToStr(QOL_Config.VCLevels), opt.ParseVolumeLevels)
	local vciEditBox = opt.CreateEditBox(vclEditBox, 0, -30, QOLUtils.Labels.OPT_VCI, QOL_Config.VCIndex, opt.ParseVolumeIndex)
	opt.Panel = panel	
	opt.ACCheckBox = acCheckBox
	opt.QMCheckBox = qmCheckBox
	opt.VCLEditBox = vclEditBox
	opt.VCIEditBox = vciEditBox
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

function opt.CreateEditBox(parent, x, y, label, text, callback)
	uniqueID = uniqueID + 1
	local editBox = CreateFrame('EditBox', 'QOLUtils_EditBox_' .. uniqueID, parent, 'InputBoxTemplate')
	editBox:SetPoint('TOPLEFT', x, y)
	editBox.Label:SetText(label)
	editBox:SetScript('OnEditFocusLost', callback)
	editBox:SetText(text)
end

function opt.ParseVolumeLevels()
	local enteredPresets = opt.StrToTable(opt.VCLEditBox, QOLUtils.Patterns.Numbers)
	local validPresets = {}
	for i = 1, #enteredPresets do
		if QOLUtils.VC.ValidLevel(enteredPresets[i]) then
			table.insert(validPresets, enteredPresets[i])
	QOL_Config.VCLevels = validPresets
	opt.VCLEditBox:SetText(opt.TableToStr(QOL_Config.VCLevels))
end

function opt.ParseVolumeIndex()
	local index = opt.VCIEditBox:gmatch(QOLUtils.Patterns.Numbers)
	if index < 1 then
		index = 1
	elseif index > #opt.VCLevels then
		index = #opt.VCLevels
	end
	QOL_Config.VCIndex = index
end

function opt.StrToTable(s, pattern)	
	local args = {}
	for num in msg:gmatch(QOLUtils.Patterns.Numbers) do
		if num:len() <= 3 then 
			table.insert(args, num)
		end
	end
	return args
end

function opt.TableToStr(t)
	local s = ''
	for i = 1, #t do
		s = t[i] .. ' '
	end	
   return s:gsub(QOLUtils.Patterns.WhiteSpaceStart, ''):gsub(QOLUtils.Patterns.WhiteSpaceEnd, '')
end

function opt.UpdateCheckBox(checkBox, checked)
	checkBox:SetChecked(checked)
end