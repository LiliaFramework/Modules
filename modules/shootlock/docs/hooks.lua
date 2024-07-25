--- Hook Documentation for ShootLock Module.
-- @hooks ShootLock

--- Called to determine if a player is allowed to bust a lock on a specific entity.
-- @realm server
-- @client client Player The player who is attempting to bust the lock.
-- @entity entity Entity The entity that the player is attempting to bust the lock on.
function CanPlayerBustLock(client, entity)
end