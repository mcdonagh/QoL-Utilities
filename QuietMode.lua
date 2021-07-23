local addonName, QOLUtils = ...

QOLUtils.QM = {}
local qm = QOLUtils.QM
local configAcct = QOL_Config_Acct.QM
local configToon = QOL_Config_Toon.QM
local optAcct = QOLUtils.OPT.Acct.QM
local optToon = QOLUtils.OPT.Toon.QM

function qm.IsEnabled()
	return QOLUtils.SettingIsTrue(configAcct.Enabled, configToon.Enabled)
end

function qm.ToggleEnabled()
	if configToon.Active then
		configToon.Enabled = not configToon.Enabled
	else
		configAcct.Enabled = not configAcct.Enabled
	end
end

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
	configAcct.PartyActive, configToon.PartyActive =
	QOLUtils.ToggleSetting(state,
		configAcct.PartyActive,
		configToon.PartyActive,
		optAcct.CheckBoxParty,
		optToon.CheckBoxParty)
end

function qm.ToggleDuel(state)
	configAcct.DuelActive, configToon.DuelActive =
	QOLUtils.ToggleSetting(state,
		configAcct.DuelActive,
		configToon.DuelActive,
		optAcct.CheckBoxDuel,
		optToon.CheckBoxDuel)
end

function qm.ToggleAll(state)
	if QOL_Config_Toon.Active then
		local combinedState = state or not (configToon.PartyActive or configToon.DuelActive)
		qm.ToggleParty(combinedState)
		qm.ToggleDuel(combinedState)
	else
		local combinedState = state or not (configAcct.PartyActive or configAcct.DuelActive)
		qm.ToggleParty(combinedState)
		qm.ToggleDuel(combinedState);
	end
end

function qm.ToggleLogonReport()
	configAcct.ReportAtLogon, configToon.ReportAtLogon =
	QOLUtils.ToggleSetting(nil,
		configAcct.ReportAtLogon,
		configToon.ReportAtLogon,
		optAcct.CheckBoxReport,
		optToon.CheckBoxReport)
end

function qm.ReportParty()
	if QOLUtils.SettingIsTrue(configAcct.PartyActive, configToon.PartyActive) then
		qm.Log('Automatically declining Party Invites.')
	else
		qm.Log('Manual confirmation required for Party Invites.')
	end
end

function qm.ReportDuel()
	if QOLUtils.SettingIsTrue(configAcct.DuelActive, configToon.DuelActive) then
		qm.Log('Automatically declining Duel Invites.')
	else
		qm.Log('Manual confirmation required for Duel Invites.')
	end
end

function qm.ReportAll()
	qm.ReportParty()
	qm.ReportDuel()
end

function qm.ReportInitial()
	if QOLUtils.SettingIsTrue(configAcct.ReportAtLogon, configToon.ReportAtLogon) then
		qm.ReportAll()
	end
end

function qm.DeclinePartyInvite(...)
	if QOLUtils.SettingIsTrue(configAcct.PartyActive, configToon.PartyActive) then
		local inviter = ...
		StaticPopup_Hide('PARTY_INVITE')
		qm.Log(format('Declined Party Invite from %s.', inviter))
	end
end

function qm.DeclineDuel(...)
	if QOLUtils.SettingIsTrue(configAcct.DuelActive, configToon.DuelActive) then
		local inviter = ...
		StaticPopup_Hide('DUEL_REQUESTED')
		CancelDuel()
		qm.Log(format('Declined Duel Request from %s.', inviter))
	end
end

function qm.TogglePartyOnClick()
	configAcct.PartyActive = optAcct.CheckBoxParty:GetChecked()
	configToon.PartyActive = optToon.CheckBoxParty:GetChecked()
end

function qm.ToggleDuelOnClick()
	configAcct.DuelActive = optAcct.CheckBoxDuel:GetChecked()
	configToon.DuelActive = optToon.CheckBoxDuel:GetChecked()
end

function qm.ToggleLogonReportOnClick()
	configAcct.ReportAtLogon = optAcct.CheckBoxReport:GetChecked()
	configToon.ReportAtLogon = optToon.CheckBoxReport:GetChecked()
end

function qm.Log(message)
	QOLUtils.Log(message, 'QM')
end
