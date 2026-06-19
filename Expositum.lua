local addonName, EXT = ...

local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

local Options = EXT.Modules.Options
local Tooltip = EXT.Modules.Tooltip
local Utils = EXT.Modules.Utils

--------------
--- Frames ---
--------------

local ExpositumFrame = CreateFrame("Frame", "Expositum")

-----------------------
--- Local Functions ---
-----------------------

local function SlashCommand(msg, editbox)
	if not msg or strtrim(msg) == "" then
		Addon:OpenCategory()
	else
		Addon:PrintDebug("No arguments will be accepted.")
	end
end

------------------------
--- Public Functions ---
------------------------

function ExpositumFrame:OnEvent(event, ...)
	self[event](self, event, ...)
end

function ExpositumFrame:ADDON_LOADED(_, addOnName)
	if addOnName == addonName then
		local dbInit = Utils:InitializeDatabase()
		Utils:InitializeMinimapButton()
		Options:Initialize()

		Tooltip:Initialize()

		Utils:OpenSettingsOnLoading()

		Addon:PrintDebug(string.format(
			"InitializeDatabase: key=%s, createdProfile=%s, createdProfileKey=%s, activeProfile=%s",
			tostring(dbInit.characterRealmKey), tostring(dbInit.createdProfile), tostring(dbInit.createdProfileKey), tostring(dbInit.activeProfile)
		))
		Addon:PrintDebug("Addon fully loaded.")
	end
end

ExpositumFrame:RegisterEvent("ADDON_LOADED")
ExpositumFrame:SetScript("OnEvent", ExpositumFrame.OnEvent)

SLASH_Expositum1, SLASH_Expositum2 = '/ext', '/expositum'

SlashCmdList["Expositum"] = SlashCommand
