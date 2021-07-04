local addonName, QOLUtils = ...

QOLUtils.AC = {}
local ac = QOLUtils.AC
local configAcct = QOL_Config.AC
local configToon = QOL_Config_Toon.AC
local configWindowAcct = QOLUtils.OPT.Acct.AC
local configWindowToon = QOLUtils.OPT.Toon.AC

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
		configWindowAcct.CheckBoxRefundable,
		configWindowToon.CheckBoxRefundable)
end

function ac.ToggleTradeable(state)
	configAcct.TradeableActive, configToon.TradeableActive =
	QOLUtils.ToggleSetting(state,
		configAcct.TradeableActive,
		configToon.TradeableActive,
		configWindowAcct.CheckBoxTradeable,
		configWindowToon.CheckBoxTradeable)
end

function ac.ToggleBindable(state)
	configAcct.BindableActive, configToon.BindableActive =
	QOLUtils.ToggleSetting(state,
		configAcct.BindableActive,
		configToon.BindableActive,
		configWindowAcct.CheckBoxBindable,
		configWindowToon.CheckBoxBindable)
end

function ac.ToggleAll(state)
	if QOL_Config_Toon.Active then
		local combinedState = state or configToon.RefundableActive or configToon.TradeableActive or configToon.BindableActive
		ac.ToggleRefundable(combinedState)
		ac.ToggleTradeable(combinedState)
		ac.ToggleBindable(combinedState)
	else
		local combinedState = state or configAcct.RefundableActive or configAcct.TradeableActive or configAcct.BindableActive
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
		configWindowAcct.CheckBoxReport,
		configWindowToon.CheckBoxReport)
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
	configAcct.RefundableActive = configWindowAcct.CheckBoxRefundable:GetChecked()
	configToon.RefundableActive = configWindowToon.CheckBoxRefundable:GetChecked()
end

function ac.ToggleTradeableOnClick()
	configAcct.TradeableActive = configWindowAcct.CheckBoxTradeable:GetChecked()
	configToon.TradeableActive = configWindowAcct.CheckBoxTradeable:GetChecked()
end

function ac.ToggleBindableOnClick()
	configAcct.BindableActive = configWindowAcct.CheckBoxBindable:GetChecked()
	configToon.BindableActive = configWindowToon.CheckBoxBindable:GetChecked()
end

function ac.ToggleLogonReportOnClick()
	configAcct.ReportAtLogon = configWindowAcct.CheckBoxReport:GetChecked()
	configToon.ReportAtLogon = configWindowToon.CheckBoxReport:GetChecked()
end

function ac.Log(message)
	QOLUtils.Log(message, 'AC')
end