function MODULE:PostDrawOpaqueRenderables()
    local client = LocalPlayer()
    if not IsValid(client) then return end
    for _, entity in ents.Iterator() do
        if IsValid(entity) and entity:GetClass() == "prop_ragdoll" and IsValid(entity:getNetVar("player")) and entity:GetNW2Bool("ShowCorpseMessage", false) then
            local distance = client:GetPos():Distance(entity:GetPos())
            local maxDistance = 500
            if distance <= maxDistance then
                local pos = entity:GetPos() + Vector(0, 0, 25)
                local ang = Angle(0, client:EyeAngles().y - 90, 90)
                cam.Start3D2D(pos, ang, 0.1)
                draw.SimpleText(L("identifyCorpse"), "Trebuchet24", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                cam.End3D2D()
            end
        end
    end
end

function MODULE:LoadFonts()
    surface.CreateFont("OrbitronFont", {
        font = "Orbitron",
        size = 18,
        weight = 500,
        antialias = true
    })
end
