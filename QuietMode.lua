local addonName, QOLUtils = ...

QOLUtils.QM = {}
local qm = QOLUtils.QM

function qm.ToggleQuietMode(reportState)
	QuietModeActive = not QuietModeActive
	if reportState then
		qm.ReportState()
	end
end

function qm.ReportState()
	if QuietModeActive then
		qm.Log('now declining invites & duels')
	else
		qm.Log('now accepting invites & duels')
	end	
end

function qm.DeclinePartyInvite(...)
	if QuietModeActive then
		local inviter = ...
		StaticPopup_Hide("PARTY_INVITE")
		qm.Log('declined invite from ' .. inviter)
	end
end

function qm.DeclineDuel(...)
	if QuietModeActive then
		local inviter = ...
		StaticPopup_Hide('DUEL_REQUESTED')
		qm.Log('declined duel from ' .. inviter)
	end
end

function qm.Log(message)
	QOLUtils.Log(message, 'QM')
end
