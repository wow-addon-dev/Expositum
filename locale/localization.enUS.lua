local _, EXT = ...

EXT.localization = setmetatable({},{__index=function(self,key)
        geterrorhandler()("Expositum (Debug): Missing entry for '" .. tostring(key) .. "'")
        return key
    end})

local L = EXT.localization

-- Generel

L["addon.version"] = "Version"

-- Addon specific

L["tooltip.expansion"] = "Expansion"
L["tooltip.category"] = "Category"

-- Options

L["info.description"] = "Description"
L["info.description.text"] = "Expositum is an addon that provides additional information about items in the tooltip.\n\nIf you find a bug or have questions about the addon, you can contact me via GitHub. You can also help me with the translation via GitHub. Thank you."

L["info.help"] = "Help"
L["info.help.text"] = "In case of problems after an update or if you want to, you can reset the options here."
L["info.help.reset-button.name"] = "Reset Options"
L["info.help.reset-button.desc"] = "Resets the options to the default values. This applies to all characters."
L["info.help.github-button.name"] = "GitHub"
L["info.help.github-button.desc"] = "Opens a popup window with a link to GitHub."

L["info.about"] = "About"
L["info.about.text"] = "|cnGOLD_FONT_COLOR:Game Version:|r %s\n|cnGOLD_FONT_COLOR:Addon Version:|r %s\n\n|cnGOLD_FONT_COLOR:Author:|r %s"

L["options"] = "Options"
L["options.general"] = "General Options"

L["options.expansion.name"] = "Show Expansion"
L["options.expansion.tooltip"] = "Displays the corresponding expansion for items in the tooltip."
L["options.category.name"] = "Show Category"
L["options.category.tooltip"] = "Displays the corresponding category for items in the tooltip."
L["options.blank-line.name"] = "Insert Blank Line"
L["options.blank-line.tooltip"] = "Inserts a blank line in the tooltip before displaying the extension and category."

L["options.other"] = "Other Options"
L["options.debug-mode.name"] = "Debug Mode"
L["options.debug-mode.tooltip"] = "Enabling the debug mode displays additional information in the chat."

-- Chat

L["chat.reset-options.success"] = "Options successfully reseted."

-- Dialog

L["dialog.copy-address.text"] = "To copy the link press CTRL + C."
L["dialog.reset-options.text"] = "Do you really want to reset the options?\n|cnNORMAL_FONT_COLOR:Warning:|r The game interface will be automatically reloaded!"
