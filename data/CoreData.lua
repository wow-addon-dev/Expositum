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
