local addonName, EXT = ...

EXT.settings = EXT.settings or {}
EXT.data = EXT.data or {}
EXT.state = EXT.state or {}
EXT.modules = EXT.modules or {}

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return EXT.settings.general and EXT.settings.general["debug-mode"]
	end
})
