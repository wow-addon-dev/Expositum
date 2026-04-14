local addonName, EXT = ...

local L = EXT.Localization
local Utils = EXT.Utils

local Options = {}

----------------------
--- Local Funtions ---
----------------------

local minimapButtonProxy = setmetatable({}, {
    __index = function(_, key)
        return not EXT.options.general["minimap-button"]["hide"]
    end,
    __newindex = function(_, key, value)
        EXT.options.general["minimap-button"]["hide"] = not value

        if value then
            Utils.minimapButton:Show("Expositum")
        else
            Utils.minimapButton:Hide("Expositum")
        end
    end,
})

---------------------
--- Main Funtions ---
---------------------

function Options:Initialize()
    local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)

	local variableTableGeneral = EXT.options.general
	local variableTableTooltip = EXT.options.tooltip
	local variableTableOther = EXT.options.other

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

	do
        local name = L["options.general.minimap-button.name"]
        local tooltip = L["options.general.minimap-button.tooltip"]
        local variable = "hide"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, minimapButtonProxy, Settings.VarType.Boolean, name, not defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.tooltip"]))

	if EXT.GAME_TYPE_MAINLINE then
		do
			local name = L["options.tooltip.expansion.name"]
			local tooltip = L["options.tooltip.expansion.tooltip"]
			local variable = "expansion"
			local defaultValue = true

			local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableTooltip, Settings.VarType.Boolean, name, defaultValue)
			Settings.CreateCheckbox(category, setting, tooltip)
		end
	end

	do
        local name = L["options.tooltip.category.name"]
        local tooltip = L["options.tooltip.category.tooltip"]
        local variable = "category"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableTooltip, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	do
        local name = L["options.tooltip.item-level.name"]
        local tooltip = L["options.tooltip.item-level.tooltip"]
        local variable = "item-level"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableTooltip, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	do
        local name = L["options.tooltip.blank-line.name"]
        local tooltip = L["options.tooltip.blank-line.tooltip"]
        local variable = "blank-line"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableTooltip, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.other"]))

    do
        local name = L["options.other.debug-mode.name"]
        local tooltip = L["options.other.debug-mode.tooltip"]
        local variable = "debug-mode"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableOther, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.about"]))

	do
		local data = {
			leftText = L["options.about.game-version"],
			rightText = EXT.GAME_VERSION .. " (" .. EXT.GAME_FLAVOR .. ")",
		}

		local text = layout:AddInitializer(Settings.CreateElementInitializer("Expositum_OptionsText", data))

		function text:GetExtent()
			return 14
		end
	end

	do
		local data = {
			leftText = L["options.about.addon-version"],
			rightText = EXT.ADDON_VERSION .. " (" .. EXT.ADDON_BUILD_DATE .. ")"
		}

		local text = layout:AddInitializer(Settings.CreateElementInitializer("Expositum_OptionsText", data))

		function text:GetExtent()
			return 14
		end
	end

	do
		local data = {
			leftText = L["options.about.author"],
			rightText = EXT.ADDON_AUTHOR
		}

		local text = layout:AddInitializer(Settings.CreateElementInitializer("Expositum_OptionsText", data))
	end

	do
        local name = L["options.about.button-github.name"]
        local tooltip = L["options.about.button-github.tooltip"]
		local buttonText = L["options.about.button-github.button"]

        local function OnButtonClick()
            WAD.Dialog:ShowCopyAddressDialog(EXT.LINK_GITHUB)
        end

        local buttonInitializer = CreateSettingsButtonInitializer(name, buttonText, OnButtonClick, tooltip, true)
        layout:AddInitializer(buttonInitializer)
    end

    Settings.RegisterAddOnCategory(category)

	EXT.MAIN_CATEGORY_ID = category:GetID()
end

EXT.Options = Options
