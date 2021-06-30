local addonName, QOLUtils = ...

QOLUtils.AC = {}
local ac = QOLUtils.AC

function ac.ToggleAndReport(args)
	if args[2] == 'r' then
		ac.ToggleRefundable(nil)
		ac.ReportRefundable()
	elseif args[2] == 't' then
		ac.ToggleTradeable(nil)
		ac.ReportTradeable()
	elseif args[2] == 'b' then
		ac.ToggleBindable(nil)
		ac.ReportBindable()
	else
		if args[2] == 'on' then
			ac.ToggleAll(true)
		elseif args[2] == 'off' then
			ac.ToggleAll(false)
		else
			ac.ToggleAll(nil)
		end
		ac.ReportAll()
	end
end

function ac.ToggleRefundable(state)
	if QOL_Config_Toon.Active then
		if state == nil then
			QOL_Config_Toon.AC.RefundableActive = not QOL_Config_Toon.AC.RefundableActive
		else
			QOL_Config_Toon.AC.RefundableActive = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.AC.CheckBoxRefundable, QOL_Config_Toon.AC.RefundableActive)
	else
		if state == nil then
			QOL_Config.AC.RefundableActive = not QOL_Config.AC.RefundableActive
		else
			QOL_Config.AC.RefundableActive = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.AC.CheckBoxRefundable, QOL_Config.AC.RefundableActive)
	end
end

function ac.ToggleTradeable(state)
	if QOL_Config_Toon.Active then
		if state == nil then
			QOL_Config_Toon.AC.TradeableActive = not QOL_Config_Toon.AC.TradeableActive
		else
			QOL_Config_Toon.AC.TradeableActive = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.AC.CheckBoxTradeable, QOL_Config_Toon.AC.TradeableActive)
	else
		if state == nil then
			QOL_Config.AC.TradeableActive = not QOL_Config.AC.TradeableActive
		else
			QOL_Config.AC.TradeableActive = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.AC.CheckBoxTradeable, QOL_Config.AC.TradeableActive)
	end
end

function ac.ToggleBindable(state)
	if QOL_Config_Toon.Active then
		if state == nil then
			QOL_Config_Toon.AC.BindableActive = not QOL_Config_Toon.AC.BindableActive
		else
			QOL_Config_Toon.AC.BindableActive = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.AC.CheckBoxBindable, QOL_Config_Toon.AC.BindableActive)
	else
		if state == nil then
			QOL_Config.AC.BindableActive = not QOL_Config.AC.BindableActive
		else
			QOL_Config.AC.BindableActive = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.AC.CheckBoxBindable, QOL_Config.AC.BindableActive)
	end
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

function ac.ToggleReport()
	if QOL_Config_Toon.Active then
		QOL_Config_Toon.AC.ReportAtLogon = not QOL_Config_Toon.AC.ReportAtLogon
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.AC.CheckBoxReport, QOL_Config_Toon.AC.ReportAtLogon)
	else
		QOL_Config.AC.ReportAtLogon = not QOL_Config.AC.ReportAtLogon
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.AC.CheckBoxReport, QOL_Config.AC.ReportAtLogon)
	end
end

function ac.ReportRefundable()
	if QOL_Config_Toon.Active and QOL_Config_Toon.AC.RefundableActive or not QOL_Config_Toon.Active and QOL_Config.AC.RefundableActive then
		ac.Log('Automatically confirming to equip Refundable items.')
	else
		ac.Log('Manual confirmation required to equip Refundable items.')
	end
end

function ac.ReportTradeable()
	if QOL_Config_Toon.Active and QOL_Config_Toon.AC.TradeableActive or not QOL_Config_Toon.Active and QOL_Config.AC.TradeableActive then
		ac.Log('Automatically confirming to equip Tradeable items.')
	else
		ac.Log('Manual confirmation required to equip Tradeable items.')
	end
end

function ac.ReportBindable()
	if QOL_Config_Toon.Active and QOL_Config_Toon.AC.BindableActive or not QOL_Config_Toon.Active and QOL_Config.AC.BindableActive then
		ac.Log('Automatically confirming to equip "Bind on Equip" items.')
	else
		ac.Log('Manual confirmation required to equip "Bind on Equip" items.')
	end
end

function ac.ReportAll()
	if QOL_Config_Toon.Active and QOL_Config_Toon.AC.RefundableActive and QOL_Config_Toon.AC.TradeableActive and QOL_Config_Toon.AC.BindableActive
		or not QOL_Config_Toon.Active and QOL_Config.AC.RefundableActive and QOL_Config.AC.TradeableActive and QOL_Config.AC.BindableActive then
		ac.Log('Automatically confiring to equip Refundable, Tradeable, and "Bind on Equip" items.')
	else
		ac.Log('Manual confirmation required to equip Refundable, Tradeable, and "Bind on Equip" items.')
	end
end

function ac.ReportInitial()
	if QOL_Config_Toon.Active and QOL_Config_Toon.AC.ReportAtLogon or not QOL_Config_Toon.Active and QOL_Config.AC.ReportAtLogon then
		ac.ReportRefundable()
		ac.ReportTradeable()
		ac.ReportBindable()
	end
end

function ac.ConfirmEquipRefundable()
	if QOL_Config_Toon.Active and QOL_Config_Toon.AC.RefundableActive or not QOL_Config_Toon.Active and QOL_Config.AC.RefundableActive then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipTradeable()
	if QOL_Config_Toon.Active and QOL_Config_Toon.AC.TradeableActive or not QOL_Config_Toon.Active and QOL_Config.AC.TradeableActive then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipBind()
	if QOL_Config_Toon.Active and QOL_Config_Toon.AC.BindableActive or not QOL_Config_Toon.Active and QOL_Config.AC.BindableActive then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ClickConfirm(confirmText, buttonType)
	for i = 1, 10 do
		local popup = _G['StaticPopup' .. i]
		if popup and popup.which and popup.IsShown and popup:IsShown() then
			local button = _G['StaticPopup' .. i .. 'Button1']
			if button and button.IsShown and button:IsShown() and button.GetText and (button:GetText() == confirmText) and button.Click then
				button:Click(buttonType)
			end
		end
	end
end

function ac.Log(message)
	QOLUtils.Log(message, 'AC')
end