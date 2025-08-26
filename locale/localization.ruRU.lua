local _, EXT = ...

if GetLocale() ~= "ruRU" then return end

local L = EXT.localization

-- Generel

L["addon.version"] = "Версия"

-- Addon specific

L["tooltip.expansion"] = "Дополнение"
L["tooltip.category"] = "Категория"
L["tooltip.item-level"] = "Уровень предмета"

-- Options

L["info.description"] = "Описание"
L["info.description.text"] = "Expositum - это дополнение, которое предоставляет дополнительную информацию о предметах во всплывающей подсказке.\n\nЕсли Вы нашли ошибку или у Вас есть вопросы по аддону, то можете связаться со мной через Github. Вы также можете помочь мне с переводом через Github. Спасибо."

L["info.help"] = "Помощь"
L["info.help.text"] = "В случае возникновения проблем после обновления, Вы можете сбросить настройки здесь."
L["info.help.reset-button.name"] = "Сбросить параметры"
L["info.help.reset-button.desc"] = "Сбрасывает параметры на значения по умолчанию. Это относится ко всем персонажам."
L["info.help.github-button.name"] = "GitHub"
L["info.help.github-button.desc"] = "Открывает всплывающее окно со ссылкой на GitHub."

L["info.about"] = "Об аддоне"
L["info.about.text"] = "|cnGOLD_FONT_COLOR:Версия игры:|r %s\n|cnGOLD_FONT_COLOR:Версия дополнения:|r %s\n\n|cnGOLD_FONT_COLOR:Автор:|r %s"

L["options"] = "Параметры"
L["options.general"] = "Общие параметры"

L["options.expansion.name"] = "Показывать дополнение WoW"
L["options.expansion.tooltip"] = "Отображает соответствующее дополнение для предметов во всплывающей подсказке."
L["options.category.name"] = "Показывать категорию"
L["options.category.tooltip"] = "Отображает соответствующую категорию для предметов во всплывающей подсказке."
L["options.item-level.name"] = "Показывать уровень предмета"
L["options.item-level.tooltip"] = "Отображает соответствующий уровень предмета для предметов во всплывающей подсказке.."
L["options.blank-line.name"] = "Вставить пустую строку"
L["options.blank-line.tooltip"] = "Вставляет пустую строку в подсказку перед отображением расширения и категории."

L["options.other"] = "Другие параметры"
L["options.debug-mode.name"] = "Режим отладки"
L["options.debug-mode.tooltip"] = "Если режим отладки включен, то отображается дополнительная информацию в чате."

-- Chat

L["chat.reset-options.success"] = "Параметры успешно сброшены."

-- Dialog

L["dialog.copy-address.text"] = "Чтобы скопировать ссылку, нажмите CTRL + C."
L["dialog.reset-options.text"] = "Вы действительно хотите сбросить настройки?\n|cnNORMAL_FONT_COLOR:Внимание:|r Интерфейс игры будет автоматически перезагружен!"
