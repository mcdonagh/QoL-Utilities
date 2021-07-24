local addonName, QOLUtils = ...

QOLUtils.AC = {}
local ac = QOLUtils.AC
local configAcct = QOL_Config_Acct.AC
local configToon = QOL_Config_Toon.AC
local storage = QOLUtils.OPT.Storage.AC

function ac.IsEnabled()
	return QOLUtils.SettingIsTrue(configAcct.Enabled, configToon.Enabled)
end

function ac.ToggleEnabled()
	if configToon.Active then
		configToon.Enabled = storage.CheckBoxEnabled:GetChecked()
	else
		configAcct.Enabled = storage.CheckBoxEnabled:GetChecked()
	end
end

function ac.ToggleAndReport(args)
	local indicator = args[2]
	if indicator == 'r' then
		ac.ToggleRefundable(nil)
		ac.ReportRefundable()
	elseif indicator == 't' then
		ac.ToggleTradeable(nil)
		ac.ReportTradeable()
	elseif indicator == 'b' then
		ac.ToggleBindable(nil)
		ac.ReportBindable()
	else
		if indicator == 'on' then
			ac.ToggleAll(true)
		elseif indicator == 'off' then
			ac.ToggleAll(false)
		else
			ac.ToggleAll(nil)
		end
		ac.ReportAll()
	end
end

function ac.ToggleRefundable(state)
	configAcct.RefundableActive, configToon.RefundableActive =
	QOLUtils.ToggleSetting(state,
		configAcct.RefundableActive,
		configToon.RefundableActive,
		storage.CheckBoxRefundable)
end

function ac.ToggleTradeable(state)
	configAcct.TradeableActive, configToon.TradeableActive =
	QOLUtils.ToggleSetting(state,
		configAcct.TradeableActive,
		configToon.TradeableActive,
		storage.CheckBoxTradeable)
end

function ac.ToggleBindable(state)
	configAcct.BindableActive, configToon.BindableActive =
	QOLUtils.ToggleSetting(state,
		configAcct.BindableActive,
		configToon.BindableActive,
		storage.CheckBoxBindable)
end

function ac.ToggleAll(state)
	if QOL_Config_Toon.Active then
		local combinedState = state or not (configToon.RefundableActive or configToon.TradeableActive or configToon.BindableActive)
		ac.ToggleRefundable(combinedState)
		ac.ToggleTradeable(combinedState)
		ac.ToggleBindable(combinedState)
	else
		local combinedState = state or not (configAcct.RefundableActive or configAcct.TradeableActive or configAcct.BindableActive)
		ac.ToggleRefundable(combinedState)
		ac.ToggleTradeable(combinedState)
		ac.ToggleBindable(combinedState)
	end
end

function ac.ToggleLogonReport()
	configAcct.ReportAtLogon, configToon.ReportAtLogon =
	QOLUtils.ToggleSetting(nil,
		configAcct.ReportAtLogon,
		configToon.ReportAtLogon,
		storage.CheckBoxReport)
end

function ac.ReportRefundable()
	if QOLUtils.SettingIsTrue(configAcct.RefundableActive, configToon.RefundableActive) then
		ac.Log('Automatically confirming to equip Refundable items.')
	else
		ac.Log('Manual confirmation required to equip Refundable items.')
	end
end

function ac.ReportTradeable()
	if QOLUtils.SettingIsTrue(configAcct.TradeableActive, configToon.TradeableActive) then
		ac.Log('Automatically confirming to equip Tradeable items.')
	else
		ac.Log('Manual confirmation required to equip Tradeable items.')
	end
end

function ac.ReportBindable()
	if QOLUtils.SettingIsTrue(configAcct.BindableActive, configToon.BindableActive) then
		ac.Log('Automatically confirming to equip "Bind on Equip" items.')
	else
		ac.Log('Manual confirmation required to equip "Bind on Equip" items.')
	end
end

function ac.ReportInitial()
	if QOLUtils.SettingIsTrue(configAcct.ReportAtLogon, configToon.ReportAtLogon) then
		ac.ReportAll()
	end
end

function ac.ReportAll()
	ac.ReportRefundable()
	ac.ReportTradeable()
	ac.ReportBindable()
end

function ac.ConfirmEquipRefundable()
	if QOLUtils.SettingIsTrue(configAcct.RefundableActive, configToon.RefundableActive) then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipTradeable()
	if QOLUtils.SettingIsTrue(configAcct.TradeableActive, configToon.TradeableActive) then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipBind()
	if QOLUtils.SettingIsTrue(configAcct.BindableActive, configToon.BindableActive) then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ClickConfirm(confirmText, buttonType)
	local popup, i = QOLUtils.GetFrame('StaticPopup')
	local button = _G['StaticPopup' .. i .. 'Button1']
	if button and button.IsShown and button:IsShown() and button.GetText and (button:GetText() == confirmText) and button.Click then
		button:Click(buttonType)
	end
end

function ac.ToggleRefundableOnClick()
	if configToon.Active then
		configToon.RefundableActive = storage.CheckBoxRefundable:GetChecked()
	else
		configAcct.RefundableActive = storage.CheckBoxRefundable:GetChecked()
	end
end

function ac.ToggleTradeableOnClick()
	if configToon.Active then
		configToon.TradeableActive = storage.CheckBoxTradeable:GetChecked()
	else
		configAcct.TradeableActive = storage.CheckBoxTradeable:GetChecked()
	end
end

function ac.ToggleBindableOnClick()
	if configToon.Active then
		configAcct.BindableActive = storage.CheckBoxBindable:GetChecked()
	else
		configToon.BindableActive = storage.CheckBoxBindable:GetChecked()
	end
end

function ac.ToggleLogonReportOnClick()
	if configToon.Active then
		configToon.ReportAtLogon = storage.CheckBoxReport:GetChecked()
	else
		configAcct.ReportAtLogon = storage.CheckBoxReport:GetChecked()
	end
end

function ac.Log(message)
	QOLUtils.Log(message, 'AC')
end