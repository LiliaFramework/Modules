--- Hook Documentation for AFK Manager Module.
-- @hooks AFKManager

--- Called to enable the AFK warning system.
-- @realm client
-- This function starts the AFK warning system by setting the initial alpha value, recording the start time,
-- playing a sound, and adding a hook to draw the warning on the HUD.
-- @internal
function EnableWarning()
end

--- Called to disable the AFK warning system.
-- @realm client
-- This function stops the AFK warning system by clearing alpha-related values and removing the hook
-- that draws the warning on the HUD.
-- @internal
function DisableWarning()
end
--- Sends a warning notification to the specified player.
-- @realm server
-- This function sends a network message to the player to notify them of an AFK warning and sets their `HasWarning` flag to true.
-- @client client The player to receive the warning.
function WarnPlayer(client)
end

--- Removes the AFK warning notification from the specified player.
-- @realm server
-- This function sends a network message to the player to remove the AFK warning and sets their `HasWarning` flag to false.
-- @client client The player from whom the warning should be removed.
function RemoveWarningclient)
end

--- Broadcasts an AFK announcement and kicks the specified player from the server.
-- @realm server
-- This function sends an AFK announcement to all players, resets the AFK time for the specified player, and schedules their kick.
-- @client client The player to be kicked for being AFK.
-- @internal
function CharKick(client)
end

--- Resets the AFK time for the specified player and removes their warning if applicable.
-- @realm server
-- This function resets the `AFKTime` for the specified player to 0 and removes their AFK warning if they have one.
-- @client client The player whose AFK time is to be reset.
function ResetAFKTime(client)
end