local addonName, EXT = ...

-- local L = EXT.Localization

local Utils = EXT.modules.Utils
local Options = EXT.modules.Options
local Tooltip = EXT.modules.Tooltip

--------------
--- Frames ---
--------------

local ExpositumFrame = CreateFrame("Frame", "Expositum")

-----------------------
--- Local Functions ---
-----------------------

local function SlashCommand(msg, editbox)
    if not msg or msg:trim() == "" then
		if not InCombatLockdown() then
			Settings.OpenToCategory(EXT.MAIN_CATEGORY_ID)
		else
			Utils:PrintDebug("In combat. The options menu cannot be opened.")
		end
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
        Utils:InitializeDatabase()
        Utils:InitializeMinimapButton()
        Options:Initialize()

        Tooltip:Initialize()

		Utils:OpenSettingsOnLoading()

		Utils:PrintDebug("Addon fully loaded.")
    end
end

ExpositumFrame:RegisterEvent("ADDON_LOADED")
ExpositumFrame:SetScript("OnEvent", ExpositumFrame.OnEvent)

SLASH_Expositum1, SLASH_Expositum2 = '/ext', '/Expositum'

SlashCmdList["Expositum"] = SlashCommand
