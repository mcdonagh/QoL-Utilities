local addonName, QOLUtils = ...

QOLUtils.AC = {}
local ac = QOLUtils.AC

function ac.ToggleAutoConfirmAndReport()
	ac.ToggleAutoConfirm()
	ac.ReportState()
end

function ac.ToggleAutoConfirm()
	QOL_Config.AutoConfirmActive = not QOL_Config.AutoConfirmActive
	QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.ACCheckBox, QOL_Config.AutoConfirmActive)
end

function ac.ConfirmEquipRefundable()
	if QOL_Config.AutoConfirmActive then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipTradeable()
	if QOL_Config.AutoConfirmActive then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipBind()
	if QOL_Config.AutoConfirmActive then
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

function ac.ReportState()
	if QOL_Config.AutoConfirmActive then
		ac.Log('Automatically confirming to equip Refundable & Tradeable items.')
	else
		ac.Log('Manual confirmation required to equip Refundable & Tradeable items.')
	end
end

function ac.Log(message)
	QOLUtils.Log(message, 'AC')
end