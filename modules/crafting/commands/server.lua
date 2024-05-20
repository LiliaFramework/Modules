lia.command.add("craftlock", {
    adminOnly = false,
    syntax = "",
    onRun = function(client)
        local trace = client:GetEyeTraceNoCursor()
        local ent = trace.Entity
        local dist = ent:GetPos():DistToSqr(client:GetPos())
        if not ent or not ent:IsValid() then return nil end
        if not ent.IsCraftingTable then return client:notifyLocalized("notATable") end
        if dist > 16384 then return client:notifyLocalized("tooFar") end
        if ent.Owner ~= client then return client:notifyLocalized("notOwner") end
        ent:LockTable(true)
        ent:EmitSound("doors/default_locked.wav")
        client:notifyLocalized("lockTable")
    end
})

lia.command.add("craftunlock", {
    adminOnly = false,
    syntax = "",
    onRun = function(client)
        local trace = client:GetEyeTraceNoCursor()
        local ent = trace.Entity
        local dist = ent:GetPos():DistToSqr(client:GetPos())
        if not ent or not ent:IsValid() then return nil end
        if not ent.IsCraftingTable then return client:notifyLocalized("notATable") end
        if dist > 16384 then return client:notifyLocalized("tooFar") end
        if ent.Owner ~= client then return client:notifyLocalized("notOwner") end
        ent:LockTable(false)
        ent:EmitSound("items/ammocrate_open.wav")
        client:notifyLocalized("unlockTable")
    end
})
