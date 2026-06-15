local addonName, EXT = ...

EXT.Settings = EXT.Settings or {}
EXT.Data = EXT.Data or {}
EXT.State = EXT.State or {}
EXT.Modules = EXT.Modules or {}

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return EXT.Settings.general and EXT.Settings.general["debug-mode"]
	end
})
