local addonName, QOLUtils = ...

QOLUtils.VC = {}
local vc = QOLUtils.VC
local configAcct = QOL_Config_Acct.VC
local configToon = QOL_Config_Toon.VC
local optAcct = QOLUtils.OPT.Acct.VC
local optToon = QOLUtils.OPT.Toon.VC

function vc.IsEnabled()
	return QOLUtils.SettingIsTrue(configAcct.Enabled, configToon.Enabled)
end

function vc.ToggleEnabled()
	if configToon.Active then
		configToon.Enabled = not configToon.Enabled
	else
		configAcct.Enabled = not configAcct.Enabled
	end
end

function vc.LoadInitialVolume()
	local level = QOL_Config_Toon.Active and configToon.Levels[configToon.Index] or configAcct.Levels[configAcct.Index]
	vc.SetVolume(level)
end

function vc.Cycle(args)
	local level = 100
	if args[2] then
		level = args[2]
	else
		local t = QOL_Config_Toon.Active and configToon.Levels or configAcct.Levels
		local i = QOL_Config_Toon.Active and configToon.Index or configAcct.Index
		local indexCount = table.getn(t)
		local desiredIndex = (i + 1) % indexCount
		if desiredIndex == 0 then
			desiredIndex = indexCount
		end
		if QOL_Config_Toon.Active then
			configToon.Index = desiredIndex
		else
			configAcct.Index = desiredIndex
		end
		level = QOL_Config_Toon.Active and configToon.Levels[desiredIndex] or configAcct.Levels[desiredIndex]
	end
	vc.SetVolume(level)
end

function vc.ValidLevel(l)
	local level = tonumber(l)
	return level >= 0 and level <= 100
end

function vc.SetVolume(level)
	if vc.ValidLevel(level) then
		SetCVar('Sound_MasterVolume', (level / 100))
		vc.Log(format('Master Volume set to %d%%.', level))
	end
end

function vc.Log(message)
	QOLUtils.Log(message, 'VC')
end