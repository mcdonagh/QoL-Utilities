local addonName, QOLUtils = ...

function QOLUtils.Attention(alert)
	if alert and QOL_Config_Acct.Attention[alert] and QOL_Config_Acct.Attention[alert].Count > 0 and QOL_Config_Acct.Attention[alert].Message then
		local repeatsLeft = QOL_Config_Acct.Attention[alert].Count - 1
		QOL_Config_Acct.Attention[alert].Count = repeatsLeft
		local repeatMessage
		if repeatsLeft > 0 then
			repeatMessage = 'This message will display ' .. repeatsLeft .. ' more ' .. (repeatsLeft == 1 and 'time.' or 'times.')
		else
			repeatMessage = 'This message will NOT display again.'
		end
		QOLUtils.Log(nil, '!! |cFFFF0000ATTENTION|r !! ', QOL_Config_Acct.Attention[alert].Message, repeatMessage)
	end
end

function QOLUtils.Debug(...)
	QOLUtils.Log('DEBUG', ...)
end

function QOLUtils.Log(subID, ...)
	local ID = subID and format('[QOL Utils - %s]', subID) or '[QOL Utils]'
	ID = '|cFF4ba4d1' .. ID .. '|r'
	print(date('%H:%M'), ID, ...)
end

function QOLUtils.IsNilOrWhitespace(val)
	return val == nil or val:gsub(QOLUtils.Patterns.WhiteSpaceStart, '') == ''
end

function QOLUtils.ValueOrDefault(val, default)
	local result = nil
	if QOLUtils.IsNilOrWhitespace(val) then
		if default == nil then
			result = 'NIL'
		else
			result = default
		end
	else
		result = val
	end
	return result
end

function QOLUtils.TableIsNilOrEmpty(t)
	return t == nil or table.getn(t) < 1
end

function QOLUtils.StrToTable(str, pattern)
	local args = {}
	for num in str:gmatch(pattern) do
		table.insert(args, num)
	end
	return args
end

function QOLUtils.TableToStr(t, separator)
	local str = ''
	local sep = QOLUtils.ValueOrDefault(separator, ' ')
	for i = 1, table.getn(t) do
		str = str .. tostring(t[i]) .. sep
	end
	str = str:gsub(QOLUtils.Patterns.WhiteSpaceStart, ''):gsub(QOLUtils.Patterns.WhiteSpaceEnd, '')
	return str
end

function QOLUtils.GetFrame(name)
	local frame = _G[name]
	if frame == nil then 
		for i = 1, 10 do
			frame = _G[name .. i]
			if frame and frame.which and frame.IsShown and frame:IsShown() then
				return frame, i
			end
		end
	else
		return frame
	end
end

function QOLUtils.SettingIsTrue(feature, setting)
	if feature and setting then
		return QOL_Config_Toon.Active and QOL_Config_Toon[feature][setting] or not QOL_Config_Toon.Active and QOL_Config_Acct[feature][setting]
	end
end

function QOLUtils.ToggleSetting(state, checkBox, feature, setting)
	local config = QOLUtils.GetConfig(feature)
	if state == nil then
		config[setting] = not config[setting]
	else
		config[setting] = state
	end
	QOLUtils.OPT.UpdateCheckBox(checkBox, feature, setting)
end

function QOLUtils.GetConfig(feature)
	if QOL_Config_Toon.Active then
		return feature and QOL_Config_Toon[feature] or QOL_Config_Toon
	else
		return feature and QOL_Config_Acct[feature] or QOL_Config_Acct
	end
end