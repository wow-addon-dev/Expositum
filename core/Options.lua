local addonName, EXT = ...

local L = EXT.localization
local Utils = EXT.utils
local Dialog = EXT.dialog

local Options = {}

---------------------
--- Main Funtions ---
---------------------

function Options:Initialize()
    local backdrop = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Friendsframe\\UI-Toast-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
    }

    local canvasFrame = CreateFrame("Frame", nil, UIParent)

    do
		local header = canvasFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightHuge")
		header:SetPoint("TOPLEFT", canvasFrame, 7, -22)
		header:SetText(addonName)

		local scrollFrame = CreateFrame("ScrollFrame", nil, canvasFrame, "QuestScrollFrameTemplate")
		scrollFrame:SetPoint("TOPLEFT", canvasFrame, "TOPLEFT", 0, -54)
		scrollFrame:SetPoint("BOTTOMRIGHT", canvasFrame, "BOTTOMRIGHT", -29, 0)

		local scrollView = CreateFrame("Frame")
		scrollView:SetSize(1, 1)
		scrollFrame:SetScrollChild(scrollView)

        local descriptionFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        descriptionFrame:SetPoint("TOPLEFT", scrollView, "TOPLEFT", 10, -20)
        descriptionFrame:SetWidth(615)
        descriptionFrame:SetBackdrop(backdrop)
        descriptionFrame:SetBackdropColor(0, 0, 0, 0.4)

        descriptionFrame.title = descriptionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        descriptionFrame.title:SetPoint("TOPLEFT", 8, 15)
        descriptionFrame.title:SetText(L["info.description"])

        descriptionFrame.text = descriptionFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        descriptionFrame.text:SetPoint("TOPLEFT", descriptionFrame, "TOPLEFT", 15, -15)
        descriptionFrame.text:SetPoint("TOPRIGHT", descriptionFrame, "TOPRIGHT",  -15, -15)
        descriptionFrame.text:SetWidth(descriptionFrame:GetWidth() - 30)
        descriptionFrame.text:SetJustifyH("LEFT")
        descriptionFrame.text:SetSpacing(2)
        descriptionFrame.text:SetText(L["info.description.text"])

        descriptionFrame:SetHeight(descriptionFrame.text:GetStringHeight() + 30)

        local helpFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        helpFrame:SetPoint("TOPLEFT", descriptionFrame, "BOTTOMLEFT", 0, -30)
        helpFrame:SetWidth(615)
        helpFrame:SetBackdrop(backdrop)
        helpFrame:SetBackdropColor(0, 0, 0, 0.4)

        helpFrame.title = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        helpFrame.title:SetPoint("TOPLEFT", 8, 15)
        helpFrame.title:SetText(L["info.help"])

        helpFrame.text = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        helpFrame.text:SetPoint("TOPLEFT", helpFrame, "TOPLEFT", 15, -15)
        helpFrame.text:SetPoint("TOPRIGHT", helpFrame, "TOPRIGHT", -15, -15)
        helpFrame.text:SetWidth(helpFrame:GetWidth() - 30)
        helpFrame.text:SetJustifyH("LEFT")
        helpFrame.text:SetSpacing(2)
        helpFrame.text:SetText(L["info.help.text"])

        helpFrame.divider = helpFrame:CreateTexture(nil, "BACKGROUND")
        helpFrame.divider:SetPoint("TOP", helpFrame.text, "BOTTOM", 0, -10)
        helpFrame.divider:SetSize(550, 6)
        helpFrame.divider:SetAtlas("RecipeList-Divider")
        helpFrame.divider:SetDesaturated(true)

        local buttonReset = CreateFrame("Button", nil, helpFrame, "UIPanelButtonTemplate")
        buttonReset:SetPoint("TOP", helpFrame.divider, "BOTTOM", 0, -10)
        buttonReset:SetSize(200, 22)
        buttonReset:SetText(L["info.help.reset-button.name"])
        buttonReset:SetScript("OnClick", function(self)
            Dialog:ShowResetOptionsDialog()
        end)
        buttonReset:SetScript("OnEnter", function(self)
			GameTooltip:ClearAllPoints()
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

			GameTooltip_SetTitle(GameTooltip, L["info.help.reset-button.name"])
			GameTooltip_AddNormalLine(GameTooltip, L["info.help.reset-button.desc"])

			GameTooltip:Show()
        end)
		buttonReset:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
        end)

        helpFrame:SetHeight(helpFrame.text:GetStringHeight() + 48 + 30)

        local aboutFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        aboutFrame:SetPoint("TOPLEFT", helpFrame, "BOTTOMLEFT", 0, -30)
        aboutFrame:SetWidth(615)
        aboutFrame:SetBackdrop(backdrop)
        aboutFrame:SetBackdropColor(0, 0, 0, 0.4)

        aboutFrame.title = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        aboutFrame.title:SetPoint("TOPLEFT", 8, 15)
        aboutFrame.title:SetText(L["info.about"])

        aboutFrame.text = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        aboutFrame.text :SetPoint("TOPLEFT", aboutFrame, "TOPLEFT", 15, -15)
        aboutFrame.text :SetPoint("TOPRIGHT", aboutFrame, "TOPRIGHT",  -15, -15)
        aboutFrame.text :SetWidth(aboutFrame:GetWidth() - 30)
        aboutFrame.text :SetJustifyH("LEFT")
        aboutFrame.text :SetSpacing(2)
        aboutFrame.text :SetText(L["info.about.text"]:format(EXT.GAME_VERSION .. " (" .. EXT.GAME_FLAVOR .. ")", EXT.ADDON_VERSION .. " (" .. EXT.ADDON_BUILD_DATE .. ")", EXT.ADDON_AUTHOR))

        aboutFrame.divider = aboutFrame:CreateTexture(nil, "BACKGROUND")
        aboutFrame.divider:SetPoint("TOP", aboutFrame.text , "BOTTOM", 0, -10)
        aboutFrame.divider:SetSize(550, 6)
        aboutFrame.divider:SetAtlas("RecipeList-Divider")
        aboutFrame.divider:SetDesaturated(true)

        local buttonGithub = CreateFrame("Button", nil, aboutFrame, "UIPanelButtonTemplate")
        buttonGithub:SetPoint("TOP", aboutFrame.divider, "BOTTOM", 0, -10)
        buttonGithub:SetSize(150, 22)
        buttonGithub:SetText(L["info.help.github-button.name"])
        buttonGithub:SetScript("OnClick", function(self)
            Dialog:ShowCopyAddressDialog(EXT.LINK_GITHUB)
        end)
        buttonGithub:SetScript("OnEnter", function(self)
			GameTooltip:ClearAllPoints()
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

			GameTooltip_SetTitle(GameTooltip, L["info.help.github-button.name"])
			GameTooltip_AddNormalLine(GameTooltip, L["info.help.github-button.desc"])

			GameTooltip:Show()
        end)
		buttonGithub:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
        end)

        aboutFrame:SetHeight(aboutFrame.text :GetStringHeight() + 48 + 30)

		local lastLine = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        lastLine:SetPoint("TOPLEFT", aboutFrame, "BOTTOMLEFT", 0, -10)
    end

    local mainCategory = Settings.RegisterCanvasLayoutCategory(canvasFrame, addonName)
    mainCategory.ID = addonName

    local variableTable = EXT.data.options
    local category, layout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, L["options"])

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

    do
        local name = L["options.expansion.name"]
        local tooltip = L["options.expansion.tooltip"]
        local variable = "expansion"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	do
        local name = L["options.category.name"]
        local tooltip = L["options.category.tooltip"]
        local variable = "category"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

		do
        local name = L["options.item-level.name"]
        local tooltip = L["options.item-level.tooltip"]
        local variable = "item-level"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	do
        local name = L["options.blank-line.name"]
        local tooltip = L["options.blank-line.tooltip"]
        local variable = "blank-line"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.other"]))

    do
        local name = L["options.debug-mode.name"]
        local tooltip = L["options.debug-mode.tooltip"]
        local variable = "debug-mode"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    Settings.RegisterAddOnCategory(mainCategory)
end

EXT.options = Options
