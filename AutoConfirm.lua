local addonName, QOLUtils = ...

QOLUtils.AC = {}
local ac = QOLUtils.AC
local feature = 'AC'
local configAcct, configToon, storage

function ac.Load()
	configAcct = QOL_Config_Acct.AC
	configToon = QOL_Config_Toon.AC
	storage = QOLUtils.OPT.Storage.AC
end

function ac.IsEnabled()
	return QOLUtils.SettingIsTrue(feature, 'Enabled')
end

function ac.CheckBoxEnabled_OnClick()
	if QOL_Config_Toon.Active then
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
	QOLUtils.ToggleSetting(state, storage.CheckBoxRefundable, feature, 'RefundableActive')
end

function ac.ToggleTradeable(state)
	QOLUtils.ToggleSetting(state, storage.CheckBoxTradeable, feature, 'TradeableActive')
end

function ac.ToggleBindable(state)
	QOLUtils.ToggleSetting(state, storage.CheckBoxBindable, feature, 'BindableActive')
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
	QOLUtils.ToggleSetting(nil, storage.CheckBoxReport, feature, 'ReportAtLogon')
end

function ac.ReportRefundable()
	if QOLUtils.SettingIsTrue(feature, 'RefundableActive') then
		ac.Log('Automatically confirming to equip Refundable items.')
	else
		ac.Log('Manual confirmation required to equip Refundable items.')
	end
end

function ac.ReportTradeable()
	if QOLUtils.SettingIsTrue(feature, 'TradeableActive') then
		ac.Log('Automatically confirming to equip Tradeable items.')
	else
		ac.Log('Manual confirmation required to equip Tradeable items.')
	end
end

function ac.ReportBindable()
	if QOLUtils.SettingIsTrue(feature, 'BindableActive') then
		ac.Log('Automatically confirming to equip "Bind on Equip" items.')
	else
		ac.Log('Manual confirmation required to equip "Bind on Equip" items.')
	end
end

function ac.ReportInitial()
	if QOLUtils.SettingIsTrue(feature, 'ReportAtLogon') then
		ac.ReportAll()
	end
end

function ac.ReportAll()
	ac.ReportRefundable()
	ac.ReportTradeable()
	ac.ReportBindable()
end

function ac.ConfirmEquipRefundable()
	if QOLUtils.SettingIsTrue(feature, 'RefundableActive') then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipTradeable()
	if QOLUtils.SettingIsTrue(feature, 'TradeableActive') then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipBind()
	if QOLUtils.SettingIsTrue(feature, 'BindableActive') then
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

function ac.CheckBoxRefundable_OnClick()
	if QOL_Config_Toon.Active then
		configToon.RefundableActive = storage.CheckBoxRefundable:GetChecked()
	else
		configAcct.RefundableActive = storage.CheckBoxRefundable:GetChecked()
	end
end

function ac.CheckBoxTradeable_OnClick()
	if QOL_Config_Toon.Active then
		configToon.TradeableActive = storage.CheckBoxTradeable:GetChecked()
	else
		configAcct.TradeableActive = storage.CheckBoxTradeable:GetChecked()
	end
end

function ac.CheckBoxBindable_OnClick()
	if QOL_Config_Toon.Active then
		configAcct.BindableActive = storage.CheckBoxBindable:GetChecked()
	else
		configToon.BindableActive = storage.CheckBoxBindable:GetChecked()
	end
end

function ac.CheckBoxReport_OnClick()
	if QOL_Config_Toon.Active then
		configToon.ReportAtLogon = storage.CheckBoxReport:GetChecked()
	else
		configAcct.ReportAtLogon = storage.CheckBoxReport:GetChecked()
	end
end

function ac.Log(message)
	QOLUtils.Log(message, feature)
end