local addonName, EXT = ...

local version = C_AddOns.GetAddOnMetadata(addonName, "Version") or ""
local buildDate = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate") or ""

EXT.CHANGELOG = {
	{
		version = version,
		date = buildDate ~= "" and buildDate or nil,
		entries = {
			"No changes available"
		}
	},
	{
		version = "v2.21",
		date = "2026-08-18",
		entries = {
			"Added: Changelog window available from the options menu",
			"Added: Changelog window available through the 'changelog' slash command",
			"Removed: Version notice chat messages",
			"Adapted to the latest version of Arcane Wizard: Library to ensure full compatibility"
		}
	},
	{
		version = "v2.20",
		date = "2026-08-14",
		entries = {
			"Removed: TOC version for patch 12.0.7 [retail]"
		}
	},
	{
		version = "v2.19",
		date = "2026-08-04",
		entries = {
			"Minor code adjustments"
		}
	},
	{
		version = "v2.18",
		date = "2026-07-28",
		entries = {
			"Added: TOC version for patch 1.15.9 [classic]",
			"Added: Item rarity and color-coded expansion badges are now displayed",
			"Removed: TOC version for patch 1.15.8 [classic]",
			"Minor code adjustments",
			"Adapted to the latest version of Arcane Wizard: Library to ensure full compatibility"
		}
	},
	{
		version = "v2.17",
		date = "2026-07-18",
		entries = {
			"Minor code adjustments"
		}
	},
	{
		version = "v2.16",
		date = "2026-07-12",
		entries = {
			"Added: Wago project page button",
			"Removed: TOC version for patch 5.5.3 [mists of pandaria - classic]",
			"Removed: TOC version for patch 2.5.5 [burning crusade - classic anniversary edition]"
		}
	},
	{
		version = "v2.15",
		date = "2026-07-09",
		entries = {
			"Minor code adjustments"
		}
	},
	{
		version = "v2.14",
		date = "2026-07-06",
		entries = {
			"Adapted to the latest version of Arcane Wizard: Library to ensure full compatibility"
		}
	},
	{
		version = "v2.13",
		date = "2026-07-04",
		entries = {
			"Added: TOC version for patch 12.1.0 [retail]",
			"Added: TOC version for patch 2.5.6 [burning crusade - classic anniversary edition]",
			"Removed: TOC version for patch 12.0.5 [retail]",
			"Minor code adjustments"
		}
	}
}
