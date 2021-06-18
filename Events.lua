local addonName, RU = ...

RU.EventFrame = CreateFrame('Frame')
RU.Events = {}

function RU.Events:PARTY_INVITE_REQUEST(...)
	RU.QM.DeclinePartyInvite(...)
end

function RU.Events:DUEL_REQUESTED(...)
	RU.QM.DeclineDuel(...)
end

function RU.Events:PLAYER_ENTERING_WORLD(...)
	local isFirstLogin, isReload = ...
	if isFirstLogin or isReload then
		ReportState()
	end
end

function RU.Events:EQUIP_BIND_REFUNDABLE_CONFIRM(...)
	local confirmText = 'Okay'
	for i = 1, 10 do
		local popup = _G['StaticPopup' .. i]
		if popup and popup.which and popup.IsShown and popup:IsShown() then
			local button = _G['StaticPopup' .. i .. 'Button1']
			if button and button.IsShown and button:IsShown() and button.GetText and (button:GetText() == confirmText) and button.Click then
				button:Click('LeftButton')
			end
		end
	end
end

function RU.Events:EQUIP_BIND_TRADEABLE_CONFIRM(...)
	local confirmText = 'Okay'
	for i = 1, 10 do
		local popup = _G['StaticPopup' .. i]
		if popup and popup.which and popup.IsShown and popup:IsShown() then
			local button = _G['StaticPopup' .. i .. 'Button1']
			if button and button.IsShown and button:IsShown() and button.GetText and (button:GetText() == confirmText) and button.Click then
				button:Click('LeftButton')
			end
		end
	end
end

RU.EventFrame:SetScript("OnEvent",
	function(self, event, ...)
		RU.Events[event](self, ...)
	end
)

for k, v in pairs(RU.Events) do
	RU.EventFrame:RegisterEvent(k)
end
