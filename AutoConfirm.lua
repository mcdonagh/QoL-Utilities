local addonName, QOLUtils = ...

QOLUtils.AC = {}
local ac = QOLUtils.AC

function ac.ToggleAutoConfirm()
	AutoConfirmActive = not AutoConfirmActive
	ac.ReportState()
end

function ac.ConfirmEquipRefundable()
	if AutoConfirmActive then
		ac.ClickConfirm('Okay', 'LeftButton')
	end
end

function ac.ConfirmEquipTradeable()
	if AutoConfirmActive then
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
	if AutoConfirmActive then
		ac.Log('Refundable & Tradeable items now auto confirming to equip')
	else
		ac.Log('Refundable & Tradeable items now requiring manual confirmation to equip')
	end
end

function ac.Log(message)
	QOLUtils.Log(message, 'AC')
end