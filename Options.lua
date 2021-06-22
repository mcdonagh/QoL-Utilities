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