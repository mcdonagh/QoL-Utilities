local addonName, QOLUtils = ...

SLASH_QOLUTILITIES1 = '/ru'
SlashCmdList['QOLUTILITIES'] = function (msg)
	QOLUtils.ParseInput(msg)
end

function QOLUtils.ParseInput(msg)
	local args = {}
	for word in msg:gmatch('%w+') do 
		table.insert(args, word)
	end
	local direction = args[1]
	if QOLUtils.IsEmpty(msg) then
		QOLUtils.OPT.OpenConfig()
	elseif direction == 'atc' then
		QOLUtils.ATC.Clean(true)
	elseif direction == 'ac' then
		QOLUtils.AC.ToggleAutoConfirm()
	elseif direction == 'at' then
		QOLUtils.AT.AnnounceTarget(args)
	elseif direction == 'mm' then
		QOLUtils.MM.ToggleMiddleMarker()
	elseif direction == 'qm' then
		QOLUtils.QM.ToggleQuietMode()
	end
end

function QOLUtils.Log(message, subID)
	local ID = '  [QOLUtils]  '
	if not QOLUtils.IsEmpty(subID) then
		ID = '  [QOLUtils-' .. subID .. ']  '
	end
	print(date('%H:%M') .. ID .. message)
end

function QOLUtils.IsEmpty(val)
	return val == nil or val == ''
end
