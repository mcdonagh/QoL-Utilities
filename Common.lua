local addonName, QOLUtils = ...

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
	QOLUtils.Log(name)
	local frame = _G[name]
	QOLUtils.Log(frame)
	if frame == nil then 
		for i = 1, 10 do
			QOLUtils.Log(name .. i)
			frame = _G[name .. i]
			if frame and frame.which and frame.IsShown and frame:IsShown() then
				QOLUtils.Log(frame)
				return frame, i
			end
		end
	else
		return frame
	end
end

function QOLUtils.SettingIsTrue(acctSetting, toonSetting)
	return QOL_Config_Toon.Active and toonSetting or not QOL_Config_Toon.Active and acctSetting
end