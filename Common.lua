local addonName, QOLUtils = ...

function QOLUtils.Log(message, subID)
	local ID = '[QoLUtils]'
	if not QOLUtils.IsEmpty(subID) then
		ID = format('[QoL Utils - %s]', subID)
	end
	if QOLUtils.IsEmpty(message) then
		message = 'NIL'
	end
	print(format('%s  %s  %s', date('%H:%M'), ID, message))
end

function QOLUtils.IsEmpty(val)
	return val == nil or val == ''
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