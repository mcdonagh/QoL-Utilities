local addonName, QOLUtils = ...

QOLUtils.Alert = nil

QOLUtils.Patterns = {}
local ptrs = QOLUtils.Patterns
ptrs.Words = '%w+'
ptrs.Numbers = '%d+'
ptrs.Decimals = '%d*%.?%d*'
ptrs.WhiteSpace = '%s+'
ptrs.WhiteSpaceStart = '^' .. QOLUtils.Patterns.WhiteSpace
ptrs.WhiteSpaceEnd = QOLUtils.Patterns.WhiteSpace .. '$'

QOLUtils.Formats = {}
local fmts = QOLUtils.Formats
fmts.Number = '%d'
fmts.NumberPrecision1 = '%.1f'
fmts.NumberPrecision2 = '%.2f'

QOLUtils.ConfigSpacing = {}
local spc = QOLUtils.ConfigSpacing
spc.SectionGap = 40
spc.HeaderGap = 30
spc.ItemGap = 20
spc.Indent = 30

QOLUtils.Labels = {}
local lb = QOLUtils.Labels
lb.Header = 'QoL Utilities'
lb.UseToon = 'USE CHARACTER SPECIFIC SETTINGS'
lb.Enabled = 'Feature enabled'

QOLUtils.Labels.ATC = {}
local atc = QOLUtils.Labels.ATC
atc.Header = 'Achievement Tracker Cleaner (ATC)'

QOLUtils.Labels.AT = {}
local at = QOLUtils.Labels.AT
at.Header = 'Announce Target (AT)'

QOLUtils.Labels.AC = {}
local ac = QOLUtils.Labels.AC
ac.Header = 'Auto Confirm (AC)'
ac.Report = 'Report Auto Confirm status at player logon and on reload'
ac.Refundable = 'Automatically confirm to equip Refundable items'
ac.Tradeable = 'Automatically confirm to equip Tradeable items'
ac.Bindable = 'Automatically confirm to equip "Bind on Equip" items'

QOLUtils.Labels.MM = {}
local mm = QOLUtils.Labels.MM
mm.Header = 'Middle Marker (MM)'
mm.Red = 'Red'
mm.Green = 'Green'
mm.Blue = 'Blue'
mm.Alpha = 'Line Opacity'
mm.Thickness = 'Line Thickness'

QOLUtils.Labels.QM = {}
local qm = QOLUtils.Labels.QM
qm.Header = 'Quiet Mode (QM)'
qm.Report = 'Report Quiet Mode status at player logon and on reload'
qm.Party = 'Automatically decline Party Invites'
qm.Duel = 'Automatically decline Duel Requests'

QOLUtils.Labels.SMN = {}
local smn = QOLUtils.Labels.SMN
smn.Header = 'Summon Mounts & Pets (SMN)'
smn.Report = 'Report Summon status at player logon and on reload'
smn.OnlyFavoritePets = 'Only summon favorite pets when summoning a random pet'
smn.OnlyFavoriteMounts = 'Only summon favorite mounts when summoning a mount'

QOLUtils.Labels.VC = {}
local vc = QOLUtils.Labels.VC
vc.Header = 'Volume Cycler (VC)'
vc.Levels = 'Volume percentages to cycle through (values separated by whitespace)'