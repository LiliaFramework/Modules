--- Configuration for NPC Spawner Module.
-- @configuration NPCSpawner

--- This table defines the default settings for the NPC Spawner Module.
-- @realm shared
-- @table Configuration
-- @field SpawnRadius The radius within which to check for existing entities before spawning new ones | **integer**
-- @field SpawnCooldown The time in seconds between spawn checks | **integer**
-- @field SpawnPositions A list of spawn points, each specifying an entity type and position | **table**