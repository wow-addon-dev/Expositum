local _, EXT = ...

if GetLocale() ~= "ruRU" then return end

local L = EXT.Localization

-- Options

L["options.general"] = "Общие параметры"
L["options.general.minimap-button.name"] = "Кнопка у мини-карты"
L["options.general.minimap-button.tooltip"] = "Если этот параметр включен, кнопка отображается у мини-карты."
L["options.general.debug-mode.name"] = "Режим отладки"
L["options.general.debug-mode.tooltip"] = "Если режим отладки включен, в чате отображается дополнительная информация."

L["options.tooltip"] = "Подсказка"
L["options.tooltip.expansion.name"] = "Показывать дополнение"
L["options.tooltip.expansion.tooltip"] = "Отображает соответствующее дополнение для предметов во всплывающей подсказке."
L["options.tooltip.category.name"] = "Показывать категорию"
L["options.tooltip.category.tooltip"] = "Отображает соответствующую категорию для предметов во всплывающей подсказке."
L["options.tooltip.item-level.name"] = "Показывать уровень предмета"
L["options.tooltip.item-level.tooltip"] = "Отображает соответствующий уровень предмета для предметов во всплывающей подсказке."
L["options.tooltip.blank-line.name"] = "Вставить пустую строку"
L["options.tooltip.blank-line.tooltip"] = "Вставляет пустую строку в подсказку перед дополнительной информацией о предмете."

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Щелкните правой кнопкой мыши|r, чтобы открыть настройки."

-- Chat

-- Tooltip

L["tooltip.expansion"] = "Дополнение"
L["tooltip.category"] = "Категория"
L["tooltip.item-level"] = "Уровень предмета"
