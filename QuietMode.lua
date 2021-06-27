local addonName, QOLUtils = ...

QOLUtils.QM = {}
local qm = QOLUtils.QM

function qm.ToggleQuietModeAndReport()
	qm.ToggleQuietMode()
	qm.ReportState()
end

function qm.ToggleQuietMode()
	QOL_Config.QuietModeActive = not QOL_Config.QuietModeActive
	QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.QMCheckBox, QOL_Config.QuietModeActive)
end

function qm.ReportState()
	if QOL_Config.QuietModeActive then
		qm.Log('Automatically declining Party Invites & Duel Requests.')
	else
		qm.Log('Manual confirmation required for Party Invites & Duel Requests.')
	end	
end

function qm.DeclinePartyInvite(...)
	if QOL_Config.QuietModeActive then
		local inviter = ...
		StaticPopup_Hide('PARTY_INVITE')
		qm.Log(format('Declined Party Invite from %s.', inviter))
	end
end

function qm.DeclineDuel(...)
	if QOL_Config.QuietModeActive then
		local inviter = ...
		StaticPopup_Hide('DUEL_REQUESTED')
		CancelDuel()
		qm.Log(format('Declined Duel Request from %s', inviter))
	end
end

function qm.Log(message)
	QOLUtils.Log(message, 'QM')
end
