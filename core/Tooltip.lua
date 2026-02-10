local _, EXT = ...

local L = EXT.localization

local Tooltip = {}

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

---------------------
--- Main funtions ---
---------------------

function Tooltip:ProcessTooltipClassic(tooltip, itemLink)
	if not itemLink then return end

	local _, _, _, itemLevel, _, itemType, itemSubType = C_Item.GetItemInfo(itemLink)

	if (EXT.data.options["category"] or EXT.data.options["item-level"]) and EXT.data.options["blank-line"] then
		tooltip:AddLine(" ")
	end

	if EXT.data.options["category"] then
		AddDoubleLine(tooltip, L["tooltip.category"], "|cnWHITE_FONT_COLOR:" .. itemType .. " (" .. itemSubType .. ")|r")
	end

	if EXT.data.options["item-level"] then
		AddDoubleLine(tooltip, L["tooltip.item-level"], "|cnWHITE_FONT_COLOR:" .. itemLevel .. "|r")
	end

	tooltip:Show()
end

function Tooltip:ProcessTooltip(tooltip, itemLink)
	if not itemLink then return end

	local _, _, _, itemLevel, _, itemType, itemSubType, _, _, _, _, _, _, _, expansionID = C_Item.GetItemInfo(itemLink)

	if expansionID == nil then return end

	local expansionName = GetExpansionName(expansionID)

	if (EXT.data.options["expansion"] or EXT.data.options["category"] or EXT.data.options["item-level"]) and EXT.data.options["blank-line"] then
		tooltip:AddLine(" ")
	end

	if EXT.data.options["expansion"] then
		AddDoubleLine(tooltip, L["tooltip.expansion"], "|cnWHITE_FONT_COLOR:" .. expansionName .. "|r")
	end

	if EXT.data.options["category"] then
		AddDoubleLine(tooltip, L["tooltip.category"], "|cnWHITE_FONT_COLOR:" .. itemType .. " (" .. itemSubType .. ")|r")
	end

	if EXT.data.options["item-level"] then
		AddDoubleLine(tooltip, L["tooltip.item-level"], "|cnWHITE_FONT_COLOR:" .. itemLevel .. "|r")
	end

	tooltip:Show()
end

EXT.tooltip = Tooltip
