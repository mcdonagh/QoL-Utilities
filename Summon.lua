local addonName, QOLUtils = ...

QOLUtils.SMN = {}
local smn = QOLUtils.SMN
local UsableMounts = {}

hooksecurfunc(C_MountJournal, 'SetIsFavorite', smn.UpdateJournal)

local GroundTypes = {}
local FlyingTypes = {}
local WaterTypes = {}
local SpecialTypes = {}
GroundTypes[230] = true   -- for most ground mounts
GroundTypes[269] = true   -- for  [Reins of the Azure Water Strider] and  [Reins of the Crimson Water Strider]
FlyingTypes[242] = true   -- for Swift Spectral Gryphon (hidden in the mount journal, used while dead in certain zones)
FlyingTypes[247] = true   -- for  [Disc of the Red Flying Cloud]
FlyingTypes[248] = true   -- for most flying mounts, including those that change capability based on riding skill
WaterTypes[231] = true    -- for  [Riding Turtle] and  [Sea Turtle]
WaterTypes[232] = true    -- for  [Vashj'ir Seahorse] (was named Abyssal Seahorse prior to Warlords of Draenor)
WaterTypes[254] = true    -- for  [Reins of Poseidus],  [Brinedeep Bottom-Feeder] and  [Fathom Dweller]
SpecialTyeps[241] = true  -- for Blue, Green, Red, and Yellow Qiraji Battle Tank (restricted to use inside Temple of Ahn'Qiraj)
SpecialTyeps[284] = true  -- for  [Chauffeured Chopper] and Chauffeured Mechano-Hog

function smn.ScanJournal()
	UsableMounts = {}
	for mountID = 1, C_MountJournal.GetMountIDs() do
		local _, _, _, _, _, _, isFavorite, _, _, hideOnChar, isCollected = C_MountJournal.GetMountInfoByID(mountID)
		local _, _, _, _, typeID = C_MountJournal.GetMountInfoExtraByID(mountID)
		if not hideOnChar and isCollected then
			UsableMounts[mountID] = { isFavorite, typeID })
		end
	end
	smn.Mount()
end

function smn.UpdateJournal(mountID, isFavorite)
	local _, _, _, _, typeID = C_MountJournal.GetMountInfoExtraByID(mountID)
	if isFavorite then
		UsableMounts[mountID] = { isFavorite, typeID }
	else
		UsableMounts[mountID] = nil
	end
end

function smn.Summon(args)
	if args[2] == 'update' then
		smn.ScanJournal()
	elseif args[2] == 'p' and args[3] 'on' then
		smn.ToggleFavoritePets(true)
	elseif args[2] == 'p' and args[3] == 'off' then
		smn.ToggleFavoritePets(false)
	elseif args[2] == 'p' and args[3] == 'f' then
		smn.ToggleFavoritePets(nil)
	elseif args[2] == 'p' then
		smn.Pet()
	elseif args[2] = 'm' then
		smn.Mount()
	else
		smn.Pet()
		smn.Mount()
	end
end

function smn.Mount()
	for i, mountData in ipairs(UsuableMounts) do
		smn.Log(format('i = %d | isFavorite | %s | typeID %s', i, mountData[1], mountData[2]) 
	end
end

function smn.Pet()
	local onlyFavorites = QOL_Config_Toon.Active and QOL_Config_Toon.SMN.OnlyFavoritePets or not QOL_Config_Toon.Active and QOL_Config.SMN.OnlyFavoritePets
	C_PetJournal.SummonRandomPet(onlyFavorites)
end

function smn.ToggleFavoritePets(state)
	if QOL_Config_Toon.Active then
		if state == nil then
			QOL_Config_Toon.SMN.OnlyFavoritePets = not QOL_Config_Toon.SMN.OnlyFavoritePets
		else
			QOL_Config_Toon.SMN.OnlyFavoritePets = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.CheckBoxFavoritePets, QOL_Config_Toon.SMN.OnlyFavoritePets)
	else
		if state == nil then
			QOL_Config.SMN.OnlyFavoritePets = not QOL_Config.OnlyFavoritePets
		else
			QOL_Config.SMN.OnlyFavoritePets = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.CheckBoxFavoritePets, QOL_Config.SMN.OnlyFavoritePets)
	end
end

function smn.Log(msg)
	QOLUtils.Log(msg, 'SMN')
end