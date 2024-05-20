function MODULE:CreateMove()
    if not LocalPlayer().UseWarTable then return end
    if not IsValid(LocalPlayer().MarkerModel) then return end
    if IsValid(LocalPlayer().WarTableModelViewer) then return end
    if input.WasMousePressed(MOUSE_LEFT) then
        LocalPlayer().WarTableModelViewer = vgui.Create("WarTableModelViewer")
        LocalPlayer().WarTableModelViewer:Display(LocalPlayer().MarkerModel, LocalPlayer().MarkerModel:GetPos())
    end
end

function MODULE:Think()
    if not LocalPlayer().UseWarTable then return end
    local client = LocalPlayer()
    local tableEnt = client.tableEnt
    if not IsValid(tableEnt) then
        client.UseWarTable = false
        if IsValid(client.MarkerModel) then client.MarkerModel:Remove() end
        return
    end

    if not IsValid(client.MarkerModel) then
        client.MarkerModel = ClientsideModel("models/william/war_marker/war_marker.mdl")
        client.MarkerModel:SetPos(tableEnt:GetPos())
        client.MarkerModel:Spawn()
    end

    local tr = util.TraceLine({
        start = client:EyePos(),
        endpos = client:GetAngles():Forward() * 100000,
        filter = function(ent) if IsValid(ent) and not ent:IsPlayer() then return true end end
    })

    if not client.MarkerModel.LastPos then client.MarkerModel.LastPos = tr.HitPos end
    client.MarkerModel.LastPos = LerpVector(FrameTime() * 15, client.MarkerModel.LastPos, tr.HitPos)
    client.MarkerModel:SetPos(client.MarkerModel.LastPos)
end
