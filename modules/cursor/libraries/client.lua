function MODULE:PostRenderVGUI()
    if self.CursorMaterial ~= "" then draw.CustCursor(self.CursorMaterial) end
end

function MODULE:Think()
    if self.CursorMaterial ~= "" then
        local hover_panel = vgui.GetHoveredPanel()
        if not IsValid(hover_panel) then return end
        hover_panel:SetCursor("blank")
    end
end