--- Extension of lia.util that aims to help on several different actions.
-- @library lia.utilities
lia.utilities = lia.utilities or {}
--- Measures the average execution time of a function.
-- @realm shared
-- @func func The function to test
-- @int n The number of iterations
-- @return number The average time in seconds it took to execute the function
function lia.utilities.SpeedTest(func, n)
    local start = SysTime()
    for _ = 1, n do
        func()
    end
    return (SysTime() - start) / n
end

-- Serializes a vector to a JSON string.
-- @realm shared
-- @vector vector The vector to serialize (a table with x, y, and z values)
-- @return string The JSON string representing the vector
function lia.utilities.SerializeVector(vector)
    return util.TableToJSON({vector.x, vector.y, vector.z})
end

-- Deserializes a JSON string back into a vector.
-- @realm shared
-- @string data The JSON string to deserialize
-- @return Vector The vector object created from the JSON data
function lia.utilities.DeserializeVector(data)
    return Vector(unpack(util.JSONToTable(data)))
end

-- Serializes an angle to a JSON string.
-- @realm shared
-- @angle ang The angle to serialize (a table with p, y, and r values)
-- @return string The JSON string representing the angle
function lia.utilities.SerializeAngle(ang)
    return util.TableToJSON({ang.p, ang.y, ang.r})
end

-- Deserializes a JSON string back into an angle.
-- @realm shared
-- @string data The JSON string to deserialize
-- @return Angle The angle object created from the JSON data
function lia.utilities.DeserializeAngle(data)
    return Angle(unpack(util.JSONToTable(data)))
end

if SERVER then
    --- Spawns a prop at a given position with optional parameters.
    -- @realm server
    -- @string model Model of the prop to spawn
    -- @vector position Position to spawn the prop
    -- @param[opt] force Force to apply to the prop
    -- @int[opt] lifetime Lifetime of the prop in seconds
    -- @angle[opt] angles Angles of the prop
    -- @param[opt] collision Collision group of the prop
    -- @return The spawned prop entity
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

    --- Spawns entities from a table of entity-position pairs.
    -- @realm server
    -- @tab entityTable Table containing entity-position pairs
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