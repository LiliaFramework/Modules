local playerMeta = FindMetaTable( "Player" )
if SERVER then
	function playerMeta:ResetBAC()
		self:setNetVar( "lia_alcoholism_bac", 0 )
	end

	function playerMeta:AddBAC( amt )
		if not amt or not isnumber( amt ) then return end
		self:setNetVar( "lia_alcoholism_bac", math.Clamp( self:getNetVar( "lia_alcoholism_bac", 0 ) + amt, 0, 100 ) )
	end
end

function playerMeta:IsDrunk()
	return self:GetBAC() > lia.config.get( "DrunkNotifyThreshold", 50 )
end

function playerMeta:GetBAC()
	return self:getNetVar( "lia_alcoholism_bac", 0 )
end
