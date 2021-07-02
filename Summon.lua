local addonName, QOLUtils = ...

QOLUtils.SMN = {}
local smn = QOLUtils.SMN
smn.Favorites = {}

hooksecurfunc(C_MountJournal, 'SetIsFavorite', smn.UpdateJournal)

function smn.ScanJournal()
	for mountID = 1, C_MountJournal.GetMountIDs() do
		local _, _, _, _, _, _, isFavorite = C_MountJournal.GetMountInfoByID(mountID)
		smn.Favorites[mountID] = isFavorite
	end
end

function smn.UpdateJournal(mountID, isFavorite)
	smn.Favorites[mountID] = isFavorite
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