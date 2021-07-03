local addonName, QOLUtils = ...

QOLUtils.QM = {}
local qm = QOLUtils.QM

function qm.ToggleQuietModeAndReport(args)
	local indicator = args[2]
	if indicator == 'p' then
		qm.ToggleParty(nil)
		qm.ReportParty()
	elseif indicator == 'd' then
		qm.ToggleDuel(nil)
		qm.ReportDuel()
	else
		if indicator == 'on' then
			qm.ToggleAll(true)
		elseif indicator == 'off' then
			qm.ToggleAll(false)
		else
			qm.ToggleAll(nil)
		end
		qm.ReportAll()
	end
end

function qm.ToggleParty(state)
	if QOL_Config_Toon.Active then
		if state == nil then
			QOL_Config_Toon.QM.PartyActive = not QOL_Config_Toon.QM.PartyActive
		else
			QOL_Config_Toon.QM.PartyActive = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.QM.CheckBoxParty, QOL_Config_Toon.QM.PartyActive)
	else
		if state == nil then
			QOL_Config.QM.PartyActive = not QOL_Config.QM.PartyActive
		else
			QOL_Config.QM.PartyActive = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.QM.CheckBoxParty, QOL_Config.QM.PartyActive)
	end
end

function qm.ToggleDuel(state)
	if QOL_Config_Toon.Active then
		if state == nil then
			QOL_Config_Toon.QM.DuelActive = not QOL_Config_Toon.QM.DuelActive
		else
			QOL_Config_Toon.QM.DuelActive = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.QM.CheckBoxDuel, QOL_Config_Toon.QM.DuelActive)
	else
		if state == nil then
			QOL_Config.QM.DuelActive = not QOL_Config.QM.DuelActive
		else
			QOL_Config.QM.DuelActive = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.QM.CheckBoxDuel, QOL_Config.QM.DuelActive)
	end
end

function qm.ToggleAll(state)
	if QOL_Config_Toon.Active then
		local combinedState = state or QOL_Config_Toon.QM.PartyActive or QOL_Config_Toon.QM.DuelActive
		qm.ToggleParty(combinedState)
		qm.ToggleDuel(combinedState)
	else
		local combinedState = state or QOL_Config.QM.PartyActive or QOL_Config.QM.DuelActive
		qm.ToggleParty(combinedState)
		qm.ToggleDuel(combinedState);
	end
end

function qm.ToggleLogonReport()
	if QOL_Config_Toon.Active then
		QOL_Config_Toon.QM.ReportAtLogon = not QOL_Config_Toon.QM.ReportAtLogon
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.QM.CheckBoxReport, QOL_Config_Toon.QM.ReportAtLogon)
	else
		QOL_Config.QM.ReportAtLogon = not QOL_Config.QM.ReportAtLogon
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.QM.CheckBoxReport, QOL_Config.QM.ReportAtLogon)
	end
end

function qm.ReportParty()
	if (QOL_Config_Toon.Active and QOL_Config_Toon.QM.PartyActive)
			or (not QOL_Config_Toon.Active and QOL_Config.QM.PartyActive) then
		qm.Log('Automatically declining Party Invites.')
	else
		qm.Log('Manual confirmation required for Party Invites.')
	end
end

function qm.ReportDuel()
	if (QOL_Config_Toon.Active and QOL_Config_Toon.QM.DuelActive)
			or (not QOL_Config_Toon.Active and QOL_Config.QM.DuelActive) then
		qm.Log('Automatically declining Duel Invites.')
	else
		qm.Log('Manual confirmation required for Duel Invites.')
	end
end

function qm.ReportAll()
	if (QOL_Config_Toon.Active and QOL_Config_Toon.QM.PartyActive and QOL_Config_Toon.QM.DuelActive)
			or (not QOL_Config_Toon.Active and QOL_Config.QM.PartyActive and QOL_Config.QM.DuelActive) then
		qm.Log('Automatically declining Party Invites and Duel Requests.')
	else
		qm.Log('Manual confirmation required for Party Invites and Duel Requests.')
	end
end

function qm.ReportInitial()
	if (QOL_Config_Toon.Active and QOL_Config_Toon.QM.ReportAtLogon)
			or (not QOL_Config_Toon.Active and QOL_Config.QM.ReportAtLogon) then
		qm.ReportParty()
		qm.ReportDuel()
	end
end

function qm.DeclinePartyInvite(...)
	if (QOL_Config_Toon.Active and QOL_Config_Toon.QM.PartyActive)
			or (not QOL_Config_Toon.Active and QOL_Config.QM.PartyActive) then
		local inviter = ...
		StaticPopup_Hide('PARTY_INVITE')
		qm.Log(format('Declined Party Invite from %s.', inviter))
	end
end

function qm.DeclineDuel(...)
	if (QOL_Config_Toon.Active and QOL_Config_Toon.QM.DuelActive)
			or (not QOL_Config_Toon.Active and QOL_Config.QM.DuelActive) then
		local inviter = ...
		StaticPopup_Hide('DUEL_REQUESTED')
		CancelDuel()
		qm.Log(format('Declined Duel Request from %s', inviter))
	end
end

function qm.Log(message)
	QOLUtils.Log(message, 'QM')
end
