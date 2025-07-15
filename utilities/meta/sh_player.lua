local playerMeta = FindMetaTable("Player")
--[[
playerMeta:squaredDistanceFromEnt(entity)

Description:
    Returns the squared distance between the player and an entity.

Parameters:
    entity (Entity) — Target entity.

Returns:
    number — Squared distance in Hammer units.

Realm:
    Shared

Example Usage:
    local dSqr = client:squaredDistanceFromEnt(ent)
]]
function playerMeta:squaredDistanceFromEnt(entity)
    return self:GetPos():DistToSqr(entity:GetPos())
end

--[[
playerMeta:distanceFromEnt(entity)

Description:
    Returns the distance between the player and an entity.

Parameters:
    entity (Entity) — Target entity.

Returns:
    number — Distance in Hammer units.

Realm:
    Shared

Example Usage:
    local dist = client:distanceFromEnt(ent)
]]
function playerMeta:distanceFromEnt(entity)
    return self:GetPos():Distance(entity:GetPos())
end

--[[
playerMeta:isMoving()

Description:
    Determines whether the player is currently walking or running.

Returns:
    boolean — True if the player is moving on the ground.

Realm:
    Shared

Example Usage:
    if client:isMoving() then print("Player is moving") end
]]
function playerMeta:isMoving()
    if not IsValid(self) or not self:Alive() then return false end
    local keydown = self:KeyDown(IN_FORWARD) or self:KeyDown(IN_BACK) or self:KeyDown(IN_MOVELEFT) or self:KeyDown(IN_MOVERIGHT)
    return keydown and self:OnGround()
end

--[[
playerMeta:isOutside()

Description:
    Checks whether the player has a clear line to the sky.

Returns:
    boolean — True if the player is outside.

Realm:
    Shared

Example Usage:
    if client:isOutside() then print("It's open air above") end
]]
function playerMeta:isOutside()
    local trace = util.TraceLine({
        start = self:GetPos(),
        endpos = self:GetPos() + self:GetUp() * 9999999999,
        filter = self
    })
    return trace.HitSky
end

--[[
playerMeta:openPage(url)

Description:
    Sends the player a request to open a webpage in the Steam overlay.

Parameters:
    url (string) — HTTP or HTTPS address.

Realm:
    Server

Returns:
    nil

Example Usage:
    client:openPage("https://example.com")
]]
function playerMeta:openPage(url)
    net.Start("OpenPage")
    net.WriteString(url)
    net.Send(self)
end

--[[
playerMeta:openUI(panel)

Description:
    Opens a named VGUI panel on the client.

Parameters:
    panel (string) — Panel identifier registered client-side.

Realm:
    Server

Returns:
    nil

Example Usage:
    client:openUI("SomePanel")
]]
function playerMeta:openUI(panel)
    net.Start("OpenVGUI")
    net.WriteString(panel)
    net.Send(self)
end
