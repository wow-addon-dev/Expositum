local _, EXT = ...

if GetLocale() ~= "deDE" then return end

local L = EXT.Localization

-- Options

L["options.general"] = "Allgemeine Einstellungen"
L["options.general.minimap-button.name"] = "Minimap-Button"
L["options.general.minimap-button.tooltip"] = "Bei Aktivierung wird der Minimap-Button angezeigt."
L["options.general.debug-mode.name"] = "Debugmodus"
L["options.general.debug-mode.tooltip"] = "Die Aktivierung des Debugmodus zeigt zusätzliche Informationen im Chat an."

L["options.tooltip"] = "Tooltip"
L["options.tooltip.expansion.name"] = "Erweiterung anzeigen"
L["options.tooltip.expansion.tooltip"] = "Zeigt bei Gegenständen im Tooltip die dazugehörige Erweiterung an."
L["options.tooltip.category.name"] = "Kategorie anzeigen"
L["options.tooltip.category.tooltip"] = "Zeigt bei Gegenständen im Tooltip die dazugehörige Kategorie an."
L["options.tooltip.item-level.name"] = "Gegenstandsstufe anzeigen"
L["options.tooltip.item-level.tooltip"] = "Zeigt bei Gegenständen im Tooltip die dazugehörige Gegenstandsstufe an."
L["options.tooltip.blank-line.name"] = "Leerzeile einfügen"
L["options.tooltip.blank-line.tooltip"] = "Fügt im Tooltip vor den zusätzlichen Gegenstandsinformationen eine Leerzeile ein."

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Rechtsklick|r zum Öffnen der Einstellungen."

-- Chat

-- Tooltip

L["tooltip.expansion"] = "Erweiterung"
L["tooltip.category"] = "Kategorie"
L["tooltip.item-level"] = "Gegenstandsstufe"
