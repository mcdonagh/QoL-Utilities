local addonName, RU = ...

RU.AT = {}
local at = RU.AT
at.S_TARGET = 'target'
at.S_PLAYER = 'player'

function at.AnnounceTarget(args)
	if UnitExists(at.S_TARGET) then
		local destination, subdestination = at.GetDestination(args)
		local message = at.GenerateMessage();
		SendChatMessage(message, destination, nil, subdestination)
	end
end

function at.GetDestination(args)
	local destination = 'CHANNEL'
	local subdestination = nil
	local indicator = 'c'
	if args[2] then
		indicator = args[2]
	end
	if indicator == 'c' then
		destination = 'CHANNEL'
		subdestination = at.GetSubDestination(true, args)
	elseif indicator == 'g' then
		destination = 'GUILD'
	elseif indicator == 'w' then
		destination = 'WHISPER'
		subdestination = at.GetSubDestination(false, args)
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

function at.GetSubDestination(isChannel, args)
	local subdestination = isChannel and 1 or UnitName(at.S_PLAYER)
	if args[3] then
		subdestination = args[3]
	end
	return subdestination
end

function at.GenerateMessage()
	local name = UnitName(at.S_TARGET)
	local health = UnitHealth(at.S_TARGET) / UnitHealthMax(at.S_TARGET)
	local map = C_Map.GetBestMapForUnit(at.S_PLAYER)
	local x, y = C_Map.GetPlayerMapPosition(map, at.S_PLAYER):GetXY()
	local message = health > 0 
		and format('%s [Health %d%%] near (%.1f, %.1f) ', name, health * 100, x * 100, y * 100)
		or format('%s [Dead] near (%.1f, %.1f) ', name, x * 100, y * 100)
	C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(map, x, y))
	local waypoint = C_Map.GetUserWaypointHyperlink()
	C_Map.ClearUserWaypoint()
	return message .. waypoint
end
