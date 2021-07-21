local addonName, QOLUtils = ...

SLASH_QOLUTILITIES1 = '/qol'
SlashCmdList['QOLUTILITIES'] = function (msg)
	QOLUtils.ParseInput(msg)
end

function QOLUtils.ParseInput(msg)
	local args = QOLUtils.StrToTable(msg, QOLUtils.Patterns.Words)
	local direction = args[1]
	if QOLUtils.IsNilOrWhitespace(msg) then
		QOLUtils.OPT.OpenConfig()
	elseif direction == 'atc' then
		if QOLUtils.ATC.IsEnabled() then
			QOLUtils.ATC.Clean(true)
		end
	elseif direction == 'at' then
		if QOLUtils.AT.IsEnabled() then
			QOLUtils.AT.AnnounceTarget(args)
		end
	elseif direction == 'ac' then
		if QOLUtils.AC.IsEnabled() then
			QOLUtils.AC.ToggleAndReport(args)
		end
	elseif direction == 'mm' then
		if QOLUtils.MM.IsEnabled() then
			QOLUtils.MM.ToggleMiddleMarker()
		end
	elseif direction == 'qm' then
		if QOLUtils.QM.IsEnabled() then
			QOLUtils.QM.ToggleAndReport(args)
		end
	elseif direction == 'smn' then
		if QOLUtils.SMN.IsEnabled() then
			QOLUtils.SMN.Summon(args)
		end
	elseif direction == 'vc' then
		if QOLUtils.VC.IsEnabled() then
			QOLUtils.VC.Cycle(args)
		end
	end
end