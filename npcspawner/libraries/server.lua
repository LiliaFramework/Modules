local MODULE = MODULE
local function isSafeSpawnPos( pos )
    local hull = {}
    hull.start = pos + Vector( 0, 0, 50 )
    hull.endpos = pos
    hull.mins = Vector( -16, -16, 0 )
    hull.maxs = Vector( 16, 16, 72 )
    hull.mask = MASK_PLAYERSOLID_BRUSHONLY
    local hullTrace = util.TraceHull( hull )
    if hullTrace.Hit then return false end
    local ground = {}
    ground.start = pos
    ground.endpos = pos - Vector( 0, 0, 100 )
    ground.mask = MASK_SOLID
    local groundTrace = util.TraceLine( ground )
    if not groundTrace.Hit then return false end
    return true
end

local function spawnNPC( zone, npcType, group )
    local randomOffset = Vector( math.Rand( -zone.radius, zone.radius ), math.Rand( -zone.radius, zone.radius ), 0 )
    local spawnPos = zone.pos + randomOffset
    if not isSafeSpawnPos( spawnPos ) then return false end
    local npc = ents.Create( npcType )
    if not IsValid( npc ) then return false end
    npc:SetPos( spawnPos )
    npc:setNetVar( "setNetVar", group )
    npc:Spawn()
    table.insert( zone.spawnedNPCs, npc )
    return true
end

local function getNPCCount( zone, npcType )
    local count = 0
    for _, npc in ipairs( zone.spawnedNPCs or {} ) do
        if IsValid( npc ) and npc:GetClass() == npcType then count = count + 1 end
    end
    return count
end

local function processZone( zone, group )
    zone.spawnedNPCs = zone.spawnedNPCs or {}
    local groupAlive = false
    for _, npc in ipairs( zone.spawnedNPCs ) do
        if IsValid( npc ) and npc:getNetVar( "setNetVar" ) == group then
            groupAlive = true
            break
        end
    end

    if groupAlive then
        return false, "Old NPCs still alive"
    else
        zone.spawnedNPCs = {}
    end

    local overallCount = 0
    for _, npc in ipairs( zone.spawnedNPCs ) do
        if IsValid( npc ) then overallCount = overallCount + 1 end
    end

    if overallCount >= zone.maxNPCs then return false end
    for npcType, maxCount in pairs( zone.maxPerType ) do
        local currentCount = getNPCCount( zone, npcType )
        local remainingForType = maxCount - currentCount
        if remainingForType > 0 then
            local overallRemaining = zone.maxNPCs - overallCount
            if overallRemaining <= 0 then break end
            local spawnCount = math.min( remainingForType, overallRemaining )
            for _ = 1, spawnCount do
                if spawnNPC( zone, npcType, group ) then overallCount = overallCount + 1 end
            end
        end
    end
    return true
end

local function spawnCycle()
    local zones = MODULE.SpawnPositions[ game.GetMap() ]
    if not zones then return end
    for group, zone in pairs( zones ) do
        processZone( zone, group )
    end
end

function MODULE:InitializedModules()
    if not timer.Exists( "NPCSpawnTimer" ) then timer.Create( "NPCSpawnTimer", lia.config.get( "SpawnCooldown" ), 0, spawnCycle ) end
end