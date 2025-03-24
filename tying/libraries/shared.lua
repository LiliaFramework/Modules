function IsHandcuffed( target )
	local isRestricted = target:getNetVar( "restricted", false )
	return isRestricted
end
