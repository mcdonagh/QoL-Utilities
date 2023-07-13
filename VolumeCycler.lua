local addonName, QOLUtils = ...

QOLUtils.VC = {}
local vc = QOLUtils.VC
local feature = 'VC'
local configAcct, configToon, storage

function vc.Load()
	configAcct = QOL_Config_Acct.VC
	configToon = QOL_Config_Toon.VC
	storage = QOLUtils.OPT.Storage.VC
end

function vc.IsEnabled()
	return QOLUtils.SettingIsTrue(feature, 'Enabled')
end

function vc.CheckBoxEnabled_OnClick()
	local config = QOLUtils.GetConfig(feature)
	config.Enabled = storage.CheckBoxEnabled:GetChecked()
end

function vc.LoadInitialVolume()
	local config = QOLUtils.GetConfig(feature)
	local level = config.Levels[config.Index]
	vc.SetVolume(level)
end

function vc.Cycle(args)
	local level = 100
	if args[2] then
		level = args[2]
	else
		local config = QOLUtils.GetConfig(feature)
		local t = config.Levels
		local i = config.Index
		local desiredIndex = (i + 1) > #t and 1 or i + 1
		config.Index = desiredIndex
		level = config.Levels[desiredIndex]
	end
	vc.SetVolume(level)
end

function vc.ValidLevel(level)
	local num = tonumber(level)
	return num >= 0 and num <= 100
end

function vc.SetVolume(level)
	if vc.ValidLevel(level) then
		SetCVar('Sound_MasterVolume', (level / 100))
		vc.Log(format('Master Volume set to %d%%.', level))
	end
end

function vc.Log(...)
	QOLUtils.Log(feature, ...)
end