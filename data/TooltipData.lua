local _, EXT = ...

local function GetLocalizedExpansionName(expansionID, fallback)
	return _G["EXPANSION_NAME" .. expansionID] or fallback
end

EXT.EXPANSION_NAMES = {
	[0]  = GetLocalizedExpansionName(0, "Classic"),
	[1]  = GetLocalizedExpansionName(1, "The Burning Crusade"),
	[2]  = GetLocalizedExpansionName(2, "Wrath of the Lich King"),
	[3]  = GetLocalizedExpansionName(3, "Cataclysm"),
	[4]  = GetLocalizedExpansionName(4, "Mists of Pandaria"),
	[5]  = GetLocalizedExpansionName(5, "Warlords of Draenor"),
	[6]  = GetLocalizedExpansionName(6, "Legion"),
	[7]  = GetLocalizedExpansionName(7, "Battle for Azeroth"),
	[8]  = GetLocalizedExpansionName(8, "Shadowlands"),
	[9]  = GetLocalizedExpansionName(9, "Dragonflight"),
	[10] = GetLocalizedExpansionName(10, "The War Within"),
	[11] = GetLocalizedExpansionName(11, "Midnight")
}
