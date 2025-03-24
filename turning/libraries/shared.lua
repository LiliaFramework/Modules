local MODULE = MODULE
function MODULE:TranslateActivity( client, act )
	local modelClass = client.liaAnimModelClass or "player"
	if not self.supportedModelClasses[ modelClass ] or not self.activityWhitelist[ act ] then return end
	local clientTable = client:GetTable()
	clientTable.NextTurn = clientTable.NextTurn or 0
	local diff = math.NormalizeAngle( client:GetRenderAngles().y - client:EyeAngles().y )
	if math.abs( diff ) >= 45 and clientTable.NextTurn <= CurTime() then
		local gesture = diff > 0 and ACT_GESTURE_TURN_RIGHT90 or ACT_GESTURE_TURN_LEFT90
		if isfunction( client.isWepRaised ) and client:isWepRaised() and gesture == ACT_GESTURE_TURN_LEFT90 then gesture = ACT_GESTURE_TURN_LEFT45 end
		client:AnimRestartGesture( GESTURE_SLOT_CUSTOM, gesture, true )
		clientTable.NextTurn = CurTime() + client:SequenceDuration( client:SelectWeightedSequence( gesture ) )
	end
end
