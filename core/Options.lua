local addonName, EXT = ...

-- Library
local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

-- Localization
local L = EXT.Localization

-- Current module
local Options = EXT.Modules.Options

-- Module imports
local Utils = EXT.Modules.Utils

-- Variables
local minimapButtonProxy = setmetatable({}, {
	__index = function(_, key)
		if key == "hide" then
			return not EXT.Settings.general["minimap-button"]["hide"]
		end
	end,
	__newindex = function(_, key, value)
		if key ~= "hide" then
			return
		end

		EXT.Settings.general["minimap-button"]["hide"] = not value

		if value then
			Utils.minimapButton:Show("Expositum")
		else
			Utils.minimapButton:Hide("Expositum")
		end
	end,
})

------------------------
--- Module Functions ---
------------------------

function Options:Initialize()
	local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

	-- Minimap Button
	AWL.Settings:AddCheckbox(category, {
		variableTable	= minimapButtonProxy,
		settingKey		= addonName .. "_hide",
		variableName	= "hide",
		name			= L["options.general.minimap-button.name"],
		tooltip			= L["options.general.minimap-button.tooltip"],
		default			= true
	})

	-- Debug Mode
	AWL.Settings:AddCheckbox(category, {
		variableTable	= EXT.Settings.general,
		settingKey		= addonName .. "_debug-mode",
		variableName	= "debug-mode",
		name			= L["options.general.debug-mode.name"],
		tooltip			= L["options.general.debug-mode.tooltip"],
		default			= false
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.tooltip"]))

		-- Expansion Check
	if AWL.GAME_TYPE_MAINLINE then
		AWL.Settings:AddCheckbox(category, {
			variableTable	= EXT.Settings.tooltip,
			settingKey		= addonName .. "_expansion",
			variableName	= "expansion",
			name			= L["options.tooltip.expansion.name"],
			tooltip			= L["options.tooltip.expansion.tooltip"],
			default			= true
		})
	end

	-- Category
	AWL.Settings:AddCheckbox(category, {
		variableTable	= EXT.Settings.tooltip,
		settingKey		= addonName .. "_category",
		variableName	= "category",
		name			= L["options.tooltip.category.name"],
		tooltip			= L["options.tooltip.category.tooltip"],
		default			= true
	})

	-- Item Level
	AWL.Settings:AddCheckbox(category, {
		variableTable	= EXT.Settings.tooltip,
		settingKey		= addonName .. "_item-level",
		variableName	= "item-level",
		name			= L["options.tooltip.item-level.name"],
		tooltip			= L["options.tooltip.item-level.tooltip"],
		default			= true
	})

	-- Blank Line
	AWL.Settings:AddCheckbox(category, {
		variableTable	= EXT.Settings.tooltip,
		settingKey		= addonName .. "_blank-line",
		variableName	= "blank-line",
		name			= L["options.tooltip.blank-line.name"],
		tooltip			= L["options.tooltip.blank-line.tooltip"],
		default			= true
	})

	-- Profiles Section
	AWL.Settings:AddProfilesSection(layout, {
		useAccountProfile			= Utils:IsAccountProfile(),
		onSwitchProfile				= function()
			Utils:ToggleProfileMode()
			ReloadUI()
		end,
		onDeleteCharacterProfiles	= function()
			Utils:ResetAllCharacterProfiles()
			ReloadUI()
		end
	})

	-- About Section
	AWL.Settings:AddAboutSection(layout, addonName)

	Settings.RegisterAddOnCategory(category)

	Addon:SetMainCategoryId(category:GetID())
end
