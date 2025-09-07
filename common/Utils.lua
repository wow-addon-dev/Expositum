local addonName, EXT = ...

local L = EXT.localization

local Utils = {}

-----------------------
--- Helper Funtions ---
-----------------------

---------------------
--- Main Funtions ---
---------------------

function Utils:PrintDebug(msg)
    if EXT.data.options["debug-mode"] then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
	end
end

function Utils:PrintMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
end

function Utils:InitializeDatabase()
    -- Options
    if (not Expositum_Options) then
        Expositum_Options = {}
    end

    EXT.data = {}
    EXT.data.options = Expositum_Options
end

EXT.utils = Utils
