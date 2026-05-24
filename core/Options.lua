local addonName, EXT = ...

local L = EXT.Localization
local Utils = EXT.Utils

local AWL = ArcaneWizardLibrary

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

local function ShowProfileSwitchConfirmation()
	local useAccount = Utils:IsAccountProfile()

	AWL.Dialogs:ShowConfirmDialog(
		AWL.Profiles:GetSwitchConfirmText(useAccount),
		function()
			Utils:SetProfileSwitch(useAccount)
			ReloadUI()
		end
	)
end

local function ShowDeleteCharacterProfilesConfirmation()
	AWL.Dialogs:ShowConfirmDialog(
		AWL.Profiles:GetText("delete-character-profiles.confirm"),
		function()
			Utils:ResetCharacterProfiles()
			ReloadUI()
		end
	)
end

----------------------
--- Main Functions ---
----------------------

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
        variableTable = EXT.options.general,
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
            variableTable = EXT.options.tooltip,
            settingKey    = addonName .. "_expansion",
            variableName  = "expansion",
            name          = L["options.tooltip.expansion.name"],
            tooltip       = L["options.tooltip.expansion.tooltip"],
            default       = true
        })
    end

    -- Category
    AWL.Settings:AddCheckbox(category, {
        variableTable = EXT.options.tooltip,
        settingKey    = addonName .. "_category",
        variableName  = "category",
        name          = L["options.tooltip.category.name"],
        tooltip       = L["options.tooltip.category.tooltip"],
        default       = true
    })

    -- Item Level
    AWL.Settings:AddCheckbox(category, {
        variableTable = EXT.options.tooltip,
        settingKey    = addonName .. "_item-level",
        variableName  = "item-level",
        name          = L["options.tooltip.item-level.name"],
        tooltip       = L["options.tooltip.item-level.tooltip"],
        default       = true
    })

    -- Blank Line
    AWL.Settings:AddCheckbox(category, {
        variableTable = EXT.options.tooltip,
        settingKey    = addonName .. "_blank-line",
        variableName  = "blank-line",
        name          = L["options.tooltip.blank-line.name"],
        tooltip       = L["options.tooltip.blank-line.tooltip"],
        default       = true
    })

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(AWL.Profiles:GetText("section-header")))

	-- Active Profile
	AWL.Settings:AddInfoText(layout, {
		leftText  = AWL.Profiles:GetText("profile-mode"),
		rightText = AWL.Profiles:GetModeText(Utils:IsAccountProfile()),
		height    = 30
	})

	-- Switch Profile
	AWL.Settings:AddButton(layout, {
		name       = AWL.Profiles:GetText("switch.name"),
		buttonText = AWL.Profiles:GetSwitchButtonText(Utils:IsAccountProfile()),
		tooltip    = AWL.Profiles:GetText("switch.tooltip"),
		onClick    = ShowProfileSwitchConfirmation
	})

	-- Delete Character Profiles
	AWL.Settings:AddButton(layout, {
		name       = AWL.Profiles:GetText("delete-character-profiles.name"),
		buttonText = AWL.Profiles:GetText("delete-character-profiles.button"),
		tooltip    = AWL.Profiles:GetText("delete-character-profiles.tooltip"),
		onClick    = ShowDeleteCharacterProfilesConfirmation
	})

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.about"]))

    -- Game Version
    AWL.Settings:AddInfoText(layout, {
        leftText  = L["options.about.game-version"],
        rightText = EXT.GAME_VERSION .. " (" .. EXT.GAME_FLAVOR .. ")"
    })

    -- Addon Version
    AWL.Settings:AddInfoText(layout, {
        leftText  = L["options.about.addon-version"],
        rightText = EXT.ADDON_VERSION .. " (" .. EXT.ADDON_BUILD_DATE .. ")"
    })

    -- Library Version
    AWL.Settings:AddInfoText(layout, {
        leftText  = L["options.about.lib-version"],
        rightText = AWL.ADDON_VERSION .. " (" .. AWL.ADDON_BUILD_DATE .. ")"
    })

    -- Author
    AWL.Settings:AddInfoText(layout, {
        leftText  = L["options.about.author"],
        rightText = EXT.ADDON_AUTHOR,
        height    = 30
    })

    -- GitHub Link
    AWL.Settings:AddButton(layout, {
        name       = L["options.about.button-github.name"],
        buttonText = L["options.about.button-github.button"],
        tooltip    = L["options.about.button-github.tooltip"],
        onClick    = function()
			AWL.Dialogs:ShowLinkDialog(EXT.LINK_GITHUB)
		end
    })

    Settings.RegisterAddOnCategory(category)

    EXT.MAIN_CATEGORY_ID = category:GetID()
end

EXT.Options = Options
