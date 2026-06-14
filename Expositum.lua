local addonName, EXT = ...

local Options = EXT.modules.Options
local Tooltip = EXT.modules.Tooltip
local Utils = EXT.modules.Utils

local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

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
		Utils:PrintDebug("No arguments will be accepted.")
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

		Utils:PrintDebug(string.format(
			"InitializeDatabase: key=%s, createdProfile=%s, createdProfileKey=%s, activeProfile=%s",
			tostring(dbInit.characterRealmKey), tostring(dbInit.createdProfile), tostring(dbInit.createdProfileKey), tostring(dbInit.activeProfile)
		))
		Utils:PrintDebug("Addon fully loaded.")
	end
end

ExpositumFrame:RegisterEvent("ADDON_LOADED")
ExpositumFrame:SetScript("OnEvent", ExpositumFrame.OnEvent)

SLASH_Expositum1, SLASH_Expositum2 = '/ext', '/expositum'

SlashCmdList["Expositum"] = SlashCommand
