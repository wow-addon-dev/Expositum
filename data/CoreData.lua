local addonName, EXT = ...

EXT.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
EXT.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
EXT.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")

EXT.GAME_VERSION = GetBuildInfo()

EXT.LINK_GITHUB = C_AddOns.GetAddOnMetadata(addonName, "X-Github")
EXT.LINK_CURSEFORGE = C_AddOns.GetAddOnMetadata(addonName, "X-Curseforge")
EXT.LINK_WAGO = C_AddOns.GetAddOnMetadata(addonName, "X-Wago")

EXT.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\assets\\"

EXT.GAME_TYPE_VANILLA = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
EXT.GAME_TYPE_TBC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
---@diagnostic disable-next-line: undefined-global
EXT.GAME_TYPE_MISTS = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)
EXT.GAME_TYPE_MAINLINE = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

EXT.GAME_FLAVOR = "unknown"

if EXT.GAME_TYPE_VANILLA then
	EXT.GAME_FLAVOR = "Classic"
elseif EXT.GAME_TYPE_TBC then
	EXT.GAME_FLAVOR = "Burning Crusade - Classic Anniversary Edition"
elseif EXT.GAME_TYPE_MISTS then
	EXT.GAME_FLAVOR = "Mist of Pandaria - Classic"
elseif EXT.GAME_TYPE_MAINLINE then
	EXT.GAME_FLAVOR = "Retail"
end
