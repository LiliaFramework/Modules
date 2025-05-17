function MODULE:runCutscene(target, id)
	local recipients = target and {target} or player.GetAll()
	for _, ply in pairs(recipients) do
		netstream.Start(ply, "lia_cutscene", id)
	end
end