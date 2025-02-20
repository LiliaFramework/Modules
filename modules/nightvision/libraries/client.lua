﻿function MODULE:HUDPaint()
    if LocalPlayer():getNetVar("nvision", false) then
        local col = {}
        col["$pp_colour_addr"] = 0.1
        col["$pp_colour_addg"] = 0.15
        col["$pp_colour_addb"] = 0.2
        col["$pp_colour_brightness"] = 0.05
        col["$pp_colour_contrast"] = 0.85
        col["$pp_colour_colour"] = 0.75
        col["$pp_colour_mulr"] = 0
        col["$pp_colour_mulg"] = 0
        col["$pp_colour_mulb"] = 0
        DrawColorModify(col)
        DrawSharpen(1, 1)
        surface.SetDrawColor(0, 160, 0, 255)
        local client = LocalPlayer()
        for _, ply in player.Iterator() do
            if ply ~= client and ply.character and ply:GetPos():Distance(client:GetPos()) <= 2000 then
                local position = ply:LocalToWorld(ply:OBBCenter()):ToScreen()
                local x, y = position.x, position.y
                local mat = Material("models/wireframe")
                surface.SetDrawColor(255, 255, 255, 220)
                surface.SetMaterial(mat)
                surface.DrawTexturedRect(x - 10, y - 10, 20, 20)
            end
        end
    end
end
