local addonName, EXT = ...

-- Enable only for releases with new features or important changes.
EXT.SHOW_UPDATE_NOTICE = false

local expansionBadgePath = "Interface\\AddOns\\" .. addonName .. "\\assets\\expansion-badges\\"

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

EXT.EXPANSION_BADGES = {
	[0]  = { abbreviation = "CL",    color = "D8B45A", texture = expansionBadgePath .. "classic.tga" },
	[1]  = { abbreviation = "TBC",   color = "9BBF4B", texture = expansionBadgePath .. "burning-crusade.tga" },
	[2]  = { abbreviation = "WotLK", color = "78C8E8", texture = expansionBadgePath .. "wrath-of-the-lich-king.tga" },
	[3]  = { abbreviation = "Cata",  color = "F0643C", texture = expansionBadgePath .. "cataclysm.tga" },
	[4]  = { abbreviation = "MoP",   color = "45C58A", texture = expansionBadgePath .. "mists-of-pandaria.tga" },
	[5]  = { abbreviation = "WoD",   color = "C76A4A", texture = expansionBadgePath .. "warlords-of-draenor.tga" },
	[6]  = { abbreviation = "LEG",   color = "9AF05A", texture = expansionBadgePath .. "legion.tga" },
	[7]  = { abbreviation = "BfA",   color = "4FA7D9", texture = expansionBadgePath .. "battle-for-azeroth.tga" },
	[8]  = { abbreviation = "SL",    color = "C2C7CF", texture = expansionBadgePath .. "shadowlands.tga" },
	[9]  = { abbreviation = "DF",    color = "D1A25A", texture = expansionBadgePath .. "dragonflight.tga" },
	[10] = { abbreviation = "TWW",   color = "F39A3F", texture = expansionBadgePath .. "the-war-within.tga" },
	[11] = { abbreviation = "MID",   color = "A47BE8", texture = expansionBadgePath .. "midnight.tga" }
}
