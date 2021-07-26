local addonName, QOLUtils = ...

QOLUtils.ATC = {}
local atc = QOLUtils.ATC
local feature = 'ATC'
local configAcct, configToon, storage

function atc.Load()
	configAcct = QOL_Config_Acct.ATC
	configToon = QOL_Config_Toon.ATC
	storage = QOLUtils.OPT.Storage.ATC
end

function atc.IsEnabled()
	return QOLUtils.SettingIsTrue(feature, 'Enabled')
end

function atc.CheckBoxEnabled_OnClick()
	if QOL_Config_Toon.Active then
		configToon.Enabled = storage.CheckBoxEnabled:GetChecked()
	else
		configAcct.Enabled = storage.CheckBoxEnabled:GetChecked()
	end
end

function atc.Clean(printRemoved)
	local trackedAchievements = { GetTrackedAchievements() }
	local removedCount = 0
	for k, trackedAchievement in ipairs(trackedAchievements) do
		local achievementID, _, _, completed = GetAchievementInfo(trackedAchievement)	
		if completed then
			RemoveTrackedAchievement(achievementID)
			removedCount = removedCount + 1
			atc.Log('Stopped tracking ' .. GetAchievementLink(achievementID))			
		end
	end
	if removedCount > 0 or printRemoved then
		atc.Log(removedCount .. ' completed achievements untracked.')
	end
end

function atc.Log(message)
	QOLUtils.Log(message, feature)
end