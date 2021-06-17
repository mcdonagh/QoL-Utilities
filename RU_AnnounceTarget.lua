local tar = 'target'
local player = 'player'

SLASH_TESTANNOUNCETARGET1 = '/at'
SlashCmdList['TESTANNOUNCETARGET'] = function (msg)
	if UnitExists(tar) then
		local destination, subdestination = GetDestination(msg)
		local message = GenerateMessage();
		SendChatMessage(message, destination, nil, subdestination)
	end
end

function GetDestination(msg)
	local destination = 'CHANNEL'
	local subdestination = nil
	local indicator = 'c'
	if strlen(msg) >= 1 then
		indicator = strsub(msg, 1, 1)
	end
	if indicator == 'c' then
		destination = 'CHANNEL'
		subdestination = GetSubDestination(true, msg)
	elseif indicator == 'g' then
		destination = 'GUILD'
	elseif indicator == 'w' then
		destination = 'WHISPER'
		subdestination = GetSubDestination(false, msg)
	elseif indicator == 'p' then
		destination = 'PARTY'
	elseif indicator == 'r' then
		destination = 'RAID'
	elseif indicator == 's' then
		destination = 'SAY'
	elseif indicator == 'i' then
		destination = 'INSTANCE_CHAT'
	elseif indicator == 'y' then
		destination = 'YELL'
	end
	return destination, subdestination
end

function GetSubDestination(isChannel, msg)
	local subdestination
	if isChannel then
		subdestination = 1
		if strlen(msg) >= 3 then
			subdestination = strsub(msg, 3)
		end
	else
		subdestination = UnitName(player)
		if strlen(msg) >= 3 then
			subdestination = strsub(msg, 3)
		end
	end
	return subdestination
end

function GenerateMessage()
	local name = UnitName(tar)
	local health = UnitHealth(tar) / UnitHealthMax(tar)
	local map = C_Map.GetBestMapForUnit(player)
	local x, y = C_Map.GetPlayerMapPosition(map, player):GetXY()
	local message = format('%s [%d%%] near (%.1f, %.1f) ', name, health * 100, x * 100, y * 100)
	C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(map, x, y))
	local waypoint = C_Map.GetUserWaypointHyperlink()
	C_Map.ClearUserWaypoint()
	return message..waypoint
end