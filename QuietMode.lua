local addonName, RU = ...

RU.QM = {}

function RU.QM.ToggleQuietMode()
	QuietModeActive = not QuietModeActive
	RU.QM.ReportState()
end

function RU.QM.ReportState()
	if QuietModeActive then
		RU.Log('now declining invites & duels')
	else
		RU.Log('now accepting invites & duels')
	end	
end

function RU.QM.DeclinePartyInvite(...)
	if QuietModeActive then
		local inviter = ...
		StaticPopup_Hide("PARTY_INVITE")
		RU.QM.Log('declined invite from ' .. inviter)
	end
end

function RU.QM.DeclineDuel(...)
	if QuietModeActive then
		local inviter = ...
		StaticPopup_Hide('DUEL_REQUESTED')
		RU.QM.Log('declined duel from ' .. inviter)
	end
end

function RU.QM.Log(message)
	RU.Log(message, 'QM')
end
