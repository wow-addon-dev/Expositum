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
        Settings.OpenToCategory("Expositum")
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

        Utils:PrintDebug("Addon fully loaded.")
    end
end

expositumFrame:RegisterEvent("ADDON_LOADED")
expositumFrame:SetScript("OnEvent", expositumFrame.OnEvent)

SLASH_Expositum1, SLASH_Expositum2 = '/ext', '/Expositum'

SlashCmdList["Expositum"] = SlashCommand
