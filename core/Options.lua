local addonName, EXT = ...

local L = EXT.Localization

local Utils = EXT.modules.Utils

local AWL = ArcaneWizardLibrary

local Options = {}

-----------------------
--- Local Functions ---
-----------------------

local minimapButtonProxy = setmetatable({}, {
	__index = function(_, key)
		if key == "hide" then
			return not EXT.settings.general["minimap-button"]["hide"]
		end
	end,
	__newindex = function(_, key, value)
		if key ~= "hide" then
			return
		end

		EXT.settings.general["minimap-button"]["hide"] = not value

		if value then
			Utils.minimapButton:Show("Expositum")
		else
			Utils.minimapButton:Hide("Expositum")
		end
	end,
})

------------------------
--- Public Functions ---
------------------------

function Options:Initialize()
	local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

	-- Minimap Button
	AWL.Settings:AddCheckbox(category, {
		variableTable = minimapButtonProxy,
		settingKey    = addonName .. "_hide",
		variableName  = "hide",
		name          = L["options.general.minimap-button.name"],
		tooltip       = L["options.general.minimap-button.tooltip"],
		default       = true
	})

	-- Debug Mode
	AWL.Settings:AddCheckbox(category, {
		variableTable = EXT.settings.general,
		settingKey    = addonName .. "_debug-mode",
		variableName  = "debug-mode",
		name          = L["options.general.debug-mode.name"],
		tooltip       = L["options.general.debug-mode.tooltip"],
		default       = false
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.tooltip"]))

		-- Expansion Check
	if EXT.GAME_TYPE_MAINLINE then
		AWL.Settings:AddCheckbox(category, {
			variableTable = EXT.settings.tooltip,
			settingKey    = addonName .. "_expansion",
			variableName  = "expansion",
			name          = L["options.tooltip.expansion.name"],
			tooltip       = L["options.tooltip.expansion.tooltip"],
			default       = true
		})
	end

	-- Category
	AWL.Settings:AddCheckbox(category, {
		variableTable = EXT.settings.tooltip,
		settingKey    = addonName .. "_category",
		variableName  = "category",
		name          = L["options.tooltip.category.name"],
		tooltip       = L["options.tooltip.category.tooltip"],
		default       = true
	})

	-- Item Level
	AWL.Settings:AddCheckbox(category, {
		variableTable = EXT.settings.tooltip,
		settingKey    = addonName .. "_item-level",
		variableName  = "item-level",
		name          = L["options.tooltip.item-level.name"],
		tooltip       = L["options.tooltip.item-level.tooltip"],
		default       = true
	})

	-- Blank Line
	AWL.Settings:AddCheckbox(category, {
		variableTable = EXT.settings.tooltip,
		settingKey    = addonName .. "_blank-line",
		variableName  = "blank-line",
		name          = L["options.tooltip.blank-line.name"],
		tooltip       = L["options.tooltip.blank-line.tooltip"],
		default       = true
	})

	-- Profiles Section
	AWL.Settings:AddProfilesSection(layout, {
		useAccountProfile = Utils:IsAccountProfile(),
		onSwitchProfile = function()
			Utils:ToggleProfileMode()
			ReloadUI()
		end,
		onDeleteCharacterProfiles = function()
			Utils:ResetAllCharacterProfiles()
			ReloadUI()
		end
	})

	-- About Section
	AWL.Settings:AddAboutSection(layout, {
		gameVersion    = EXT.GAME_VERSION,
		gameFlavor     = EXT.GAME_FLAVOR,
		addonVersion   = EXT.ADDON_VERSION,
		addonBuildDate = EXT.ADDON_BUILD_DATE,
		addonAuthor    = EXT.ADDON_AUTHOR,
		githubLink     = EXT.LINK_GITHUB
	})

	Settings.RegisterAddOnCategory(category)

	EXT.MAIN_CATEGORY_ID = category:GetID()
end

EXT.modules.Options = Options
