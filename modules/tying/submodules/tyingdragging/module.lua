MODULE.name = "Tying Dragging Sub-Module"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0"
MODULE.desc = "Adds Dragging to Tying"
lia.config.DraggingTargetRadius = 50 * 50
lia.config.DragMovementSpeed = 160
function MODULE:StartCommand(client, cmd)
    if not IsDragged(client) then return end
    if IsValid(GetDragger(client)) then
        local dragger = GetDragger(client)
        local TargetPos = dragger:GetPos()
        cmd:ClearMovement()
        local myPos = client:GetPos()
        local MoveVector = WorldToLocal(TargetPos, Angle(0, 0, 0), myPos, client:GetAngles())
        MoveVector:Normalize()
        MoveVector:Mul(lia.config.DragMovementSpeed)
        cmd:RemoveKey(IN_JUMP)
        cmd:RemoveKey(IN_SPEED)
        cmd:RemoveKey(IN_DUCK)
        local dist2Sqr = (TargetPos.x - myPos.x) ^ 2 + (TargetPos.y - myPos.y) ^ 2
        if dist2Sqr > lia.config.DraggingTargetRadius then
            cmd:SetForwardMove(MoveVector.x)
            cmd:SetSideMove(-MoveVector.y)
        end
    end
end
