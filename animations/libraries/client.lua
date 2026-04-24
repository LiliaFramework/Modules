net.Receive("liaSeqSet", function()
    local entity = net.ReadEntity()
    if not IsValid(entity) then return end
    local hasSequence = net.ReadBool()
    if not hasSequence then
        entity.liaForceSeq = nil
        return
    end

    local seqId = net.ReadInt(16)
    entity:SetCycle(0)
    entity:SetPlaybackRate(1)
    entity.liaForceSeq = seqId
end)
