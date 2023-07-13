local addonName, QOLUtils = ...

QOLUtils.QM = {}
local qm = QOLUtils.QM
local feature = 'QM'
local configAcct, configToon, storage

function qm.Load()
	configAcct = QOL_Config_Acct.QM
	configToon = QOL_Config_Toon.QM
	storage = QOLUtils.OPT.Storage.QM
end

function qm.IsEnabled()
	return QOLUtils.SettingIsTrue(feature, 'Enabled')
end

function qm.CheckBoxEnabled_OnClick()
	if QOL_Config_Toon.Active then
		configToon.Enabled = storage.CheckBoxEnabled:GetChecked()
	else
		configAcct.Enabled = storage.CheckBoxEnabled:GetChecked()
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
	QOLUtils.ToggleSetting(state, storage.CheckBoxParty, feature, 'PartyActive')
end

function qm.ToggleDuel(state)
	QOLUtils.ToggleSetting(state, storage.CheckBoxDuel, feature, 'DuelActive')
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
	QOLUtils.ToggleSetting(nil, storage.CheckBoxReport, feature, 'ReportAtLogon')
end

function qm.ReportParty()
	if QOLUtils.SettingIsTrue(feature, 'PartyActive') then
		qm.Log('Automatically declining Party Invites.')
	else
		qm.Log('Manual confirmation required for Party Invites.')
	end
end

function qm.ReportDuel()
	if QOLUtils.SettingIsTrue(feature, 'DuelActive') then
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
	if QOLUtils.SettingIsTrue(feature, 'ReportAtLogon') then
		qm.ReportAll()
	end
end

function qm.DeclinePartyInvite(...)
	if QOLUtils.SettingIsTrue(feature, 'PartyActive') then
		local inviter = ...
		DeclineGroup()
		StaticPopup_Hide('PARTY_INVITE')
		qm.Log(format('Declined Party Invite from %s.', inviter))
	end
end

function qm.DeclineDuel(...)
	if QOLUtils.SettingIsTrue(feature, 'DuelActive') then
		local inviter = ...
		CancelDuel()
		StaticPopup_Hide('DUEL_REQUESTED')
		qm.Log(format('Declined Duel Request from %s.', inviter))
	end
end

-- function qm.GetPlayerLink(inviter)
	-- return GetPlayerLink(inviter, format('[%s].', inviter))
-- end

-- function qm.GetColor(guid)
	-- local _, class = GetPlayerInfoByGUID(guid)
	-- local _, _, _, argbHex = GetClassColor(class)
-- end

function qm.CheckBoxParty_OnClick()
	if QOL_Config_Toon.Active then
		configToon.PartyActive = storage.CheckBoxParty:GetChecked()
	else
		configAcct.PartyActive = storage.CheckBoxParty:GetChecked()
	end
end

function qm.CheckBoxDuel_OnClick()
	if QOL_Config_Toon.Active then
		configAcct.DuelActive = storage.CheckBoxDuel:GetChecked()
	else
		configToon.DuelActive = storage.CheckBoxDuel:GetChecked()
	end
end

function qm.CheckBoxReport_OnClick()
	if QOL_Config_Toon.Active then
		configAcct.ReportAtLogon = optAcct.CheckBoxReport:GetChecked()
	else
		configToon.ReportAtLogon = optToon.CheckBoxReport:GetChecked()
	end
end

function qm.Log(...)
	QOLUtils.Log(feature, ...)
end