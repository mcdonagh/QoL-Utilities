local addonName, RU = ...

SLASH_REDBEARDSUTILITIES1 = '/ru'
SlashCmdList['REDBEARDSUTILITIES'] = function (msg)
	RU.ParseInput(msg)
end

function RU.ParseInput(msg)
	local args = {}
	for word in msg:gmatch('%w+') do 
		table.insert(args, word)
	end
	local direction = args[1]
	if direction == 'mm' then
		RU.MM.ToggleMiddleMarker()
	elseif direction == 'at' then
		RU.AT.AnnounceTarget(args)
	elseif direction == 'qm' then
		RU.QM.ToggleQuietMode()
	elseif direction == 'ac' then
		RU.AC.ToggleAutoConfirm()
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
