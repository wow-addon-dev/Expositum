local _, EXT = ...

if GetLocale() ~= "ruRU" then return end

local L = EXT.Localization

-- Options

L["options.general"] = "Общие параметры"
L["options.general.minimap-button.name"] = "Minimap Button"
L["options.general.minimap-button.tooltip"] = "When this is enabled, the minimap button is displayed."

L["options.tooltip"] = "Tooltip"
L["options.tooltip.expansion.name"] = "Показывать контент WoW"
L["options.tooltip.expansion.tooltip"] = "Отображает соответствующий контент для предметов во всплывающей подсказке."
L["options.tooltip.category.name"] = "Показывать категорию"
L["options.tooltip.category.tooltip"] = "Отображает соответствующую категорию для предметов во всплывающей подсказке."
L["options.tooltip.item-level.name"] = "Показывать уровень предмета"
L["options.tooltip.item-level.tooltip"] = "Отображает соответствующий уровень предмета для предметов во всплывающей подсказке.."
L["options.tooltip.blank-line.name"] = "Вставить пустую строку"
L["options.tooltip.blank-line.tooltip"] = "Вставляет пустую строку в подсказку перед отображением расширения и категории."

L["options.other"] = "Другие параметры"
L["options.other.debug-mode.name"] = "Режим отладки"
L["options.other.debug-mode.tooltip"] = "Если режим отладки включен, то отображается дополнительная информацию в чате."

L["options.about"] = "About"
L["options.about.game-version"] = "Game Version"
L["options.about.addon-version"] = "Addon Version"
L["options.about.author"] = "Author"

L["options.about.button-delete-data.name"] = "???"
L["options.about.button-delete-data.tooltip"] = "???"
L["options.about.button-delete-data.button"] = "???"

L["options.about.button-github.name"] = "Feedback & Help"
L["options.about.button-github.tooltip"] = "Opens a popup window with a link to GitHub."
L["options.about.button-github.button"] = "GitHub"

-- Generel

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Right-click|r to open the options."

-- Dialog

L["dialog.copy-address.text"] = "Чтобы скопировать ссылку, нажмите CTRL + C."
L["dialog.delete-data.text"] = "Do you really want to delete all addon data?\n|cnNORMAL_FONT_COLOR:Warning:|r The game interface will be automatically reloaded!"

-- Tooltip

L["tooltip.expansion"] = "Контент"
L["tooltip.category"] = "Категория"
L["tooltip.item-level"] = "Уровень предмета"
