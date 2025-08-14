local _, EXT = ...

local L =  EXT.localization

local Dialog = {}

--------------
--- Frames ---
--------------

local copyAddressDialog
local resetOptionsDialog

---------------------
--- Main Funtions ---
---------------------

function Dialog:Initialize()
    copyAddressDialog = CreateFrame("Frame", "Percursus_CopyAdressDialog", UIParent, "Expositum_CopyAdressDialogTemplate")
	resetOptionsDialog = CreateFrame("Frame", "Percursus_ResetOptionsDialog", UIParent, "Expositum_ResetOptionsDialogTemplate")
end

function Dialog:ShowCopyAddressDialog(address)
    if (not copyAddressDialog:IsShown()) and (not resetOptionsDialog:IsShown()) then
        copyAddressDialog:ShowDialog(address)
    end
end

function Dialog:ShowResetOptionsDialog()
    if (not copyAddressDialog:IsShown()) and (not resetOptionsDialog:IsShown()) then
        resetOptionsDialog:ShowDialog()
    end
end

EXT.dialog = Dialog
