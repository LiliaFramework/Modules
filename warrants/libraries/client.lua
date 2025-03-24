function MODULE:DrawCharInfo( client, _, info )
	if client:IsWanted() and LocalPlayer():CanSeeWarrants() then info[ #info + 1 ] = { L( "WarrantedText" ), Color( 255, 0, 0 ) } end
end

function MODULE:LoadCharInformation()
	local client = LocalPlayer()
	hook.Run( "AddTextField", "General Info", "wanted", "Wanted", function() return client:IsWanted() and "Wanted" or "Upstanding" end )
end
