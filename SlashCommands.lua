local addonName, RU = ...

SLASH_REDBEARDSUTILITIES1 = '/ru'
SlashCmdList['REDBEARDSUTILITIES'] = function (msg)
	RU.ParseInput(msg)
end

function RU.ParseInput(msg)
	local args = {}
	local count = 0
	for word in s:gmatch('%w+') do 
		table.insert(args, word)
		RU.Log(word)
		count = count + 1
	end
	local n = table.getn(args)
	RU.Log('count = ' .. count .. ' | getn = ' .. n)
	local direction = args[1]
	if direction == 'mm' then
		RU.ToggleMiddleMarker()
	elseif direction == 'at' then
		RU.AnnounceTarget(args)
	elseif direction == 'qm' then
		RU.ToggleQuietMode()
	elseif direction == 'ac' then
		RU.ToggleAutoConfirm()
	end
end

function RU.Log(message, subID)
	local ID = '  [RU]  '
	if not RU.IsEmpty(subID) then
		ID = '  [RU-' .. subID .. ']  '
	end
	print(date('%H:%M') .. ID .. message)
end

function RU.IsEmpty(val)
	return val == nil or val == ''
end
