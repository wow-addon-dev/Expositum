local _, EXT = ...

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

	local expansionName = GetExpansionName(expansionID)

	tooltip:AddLine(" ")
	AddDoubleLine(tooltip, "Expansion", "|cnWHITE_FONT_COLOR:" .. expansionName .. "|r")
	--AddDoubleLine(tooltip, "Expansion", "|cnWHITE_FONT_COLOR:" .. expansionName .. " (Patch " .. (expansionID + 1) .. ")|r")
	AddDoubleLine(tooltip, "Category", "|cnWHITE_FONT_COLOR:" .. itemType .. " (" .. itemSubType .. ")|r")

	tooltip:Show()
end

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
