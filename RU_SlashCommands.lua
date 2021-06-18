local addonName, RU = ...

SLASH_REDBEARDSUTILITIES1 = '/ru'

SlashCmdList['REDBEARDSUTILITIES'] = function (msg)
	RU.ParseInput(msg)
end

function RU.ParseInput(msg)
	local words = {}
	local count = 0
	for word in s:gmatch('%w+') do 
		table.insert(words, word)
		RU.Log(word)
		count = count + 1
	end
	local n = table.getn(words)
	RU.Log('count = ' .. count .. ' | getn = ' .. n)
end

function RU.Log(message)	
	print(date('%H:%M') .. '  [QM]  ' .. message)
end