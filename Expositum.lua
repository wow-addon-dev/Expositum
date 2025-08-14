local addonName, EXT = ...

local L = EXT.localization
local Utils = EXT.utils
local Dialog = EXT.dialog
local Options = EXT.options

----------------------
--- Local funtions ---
----------------------

local function AddDoubleLine(tooltip, leftText, rightText)
	for i = 1, tooltip:NumLines() do
		local left = _G[tooltip:GetName().."TextLeft"..i]

		if left and left:GetText() == leftText then
			local right = _G[tooltip:GetName().."TextRight"..i]

			if right then right:SetText(rightText) end

			return
    	end
	end

	tooltip:AddDoubleLine(leftText, rightText)
end

local function GetExpansionName(expansionID)
	if expansionID and EXT.EXPANSION_NAMES[expansionID] then
		return EXT.EXPANSION_NAMES[expansionID]
	end

	return nil
end

local function ProcessTooltip(tooltip, itemLink)
	if not itemLink then return end

	local _, _, _, _, _, itemType, itemSubType, _, _, _, _, classID, subclassID, _, expansionID = C_Item.GetItemInfo(itemLink)

	if expansionID == nil then return end

	local expansionName = GetExpansionName(expansionID)

	if EXT.data.options["expansion"] and EXT.data.options["category"] and EXT.data.options["blank-line"] then
		tooltip:AddLine(" ")
	end

	if EXT.data.options["expansion"] then
		AddDoubleLine(tooltip, L["tooltip.expansion"], "|cnWHITE_FONT_COLOR:" .. expansionName .. "|r")
	end

	if EXT.data.options["category"] then
		AddDoubleLine(tooltip, L["tooltip.category"], "|cnWHITE_FONT_COLOR:" .. itemType .. " (" .. itemSubType .. ")|r")
	end

	tooltip:Show()
end

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
				ProcessTooltip(tooltip, link)
			end
		end)

        Utils:PrintDebug("Addon fully loaded.")
    end
end

expositumFrame:RegisterEvent("ADDON_LOADED")
expositumFrame:SetScript("OnEvent", expositumFrame.OnEvent)

SLASH_Expositum1, SLASH_Expositum2 = '/ext', '/Expositum'

SlashCmdList["Expositum"] = SlashCommand
