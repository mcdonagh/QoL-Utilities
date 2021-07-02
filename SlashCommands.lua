local addonName, QOLUtils = ...

SLASH_QOLUTILITIES1 = '/qol'
SlashCmdList['QOLUTILITIES'] = function (msg)
	QOLUtils.ParseInput(msg)
end

function QOLUtils.ParseInput(msg)
	local args = QOLUtils.OPT.StrToTable(msg, QOLUtils.Patterns.Words)
	local direction = args[1]
	if QOLUtils.IsEmpty(msg) then
		QOLUtils.OPT.OpenConfig()
	elseif direction == 'atc' then
		QOLUtils.ATC.Clean(true)
	elseif direction == 'ac' then
		QOLUtils.AC.ToggleAndReport(args)
	elseif direction == 'at' then
		QOLUtils.AT.AnnounceTarget(args)
	elseif direction == 'mm' then
		QOLUtils.MM.ToggleMiddleMarker()
	elseif direction == 'qm' then
		QOLUtils.QM.ToggleAndReport(args)
	elseif direction == 'smn' then
		QOLUtils.SMN.Summon(args)
	elseif direction == 'vc' then
		QOLUtils.VC.Cycle(args)
	end
end