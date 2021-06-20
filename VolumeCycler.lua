local addonName, QOLUtils = ...

QOLUtils.VC = {}
local vc = QOLUtils.VC

function vc.Cycle(args)
		-- QOL_Config.VCLevels = { 80, 20, 5 }
		-- QOL_Config.VCIndex = 1
	local soundPercent = 1
	if args[2] then
		soundPercent = args[2]
	else
		local indexCount = table.getn(QOL_Config.VCLevels)
		local desiredIndex = (QOL_Config.VCIndex + 1) % indexCount
		if desiredIndex == 0 then
			desiredIndex = indexCount
		end
		QOL_Config.VCIndex = desiredIndex
		soundPercent = QOL_Config.VCLevels[desiredIndex]
	end
	SetCVar('Sound_MasterVolcume', (soundPercent / 100))
	vc.Log('volume set to ' .. soundPercent .. '%')
end

function vc.Log(message)
	QOLUtils.Log(message, 'VC')
end