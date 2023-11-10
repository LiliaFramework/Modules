--------------------------------------------------------------------------------------------------------
function MODULE:CreateMove()
    if not LocalPlayer().UseWarTable then return end
    if not IsValid(LocalPlayer().MarkerModel) then return end
    if IsValid(LocalPlayer().WarTableModelViewer) then return end
    if input.WasMousePressed(MOUSE_LEFT) then
        LocalPlayer().WarTableModelViewer = vgui.Create("WarTableModelViewer")
        LocalPlayer().WarTableModelViewer:Display(LocalPlayer().MarkerModel, LocalPlayer().MarkerModel:GetPos())
    end
end

--------------------------------------------------------------------------------------------------------
function MODULE:Think()
    if not LocalPlayer().UseWarTable then return end
    local ply = LocalPlayer()
    local tableEnt = ply.tableEnt
    if not IsValid(tableEnt) then
        ply.UseWarTable = false
        if IsValid(ply.MarkerModel) then ply.MarkerModel:Remove() end
        return
    end

    if not IsValid(ply.MarkerModel) then
        ply.MarkerModel = ClientsideModel("models/william/war_marker/war_marker.mdl")
        ply.MarkerModel:SetPos(tableEnt:GetPos())
        ply.MarkerModel:Spawn()
    end

    local tr = util.TraceLine(
        {
            start = ply:EyePos(),
            endpos = ply:GetAngles():Forward() * 100000,
            filter = function(ent) if IsValid(ent) and not ent:IsPlayer() then return true end end
        }
    )

    if not ply.MarkerModel.LastPos then ply.MarkerModel.LastPos = tr.HitPos end
    ply.MarkerModel.LastPos = LerpVector(FrameTime() * 15, ply.MarkerModel.LastPos, tr.HitPos)
    ply.MarkerModel:SetPos(ply.MarkerModel.LastPos)
end
--------------------------------------------------------------------------------------------------------
