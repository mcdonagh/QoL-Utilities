local addonName, RU = ...

RU.OPT = {}
local opt = RU.OPT
opt.Panel = CreateFrame('Frame', 'Redbeard\'s Utilities', UIParent);
opt.Panel.name = 'Redbeard\'s Utilities'
InterfaceOptions_AddCategory(opt.Panel);

function opt.OpenConfig()
	InterfaceOptionsFrame_Show()
	InterfaceOptionsFrame_OpenToCategory(opt.Panel)
end

function opt.Okay()

end

function opt.Cancel()

end
