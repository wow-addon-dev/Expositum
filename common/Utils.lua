local addonName, EXT = ...

local L = EXT.Localization

local Utils = {}

---------------------
--- Main Funtions ---
---------------------

function Utils:PrintDebug(msg)
    if EXT.options.other["debug-mode"] then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
	end
end

function Utils:PrintMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
end

function Utils:InitializeDatabase()
    if (not Expositum_Options_v2) then
        Expositum_Options_v2 = {
			["general"] = {
				["minimap-button"] = {
					["hide"] = false
				}
			},
			["tooltip"] = {},
			["other"] = {}
		}
    end

    EXT.options = {}
	EXT.options.general = Expositum_Options_v2["general"]
	EXT.options.tooltip = Expositum_Options_v2["tooltip"]
	EXT.options.other = Expositum_Options_v2["other"]
end

function Utils:InitializeMinimapButton()
    local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Expositum", {
        type     = "launcher",
        text     = "Expositum",
        icon     = EXT.MEDIA_PATH .. "icon-round.blp",
        OnClick  = function(self, button)
            if button == "RightButton" then
                Settings.OpenToCategory(EXT.MAIN_CATEGORY_ID)
            end
        end,
        OnTooltipShow = function(tooltip)
			GameTooltip_SetTitle(tooltip, addonName)
			GameTooltip_AddNormalLine(tooltip, EXT.ADDON_VERSION .. " (" .. EXT.ADDON_BUILD_DATE .. ")")
			GameTooltip_AddBlankLineToTooltip(tooltip)
			GameTooltip_AddHighlightLine(tooltip, L["minimap-button.tooltip"])
        end,
    })

    self.minimapButton = LibStub("LibDBIcon-1.0")
    self.minimapButton:Register("Expositum", LDB, EXT.options.general["minimap-button"])
end

EXT.Utils = Utils
