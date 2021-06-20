local addonName, RU = ...

RU.EventFrame = CreateFrame('Frame')
RU.Events = {}

function RU.Events:PLAYER_ENTERING_WORLD(...)
	local isFirstLogin, isReload = ...
	if isFirstLogin or isReload then
		RU.ATC.Clean(false)
	end
	RU.QM.ReportState()
	RU.AC.ReportState()
end

function RU.Events:ACHIEVEMENT_EARNED(...)
	RU.ATC.Clean(false)
end

function RU.Events:PARTY_INVITE_REQUEST(...)
	RU.QM.DeclinePartyInvite(...)
end

function RU.Events:DUEL_REQUESTED(...)
	RU.QM.DeclineDuel(...)
end

function RU.Events:EQUIP_BIND_REFUNDABLE_CONFIRM(...)
	RU.AC.ConfirmEquipRefundable()
end

function RU.Events:EQUIP_BIND_TRADEABLE_CONFIRM(...)
	RU.AC.ConfirmEquipTradeable()
end

RU.EventFrame:SetScript("OnEvent",
	function(self, event, ...)
		RU.Events[event](self, ...)
	end
)

for k, v in pairs(RU.Events) do
	RU.EventFrame:RegisterEvent(k)
end
