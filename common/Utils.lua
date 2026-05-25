local addonName, EXT = ...

local L = EXT.Localization

local AWL = ArcaneWizardLibrary

local Utils = {}

-----------------------
--- Local Functions ---
-----------------------

local function CopyTable(source)
	local target = {}

	for key, value in pairs(source) do
		if type(value) == "table" then
			target[key] = CopyTable(value)
		else
			target[key] = value
		end
	end

	return target
end

local function GetCharKey()
	return AWL.Utils:GetCharKey()
end

------------------------
--- Public Functions ---
------------------------

function Utils:PrintDebug(msg)
	if EXT.settings.general["debug-mode"] then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
	end
end

function Utils:PrintMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
end

function Utils:IsAccountProfile()
	local charKey = GetCharKey()

	return Expositum_Options_v3.profileKeys[charKey]["use-account"]
end

function Utils:OpenSettingsOnLoading()
	local charKey = GetCharKey()

	if Expositum_Options_v3.profileKeys[charKey]["open-settings"] then
		Settings.OpenToCategory(EXT.MAIN_CATEGORY_ID)

		Expositum_Options_v3.profileKeys[charKey]["open-settings"] = false
	end
end

function Utils:ToggleProfileMode()
	local charKey = GetCharKey()
	local useAccountProfile = self:IsAccountProfile()

	Expositum_Options_v3.profileKeys[charKey]["use-account"] = not useAccountProfile
	Expositum_Options_v3.profileKeys[charKey]["open-settings"] = true
end

function Utils:ResetAllCharacterProfiles()
	local charKey = GetCharKey()

	Expositum_Options_v3.profiles = {}
	Expositum_Options_v3.profileKeys = {}

	Expositum_Options_v3.profileKeys[charKey] = {
		["use-account"] = true,
		["open-settings"] = true
	}
end

function Utils:InitializeDatabase()
	local charKey = GetCharKey()

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

	if not Expositum_Options_v3.profiles[charKey] then
		Expositum_Options_v3.profiles[charKey] = CopyTable(defaults)
	end

	if not Expositum_Options_v3.profileKeys[charKey] then
		Expositum_Options_v3.profileKeys[charKey] = {
			["use-account"] = true,
			["open-settings"] = false
		}
	end

	if Expositum_Options_v3.profileKeys[charKey]["use-account"] then
		EXT.settings.general = Expositum_Options_v3.account["general"]
		EXT.settings.tooltip = Expositum_Options_v3.account["tooltip"]
	else
		EXT.settings.general = Expositum_Options_v3.profiles[charKey]["general"]
		EXT.settings.tooltip = Expositum_Options_v3.profiles[charKey]["tooltip"]
	end
end

function Utils:InitializeMinimapButton()
	local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Expositum", {
		type     = "launcher",
		text     = "Expositum",
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
	self.minimapButton:Register("Expositum", LDB, EXT.settings.general["minimap-button"])
end

EXT.modules.Utils = Utils
