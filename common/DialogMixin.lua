local _, EXT = ...

local L = EXT.localization

Expositum_CopyAdressDialogMixin = {}

function Expositum_CopyAdressDialogMixin:OnLoad()
    self.Text:SetText(L["dialog.copy-address.text"])
	self:SetHeight(self:GetTop() - self.CloseButton:GetBottom() + 20)

    tinsert(UISpecialFrames, self:GetName())
end

function Expositum_CopyAdressDialogMixin:ShowDialog(address)
    self.EditBox:SetText(address)
	self.EditBox:HighlightText()
    self:Show()
end

Expositum_ResetOptionsDialogMixin = {}

function Expositum_ResetOptionsDialogMixin:OnLoad()
	self.Text:SetText(L["dialog.reset-options.text"])
	self:SetHeight(self:GetTop() - self.NoButton:GetBottom() + 20)

    tinsert(UISpecialFrames, self:GetName())
end

function Expositum_ResetOptionsDialogMixin:ShowDialog()
    self:Show()
end
