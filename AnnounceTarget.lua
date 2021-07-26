local addonName, QOLUtils = ...

QOLUtils.AT = {}
local at = QOLUtils.AT
local feature = 'AT'
local configAcct, configToon, storage

function at.Load()
	configAcct = QOL_Config_Acct.AT
	configToon = QOL_Config_Toon.AT
	storage = QOLUtils.OPT.Storage.AT
end

function at.IsEnabled()
	return QOLUtils.SettingIsTrue(feature, 'Enabled')
end

function at.CheckBoxEnabled_OnClick()
	if QOL_Config_Toon.Active then
		configToon.Enabled = storage.CheckBoxEnabled:GetChecked()
	else
		configAcct.Enabled = storage.CheckBoxEnabled:GetChecked()
	end
end

local tar = 'TARGET'
local player = 'PLAYER'

function at.AnnounceTarget(args)
	if UnitExists(tar) then
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
	local subdestination = isChannel and 1 or UnitName(player)
	if args[3] then
		subdestination = args[3]
	end
	return subdestination
end

function at.GenerateMessage()
	local name = UnitName(tar)
	local health = UnitHealth(tar) / UnitHealthMax(tar)
	local map = C_Map.GetBestMapForUnit(player)
	local x, y = C_Map.GetPlayerMapPosition(map, player):GetXY()
	local message = health > 0 
		and format('%s [Health %d%%] near (%.1f, %.1f) ', name, health * 100, x * 100, y * 100)
		or format('%s [Dead] near (%.1f, %.1f) ', name, x * 100, y * 100)
	C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(map, x, y))
	local waypoint = C_Map.GetUserWaypointHyperlink()
	C_Map.ClearUserWaypoint()
	return message .. waypoint
end