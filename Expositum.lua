local addonName, EXT = ...

local L = EXT.localization
local Utils = EXT.utils
local Dialog = EXT.dialog
local Options = EXT.options
local Tooltip = EXT.tooltip

----------------------
--- Local funtions ---
----------------------

local function SlashCommand(msg, editbox)
    if not msg or msg:trim() == "" then
        Settings.OpenToCategory(EXT.MAIN_CATEGORY_ID)
	else
        Utils:PrintDebug("No arguments will be accepted.")
	end
end

--------------
--- Frames ---
--------------

local expositumFrame = CreateFrame("Frame", "Expositum")

---------------------
--- Main funtions ---
---------------------

function expositumFrame:OnEvent(event, ...)
	self[event](self, event, ...)
end

function expositumFrame:ADDON_LOADED(_, addOnName)
    if addOnName == addonName then
        Utils:InitializeDatabase()
        Dialog:Initialize()
        Options:Initialize()

		if EXT.GAME_TYPE_VANILLA or EXT.GAME_TYPE_TBC or EXT.GAME_TYPE_MISTS then
			local function OnTooltipSetItem(tooltip)
				local _, link = tooltip:GetItem()
				if link then
					Tooltip:ProcessTooltipClassic(tooltip, link)
				end
			end

			GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
			ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
			if ShoppingTooltip1 then ShoppingTooltip1:HookScript("OnTooltipSetItem", OnTooltipSetItem) end
			if ShoppingTooltip2 then ShoppingTooltip2:HookScript("OnTooltipSetItem", OnTooltipSetItem) end
		elseif EXT.GAME_TYPE_MAINLINE then
			TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
				if not tooltip or not data then return end

				local link = (data.hyperlink or data.link)

				if not link and data.guid and C_Item.GetItemLinkByGUID then
					link = C_Item.GetItemLinkByGUID(data.guid)
				end

				if not link and data.id then
					link = ("item:%d"):format(data.id)
				end

				if link then
					Tooltip:ProcessTooltip(tooltip, link)
				end
			end)
		else
			Utils:PrintDebug("Unsupported game type.")
		end

        Utils:PrintDebug("Addon fully loaded.")
    end
end

expositumFrame:RegisterEvent("ADDON_LOADED")
expositumFrame:SetScript("OnEvent", expositumFrame.OnEvent)

SLASH_Expositum1, SLASH_Expositum2 = '/ext', '/Expositum'

SlashCmdList["Expositum"] = SlashCommand
