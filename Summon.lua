local addonName, QOLUtils = ...

QOLUtils.SMN = {}
local smn = QOLUtils.SMN

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
	local onlyFavorites = QOLUtils.SettingIsTrue(QOL_Config.SMN.OnlyFavoritePets, QOL_Config_Toon.SMN.OnlyFavoritePets)
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
	else
		local usableMounts = {}
		if not smn.HasRidingSkill() then
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.LowLevel, smn.Types.Ground)
		elseif smn.IsUnderWater() then
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.Water)
		elseif IsFlyableArea() then 
			if not smn.HasRidingSkillFlight() then
				usableMounts = smn.ScanJournal(usableMounts, smn.Types.Ground)
			else
				usableMounts = smn.ScanJournal(usableMounts, smn.Types.Flying, smn.Types.Nazjatar)
			end
		elseif GetZoneText() == 'Ahn\'Qiraj' then
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.Qiraj)
			if QOLUtils.TableIsNilOrEmpty(usableMounts) then
				usableMounts = smn.ScanJournal(usableMounts, smn.Types.Ground)
			end
		else
			usableMounts = smn.ScanJournal(usableMounts, smn.Types.Ground)
		end
		C_MountJournal.SummonByID(usableMounts[math.random(table.getn(usableMounts))])
	end
end

function smn.HasRidingSkill()
	return smn.HasRidingSkillGround()
		or smn.HasRidingSkillFlight()
end

function smn.HasRidingSkillGround()
	return C_Spell.DoesSpellExist(33388)
		or C_Spell.DoesSpellExist(33391)
end

function smn.HasRidingSkillFlight()
	return C_Spell.DoesSpellExist(34090)
		or C_Spell.DoesSpellExist(34091)
		or C_Spell.DoesSpellExist(90265)
end

local breathingBuffs = {
	[5697] = true,
	[7178] = true,
	[11789] = true,
	[222105] = true
}

function smn.IsUnderWater()
	local _, _, _, _, paused = GetMirrorTimerInfo(2)
	local holdingBreath = paused > 0
	local hasBuff = false
	local _, buffSlots = UnitAuraSlots('PLAYER', 'HELPFUL')
	smn.Log('type = ' .. type(buffSlots))
	smn.Log(type(buffSlots) == 'table' and QOLUtils.TableToStr(buffSlots) or buffSlots)
	for slot in buffSlots do
		local _, _, _, _, _, _, _, _, _, spellID = UnitAuraBySlot('PLAYER', slot)
		smn.Log(spellID)
		if breathingBuffs[spellID] then
			hasBuff = true
		end
	end
	return IsSubmerged() and (holdingBreath or hasBuff)
end

function smn.ScanJournal(existingMounts, validTypeA, validTypeB)
	local usableMounts = {}
	for i, v in ipairs(existingMounts) do
		table.insert(usableMounts, v)
	end
	local onlyFavorites = QOLUtils.SettingIsTrue(QOL_Config.SMN.OnlyFavoriteMounts, QOL_Config_Toon.SMN.OnlyFavoriteMounts)
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
	QOL_Config.SMN.OnlyFavoritePets, QOL_Config_Toon.SMN.OnlyFavoritePets =
	QOLUtils.ToggleSetting(state,
		QOL_Config.SMN.OnlyFavoritePets,
		QOL_Config_Toon.SMN.OnlyFavoritePets,
		QOLUtils.OPT.Acct.SMN.CheckBoxPets,
		QOLUtils.OPT.Toon.SMN.CheckBoxPets)
end

function smn.ToggleFavoriteMounts(state)
	QOL_Config.SMN.OnlyFavoriteMounts, QOL_Config_Toon.SMN.OnlyFavoriteMounts =
	QOLUtils.ToggleSetting(state,
		QOL_Config.SMN.OnlyFavoriteMounts,
		QOL_Config_Toon.SMN.OnlyFavoriteMounts,
		QOLUtils.OPT.Acct.SMN.CheckBoxMounts,
		QOLUtils.OPT.Toon.SMN.CheckBoxMounts)
end

function smn.ToggleLogonReport()
	QOL_Config.SMN.ReportAtLogon, QOL_Config_Toon.SMN.ReportAtLogon =
	QOLUtils.ToggleSetting(nil,
		QOL_Config.SMN.ReportAtLogon,
		QOL_Config_Toon.SMN.ReportAtLogon,
		QOLUtils.OPT.Acct.SMN.CheckBoxReport,
		QOLUtils.OPT.Toon.SMN.CheckBoxReport)
end

function smn.ReportFavoritePets()
	if QOLUtils.SettingIsTrue(QOL_Config.SMN.OnlyFavoritePets, QOL_Config_Toon.SMN.OnlyFavoritePets) then
		smn.Log('Only favorited pets will be summoned.')
	else
		smn.Log('Any pet will be summoned.')
	end
end

function smn.ReportFavoriteMounts()
	if QOLUtils.SettingIsTrue(QOL_Config.SMN.OnlyFavoriteMounts, QOL_Config_Toon.SMN.OnlyFavoriteMounts) then
		smn.Log('Only appropiate and favorited mounts will be summoned.')
	else
		smn.Log('Any appropiate mount will be summoned.')
	end
end

function smn.ReportInitial()
	if QOLUtils.SettingIsTrue(QOL_Config.SMN.ReportAtLogon, QOL_Config_Toon.SMN.ReportAtLogon) then
		smn.ReportFavoritePets()
		smn.ReportFavoriteMounts()
	end
end

function smn.ToggleFavoritePetsOnClick()
	QOL_Config.SMN.OnlyFavoritePets = QOLUtils.OPT.Acct.SMN.CheckBoxPets:GetChecked()
	QOL_Config_Toon.SMN.OnlyFavoritePets = QOLUtils.OPT.Toon.SMN.CheckBoxPets:GetChecked()
end

function smn.ToggleFavoriteMountsOnClick()
	QOL_Config.SMN.OnlyFavoriteMounts = QOLUtils.OPT.Acct.SMN.CheckBoxMounts:GetChecked()
	QOL_Config_Toon.SMN.OnlyFavoriteMounts = QOLUtils.OPT.Toon.SMN.CheckBoxMounts:GetChecked()
end

function smn.ToggleLogonReportOnClick()
	QOL_Config.SMN.ReportAtLogon = QOLUtils.OPT.Acct.SMN.CheckBoxReport:GetChecked()
	QOL_Config_Toon.SMN.ReportAtLogon = QOLUtils.OPT.Toon.SMN.CheckBoxReport:GetChecked()
end

function smn.Log(msg)
	QOLUtils.Log(msg, 'SMN')
end