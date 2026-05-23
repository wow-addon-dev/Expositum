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
    local defaults = {
        ["general"] = {
				["minimap-button"] = {
					["hide"] = false
				}
			},
			["tooltip"] = {},
			["other"] = {}
    }

    local charKey = GetUnitName("player", true) .. "#" .. GetRealmName()

    if not Expositum_Options_v3 then
        Expositum_Options_v3 = {
            ["global"] = defaults,
            ["profiles"] = {},
            ["profileKeys"] = {}
        }
    end

    if not Expositum_Options_v3.profiles[charKey] then
        Expositum_Options_v3.profiles[charKey] = defaults
    end

    if not Expositum_Options_v3.profileKeys[charKey] then
        Expositum_Options_v3.profileKeys[charKey] = {
			["use-global"] = true,
			["open-settings"] = false
		}
    end

	EXT.options = {}

    if Expositum_Options_v3.profileKeys[charKey]["use-global"] then
		EXT.options.general = Expositum_Options_v3.global["general"]
		EXT.options.tooltip = Expositum_Options_v3.global["tooltip"]
		EXT.options.other   = Expositum_Options_v3.global["other"]
    else
		EXT.options.general = Expositum_Options_v3.profiles[charKey]["general"]
		EXT.options.tooltip = Expositum_Options_v3.profiles[charKey]["tooltip"]
		EXT.options.other   = Expositum_Options_v3.profiles[charKey]["other"]
    end
end

function Utils:InitializeMinimapButton()
    local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Expositum", {
        type     = "launcher",
        text     = "Expositum",
        icon     = EXT.MEDIA_PATH .. "icon-round.blp",
        OnClick  = function(self, button)
            if button == "RightButton" then
				if not InCombatLockdown() then
					Settings.OpenToCategory(EXT.MAIN_CATEGORY_ID)
				else
					Utils:PrintDebug("In combat. The options menu cannot be opened.")
				end
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
