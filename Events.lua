local addonName, QOLUtils = ...

QOLUtils.EventFrame = CreateFrame('Frame')
QOLUtils.Events = {}

function QOLUtils.Events.ADDON_LOADED(...)
	local loadedAddon = ...
	if loadedAddon == addonName then
		QOLUtils.OPT.LoadDefaults()
		QOLUtils.OPT.CreateConfig()
		QOLUtils.OPT.UpdateConfig()
	end
end

function QOLUtils.Events.PLAYER_ENTERING_WORLD(...)
	local isFirstLogin, isReload = ...
	if isFirstLogin or isReload then
		if QOLUtils.ATC.IsEnabled() then
			QOLUtils.ATC.Clean(false)
		end
		if QOLUtils.AC.IsEnabled() then
			QOLUtils.AC.ReportInitial()
		end
		if QOLUtils.QM.IsEnabled() then
			QOLUtils.QM.ReportInitial()
		end
		if QOLUtils.SMN.IsEnabled() then
			QOLUtils.SMN.ReportInitial()
		end
		if QOLUtils.VC.IsEnabled() then
			QOLUtils.VC.LoadInitialVolume()
		end
		QOLUtils.Attention()
	end
end

function QOLUtils.Events.ACHIEVEMENT_EARNED(...)
	if QOLUtils.ATC.IsEnabled() then
		QOLUtils.ATC.Clean(false)
	end
end

function QOLUtils.Events.PARTY_INVITE_REQUEST(...)
	if QOLUtils.QM.IsEnabled() then
		QOLUtils.QM.DeclinePartyInvite(...)
	end
end

function QOLUtils.Events.DUEL_REQUESTED(...)
	if QOLUtils.QM.IsEnabled() then
		QOLUtils.QM.DeclineDuel(...)
	end
end

function QOLUtils.Events.EQUIP_BIND_REFUNDABLE_CONFIRM(...)
	if QOLUtils.AC.IsEnabled() then
		QOLUtils.AC.ConfirmEquipRefundable()
	end
end

function QOLUtils.Events.EQUIP_BIND_TRADEABLE_CONFIRM(...)
	if QOLUtils.AC.IsEnabled() then
		QOLUtils.AC.ConfirmEquipTradeable()
	end
end

function QOLUtils.Events.EQUIP_BIND_CONFIRM(...)
	if QOLUtils.AC.IsEnabled() then
		QOLUtils.AC.ConfirmEquipBind()
	end
end

QOLUtils.EventFrame:SetScript('OnEvent',
	function(self, event, ...)
		QOLUtils.Events[event](self, ...)
	end
)

for event in pairs(QOLUtils.Events) do
	QOLUtils.EventFrame:RegisterEvent(event)
end