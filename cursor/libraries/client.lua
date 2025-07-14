local CursorMaterial = ""
function MODULE:PostRenderVGUI()
    if CursorMaterial ~= "" then
        hook.Run("PreRenderCursor", CursorMaterial)
        draw.CustCursor(CursorMaterial)
        hook.Run("PostRenderCursor", CursorMaterial)
    end
end

function MODULE:Think()
    if CursorMaterial ~= "" then
        local hover_panel = vgui.GetHoveredPanel()
        if not IsValid(hover_panel) then return end
        hook.Run("PreCursorThink", hover_panel)
        hover_panel:SetCursor("blank")
        hook.Run("CursorThink", hover_panel)
    end
end
