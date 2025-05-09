function MODULE:CalcView(client, origin, angles)
    if not client:InVehicle() and lia.option.get("realisticViewEnabled") then
        local view = {
            origin = origin,
            angles = angles,
            fov = 90,
            drawviewer = true
        }

        local head = client:LookupAttachment("eyes")
        head = client:GetAttachment(head)
        if not head or not head.Pos or IsValid(lia.gui.menu) or client:GetMoveType() == MOVETYPE_NOCLIP then return end
        if not client.BonesRattled then
            client.BonesRattled = true
            client:InvalidateBoneCache()
            client:SetupBones()
            local matrix
            for bone = 0, client:GetBoneCount() or 1 do
                if client:GetBoneName(bone):lower():find("head") then
                    matrix = client:GetBoneMatrix(bone)
                    break
                end
            end

            if IsValid(matrix) then matrix:SetScale(Vector(0, 0, 0)) end
        end

        view.origin = head.Pos + head.Ang:Up()
        if lia.option.get("realisticViewUseFullBody") then
            view.angles = head.Ang
        else
            view.angles = Angle(head.Ang.p, head.Ang.y, angles.r)
        end
        return view
    end
end