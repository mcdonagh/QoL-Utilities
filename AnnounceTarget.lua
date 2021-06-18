local addonName, RU = ...

RU.AT = {}
local at = RU.AT
at.S_TARGET = 'target'
at.S_PLAYER = 'player'

function at.AnnounceTarget(words)
	if UnitExists(at.S_TARGET) then
		local destination, subdestination = at.GetDestination(msg)
		local message = at.GenerateMessage();
		SendChatMessage(message, destination, nil, subdestination)
	end
end

function at.GetDestination(msg)
	local destination = 'CHANNEL'
	local subdestination = nil
	local indicator = 'c'
	if strlen(msg) >= 1 then
		indicator = strsub(msg, 1, 1)
	end
	if indicator == 'c' then
		destination = 'CHANNEL'
		subdestination = at.GetSubDestination(true, msg)
	elseif indicator == 'g' then
		destination = 'GUILD'
	elseif indicator == 'w' then
		destination = 'WHISPER'
		subdestination = at.GetSubDestination(false, msg)
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

function at.GetSubDestination(isChannel, msg)
	local subdestination
	if isChannel then
		subdestination = 1
		if strlen(msg) >= 3 then
			subdestination = strsub(msg, 3)
		end
	else
		subdestination = UnitName(at.S_PLAYER)
		if strlen(msg) >= 3 then
			subdestination = strsub(msg, 3)
		end
	end
	return subdestination
end

function at.GenerateMessage()
	local name = UnitName(at.S_TARGET)
	local health = UnitHealth(at.S_TARGET) / UnitHealthMax(at.S_TARGET)
	local map = C_Map.GetBestMapForUnit(at.S_PLAYER)
	local x, y = C_Map.GetPlayerMapPosition(map, at.S_PLAYER):GetXY()
	local message = format('%s [%d%%] near (%.1f, %.1f) ', name, health * 100, x * 100, y * 100)
	C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(map, x, y))
	local waypoint = C_Map.GetUserWaypointHyperlink()
	C_Map.ClearUserWaypoint()
	return message..waypoint
end
