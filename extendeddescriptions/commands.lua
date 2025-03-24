lia.command.add( "viewextdescription", {
    adminOnly = false,
    privilege = "Default User Commands",
    desc = "Opens a window displaying your character’s detailed description and URL.",
    onRun = function( client )
        net.Start( "OpenDetailedDescriptions" )
        net.WriteEntity( client )
        net.WriteString( client:getChar():getData( "textDetDescData", nil ) or "No detailed description found." )
        net.WriteString( client:getChar():getData( "textDetDescDataURL", nil ) or "No detailed description found." )
        net.Send( client )
    end
} )

lia.command.add( "charsetextdescription", {
    adminOnly = true,
    privilege = "Change Description",
    desc = "Opens the interface to edit your character’s detailed description and URL.",
    onRun = function( client )
        net.Start( "SetDetailedDescriptions" )
        net.WriteString( client:steamName() )
        net.Send( client )
    end
} )