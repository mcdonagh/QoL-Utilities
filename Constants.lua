local addonName, QOLUtils = ...

QOLUtils.Patterns = {}
local ptrs = QOLUtils.Patterns
ptrs.Words = '%w+'
ptrs.Numbers = '%d+'
ptrs.WhiteSpace = '%s+'
ptrs.WhiteSpaceStart = '^' .. QOLUtils.Patterns.WhiteSpace
ptrs.WhiteSpaceEnd = QOLUtils.Patterns.WhiteSpace .. '$'

QOLUtils.Labels = {}
QOLUtils.Labels.AC = {}
QOLUtils.Labels.QM = {}
QOLUtils.Labels.VC = {}

local lb = QOLUtils.Labels
lb.Acct = 'ACCOUNT  WIDE  SETTINGS'
lb.Toon = 'CHARACTER  SPECIFIC  SETTINGS'
lb.UseToon = 'Use character specific settings.'

local ac = QOLUtils.Labels.AC
ac.Header = 'Auto Confirm'
ac.Report = 'Report Auto Confirm status at player logon and on reload.'
ac.Refundable = 'Automatically confirm to equip Refundable items.'
ac.Tradeable = 'Automatically confirm to equip Tradeable items.'
ac.Bindable = 'Automatically confirm to equip "Bind on Equip" items.'

local qm = QOLUtils.Labels.QM
qm.Header = 'Quiet Mode'
qm.Report = 'Report Quiet Mode status at player logon and on reload.'
qm.Party = 'Automatically decline Party Invites.'
qm.Duel = 'Automatically decline Duel Requests.'

local vc = QOLUtils.Labels.VC
vc.Header = 'Volume Cycler'
vc.Levels = 'Volume percentages to cycle through (each value separated by whitespace).'