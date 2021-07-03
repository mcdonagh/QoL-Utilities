local addonName, QOLUtils = ...

QOLUtils.Patterns = {}
local ptrs = QOLUtils.Patterns
ptrs.Words = '%w+'
ptrs.Numbers = '%d+'
ptrs.WhiteSpace = '%s+'
ptrs.WhiteSpaceStart = '^' .. QOLUtils.Patterns.WhiteSpace
ptrs.WhiteSpaceEnd = QOLUtils.Patterns.WhiteSpace .. '$'

QOLUtils.Labels = {}
local lb = QOLUtils.Labels
lb.Acct = 'ACCOUNT  WIDE  SETTINGS'
lb.Toon = 'CHARACTER  SPECIFIC  SETTINGS'
lb.UseToon = 'Use character specific settings.'

QOLUtils.Labels.AC = {}
local ac = QOLUtils.Labels.AC
ac.Header = 'Auto Confirm'
ac.Report = 'Report Auto Confirm status at player logon and on reload.'
ac.Refundable = 'Automatically confirm to equip Refundable items.'
ac.Tradeable = 'Automatically confirm to equip Tradeable items.'
ac.Bindable = 'Automatically confirm to equip "Bind on Equip" items.'

QOLUtils.Labels.QM = {}
local qm = QOLUtils.Labels.QM
qm.Header = 'Quiet Mode'
qm.Report = 'Report Quiet Mode status at player logon and on reload.'
qm.Party = 'Automatically decline Party Invites.'
qm.Duel = 'Automatically decline Duel Requests.'

QOLUtils.Labels.SMN = {}
local smn = QOLUtils.Labels.SMN
smn.Header = 'Summon Mounts & Pets'
smn.Report = 'Report Summon status at player logon and on reload.'
smn.OnlyFavoritePets = 'Only summon favorite pets when summoning a random pet.'
smn.OnlyFavoriteMounts = 'Only summon favorite mounts when summoning a mount.'

QOLUtils.Labels.VC = {}
local vc = QOLUtils.Labels.VC
vc.Header = 'Volume Cycler'
vc.Levels = 'Volume percentages to cycle through (each value separated by whitespace).'