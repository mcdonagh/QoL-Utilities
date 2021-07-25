local addonName, QOLUtils = ...

function QOLUtils.Attention()
	if QOL_Config_Acct.Attention > 0 then
		QOL_Config_Acct.Attention = QOL_Config_Acct.Attention - 1
		QOLUtils.Log(format('|cFFFF0000ATTENTION:|r Due to a recent update, some features of QoL Utilities are now disabled by default to prevent potential conflicts with other addons and to avoid unwanted behavior. Turn features on/off through the in-game configuration window. This message will display %d more %s.',
			QOL_Config_Acct.Attention,
			QOL_Config_Acct.Attention == 1 and 'time' or 'times'))
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

function QOLUtils.ToggleSetting(state, checkBox, feature, setting)
	if QOL_Config_Toon.Active then
		if state == nil then
			QOL_Config_Toon[feature][setting] = not QOL_Config_Toon[feature][setting]
		else
			QOL_Config_Toon[feature][setting] = state
		end
	else
		if state == nil then
			QOL_Config_Acct[feature][setting] = not QOL_Config_Acct[feature][setting]
		else
			QOL_Config_Acct[feature][setting] = state
		end
	end
	QOLUtils.OPT.UpdateCheckBox(checkBox, feature, setting)
end