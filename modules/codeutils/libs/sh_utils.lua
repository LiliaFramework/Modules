lia.utilities = lia.utilities or {}
function lia.utilities.SpeedTest(func, n)
    local start = SysTime()
    for _ = 1, n do
        func()
    end
    return (SysTime() - start) / n
end

function lia.utilities.SerializeVector(vector)
    return util.TableToJSON({vector.x, vector.y, vector.z})
end

function lia.utilities.DeserializeVector(data)
    return Vector(unpack(util.JSONToTable(data)))
end

function lia.utilities.SerializeAngle(ang)
    return util.TableToJSON({ang.p, ang.y, ang.r})
end

function lia.utilities.DeserializeAngle(data)
    return Angle(unpack(util.JSONToTable(data)))
end

if SERVER then
    function lia.utilities.spawnProp(model, position, force, lifetime, angles, collision)
        local entity = ents.Create("prop_physics")
        entity:SetModel(model)
        entity:Spawn()
        entity:SetCollisionGroup(collision or COLLISION_GROUP_WEAPON)
        entity:SetAngles(angles or angle_zero)
        if type(position) == "Player" then position = position:GetItemDropPos(entity) end
        entity:SetPos(position)
        if force then
            local phys = entity:GetPhysicsObject()
            if IsValid(phys) then phys:ApplyForceCenter(force) end
        end

        if (lifetime or 0) > 0 then timer.Simple(lifetime, function() if IsValid(entity) then entity:Remove() end end) end
        return entity
    end

    function lia.utilities.spawnEntities(entityTable)
        for entity, position in pairs(entityTable) do
            if isvector(position) then
                local newEnt = ents.Create(entity)
                if IsValid(newEnt) then
                    newEnt:SetPos(position)
                    newEnt:Spawn()
                end
            else
                LiliaInformation("Invalid position for entity", entity)
            end
        end
    end
end
