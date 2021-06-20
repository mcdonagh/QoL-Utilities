local addonName, QOLUtils = ...

QOLUtils.QM = {}
local qm = QOLUtils.QM

function qm.ToggleQuietMode(reportState)
	QOL_Config.QuietModeActive = not QOL_Config.QuietModeActive
	if reportState ~= nil and reportState then
		qm.ReportState()
	end
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
		StaticPopup_Hide("PARTY_INVITE")
		qm.Log('Declined Party Invite from ' .. inviter .. '.')
	end
end

function qm.DeclineDuel(...)
	if QOL_Config.QuietModeActive then
		local inviter = ...
		StaticPopup_Hide('DUEL_REQUESTED')
		qm.Log('Declined Duel Request from ' .. inviter .. '.')
	end
end

function qm.Log(message)
	QOLUtils.Log(message, 'QM')
end
