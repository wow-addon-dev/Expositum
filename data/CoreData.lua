local addonName, EXT = ...

EXT.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
EXT.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
EXT.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")

EXT.GAME_VERSION = GetBuildInfo()
EXT.GAME_FLAVOR = C_AddOns.GetAddOnMetadata(addonName, "X-Flavor")

EXT.LINK_GITHUB = C_AddOns.GetAddOnMetadata(addonName, "X-Github")
EXT.LINK_CURSEFORGE = C_AddOns.GetAddOnMetadata(addonName, "X-Curseforge")
EXT.LINK_WAGO = C_AddOns.GetAddOnMetadata(addonName, "X-Wago")

EXT.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\media\\"

EXT.GAME_TYPE_CLASSIC = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
---@diagnostic disable-next-line: undefined-global
EXT.GAME_TYPE_MISTS = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)
EXT.GAME_TYPE_RETAIL = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
