local addonName, EXT = ...

local L = EXT.Localization

---------------------
--- Main Funtions ---
---------------------

function Expositum_CompartmentOnEnter(self, button)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetOwner(button, "ANCHOR_LEFT")

	GameTooltip_SetTitle(GameTooltip, addonName)
	GameTooltip_AddNormalLine(GameTooltip, EXT.ADDON_VERSION .. " (" .. EXT.ADDON_BUILD_DATE .. ")")
	GameTooltip_AddBlankLineToTooltip(GameTooltip)
	GameTooltip_AddHighlightLine(GameTooltip, L["minimap-button.tooltip"])

	GameTooltip:Show()
end

function Expositum_CompartmentOnLeave()
    GameTooltip:Hide()
end

function Expositum_CompartmentOnClick(_, button)
    if button == "RightButton" then
        Settings.OpenToCategory(EXT.MAIN_CATEGORY_ID)
    end
end
