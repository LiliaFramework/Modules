--- Hook Documentation for Donator Module.
-- @hooks Donator

--- Increases the number of character slots for a specific player.
-- @client client The player whose character slots are to be increased.
-- @realm server
function AddOverrideCharSlots(client)
end

--- Decreases the number of character slots for a specific player.
-- @client client The player whose character slots are to be decreased.
-- @realm server
function SubtractOverrideCharSlots(client)
end

--- Sets the number of character slots for a specific player to a given value.
-- @client client The player whose character slots are to be set.
-- @int value The number of character slots to set.
-- @realm server
function OverrideCharSlots(client, value)
end

--- Retrieves the number of character slots currently overridden for a player.
-- @client client The player for whom to retrieve the number of character slots.
-- @return int The number of character slots currently overridden for the player.
-- @realm shared
function getOverrideChars(client)
end

--- Retrieves the number of character slots allowed based on the player's rank.
-- @client client The player for whom to retrieve the rank-based character slots.
-- @return int The number of character slots allowed based on the player's rank.
-- @realm shared
function getRankChars(client)
end