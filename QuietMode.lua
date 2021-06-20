local addonName, RU = ...

RU.QM = {}
local qm = RU.QM

function qm.ToggleQuietMode()
	QuietModeActive = not QuietModeActive
	qm.ReportState()
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
	RU.Log(message, 'QM')
end
