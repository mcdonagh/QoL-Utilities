local addonName, QOLUtils = ...

QOLUtils.VC = {}
local vc = QOLUtils.VC

function vc.LoadInitialVolume()
	local level = QOL_Config.VCLevels[QOL_Config.VCIndex]
	vc.SetVolume(level)
end

function vc.Cycle(args)
	local level = 100
	if args[2] and vc.ValidLevel(args[2]) then
		level = args[2]
	else
		local indexCount = table.getn(QOL_Config.VCLevels)
		local desiredIndex = (QOL_Config.VCIndex + 1) % indexCount
		if desiredIndex == 0 then
			desiredIndex = indexCount
		end
		QOL_Config.VCIndex = desiredIndex
		level = QOL_Config.VCLevels[desiredIndex]
	end
	vc.SetVolume(level)
end

function vc.ValidLevel(l)
	local level = tonumber(l)
	return level >= 0 and level <= 100
end

function vc.SetVolume(l)
	local level = tonumber(l)
	if level then
		SetCVar('Sound_MasterVolume', (level / 100))
		vc.Log(format('Master Volume set to %d%%.', level))
	end
end

function vc.Log(message)
	QOLUtils.Log(message, 'VC')
end