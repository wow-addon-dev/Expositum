local _, EXT = ...

if GetLocale() ~= "deDE" then return end

local L = EXT.Localization

-- Options

L["options.general"] = "Allgemeine Einstellungen"
L["options.general.minimap-button.name"] = "Minimap Button"
L["options.general.minimap-button.tooltip"] = "Bei Aktivierung wird der Minimap Button angezeigt."

L["options.tooltip"] = "Tooltip"
L["options.tooltip.expansion.name"] = "Erweiterung anzeigen"
L["options.tooltip.expansion.tooltip"] = "Zeigt bei Gegenständen im Tooltip die dazugehörige Erweiterung an."
L["options.tooltip.category.name"] = "Kategorie anzeigen"
L["options.tooltip.category.tooltip"] = "Zeigt bei Gegenständen im Tooltip die dazugehörige Kategorie an."
L["options.tooltip.item-level.name"] = "Itemlevel anzeigen"
L["options.tooltip.item-level.tooltip"] = "Zeigt bei Gegenständen im Tooltip die dazugehörige Itemlevel an."
L["options.tooltip.blank-line.name"] = "Leerzeile einfügen"
L["options.tooltip.blank-line.tooltip"] = "Fügt eine Leerzeile im Tooltip vor der Anzeige von Erweiterung und Kategorie ein."

L["options.other"] = "Sonstige Einstellungen"
L["options.other.debug-mode.name"] = "Debugmodus"
L["options.other.debug-mode.tooltip"] = "Die Aktivierung des Debugmodus zeigt zusätzliche Informationen im Chat an."

L["options.about"] = "Über"
L["options.about.game-version"] = "Spielversion"
L["options.about.addon-version"] = "Addonversion"
L["options.about.author"] = "Autor"

L["options.about.button-delete-data.name"] = "???"
L["options.about.button-delete-data.tooltip"] = "???"
L["options.about.button-delete-data.button"] = "???"

L["options.about.button-github.name"] = "Feedback & Hilfe"
L["options.about.button-github.tooltip"] = "Öffnet ein Popup-Fenster mit einem Link nach GitHub."
L["options.about.button-github.button"] = "GitHub"

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Rechtsklick|r zum Öffnen der Einstellungen."

-- Dialog

L["dialog.copy-address.text"] = "Um den Link zu kopieren drücke STRG + C."
L["dialog.delete-data.text"] = "Sollen alle Addon Daten wirklich gelöscht werden?\n|cnNORMAL_FONT_COLOR:Achtung:|r Es erfolgt ein automatischer Reload der Spieloberfläche!"

-- Tooltip

L["tooltip.expansion"] = "Erweiterung"
L["tooltip.category"] = "Kategorie"
L["tooltip.item-level"] = "Itemlevel"
