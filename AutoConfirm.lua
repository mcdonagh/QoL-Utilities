local addonName, QOLUtils = ...

QOLUtils.AC = {}
local ac = QOLUtils.AC
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
	QOL_Config.AC.RefundableActive, QOL_Config_Toon.AC.RefundableActive =
	QOLUtils.ToggleSetting(state,
		QOL_Config.AC.RefundableActive,
		QOL_Config_Toon.AC.RefundableActive,
		configWindowAcct.CheckBoxRefundable,
		configWindowToon.CheckBoxRefundable)
end

function ac.ToggleTradeable(state)
	QOL_Config.AC.TradeableActive, QOL_Config_Toon.AC.TradeableActive =
	QOLUtils.ToggleSetting(state,
		QOL_Config.AC.TradeableActive,
		QOL_Config_Toon.AC.TradeableActive,
		configWindowAcct.CheckBoxTradeable,
		configWindowToon.CheckBoxTradeable)
end

function ac.ToggleBindable(state)
	QOL_Config.AC.BindableActive, QOL_Config_Toon.AC.BindableActive =
	QOLUtils.ToggleSetting(state,
		QOL_Config.AC.BindableActive,
		QOL_Config_Toon.AC.BindableActive,
		configWindowAcct.CheckBoxBindable,
		configWindowToon.CheckBoxBindable)
end

function ac.ToggleAll(state)
	if QOL_Config_Toon.Active then
		local combinedState = state or QOL_Config_Toon.AC.RefundableActive or QOL_Config_Toon.AC.TradeableActive or QOL_Config_Toon.AC.BindableActive
		ac.ToggleRefundable(combinedState)
		ac.ToggleTradeable(combinedState)
		ac.ToggleBindable(combinedState)
	else
		local combinedState = state or QOL_Config.AC.RefundableActive or QOL_Config.AC.TradeableActive or QOL_Config.AC.BindableActive
		ac.ToggleRefundable(combinedState)
		ac.ToggleTradeable(combinedState)
		ac.ToggleBindable(combinedState)
	end
end

function ac.ToggleLogonReport()
	QOL_Config.AC.ReportAtLogon, QOL_Config_Toon.AC.ReportAtLogon =
	QOLUtils.ToggleSetting(nil,
		QOL_Config.AC.ReportAtLogon,
		QOL_Config_Toon.AC.ReportAtLogon,
		configWindowAcct.CheckBoxReport,
		configWindowToon.CheckBoxReport)
end

function ac.ReportRefundable()
	if QOLUtils.SettingIsTrue(QOL_Config.AC.RefundableActive, QOL_Config_Toon.AC.RefundableActive) then
		ac.Log('Automatically confirming to equip Refundable items.')
	else
		ac.Log('Manual confirmation required to equip Refundable items.')
	end
end

function ac.ReportTradeable()
	if QOLUtils.SettingIsTrue(QOL_Config.AC.TradeableActive, QOL_Config_Toon.AC.TradeableActive) then
		ac.Log('Automatically confirming to equip Tradeable items.')
	else
		ac.Log('Manual confirmation required to equip Tradeable items.')
	end
end

function ac.ReportBindable()
	if QOLUtils.SettingIsTrue(QOL_Config.AC.BindableActive, QOL_Config_Toon.AC.BindableActive) then
		ac.Log('Automatically confirming to equip "Bind on Equip" items.')
	else
		ac.Log('Manual confirmation required to equip "Bind on Equip" items.')
	end
end

function ac.ReportInitial()
	if QOLUtils.SettingIsTrue(QOL_Config.AC.ReportAtLogon, QOL_Config_Toon.AC.ReportAtLogon) then
		ac.ReportAll()
	end
end

function ac.ReportAll()
	ac.ReportRefundable()
	ac.ReportTradeable()
	ac.ReportBindable()
end

function ac.ConfirmEquipRefundable()
	if QOLUtils.SettingIsTrue(QOL_Config.AC.RefundableActive, QOL_Config_Toon.AC.RefundableActive) then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipTradeable()
	if QOLUtils.SettingIsTrue(QOL_Config.AC.TradeableActive, QOL_Config_Toon.AC.TradeableActive) then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipBind()
	if QOLUtils.SettingIsTrue(QOL_Config.AC.BindableActive, QOL_Config_Toon.AC.BindableActive) then
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
	QOL_Config.AC.RefundableActive = configWindowAcct.CheckBoxRefundable:GetChecked()
	QOL_Config_Toon.AC.RefundableActive = configWindowToon.CheckBoxRefundable:GetChecked()
end

function ac.ToggleTradeableOnClick()
	QOL_Config.AC.TradeableActive = configWindowAcct.CheckBoxTradeable:GetChecked()
	QOL_Config_Toon.AC.TradeableActive = configWindowAcct.CheckBoxTradeable:GetChecked()
end

function ac.ToggleBindableOnClick()
	QOL_Config.AC.BindableActive = configWindowAcct.CheckBoxBindable:GetChecked()
	QOL_Config_Toon.AC.BindableActive = configWindowToon.CheckBoxBindable:GetChecked()
end

function ac.ToggleLogonReportOnClick()
	QOL_Config.AC.ReportAtLogon = configWindowAcct.CheckBoxReport:GetChecked()
	QOL_Config_Toon.AC.ReportAtLogon = configWindowToon.CheckBoxReport:GetChecked()
end

function ac.Log(message)
	QOLUtils.Log(message, 'AC')
end