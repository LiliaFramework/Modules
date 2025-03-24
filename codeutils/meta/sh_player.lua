local playerMeta = FindMetaTable( "Player" )
function playerMeta:squaredDistanceFromEnt( entity )
	return self:GetPos():DistToSqr( entity:GetPos() )
end

function playerMeta:distanceFromEnt( entity )
	return self:GetPos():Distance( entity:GetPos() )
end

function playerMeta:isMoving()
	if not IsValid( self ) or not self:Alive() then return false end
	local keydown = self:KeyDown( IN_FORWARD ) or self:KeyDown( IN_BACK ) or self:KeyDown( IN_MOVELEFT ) or self:KeyDown( IN_MOVERIGHT )
	return keydown and self:OnGround()
end

function playerMeta:isOutside()
	local trace = util.TraceLine( {
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetUp() * 9999999999,
		filter = self
	} )
	return trace.HitSky
end
