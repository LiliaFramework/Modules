function MODULE:runCutscene(target, id)
    local recipients = target and {target} or player.GetAll()
    for _, ply in pairs(recipients) do
        hook.Run("CutsceneStarted", ply, id)
        net.Start("lia_cutscene")
        net.WriteString(id)
        net.Send(ply)
    end
end