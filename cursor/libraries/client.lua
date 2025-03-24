local CursorMaterial = ""
function MODULE:PostRenderVGUI()
	if CursorMaterial ~= "" then draw.CustCursor( CursorMaterial ) end
end

function MODULE:Think()
	if CursorMaterial ~= "" then
		local hover_panel = vgui.GetHoveredPanel()
		if not IsValid( hover_panel ) then return end
		hover_panel:SetCursor( "blank" )
	end
end
