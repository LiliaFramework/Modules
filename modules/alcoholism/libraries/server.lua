--------------------------------------------------------------------------------------------------------
function MODULE:Think()
    if not self.next_think then
        self.next_think = CurTime()
    end

    if self.next_think <= CurTime() then
        for k, v in next, player.GetAll() do
            local bac = v:GetNW2Int("lia_alcoholism_bac", 0)
            if bac > 0 then
                v:SetNW2Int("lia_alcoholism_bac", math.Clamp(bac - self.DegradeRate, 0, 100))
            end
        end

        self.next_think = CurTime() + self.TickTime
    end
end

--------------------------------------------------------------------------------------------------------
function MODULE:StartCommand(ply, ucmd)
    if (ply.nextDrunkCheck or 0) < CurTime() then
        ply.nextDrunkCheck = CurTime() + 0.05
        if ply:GetNW2Int("lia_alcoholism_bac", 0) > 30 then
            ucmd:ClearButtons()
            if (ply.nextDrunkSide or 0) < CurTime() then
                ply.nextDrunkSide = CurTime() + math.Rand(0.1, 0.3) + (ply:GetNW2Int("lia_alcoholism_bac", 0) * 0.01)
                ply.sideRoll = math.random(-1, 1)
                ply.frontRoll = math.random(-1, 1)
            end

            if ply.frontRoll == 1 then
                ucmd:SetForwardMove(100000)
            elseif ply.frontRoll == -1 then
                ucmd:SetForwardMove(-100000)
            end

            if ply.sideRoll == 1 then
                ucmd:SetSideMove(100000)
            elseif ply.sideRoll == -1 then
                ucmd:SetSideMove(-100000)
            end
        end
    end
end

--------------------------------------------------------------------------------------------------------
function MODULE:PlayerLoadedChar(ply)
    ply:ResetBAC()
end

--------------------------------------------------------------------------------------------------------
function MODULE:PostPlayerLoadout(ply)
    ply:ResetBAC()
end
--------------------------------------------------------------------------------------------------------