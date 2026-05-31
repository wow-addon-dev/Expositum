local addonName, EXT = ...

local L = EXT.Localization

local AWL = ArcaneWizardLibrary

local Utils = {}

-----------------------
--- Local Functions ---
-----------------------

local function CopyTable(source)
	return AWL.Utils:CopyTable(source)
end

local function GetCharacterRealmKey()
	return AWL.Utils:GetCharacterRealmKey()
end

------------------------
--- Public Functions ---
------------------------

function Utils:PrintDebug(msg)
	if EXT.settings.general["debug-mode"] then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ") .. msg)
	end
end

function Utils:PrintMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
end

function Utils:IsAccountProfile()
	local characterRealmKey = GetCharacterRealmKey()

	return Expositum_Options_v3.profileKeys[characterRealmKey]["use-account"]
end

function Utils:OpenSettingsOnLoading()
	local characterRealmKey = GetCharacterRealmKey()

	if Expositum_Options_v3.profileKeys[characterRealmKey]["open-settings"] then
		Settings.OpenToCategory(EXT.MAIN_CATEGORY_ID)

		Expositum_Options_v3.profileKeys[characterRealmKey]["open-settings"] = false
	end
end

function Utils:ToggleProfileMode()
	local characterRealmKey = GetCharacterRealmKey()
	local useAccountProfile = self:IsAccountProfile()

	Expositum_Options_v3.profileKeys[characterRealmKey]["use-account"] = not useAccountProfile
	Expositum_Options_v3.profileKeys[characterRealmKey]["open-settings"] = true
end

function Utils:ResetAllCharacterProfiles()
	local characterRealmKey = GetCharacterRealmKey()

	Expositum_Options_v3.profiles = {}
	Expositum_Options_v3.profileKeys = {}

	Expositum_Options_v3.profileKeys[characterRealmKey] = {
		["use-account"] = true,
		["open-settings"] = true
	}
end

function Utils:InitializeDatabase()
	local characterRealmKey = GetCharacterRealmKey()

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
			["account"] = CopyTable(defaults),
			["profiles"] = {},
			["profileKeys"] = {}
		}
	end

	if not Expositum_Options_v3.profiles[characterRealmKey] then
		Expositum_Options_v3.profiles[characterRealmKey] = CopyTable(defaults)
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
		EXT.settings.general = Expositum_Options_v3.account["general"]
		EXT.settings.tooltip = Expositum_Options_v3.account["tooltip"]
	else
		EXT.settings.general = Expositum_Options_v3.profiles[characterRealmKey]["general"]
		EXT.settings.tooltip = Expositum_Options_v3.profiles[characterRealmKey]["tooltip"]
	end

	return {
		characterRealmKey = characterRealmKey,
		createdProfile = createdProfile,
		createdProfileKey = createdProfileKey,
		activeProfile = useAccountProfile and "account" or "character"
	}
end

function Utils:InitializeMinimapButton()
	local LDB = LibStub("LibDataBroker-1.1"):NewDataObject(addonName, {
		type     = "launcher",
		text     = addonName,
		icon     = EXT.MEDIA_PATH .. "icon-round.blp",
		OnClick  = function(self, button)
			if button == "RightButton" then
				if not InCombatLockdown() then
					Settings.OpenToCategory(EXT.MAIN_CATEGORY_ID)
				else
					Utils:PrintDebug("In combat. The options menu cannot be opened.")
				end
			end
		end,
		OnTooltipShow = function(tooltip)
			GameTooltip_SetTitle(tooltip, addonName)
			GameTooltip_AddNormalLine(tooltip, EXT.ADDON_VERSION .. " (" .. EXT.ADDON_BUILD_DATE .. ")")
			GameTooltip_AddBlankLineToTooltip(tooltip)
			GameTooltip_AddHighlightLine(tooltip, L["minimap-button.tooltip"])
		end,
	})

	self.minimapButton = LibStub("LibDBIcon-1.0")
	self.minimapButton:Register(addonName, LDB, EXT.settings.general["minimap-button"])
end

EXT.modules.Utils = Utils
