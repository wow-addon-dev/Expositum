local _, EXT = ...

if GetLocale() ~= "deDE" then return end

local L = EXT.Localization

-- Options

L["options.general"] = "Allgemeine Einstellungen"
L["options.general.minimap-button.name"] = "Minimap Button"
L["options.general.minimap-button.tooltip"] = "Bei Aktivierung wird der Minimap Button angezeigt."

L["options.profiles"] = "Profile"
L["options.profiles.profile-mode"] = "Profiltyp"
L["options.profiles.description"] = "Lege fest, ob dieser Charakter das accountweite Profil oder ein eigenes Charakterprofil verwendet."
L["options.profiles.mode.global"] = "Accountweit"
L["options.profiles.mode.character"] = "Charakterprofil"
L["options.profiles.use-global.name"] = "Globale Einstellungen nutzen"
L["options.profiles.reload.required"] = "Das Wechseln des Profiltyps erfordert einen UI-Reload."
L["options.profiles.reload.confirm"] = "Diese Änderung erfordert einen UI-Reload. Möchtest du das UI jetzt neu laden?"

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
L["options.about.lib-version"] = "Bibliotheksversion"
L["options.about.author"] = "Autor"

L["options.about.button-github.name"] = "Feedback & Hilfe"
L["options.about.button-github.tooltip"] = "Öffnet ein Popup-Fenster mit einem Link nach GitHub."
L["options.about.button-github.button"] = "GitHub"

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Rechtsklick|r zum Öffnen der Einstellungen."

-- Chat

-- Tooltip

L["tooltip.expansion"] = "Erweiterung"
L["tooltip.category"] = "Kategorie"
L["tooltip.item-level"] = "Itemlevel"
