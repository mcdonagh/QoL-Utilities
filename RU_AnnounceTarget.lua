local addonName, RU = ...

RU.AT = {}
RU.AT.S_TARGET = 'target'
RU.AT.S_PLAYER = 'player'

function RU.AT.AnnounceTarget(words)
	if UnitExists(RU.AT.S_TARGET) then
		local destination, subdestination = RU.AT.GetDestination(msg)
		local message = RU.AT.GenerateMessage();
		SendChatMessage(message, destination, nil, subdestination)
	end
end

function RU.AT.GetDestination(msg)
	local destination = 'CHANNEL'
	local subdestination = nil
	local indicator = 'c'
	if strlen(msg) >= 1 then
		indicator = strsub(msg, 1, 1)
	end
	if indicator == 'c' then
		destination = 'CHANNEL'
		subdestination = RU.AT.GetSubDestination(true, msg)
	elseif indicator == 'g' then
		destination = 'GUILD'
	elseif indicator == 'w' then
		destination = 'WHISPER'
		subdestination = RU.AT.GetSubDestination(false, msg)
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

function RU.AT.GetSubDestination(isChannel, msg)
	local subdestination
	if isChannel then
		subdestination = 1
		if strlen(msg) >= 3 then
			subdestination = strsub(msg, 3)
		end
	else
		subdestination = UnitName(RU.AT.S_PLAYER)
		if strlen(msg) >= 3 then
			subdestination = strsub(msg, 3)
		end
	end
	return subdestination
end

function RU.AT.GenerateMessage()
	local name = UnitName(RU.AT.S_TARGET)
	local health = UnitHealth(RU.AT.S_TARGET) / UnitHealthMax(RU.AT.S_TARGET)
	local map = C_Map.GetBestMapForUnit(RU.AT.S_PLAYER)
	local x, y = C_Map.GetPlayerMapPosition(map, RU.AT.S_PLAYER):GetXY()
	local message = format('%s [%d%%] near (%.1f, %.1f) ', name, health * 100, x * 100, y * 100)
	C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(map, x, y))
	local waypoint = C_Map.GetUserWaypointHyperlink()
	C_Map.ClearUserWaypoint()
	return message..waypoint
end