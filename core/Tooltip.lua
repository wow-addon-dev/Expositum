local _, EXT = ...

local L = EXT.Localization

local Tooltip = {}

----------------------
--- Local funtions ---
----------------------

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

---------------------
--- Main funtions ---
---------------------

function Tooltip:ProcessTooltipClassic(tooltip, itemLink)
	if not itemLink then return end

	local _, _, _, itemLevel, _, itemType, itemSubType = C_Item.GetItemInfo(itemLink)

	if itemLevel == nil or itemType == nil or itemSubType == nil then return end

	local lineState = GetTooltipLineState(tooltip, itemLink)

	if (EXT.options.tooltip["category"] or EXT.options.tooltip["item-level"]) and EXT.options.tooltip["blank-line"] then
		AddBlankLine(tooltip, lineState)
	end

	if EXT.options.tooltip["category"] then
		AddDoubleLine(tooltip, lineState, "category", L["tooltip.category"], "|cnWHITE_FONT_COLOR:" .. itemType .. " (" .. itemSubType .. ")|r")
	end

	if EXT.options.tooltip["item-level"] then
		AddDoubleLine(tooltip, lineState, "item-level", L["tooltip.item-level"], "|cnWHITE_FONT_COLOR:" .. itemLevel .. "|r")
	end
end

function Tooltip:ProcessTooltip(tooltip, itemLink)
	if not itemLink then return end

	local _, _, _, itemLevel, _, itemType, itemSubType, _, _, _, _, _, _, _, expansionID = C_Item.GetItemInfo(itemLink)

	if itemLevel == nil or itemType == nil or itemSubType == nil or expansionID == nil then return end

	local expansionName = GetExpansionName(expansionID)
	local lineState = GetTooltipLineState(tooltip, itemLink)

	if (EXT.options.tooltip["expansion"] or EXT.options.tooltip["category"] or EXT.options.tooltip["item-level"]) and EXT.options.tooltip["blank-line"] then
		AddBlankLine(tooltip, lineState)
	end

	if EXT.options.tooltip["expansion"] then
		AddDoubleLine(tooltip, lineState, "expansion", L["tooltip.expansion"], "|cnWHITE_FONT_COLOR:" .. expansionName .. "|r")
	end

	if EXT.options.tooltip["category"] then
		AddDoubleLine(tooltip, lineState, "category", L["tooltip.category"], "|cnWHITE_FONT_COLOR:" .. itemType .. " (" .. itemSubType .. ")|r")
	end

	if EXT.options.tooltip["item-level"] then
		AddDoubleLine(tooltip, lineState, "item-level", L["tooltip.item-level"], "|cnWHITE_FONT_COLOR:" .. itemLevel .. "|r")
	end
end

EXT.Tooltip = Tooltip
