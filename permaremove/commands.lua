local MODULE = MODULE
lia.command.add( "permaremove", {
	adminOnly = true,
	privilege = "Remove Map Entities",
	desc = "Permanently removes the targeted map entity.",
	onRun = function( client )
		local entity = client:GetEyeTraceNoCursor().Entity
		local data = MODULE:getData( {} )
		local mapID = game.GetMap()
		if IsValid( entity ) and entity:CreatedByMap() then
			data[ #data + 1 ] = { mapID, entity:MapCreationID() }
			entity:Remove()
			MODULE:setData( data )
			client:notify( L( "permRemoveSuccess" ) )
		else
			client:notify( L( "permRemoveInvalid" ) )
		end
	end
} )
