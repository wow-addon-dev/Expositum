local addonName, EXT = ...

local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

local L = EXT.Localization

local handlers = Addon:CreateCompartmentHandlers({
	tooltip = L["minimap-button.tooltip"]
})

------------------------
--- Public Functions ---
------------------------

function Expositum_CompartmentOnEnter(self, button)
	handlers.OnEnter(self, button)
end

function Expositum_CompartmentOnLeave()
	handlers.OnLeave()
end

function Expositum_CompartmentOnClick(self, button)
	handlers.OnClick(self, button)
end
