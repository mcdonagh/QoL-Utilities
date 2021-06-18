local addonName, RU = ...

SLASH_QUIETMODE1 = '/qm'
SlashCmdList['QUIETMODE'] = function (msg)
	QuietModeActive = not QuietModeActive
	ReportState()
end

function ReportState()
	if QuietModeActive then
		Log('now declining invites & duels')
	else
		Log('now accepting invites & duels')
	end	
end

function Log(message)
	print(date('%H:%M') .. '  [QM]  ' .. message)
end


-- ========================
-- ===  Event Registry  ===
-- ========================

local frame = CreateFrame("Frame")
local events = {}

function events:PARTY_INVITE_REQUEST(...)
	if QuietModeActive then
		local inviter = ...
		StaticPopup_Hide("PARTY_INVITE")
		Log('declined invite from ' .. inviter)
	end
end

function events:DUEL_REQUESTED(...)
	if QuietModeActive then
		local inviter = ...
		StaticPopup_Hide('DUEL_REQUESTED')
		Log('declined duel from ' .. inviter)
	end
end

function events:PLAYER_ENTERING_WORLD(...)
	local isFirstLogin, isReload = ...
	if isFirstLogin or isReload then
		ReportState()
	end
end

function events:EQUIP_BIND_REFUNDABLE_CONFIRM(...)
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

function events:EQUIP_BIND_TRADEABLE_CONFIRM(...)
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

frame:SetScript("OnEvent",
	function(self, event, ...)
		events[event](self, ...)
	end
)

for k, v in pairs(events) do
	frame:RegisterEvent(k)
end