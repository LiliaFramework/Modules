-------------------------------------------------------------------------------------------
local playerMeta = FindMetaTable("Player")
-------------------------------------------------------------------------------------------
function playerMeta:setRagdolledTase(state, time, nm)
    getUpGrace = 0
    if state then
        if IsValid(self.liaRagdoll) then self.liaRagdoll:Remove() end
        local entity = self:createRagdoll()
        entity:setNetVar("player", self)
        entity:CallOnRemove(
            "fixer",
            function()
                if IsValid(self) then
                    self:setLocalVar("blur", nil)
                    self:setLocalVar("ragdoll", nil)
                    if not entity.liaNoReset then self:SetPos(entity:GetPos()) end
                    self:SetNoDraw(false)
                    self:SetNotSolid(false)
                    self:SetMoveType(MOVETYPE_WALK)
                    self:SetLocalVelocity(IsValid(entity) and entity.liaLastVelocity or vector_origin)
                end

                if IsValid(self) and not entity.liaIgnoreDelete then
                    if entity.liaWeapons then
                        for k, v in ipairs(entity.liaWeapons) do
                            self:Give(v)
                            if entity.liaAmmo then
                                for k2, v2 in ipairs(entity.liaAmmo) do
                                    if v == v2[1] then self:SetAmmo(v2[2], tostring(k2)) end
                                end
                            end
                        end

                        for k, v in ipairs(self:GetWeapons()) do
                            v:SetClip1(0)
                        end
                    end

                    if self:isStuck() then
                        entity:DropToFloor()
                        self:SetPos(entity:GetPos() + Vector(0, 0, 16))
                        local positions = lia.util.findEmptySpace(self, {entity, self})
                        for k, v in ipairs(positions) do
                            self:SetPos(v)
                            if not self:isStuck() then return end
                        end
                    end
                end
            end
        )

        self:setLocalVar("blur", 25)
        self.liaRagdoll = entity
        entity.liaWeapons = {}
        entity.liaAmmo = {}
        entity.liaPlayer = self
        if getUpGrace then entity.liaGrace = CurTime() + getUpGrace end
        if time and time > 0 then
            entity.liaStart = CurTime()
            entity.liaFinish = entity.liaStart + time
            self:setAction("@wakingUp", nil, nil, entity.liaStart, entity.liaFinish)
        end

        for k, v in ipairs(self:GetWeapons()) do
            entity.liaWeapons[#entity.liaWeapons + 1] = v:GetClass()
            local clip = v:Clip1()
            local reserve = self:GetAmmoCount(v:GetPrimaryAmmoType())
            local ammo = clip + reserve
            entity.liaAmmo[v:GetPrimaryAmmoType()] = {v:GetClass(), ammo}
        end

        self:GodDisable()
        self:StripWeapons()
        self:SetNoDraw(true)
        self:SetNotSolid(true)
        self:SetMoveType(MOVETYPE_NONE)
        if time then
            local time2 = time
            local uniqueID = "liaUnRagdoll" .. self:SteamID()
            timer.Create(
                uniqueID,
                0.33,
                0,
                function()
                    if IsValid(entity) and IsValid(self) then
                        local velocity = entity:GetVelocity()
                        entity.liaLastVelocity = velocity
                        self:SetPos(entity:GetPos())
                        if velocity:Length2D() >= 8 then
                            if not entity.liaPausing then
                                self:setAction()
                                entity.liaPausing = true
                            end
                            return
                        elseif entity.liaPausing then
                            self:setAction("@wakingUp", time)
                            entity.liaPausing = false
                        end

                        time = time - 0.33
                        if time <= 0 then entity:Remove() end
                    else
                        timer.Remove(uniqueID)
                    end
                end
            )
        end

        self:setLocalVar("ragdoll", entity:EntIndex())
        hook.Run("OnCharFallover", self, entity, true)
    elseif IsValid(self.liaRagdoll) then
        self.liaRagdoll:Remove()
        hook.Run("OnCharFallover", self, entity, false)
    end
end
-------------------------------------------------------------------------------------------
