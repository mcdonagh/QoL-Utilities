local addonName, QOLUtils = ...

QOLUtils.QM = {}
local qm = QOLUtils.QM
local configWindowAcct = QOLUtils.OPT.Acct.QM
local configWindowToon = QOLUtils.OPT.Toon.QM

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
	QOL_Config.QM.PartyActive, QOL_Config_Toon.QM.PartyActive =
	QOLUtils.ToggleSetting(state,
		QOL_Config.QM.PartyActive,
		QOL_Config_Toon.QM.PartyActive,
		configWindowAcct.CheckBoxParty,
		configWindowToon.CheckBoxParty)
end

function qm.ToggleDuel(state)
	QOL_Config.QM.DuelActive, QOL_Config_Toon.QM.DuelActive =
	QOLUtils.ToggleSetting(state,
		QOL_Config.QM.DuelActive,
		QOL_Config_Toon.QM.DuelActive,
		configWindowAcct.CheckBoxDuel,
		configWindowToon.CheckBoxDuel)
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
	QOL_Config.QM.ReportAtLogon, QOL_Config_Toon.QM.ReportAtLogon =
	QOLUtils.ToggleSetting(nil,
		QOL_Config.QM.ReportAtLogon,
		QOL_Config_Toon.QM.ReportAtLogon,
		configWindowAcct.CheckBoxReport,
		configWindowToon.CheckBoxReport)
end

function qm.ReportParty()
	if QOLUtils.SettingIsTrue(QOL_Config.QM.PartyActive, QOL_Config_Toon.QM.PartyActive) then
		qm.Log('Automatically declining Party Invites.')
	else
		qm.Log('Manual confirmation required for Party Invites.')
	end
end

function qm.ReportDuel()
	if QOLUtils.SettingIsTrue(QOL_Config.QM.DuelActive, QOL_Config_Toon.QM.DuelActive) then
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
	if QOLUtils.SettingIsTrue(QOL_Config.QM.ReportAtLogon, QOL_Config_Toon.QM.ReportAtLogon) then
		qm.ReportAll()
	end
end

function qm.DeclinePartyInvite(...)
	if QOLUtils.SettingIsTrue(QOL_Config.QM.PartyActive, QOL_Config_Toon.QM.PartyActive) then
		local inviter = ...
		StaticPopup_Hide('PARTY_INVITE')
		qm.Log(format('Declined Party Invite from %s.', inviter))
	end
end

function qm.DeclineDuel(...)
	if QOLUtils.SettingIsTrue(QOL_Config.QM.DuelActive, QOL_Config_Toon.QM.DuelActive) then
		local inviter = ...
		StaticPopup_Hide('DUEL_REQUESTED')
		CancelDuel()
		qm.Log(format('Declined Duel Request from %s', inviter))
	end
end

function qm.TogglePartyOnClick()
	QOL_Config.QM.PartyActive = configWindowAcct.CheckBoxParty:GetChecked()
	QOL_Config_Toon.QM.PartyActive = configWindowToon.CheckBoxParty:GetChecked()
end

function qm.ToggleDuelOnClick()
	QOL_Config.QM.DuelActive = configWindowAcct.CheckBoxDuel:GetChecked()
	QOL_Config_Toon.QM.DuelActive = configWindowToon.CheckBoxDuel:GetChecked()
end

function qm.ToggleLogonReportOnClick()
	QOL_Config.QM.ReportAtLogon = configWindowAcct.CheckBoxReport:GetChecked()
	QOL_Config_Toon.QM.ReportAtLogon = configWindowToon.CheckBoxReport:GetChecked()
end

function qm.Log(message)
	QOLUtils.Log(message, 'QM')
end
