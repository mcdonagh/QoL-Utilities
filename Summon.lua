local addonName, QOLUtils = ...

QOLUtils.SMN = {}
local smn = QOLUtils.SMN
local configAcct = QOL_Config_Acct.SMN
local configToon = QOL_Config_Toon.SMN
local optAcct = QOLUtils.OPT.Acct.SMN
local optToon = QOLUtils.OPT.Toon.SMN

function smn.IsEnabled()
	return QOLUtils.SettingIsTrue(configAcct.Enabled, configToon.Enabled)
end

function smn.Summon(args)
	local subdirection = args[2]
	local state = args[3]
	if subdirection == 'p' then
		if not smn.ProcessState(state, smn.ToggleFavoritePets, smn.ReportFavoritePets) then
			smn.Pet()
		end
	elseif subdirection == 'm' then
		if not smn.ProcessState(state, smn.ToggleFavoriteMounts, smn.ReportFavoriteMounts) then
			smn.Mount()
		end
	else
		smn.Pet()
		smn.Mount()
	end
end

function smn.ProcessState(state, Toggle, Report)
	local hasState = state == 'on' or state == 'off' or state == 'f'
	if hasState then
		if state == 'on' then
			Toggle(true)
		elseif state == 'off' then
			Toggle(false)
		else
			Toggle(nil)
		end
		Report()
	end
	return hasState
end

function smn.Pet()
	local onlyFavorites = QOLUtils.SettingIsTrue(configAcct.OnlyFavoritePets, configToon.OnlyFavoritePets)
	C_PetJournal.SummonRandomPet(onlyFavorites)
end

smn.Types = {}
smn.Types.Ground = {
	[230] = true,    -- for most ground mounts
	[269] = true     -- for  [Reins of the Azure Water Strider] and  [Reins of the Crimson Water Strider]
}
smn.Types.Flying = {
	[242] = true,    -- for Swift Spectral Gryphon (hidden in the mount journal, used while dead in certain zones)
	[247] = true,    -- for [Disc of the Red Flying Cloud]
	[248] = true     -- for most flying mounts, including those that change capability based on riding skill
}
smn.Types.Water = {
	[231] = true,    -- for  [Riding Turtle] and  [Sea Turtle]
	[232] = true,    -- for  [Vashj'ir Seahorse] (was named Abyssal Seahorse prior to Warlords of Draenor)
	[254] = true     -- for  [Reins of Poseidus],  [Brinedeep Bottom-Feeder] and  [Fathom Dweller]
}
smn.Types.Nazjatar = {
	[232] = true,
	[254] = true
}
smn.Types.Qiraj = {
	[241] = true     -- for Blue, Green, Red, and Yellow Qiraji Battle Tank (restricted to use inside Temple of Ahn'Qiraj)
}
smn.Types.LowLevel = {
	[284] = true     -- for  [Chauffeured Chopper] and Chauffeured Mechano-Hog
}

function smn.Mount()
	if IsMounted() then
		Dismount()
	elseif not UnitAffectingCombat('PLAYER') then
		local usableMounts = {}
		local lowLevel = not smn.HasRidingSkill()
		local underwater = smn.IsUnderWater()
		local flyable = IsFlyableArea()
		local hasFlight = smn.HasRidingSkillFlight()
		local inAhnqiraj = GetZoneText() == 'Ahn\'Qiraj'
		if lowLevel then
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.LowLevel, smn.Types.Ground)
		elseif underwater then
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.Water)
		elseif flyable then 
			if not hasFlight then
				usableMounts = smn.ScanJournal(usableMounts, smn.Types.Ground)
			else
				usableMounts = smn.ScanJournal(usableMounts, smn.Types.Flying, smn.Types.Nazjatar)
			end
		elseif inAhnqiraj then
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.Qiraj)
			if QOLUtils.TableIsNilOrEmpty(usableMounts) then
				usableMounts = smn.ScanJournal(usableMounts, smn.Types.Ground)
			end
		else
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.Ground)
		end
		if QOLUtils.TableIsNilOrEmpty(usableMounts) then
				and QOLUtils.SettingIsTrue(configAcct.OnlyFavoriteMounts, configToon.OnlyFavoriteMounts) then
			if lowLevel then
				smn.Log('No favorited mount available for pre riding skill use.')
			elseif underwater then
				smn.Log('No favorited mount available for underwater use.')
			elseif flyable and hasFlight then
				smn.Log('No favorited mount available for flying.')
			else
				smn.Log('No favorited mount available for ground use.')
			end
		elseif not QOLUtils.TableIsNilOrEmpty(usableMounts) then
			for i = #usableMounts, 2, -1 do
				local j = math.random(i)
				usableMounts[i], usableMounts[j] = usableMounts[j], usableMounts[i]
			end
			C_MountJournal.SummonByID(usableMounts[math.random(#usableMounts))])
		end
	end
end

function smn.HasRidingSkill()
	return smn.HasRidingSkillGround()
		or smn.HasRidingSkillFlight()
end

function smn.HasRidingSkillGround()
	return IsSpellKnown(33388)
		or IsSpellKnown(33391)
end

function smn.HasRidingSkillFlight()
	return IsSpellKnown(34090)
		or IsSpellKnown(34091)
		or IsSpellKnown(90265)
end

function smn.IsUnderWater()
	local underwater = IsSubmerged() and not smn.AtOrAboveSurface
	smn.AtOrAboveSurface = false
	return underwater
end

smn.AtOrAboveSurface = false
hooksecurefunc('AscendStop', function()
	smn.AtOrAboveSurface = not IsSubmerged()
end)

function smn.ScanJournal(existingMounts, validTypeA, validTypeB)
	local usableMounts = {}
	for i, v in ipairs(existingMounts) do
		table.insert(usableMounts, v)
	end
	local onlyFavorites = QOLUtils.SettingIsTrue(configAcct.OnlyFavoriteMounts, configToon.OnlyFavoriteMounts)
	for i, mountID in pairs(C_MountJournal.GetMountIDs()) do
		local _, _, _, _, isUsable, _, isFavorite = C_MountJournal.GetMountInfoByID(mountID)
		local _, _, _, _, typeID = C_MountJournal.GetMountInfoExtraByID(mountID)
		if isUsable and ((validTypeA and validTypeA[typeID]) or (validTypeB and validTypeB[typeID])) and ((onlyFavorites and isFavorite) or not onlyFavorites) then
			table.insert(usableMounts, mountID)
		end
	end
	return usableMounts
end

function smn.ToggleFavoritePets(state)
	configAcct.OnlyFavoritePets, configToon.OnlyFavoritePets =
	QOLUtils.ToggleSetting(state,
		configAcct.OnlyFavoritePets,
		configToon.OnlyFavoritePets,
		optAcct.CheckBoxPets,
		optToon.CheckBoxPets)
end

function smn.ToggleFavoriteMounts(state)
	configAcct.OnlyFavoriteMounts, configToon.OnlyFavoriteMounts =
	QOLUtils.ToggleSetting(state,
		configAcct.OnlyFavoriteMounts,
		configToon.OnlyFavoriteMounts,
		optAcct.CheckBoxMounts,
		optToon.CheckBoxMounts)
end

function smn.ToggleLogonReport()
	configAcct.ReportAtLogon, configToon.ReportAtLogon =
	QOLUtils.ToggleSetting(nil,
		configAcct.ReportAtLogon,
		configToon.ReportAtLogon,
		optAcct.CheckBoxReport,
		optToon.CheckBoxReport)
end

function smn.ReportFavoritePets()
	if QOLUtils.SettingIsTrue(configAcct.OnlyFavoritePets, configToon.OnlyFavoritePets) then
		smn.Log('Only favorited pets will be summoned.')
	else
		smn.Log('Any pet will be summoned.')
	end
end

function smn.ReportFavoriteMounts()
	if QOLUtils.SettingIsTrue(configAcct.OnlyFavoriteMounts, configToon.OnlyFavoriteMounts) then
		smn.Log('Only appropiate and favorited mounts will be summoned.')
	else
		smn.Log('Any appropiate mount will be summoned.')
	end
end

function smn.ReportInitial()
	if QOLUtils.SettingIsTrue(configAcct.ReportAtLogon, configToon.ReportAtLogon) then
		smn.ReportFavoritePets()
		smn.ReportFavoriteMounts()
	end
end

function smn.ToggleFavoritePetsOnClick()
	configAcct.OnlyFavoritePets = optAcct.CheckBoxPets:GetChecked()
	configToon.OnlyFavoritePets = optToon.CheckBoxPets:GetChecked()
end

function smn.ToggleFavoriteMountsOnClick()
	configAcct.OnlyFavoriteMounts = optAcct.CheckBoxMounts:GetChecked()
	configToon.OnlyFavoriteMounts = optToon.CheckBoxMounts:GetChecked()
end

function smn.ToggleLogonReportOnClick()
	configAcct.ReportAtLogon = optAcct.CheckBoxReport:GetChecked()
	configToon.ReportAtLogon = optToon.CheckBoxReport:GetChecked()
end

function smn.Log(msg)
	QOLUtils.Log(msg, 'SMN')
end