local addonName, QOLUtils = ...

QOLUtils.ATC = {}
local atc = QOLUtils.ATC
local configAcct = QOL_Config_Acct.ATC
local configToon = QOL_Config_Toon.ATC
local storage = QOLUtils.OPT.Storage.ATC

function atc.IsEnabled()
	return QOLUtils.SettingIsTrue(configAcct.Enabled, configToon.Enabled)
end

function atc.ToggleEnabled()
	if configToon.Active then
		configToon.Enabled = storage.CheckBoxEnabled:GetChecked()
	else
		configAcct.Enabled = storage.CheckBoxEnabled:GetChecked()
	end
end

function atc.Clean(printRemoved)
	local trackedAchievements = { GetTrackedAchievements() }
	local removedCount = 0
	for i, trackedAchievement in ipairs(trackedAchievements) do
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
	QOLUtils.Log(message, 'ATC')
end