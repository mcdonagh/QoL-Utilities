local addonName, QOLUtils = ...

QOLUtils.EventFrame = CreateFrame('Frame')
QOLUtils.Events = {}

function QOLUtils.Events:ADDON_LOADED(...)
	local loadedAddon = ...
	if loadedAddon == addonName then
		QOLUtils.OPT.LoadDefaults()
		QOLUtils.OPT.CreateConfig()
	end
end

function QOLUtils.Events:PLAYER_ENTERING_WORLD(...)
	local isFirstLogin, isReload = ...
	if isFirstLogin or isReload then
		QOLUtils.ATC.Clean(false)
		QOLUtils.AC.ReportInitial()
		QOLUtils.Mount.ScanJournal()
		QOLUtils.QM.ReportInitial()
		QOLUtils.VC.LoadInitialVolume()
	end
end

function QOLUtils.Events:ACHIEVEMENT_EARNED(...)
	QOLUtils.ATC.Clean(false)
end

function QOLUtils.Events:PARTY_INVITE_REQUEST(...)
	QOLUtils.QM.DeclinePartyInvite(...)
end

function QOLUtils.Events:DUEL_REQUESTED(...)
	QOLUtils.QM.DeclineDuel(...)
end

function QOLUtils.Events:EQUIP_BIND_REFUNDABLE_CONFIRM(...)
	QOLUtils.AC.ConfirmEquipRefundable()
end

function QOLUtils.Events:EQUIP_BIND_TRADEABLE_CONFIRM(...)
	QOLUtils.AC.ConfirmEquipTradeable()
end

function QOLUtils.Events:EQUIP_BIND_CONFIRM(...)
	QOLUtils.AC.ConfirmEquipBind()
end

QOLUtils.EventFrame:SetScript('OnEvent',
	function(self, event, ...)
		QOLUtils.Events[event](self, ...)
	end
)

for k, v in pairs(QOLUtils.Events) do
	QOLUtils.EventFrame:RegisterEvent(k)
end
