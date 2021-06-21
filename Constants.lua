local addonName, QOLUtils = ...

QOLUtils.Patterns = {}
local ptrs = QOLUtils.Patterns
ptrs.Words = '%w+'
ptrs.Numbers = '%d+'
ptrs.WhiteSpace = '$s+'
ptrs.WhiteSpaceStart = '^' .. QOLUtils.Patterns.WhiteSpace
ptrs.WhiteSpaceEnd = QOLUtils.Patterns.WhiteSpace .. '$'

QOLUtils.Labels = {}
local lbls = QOLUtils.Labels
lbls.OPT_AC = 'Automatically confirm to equip Tradeable or Refundable items.'
lbls.OPT_QM = 'Automatically decline Party Invites and Duel Requests.'
lbls.OPT_VCL = 'Volume percentages to cycle through (each value separated by whitespace).'
lbls.OPT_VCI = 'Index of the volume level to begin cycling through.'
