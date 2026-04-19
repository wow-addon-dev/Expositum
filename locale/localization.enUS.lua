local _, EXT = ...

EXT.Localization = setmetatable({},{__index=function(self,key)
        geterrorhandler()("Expositum (Debug): Missing entry for '" .. tostring(key) .. "'")
        return key
    end})

local L = EXT.Localization

-- Options

L["options.general"] = "General Options"
L["options.general.minimap-button.name"] = "Minimap Button"
L["options.general.minimap-button.tooltip"] = "When this is enabled, the minimap button is displayed."

L["options.tooltip"] = "Tooltip"
L["options.tooltip.expansion.name"] = "Show Expansion"
L["options.tooltip.expansion.tooltip"] = "Displays the corresponding expansion for items in the tooltip."
L["options.tooltip.category.name"] = "Show Category"
L["options.tooltip.category.tooltip"] = "Displays the corresponding category for items in the tooltip."
L["options.tooltip.item-level.name"] = "Show Item Level"
L["options.tooltip.item-level.tooltip"] = "Displays the corresponding item level for items in the tooltip."
L["options.tooltip.blank-line.name"] = "Insert Blank Line"
L["options.tooltip.blank-line.tooltip"] = "Inserts a blank line in the tooltip before displaying the extension and category."

L["options.other"] = "Other Options"
L["options.other.debug-mode.name"] = "Debug Mode"
L["options.other.debug-mode.tooltip"] = "Enabling the debug mode displays additional information in the chat."

L["options.about"] = "About"
L["options.about.game-version"] = "Game Version"
L["options.about.addon-version"] = "Addon Version"
L["options.about.lib-version"] = "Library Version"
L["options.about.author"] = "Author"

L["options.about.button-github.name"] = "Feedback & Help"
L["options.about.button-github.tooltip"] = "Opens a popup window with a link to GitHub."
L["options.about.button-github.button"] = "GitHub"

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Right-click|r to open the options."

-- Chat

-- Tooltip

L["tooltip.expansion"] = "Expansion"
L["tooltip.category"] = "Category"
L["tooltip.item-level"] = "Item Level"
