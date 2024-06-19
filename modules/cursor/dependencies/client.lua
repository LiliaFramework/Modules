function draw.CustCursor(material)
    local pos_x, pos_y = input.GetCursorPos()
    if vgui.CursorVisible() then
        surface.SetDrawColor(color_white)
        surface.SetMaterial(material)
        surface.DrawTexturedRect(pos_x, pos_y, ScreenScale(15), ScreenScale(15))
    end
end
