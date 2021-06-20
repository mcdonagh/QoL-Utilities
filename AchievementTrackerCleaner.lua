local addonName, RU = ...

RU.ATC = {}
local atc = RU.ATC

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
	RU.Log(message, 'ATC')
end