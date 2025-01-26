function MODULE:KeyPress(ply)
    if ply:KeyPressed(IN_JUMP) then
        local trace = {}
        trace.start = ply:GetShootPos() + Vector(0, 0, 15)
        trace.endpos = trace.start + ply:GetAimVector() * 30
        trace.filter = ply
        local trHi = util.TraceLine(trace)
        trace = {}
        trace.start = ply:GetShootPos()
        trace.endpos = trace.start + ply:GetAimVector() * 30
        trace.filter = ply
        local trLo = util.TraceLine(trace)
        if trLo and trHi and trLo.Hit and not trHi.Hit then
            local dist = math.abs(trHi.HitPos.z - ply:GetPos().z)
            ply:SetVelocity(Vector(0, 0, 50 + dist * 3))
        end
    end
end
