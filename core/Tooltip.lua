local addonName, EXT = ...

-- Library
local AWL = ArcaneWizardLibrary

-- Localization
local L = EXT.Localization

-- Module imports
local Utils = EXT.Modules.Utils

-- Current module
local Tooltip = EXT.Modules.Tooltip

-- Variables
local tooltipLineStates = setmetatable({}, { __mode = "k" })
local tooltipResetHooks = setmetatable({}, { __mode = "k" })

-----------------------
--- Local Functions ---
-----------------------

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

local function GetExpansionText(expansionID, expansionName)
	local expansionText = "|cnWHITE_FONT_COLOR:" .. expansionName .. "|r"
	local expansionBadge = EXT.EXPANSION_BADGES[expansionID]

	if expansionBadge and expansionBadge.texture then
		return ("|T%s:16:32|t %s"):format(expansionBadge.texture, expansionText)
	end

	return expansionText
end

local function GetCategoryText(itemType, itemSubType)
	if itemSubType and itemSubType ~= "" then
		return itemType .. " (" .. itemSubType .. ")"
	end

	return itemType
end

local function GetRarityText(itemQuality)
	if itemQuality == nil then return nil end

	local qualityName = _G["ITEM_QUALITY" .. itemQuality .. "_DESC"]

	if not qualityName then return nil end

	local qualityColor = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[itemQuality]

	if qualityColor and type(qualityColor.hex) == "string" then
		local colorCode = qualityColor.hex

		if colorCode:sub(1, 2) ~= "|c" then
			colorCode = "|c" .. colorCode
		end

		return colorCode .. qualityName .. "|r"
	end

	return "|cnWHITE_FONT_COLOR:" .. qualityName .. "|r"
end

------------------------
--- Module Functions ---
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

	local _, _, itemQuality, itemLevel, _, itemType, itemSubType, _, _, _, _, _, _, _, expansionID = C_Item.GetItemInfo(itemLink)

	local expansionName = GetExpansionName(expansionID)
	local rarityText = GetRarityText(itemQuality)
	local showExpansion = EXT.Settings.tooltip["expansion"] and expansionName
	local showCategory = EXT.Settings.tooltip["category"] and itemType ~= nil
	local showRarity = EXT.Settings.tooltip["rarity"] and rarityText
	local showItemLevel = EXT.Settings.tooltip["item-level"] and itemLevel ~= nil

	if not (showExpansion or showCategory or showRarity or showItemLevel) then return end

	local lineState = GetTooltipLineState(tooltip, itemLink)

	if EXT.Settings.tooltip["blank-line"] then
		AddBlankLine(tooltip, lineState)
	end

	if showExpansion then
		AddDoubleLine(tooltip, lineState, "expansion", L["tooltip.expansion"], GetExpansionText(expansionID, expansionName))
	end

	if showCategory then
		AddDoubleLine(tooltip, lineState, "category", L["tooltip.category"], "|cnWHITE_FONT_COLOR:" .. GetCategoryText(itemType, itemSubType) .. "|r")
	end

	if showRarity then
		AddDoubleLine(tooltip, lineState, "rarity", L["tooltip.rarity"], rarityText)
	end

	if showItemLevel then
		AddDoubleLine(tooltip, lineState, "item-level", L["tooltip.item-level"], "|cnWHITE_FONT_COLOR:" .. itemLevel .. "|r")
	end
end
