local addonName, EXT = ...

EXT.Settings = EXT.Settings or {}
EXT.Data = EXT.Data or {}
EXT.State = EXT.State or {}
EXT.Modules = EXT.Modules or {}

EXT.Modules.Options = EXT.Modules.Options or {}
EXT.Modules.Tooltip = EXT.Modules.Tooltip or {}
EXT.Modules.Utils = EXT.Modules.Utils or {}

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return EXT.Settings.general and EXT.Settings.general["debug-mode"]
	end
})
