net.Receive("PlayPickupAnimation", function()
    if not VManip then return end
    local itemID = net.ReadString()
    local item = lia.item.list[itemID]
    local isDisabled = item.VManipDisabled
    if item and VManip.PlayAnim and not isDisabled then
        local anim = hook.Run("VManipChooseAnim", itemID) or "interactslower"
        VManip:PlayAnim(anim)
        hook.Run("VManipAnimationPlayed", itemID)
    end
end)