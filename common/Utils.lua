local addonName, EXT = ...

-- Library
local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

-- Localization
local L = EXT.Localization

-- Current module
local Utils = EXT.Modules.Utils

-----------------------
--- Local Functions ---
-----------------------

local function PrintChatMessage(color, prefix, msg)
	DEFAULT_CHAT_FRAME:AddMessage(color:WrapTextInColorCode(prefix .. ": ") .. tostring(msg))
end

------------------------
--- Module Functions ---
------------------------

function Utils:PrintMessage(msg)
	PrintChatMessage(NORMAL_FONT_COLOR, addonName, msg)
end

function Utils:PrintDebug(msg)
	if EXT.Settings.general["debug-mode"] then
		PrintChatMessage(ORANGE_FONT_COLOR, addonName .. " (Debug)", msg)
	end
end

function Utils:OpenSettings()
	if not Addon:OpenCategory() then
		self:PrintDebug("In combat. The options menu cannot be opened.")
		return false
	end

	return true
end

function Utils:IsAccountProfile()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	return Expositum_Options_v3.profileKeys[characterRealmKey]["use-account"]
end

function Utils:OpenSettingsOnLoading()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	if Expositum_Options_v3.profileKeys[characterRealmKey]["open-settings"] then
		if not self:OpenSettings() then
			return
		end

		Expositum_Options_v3.profileKeys[characterRealmKey]["open-settings"] = false
	end
end

function Utils:ToggleProfileMode()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()
	local useAccountProfile = self:IsAccountProfile()

	Expositum_Options_v3.profileKeys[characterRealmKey]["use-account"] = not useAccountProfile
	Expositum_Options_v3.profileKeys[characterRealmKey]["open-settings"] = true
end

function Utils:ResetAllCharacterProfiles()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	Expositum_Options_v3.profiles = {}
	Expositum_Options_v3.profileKeys = {}

	Expositum_Options_v3.profileKeys[characterRealmKey] = {
		["use-account"] = true,
		["open-settings"] = true
	}
end

function Utils:InitializeDatabase()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	local createdProfile = false
	local createdProfileKey = false

	local defaults = {
		["general"] = {
			["minimap-button"] = {
				["hide"] = false
			}
		},
		["tooltip"] = {}
	}

	if not Expositum_Options_v3 then
		Expositum_Options_v3 = {
			["account"] = AWL.Utils:CopyTable(defaults),
			["profiles"] = {},
			["profileKeys"] = {}
		}
	end

	if not Expositum_Options_v3.profiles[characterRealmKey] then
		Expositum_Options_v3.profiles[characterRealmKey] = AWL.Utils:CopyTable(defaults)
		createdProfile = true
	end

	if not Expositum_Options_v3.profileKeys[characterRealmKey] then
		Expositum_Options_v3.profileKeys[characterRealmKey] = {
			["use-account"] = true,
			["open-settings"] = false
		}
		createdProfileKey = true
	end

	local useAccountProfile = Expositum_Options_v3.profileKeys[characterRealmKey]["use-account"]

	if useAccountProfile then
		EXT.Settings.general = Expositum_Options_v3.account["general"]
		EXT.Settings.tooltip = Expositum_Options_v3.account["tooltip"]
	else
		EXT.Settings.general = Expositum_Options_v3.profiles[characterRealmKey]["general"]
		EXT.Settings.tooltip = Expositum_Options_v3.profiles[characterRealmKey]["tooltip"]
	end

	return {
		characterRealmKey = characterRealmKey,
		createdProfile = createdProfile,
		createdProfileKey = createdProfileKey,
		activeProfile = useAccountProfile and "account" or "character"
	}
end

function Utils:InitializeMinimapButton()
	self.minimapButton = Addon:RegisterMinimapButton({
		db = EXT.Settings.general["minimap-button"],
		tooltip = L["minimap-button.tooltip"]
	})
end
