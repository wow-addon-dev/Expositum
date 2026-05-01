local _, EXT = ...

local L = EXT.Localization

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

	if itemLevel == nil or itemType == nil or itemSubType == nil then return end

	if (EXT.options.tooltip["category"] or EXT.options.tooltip["item-level"]) and EXT.options.tooltip["blank-line"] then
		tooltip:AddLine(" ")
	end

	if EXT.options.tooltip["category"] then
		AddDoubleLine(tooltip, L["tooltip.category"], "|cnWHITE_FONT_COLOR:" .. itemType .. " (" .. itemSubType .. ")|r")
	end

	if EXT.options.tooltip["item-level"] then
		AddDoubleLine(tooltip, L["tooltip.item-level"], "|cnWHITE_FONT_COLOR:" .. itemLevel .. "|r")
	end
end

function Tooltip:ProcessTooltip(tooltip, itemLink)
	if not itemLink then return end

	local _, _, _, itemLevel, _, itemType, itemSubType, _, _, _, _, _, _, _, expansionID = C_Item.GetItemInfo(itemLink)

	if itemLevel == nil or itemType == nil or itemSubType == nil or expansionID == nil then return end

	local expansionName = GetExpansionName(expansionID)

	if (EXT.options.tooltip["expansion"] or EXT.options.tooltip["category"] or EXT.options.tooltip["item-level"]) and EXT.options.tooltip["blank-line"] then
		tooltip:AddLine(" ")
	end

	if EXT.options.tooltip["expansion"] then
		AddDoubleLine(tooltip, L["tooltip.expansion"], "|cnWHITE_FONT_COLOR:" .. expansionName .. "|r")
	end

	if EXT.options.tooltip["category"] then
		AddDoubleLine(tooltip, L["tooltip.category"], "|cnWHITE_FONT_COLOR:" .. itemType .. " (" .. itemSubType .. ")|r")
	end

	if EXT.options.tooltip["item-level"] then
		AddDoubleLine(tooltip, L["tooltip.item-level"], "|cnWHITE_FONT_COLOR:" .. itemLevel .. "|r")
	end
end

EXT.Tooltip = Tooltip
