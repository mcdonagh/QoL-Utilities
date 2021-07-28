local addonName, QOLUtils = ...

function QOLUtils.Attention(setting)
	if QOL_Config_Acct.Attention[setting] > 0 then
		local repeatsLeft = QOL_Config_Acct.Attention[setting] - 1
		QOL_Config_Acct.Attention[setting] = repeatsLeft
		local repeatMessage
		if repeatsLeft > 0 then
			repeatMessage = 'This message will display ' .. repeatsLeft .. ' more ' .. (repeatsLeft == 1 and 'time.' or 'times.')
		else
			repeatMessage = 'This message will NOT display again.'
		end
		QOLUtils.Log('|cFFFF0000ATTENTION|r: Due to a recent update, some features of QoL Utilities are now disabled by default to prevent potential conflicts with other addons and to avoid unwanted behavior. Turn features on/off through the in-game configuration window. ' .. repeatMessage)
	end
end

function QOLUtils.Log(message, subID)
	local ID = '[QoLUtils]'
	if not QOLUtils.IsNilOrWhitespace(subID) then
		ID = format('[QoL Utils - %s]', subID)
	end
	message = QOLUtils.ValueOrDefault(message)
	print(format('%s  %s  %s', date('%H:%M'), ID, message))
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