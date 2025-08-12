function MODULE:KeyPress(ply)
    if ply:KeyPressed(IN_JUMP) then
        hook.Run("PlayerClimbAttempt", ply)
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
            hook.Run("PlayerBeginClimb", ply, dist)
            ply:SetVelocity(Vector(0, 0, 50 + dist * 3))
            hook.Run("PlayerClimbed", ply, dist)
        else
            hook.Run("PlayerFailedClimb", ply)
        end
    end
end