local MODULE = MODULE
function getTableEnt(pos)
    for _, ent in pairs(ents.FindByClass("wartable")) do
        if ent:GetPos():DistToSqr(pos) < 25000 then return ent end
    end
    return nil
end

function MODULE:PhysgunPickup(_, ent)
    if ent:GetModel() == "models/william/war_marker/war_marker.mdl" then return false end
end
