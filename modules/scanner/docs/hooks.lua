--- Hook Documentation for Scanner Module.
-- @hooks Scanner

--- Called to determine if a player can receive scan data from another player.
-- @realm server
-- @client client Player The player who is being checked to see if they can receive the scan data.
-- @client sender Player The player who is sending the scan data.
function CanPlayerReceiveScan()
end