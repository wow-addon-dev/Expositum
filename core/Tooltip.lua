local _, EXT = ...

local L = EXT.Localization

local AWL = ArcaneWizardLibrary

local Utils = EXT.modules.Utils

local Tooltip = {}

-----------------------
--- Local Functions ---
-----------------------

local tooltipLineStates = setmetatable({}, { __mode = "k" })
local tooltipResetHooks = setmetatable({}, { __mode = "k" })

local function ResetTooltipLineState(tooltip)
	tooltipLineStates[tooltip] = nil
end

local function EnsureTooltipResetHook(tooltip)
	if tooltipResetHooks[tooltip] or not tooltip.HookScript then return end

	tooltip:HookScript("OnTooltipCleared", ResetTooltipLineState)
	tooltipResetHooks[tooltip] = true
end

local function GetItemID(itemLink)
	if C_Item and C_Item.GetItemInfoInstant then
		local itemID = C_Item.GetItemInfoInstant(itemLink)

		if itemID then return itemID end
	end

	if type(itemLink) == "string" then
		return tonumber(itemLink:match("item:(%d+)"))
	end

	return nil
end

local function GetTooltipLineState(tooltip, itemLink)
	EnsureTooltipResetHook(tooltip)

	local itemID = GetItemID(itemLink)

	if not itemID then
		return { lineKeys = {} }
	end

	local state = tooltipLineStates[tooltip]

	if not state or state.itemID ~= itemID then
		state = {
			itemID = itemID,
			lineKeys = {}
		}
		tooltipLineStates[tooltip] = state
	end

	return state
end

local function AddDoubleLine(tooltip, state, lineKey, leftText, rightText)
	if state.lineKeys[lineKey] then return end

	tooltip:AddDoubleLine(leftText, rightText)
	state.lineKeys[lineKey] = true
end

local function AddBlankLine(tooltip, state)
	if state.lineKeys["blank-line"] then return end

	tooltip:AddLine(" ")
	state.lineKeys["blank-line"] = true
end

local function GetExpansionName(expansionID)
	if expansionID and EXT.EXPANSION_NAMES[expansionID] then
		return EXT.EXPANSION_NAMES[expansionID]
	end

	return nil
end

local function GetCategoryText(itemType, itemSubType)
	if itemSubType and itemSubType ~= "" then
		return itemType .. " (" .. itemSubType .. ")"
	end

	return itemType
end

------------------------
--- Public Functions ---
------------------------

function Tooltip:Initialize()
	if AWL.GAME_TYPE_VANILLA or AWL.GAME_TYPE_TBC or AWL.GAME_TYPE_MISTS then
		local function OnTooltipSetItem(tooltip)
			if not tooltip or (tooltip.IsForbidden and tooltip:IsForbidden()) then return end

			local _, link = tooltip:GetItem()
			if link then
				self:ProcessTooltip(tooltip, link)
			end
		end

		GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
		ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
		if ShoppingTooltip1 then ShoppingTooltip1:HookScript("OnTooltipSetItem", OnTooltipSetItem) end
		if ShoppingTooltip2 then ShoppingTooltip2:HookScript("OnTooltipSetItem", OnTooltipSetItem) end
	elseif AWL.GAME_TYPE_MAINLINE then
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
			if not tooltip or (tooltip.IsForbidden and tooltip:IsForbidden()) or not data then return end

			local link = (data.hyperlink or data.link)

			if not link and data.guid and C_Item.GetItemLinkByGUID then
				link = C_Item.GetItemLinkByGUID(data.guid)
			end

			if not link and data.id then
				link = ("item:%d"):format(data.id)
			end

			if link then
				self:ProcessTooltip(tooltip, link)
			end
		end)
	else
		Utils:PrintDebug("Unsupported game type.")
	end
end

function Tooltip:ProcessTooltip(tooltip, itemLink)
	if not itemLink then return end

	local _, _, _, itemLevel, _, itemType, itemSubType, _, _, _, _, _, _, _, expansionID = C_Item.GetItemInfo(itemLink)

	local expansionName = GetExpansionName(expansionID)
	local showExpansion = EXT.settings.tooltip["expansion"] and expansionName
	local showCategory = EXT.settings.tooltip["category"] and itemType ~= nil
	local showItemLevel = EXT.settings.tooltip["item-level"] and itemLevel ~= nil

	if not (showExpansion or showCategory or showItemLevel) then return end

	local lineState = GetTooltipLineState(tooltip, itemLink)

	if EXT.settings.tooltip["blank-line"] then
		AddBlankLine(tooltip, lineState)
	end

	if showExpansion then
		AddDoubleLine(tooltip, lineState, "expansion", L["tooltip.expansion"], "|cnWHITE_FONT_COLOR:" .. expansionName .. "|r")
	end

	if showCategory then
		AddDoubleLine(tooltip, lineState, "category", L["tooltip.category"], "|cnWHITE_FONT_COLOR:" .. GetCategoryText(itemType, itemSubType) .. "|r")
	end

	if showItemLevel then
		AddDoubleLine(tooltip, lineState, "item-level", L["tooltip.item-level"], "|cnWHITE_FONT_COLOR:" .. itemLevel .. "|r")
	end
end

EXT.modules.Tooltip = Tooltip
