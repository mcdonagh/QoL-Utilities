local addonName, QOLUtils = ...

QOLUtils.VC = {}
local vc = QOLUtils.VC

function vc.LoadInitialVolume()
	local level = QOL_Config.VCLevels[QOL_Config.VCIndex]
	vc.SetVolume(level)
end

function vc.Cycle(args)
		-- QOL_Config.VCLevels = { 80, 20, 5 }
		-- QOL_Config.VCIndex = 1
	local level = 100
	if args[2] then
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

function vc.SetVolume(level)
	SetCVar('Sound_MasterVolume', (level / 100))
	vc.Log('Master Volume set to ' .. level .. '%.')
end

function vc.Log(message)
	QOLUtils.Log(message, 'VC')
end