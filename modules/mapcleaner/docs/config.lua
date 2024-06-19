--- Configuration for Map Cleaner Module.
-- @configuration MapCleaner

--- This table defines the default settings for the Map Cleaner Module.
-- @realm shared
-- @table Configuration
-- @field MapCleanerEnabled  Indicates whether the map cleaner is enabled | **bool**
-- @field ItemCleanupTime The time in seconds before items are cleaned up | **number**
-- @field MapCleanupTime The time in seconds before the entire map is cleaned up | **number**
-- @field MapCleanerEntitiesToRemove A list of entity types that will be removed during map cleanup | **table**