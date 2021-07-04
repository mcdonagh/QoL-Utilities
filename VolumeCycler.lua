local addonName, QOLUtils = ...

QOLUtils.VC = {}
local vc = QOLUtils.VC

function vc.LoadInitialVolume()
	local level = QOL_Config_Toon.Active and QOL_Config_Toon.VC.Levels[QOL_Config_Toon.VC.Index] or QOL_Config.VC.Levels[QOL_Config.VC.Index]
	vc.SetVolume(level)
end

function vc.Cycle(args)
	local level = 100
	if args[2] then
		level = args[2]
	else
		local t = QOL_Config_Toon.Active and QOL_Config_Toon.VC.Levels or QOL_Config.VC.Levels
		local i = QOL_Config_Toon.Active and QOL_Config_Toon.VC.Index or QOL_Config.VC.Index
		local indexCount = table.getn(t)
		local desiredIndex = (i + 1) % indexCount
		if desiredIndex == 0 then
			desiredIndex = indexCount
		end
		if QOL_Config_Toon.Active then
			QOL_Config_Toon.VC.Index = desiredIndex
		else
			QOL_Config.VC.Index = desiredIndex
		end
		level = QOL_Config_Toon.Active and QOL_Config_Toon.VC.Levels[desiredIndex] or QOL_Config.VC.Levels[desiredIndex]
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