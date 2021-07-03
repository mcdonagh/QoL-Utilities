local addonName, QOLUtils = ...

QOLUtils.SMN = {}
local smn = QOLUtils.SMN

function smn.Summon(args)
	local subdirection = args[2]
	local state = QOLUtils.ValueOrNIL(args[3])
	if subdirection == 'update' then
		smn.ScanJournal()
	elseif subdirection == 'p' and state == 'on' then
		smn.ToggleFavoritePets(true)
		smn.ReportFavoritePets()
	elseif subdirection == 'p' and state == 'off' then
		smn.ToggleFavoritePets(false)
		smn.ReportFavoritePets()
	elseif subdirection == 'p' and state == 'f' then
		smn.ToggleFavoritePets(nil)
		smn.ReportFavoritePets()
	elseif subdirection == 'p' then
		smn.Pet()
	elseif subdirection == 'm' and state == 'on' then
		smn.ToggleFavoriteMounts(true)
		smn.ReportFavoriteMounts()
	elseif subdirection == 'm' and state == 'off' then
		smn.ToggleFavoriteMounts(false)
		smn.ReportFavoriteMounts()
	elseif subdirection == 'm' and state == 'f' then
		smn.ToggleFavoriteMounts(nil)
		smn.ReportFavoriteMounts()
	elseif subdirection == 'm' then
		smn.Mount()
	else
		smn.Pet()
		smn.Mount()
	end
end

function smn.Pet()
	local onlyFavorites = QOL_Config_Toon.Active and QOL_Config_Toon.SMN.OnlyFavoritePets or not QOL_Config_Toon.Active and QOL_Config.SMN.OnlyFavoritePets
	C_PetJournal.SummonRandomPet(onlyFavorites)
end

smn.Types = {}
smn.Types.Ground = {}
smn.Types.Ground[230] = true   -- for most ground mounts
smn.Types.Ground[269] = true   -- for  [Reins of the Azure Water Strider] and  [Reins of the Crimson Water Strider]
smn.Types.Flying = {}
smn.Types.Flying[242] = true   -- for Swift Spectral Gryphon (hidden in the mount journal, used while dead in certain zones)
smn.Types.Flying[247] = true   -- for  [Disc of the Red Flying Cloud]
smn.Types.Flying[248] = true   -- for most flying mounts, including those that change capability based on riding skill
smn.Types.Water = {}
smn.Types.Water[231] = true    -- for  [Riding Turtle] and  [Sea Turtle]
smn.Types.Water[232] = true    -- for  [Vashj'ir Seahorse] (was named Abyssal Seahorse prior to Warlords of Draenor)
smn.Types.Water[254] = true    -- for  [Reins of Poseidus],  [Brinedeep Bottom-Feeder] and  [Fathom Dweller]
smn.Types.Qiraj = {}
smn.Types.Qiraj[241] = true    -- for Blue, Green, Red, and Yellow Qiraji Battle Tank (restricted to use inside Temple of Ahn'Qiraj)
smn.Types.LowLevel = {}
smn.Types.LowLevel[284] = true -- for  [Chauffeured Chopper] and Chauffeured Mechano-Hog

function smn.Mount()
	if IsMounted() then
		Dismount()
	else
		local usableMounts = {}
		if not smn.HasRidingSkill() then
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.LowLevel, smn.Types.Ground)
		elseif IsSubmerged() then
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.Water)
		elseif IsFlyableArea() then 
			if not smn.CanRideFlyingMounts() then
				usableMounts = smn.ScanJournal(usableMounts, smn.Types.Ground)
			else
				usableMounts = smn.ScanJournal(usableMounts, smn.Types.Flying, smn.Types.Water)
			end
		elseif GetZoneText() == 'Temple of Ahn\'Qiraj' then
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.Qiraj)
			if QOLUtils.TableIsNilOrEmpty(usableMounts) then
				usableMounts = smn.ScanJournal(usableMounts, smn.Types.Ground)
			end
		end
		C_MountJournal.SummonByID(usableMounts[math.random(table.getn(usableMounts))])
	end
end

function smn.HasRidingSkill()
	return smn.CanRideGroundMounts()
		or smn.CanRideFlyingMounts()
end

function smn.CanRideGroundMounts()
	return C_Spell.DoesSpellExist(33388)
		or C_Spell.DoesSpellExist(33391)
end

function smn.CanRideFlyingMounts()
	return C_Spell.DoesSpellExist(34090)
		or C_Spell.DoesSpellExist(34091)
		or C_Spell.DoesSpellExist(90265)
end

function smn.ScanJournal(existingMounts, validTypeA, validTypeB)
	local usableMounts = {}
	for i, v in ipairs(existingMounts) do
		table.insert(usableMounts, v)
	end
	local foundMounts = {}
	local onlyFavorites = QOL_Config_Toon.Active and QOL_Config_Toon.SMN.OnlyFavoriteMounts or not QOL_Config_Toon.Active and QOL_Config.SMN.OnlyFavoriteMounts
	for i, mountID in pairs(C_MountJournal.GetMountIDs()) do
		local _, _, _, _, isUsable, _, isFavorite = C_MountJournal.GetMountInfoByID(mountID)
		local _, _, _, _, typeID = C_MountJournal.GetMountInfoExtraByID(mountID)
		if isUsable and ((validTypeA and validTypeA[typeID]) or (validTypeB and validTypeB[typeID])) and ((onlyFavorites and isFavorite) or not onlyFavorites) then
			table.insert(foundMounts, mountID)
		end
	end
	for i, v in ipairs(foundMounts) do
		table.insert(usableMounts, v)
	end
	return usableMounts
end

function smn.ToggleFavoritePets(state)
	if QOL_Config_Toon.Active then
		if state == nil then
			QOL_Config_Toon.SMN.OnlyFavoritePets = not QOL_Config_Toon.SMN.OnlyFavoritePets
		else
			QOL_Config_Toon.SMN.OnlyFavoritePets = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.CheckBoxPets, QOL_Config_Toon.SMN.OnlyFavoritePets)
	else
		if state == nil then
			QOL_Config.SMN.OnlyFavoritePets = not QOL_Config.OnlyFavoritePets
		else
			QOL_Config.SMN.OnlyFavoritePets = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.CheckBoxPets, QOL_Config.SMN.OnlyFavoritePets)
	end
end

function smn.ToggleFavoriteMounts(state)
	if QOL_Config_Toon.Active then
		if state == nil then
			QOL_Config_Toon.SMN.OnlyFavoriteMounts = not QOL_Config_Toon.SMN.OnlyFavoriteMounts
		else
			QOL_Config_Toon.SMN.OnlyFavoriteMounts = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.CheckBoxMounts, QOL_Config_Toon.SMN.OnlyFavoriteMounts)
	else
		if state == nil then
			QOL_Config.SMN.OnlyFavoriteMounts = not QOL_Config.SMN.OnlyFavoriteMounts
		else
			QOL_Config.SMN.OnlyFavoriteMounts = state
		end
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.CheckBoxMounts, QOL_Config.SMN.OnlyFavoriteMounts)
	end
end

function smn.ToggleLogonReport()
	if QOL_Config_Toon.Active then
		QOL_Config_Toon.SMN.ReportAtLogon = not QOL_Config_Toon.SMN.ReportAtLogon
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Toon.SMN.CheckBoxReport, QOL_Config_Toon.SMN.ReportAtLogon)
	else
		QOL_Config.SMN.ReportAtLogon = not QOL_Config.SMN.ReportAtLogon
		QOLUtils.OPT.UpdateCheckBox(QOLUtils.OPT.Acct.SMN.CheckBoxReport, QOL_Config.SMN.ReportAtLogon)
	end
end

function smn.ReportFavoritePets()
	if QOL_Config_Toon.Active and QOL_Config_Toon.SMN.OnlyFavoritePets
			or not QOL_Config_Toon.Active and QOL_Config.SMN.OnlyFavoritePets then
		smn.Log('Only favorited pets will be summoned.')
	else
		smn.Log('Any pet will be summoned.')
	end
end

function smn.ReportFavoriteMounts()
	if QOL_Config_Toon.Active and QOL_Config_Toon.SMN.OnlyFavoriteMounts
			or not QOL_Config_Toon.Active and QOL_Config.SMN.OnlyFavoriteMountsthen
		smn.Log('Only favorited appropiate mounts will be summoned.')
	else
		smn.Log('Any appropiate mount will be summoned.')
	end
end

function smn.ReportInitial()
	if QOL_Config_Toon.Active and QOL_Config_Toon.SMN.ReportAtLogon
			or not QOL_Config_Toon.Active and QOL_Config.SMN.ReportAtLogon then
		smn.ReportFavoritePets()
		smn.ReportFavoriteMounts()
	end
end

function smn.Log(msg)
	QOLUtils.Log(msg, 'SMN')
end