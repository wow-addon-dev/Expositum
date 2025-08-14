local _, EXT = ...

if GetLocale() ~= "deDE" then return end

local L = EXT.localization

-- Generel

L["addon.version"] = "Version"

-- Addon specific

L["tooltip.expansion"] = "Erweiterung"
L["tooltip.category"] = "Kategorie"

-- Options

L["info.description"] = "Beschreibung"
L["info.description.text"] = "Expositum ist ein Addon, das zusätzliche Informationen zu Gegenständen im Tooltip bereitstellt.\n\nSolltest Du einen Fehler finden oder Fragen zum Addon haben, so kannst Du über GitHub Kontakt aufnehmen. Über GitHub kannst Du mir auch bei der Übersetzung helfen. Vielen Dank."

L["info.help"] = "Hilfe"
L["info.help.text"] = "Bei Problemen nach einem Update oder wenn Du es möchtest, kannst Du hier die Einstellungen zurücksetzen."
L["info.help.reset-button.name"] = "Einstellungen zurücksetzen"
L["info.help.reset-button.desc"] = "Setzt die Einstellungen auf die Standardwerte zurück. Dies gilt für alle Charaktere."
L["info.help.github-button.name"] = "GitHub"
L["info.help.github-button.desc"] = "Öffnet ein Popup-Fenster mit einem Link nach GitHub."

L["info.about"] = "Über"
L["info.about.text"] = "|cnGOLD_FONT_COLOR:Spielversion:|r %s\n|cnGOLD_FONT_COLOR:Addonversion:|r %s\n\n|cnGOLD_FONT_COLOR:Autor:|r %s"

L["options"] = "Einstellungen"
L["options.general"] = "allgemeine Einstellungen"

L["options.expansion.name"] = "Erweiterung anzeigen"
L["options.expansion.tooltip"] = "Zeigt bei Gegenständen im Tooltip die dazugehörige Erweiterung an."
L["options.category.name"] = "Kategorie anzeigen"
L["options.category.tooltip"] = "Zeigt bei Gegenständen im Tooltip die dazugehörige Kategorie an."
L["options.blank-line.name"] = "Leerzeile einfügen"
L["options.blank-line.tooltip"] = "Fügt eine Leerzeile im Tooltip vor der Anzeige von Erweiterung und Kategorie ein."

L["options.other"] = "sonstige Einstellungen"
L["options.debug-mode.name"] = "Debugmodus"
L["options.debug-mode.tooltip"] = "Die Aktivierung des Debugmodus zeigt zusätzliche Informationen im Chat an."

-- Chat

L["chat.reset-options.success"] = "Einstellungen erfolgreich zurückgesetzt."

-- Dialog

L["dialog.copy-address.text"] = "Um den Link zu kopieren drücke STRG + C."
L["dialog.reset-options.text"] = "Sollen die Einstellungen wirklich zurückgesetzt werden?\n|cnNORMAL_FONT_COLOR:Achtung:|r Es erfolgt ein automatischer Reload der Spieloberfläche!"
