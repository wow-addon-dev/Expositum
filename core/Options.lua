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

local function GetCharKey()
	return GetUnitName("player", true) .. "#" .. GetRealmName()
end

local function GetProfileModeText()
	if Expositum_Options_v3.profileKeys[GetCharKey()]["use-global"] then
		return L["options.profiles.mode.global"]
	end

	return L["options.profiles.mode.character"]
end

local function SetCheckButtonText(checkButton, text)
	local label = checkButton.Text or _G[checkButton:GetName() .. "Text"]

	if label then
		label:SetFontObject(GameFontHighlight)
		label:SetText(" " .. text)
		checkButton:SetHitRectInsets(0, -label:GetStringWidth(), 0, 0)
	end
end

local function ShowProfileReloadConfirmation(panel, oldValue)
	AWL.Dialogs:ShowConfirmDialog(
		L["options.profiles.reload.confirm"],
		function()
			Expositum_Options_v3.profileKeys[GetCharKey()]["open-settings"] = true
			ReloadUI()
		end,
		function()
			Expositum_Options_v3.profileKeys[GetCharKey()]["use-global"] = oldValue
			panel.useGlobal:SetChecked(oldValue)
		end
	)
end

local function CreateCanvasSectionHeader(parent, text)
	local header = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	header:SetPoint("TOPLEFT", 16, -16)
	header:SetText(text)

	local divider = parent:CreateTexture(nil, "ARTWORK")
	divider:SetHeight(1)
	divider:SetPoint("LEFT", header, "RIGHT", 12, 0)
	divider:SetPoint("RIGHT", parent, "RIGHT", -24, 0)
	divider:SetColorTexture(0.25, 0.25, 0.25, 1)

	return header
end

local function CreateProfileCanvas()
	local panel = CreateFrame("Frame", addonName .. "ProfilesCanvas")
	panel.name = L["options.profiles"]

	local header = CreateCanvasSectionHeader(panel, L["options.profiles"])

	local description = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	description:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -14)
	description:SetWidth(560)
	description:SetJustifyH("LEFT")
	description:SetText(L["options.profiles.description"])

	panel.useGlobal = CreateFrame("CheckButton", addonName .. "UseGlobalProfileCheckButton", panel, "InterfaceOptionsCheckButtonTemplate")
	panel.useGlobal:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -14)
	SetCheckButtonText(panel.useGlobal, L["options.profiles.use-global.name"])
	panel.useGlobal:SetChecked(Expositum_Options_v3.profileKeys[GetCharKey()]["use-global"])
	panel.useGlobal:SetScript("OnClick", function(checkButton)
		local newValue = checkButton:GetChecked() and true or false
		local oldValue = not newValue

		Expositum_Options_v3.profileKeys[GetCharKey()]["use-global"] = newValue
		ShowProfileReloadConfirmation(panel, oldValue)
	end)

	local reloadHint = panel:CreateFontString(nil, "ARTWORK", "GameFontDisable")
	reloadHint:SetPoint("TOPLEFT", panel.useGlobal, "BOTTOMLEFT", 28, -4)
	reloadHint:SetWidth(520)
	reloadHint:SetJustifyH("LEFT")
	reloadHint:SetText(L["options.profiles.reload.required"])

	return panel
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

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.other"]))

    -- Debug Mode
    AWL.Settings:AddCheckbox(category, {
        variableTable = EXT.options.other,
        settingKey    = addonName .. "_debug-mode",
        variableName  = "debug-mode",
        name          = L["options.other.debug-mode.name"],
        tooltip       = L["options.other.debug-mode.tooltip"],
        default       = false
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

	-- Active Profile
	AWL.Settings:AddInfoText(layout, {
		leftText  = L["options.profiles.profile-mode"],
		rightText = GetProfileModeText(),
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

	local profileCategory = Settings.RegisterCanvasLayoutSubcategory(category, CreateProfileCanvas(), L["options.profiles"])

    EXT.MAIN_CATEGORY_ID = category:GetID()
	EXT.PROFILES_CATEGORY_ID = profileCategory:GetID()
end

EXT.Options = Options
