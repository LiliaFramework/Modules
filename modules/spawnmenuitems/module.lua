--- Configuration for Protection Module.
-- @configurations Temp

--- This table defines the default settings for the Protection Module.
-- @realm shared
-- @table Configuration
-- @field TempValue Indicates whether Family Sharing is enabled on this server | **bool**

MODULE.name = "Spawn Menu Items"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.desc = "Adds Spawnable Items from Spawn Menu"
MODULE.CAMIPrivileges = {
    {
        Name = "Lilia - Staff Permissions - Can Spawn Menu Items",
        MinAccess = "superadmin",
        Description = "Allows access to Spawning Menu Items.",
    }
}

MODULE.cooldown = 0.5
