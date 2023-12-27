----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ITEM.name = "Restraints"
--------------------------------------------------------------------------------------------------------
ITEM.desc = "A pair of ties used in the process of restraining individuals by binding their hands."
--------------------------------------------------------------------------------------------------------
ITEM.model = "models/items/crossbowrounds.mdl"
--------------------------------------------------------------------------------------------------------
ITEM.functions.use = {
    name = "Use",
    onRun = function(item)
        local client = item.player
        local target = client:GetEyeTrace().Entity
        if not IsValid(target) or not (target:IsPlayer() and target:getChar()) then return end
        if target:Team() == FACTION_STAFF then
            target:notify("You were just attempted to be restrained by " .. client:Name() .. ".")
            client:notify("You can't tie a staff member!")

            return false
        end

        if not target:IsPlayer() then
            client:notify("You need to be aiming at a player...", NOT_ERROR)

            return false
        end

        if IsHandcuffed(target) then
            client:notify("This person is already cuffed", NOT_ERROR)

            return false
        end

        target:setAction("@beingTied", 3)
        client:setAction(
            "@tying",
            3,
            function()
                local ete = client:GetEyeTrace().Entity
                if IsValid(ete) and ete == target then
                    HandcuffPlayer(target)
                    item:remove()
                end
            end
        )

        return false
    end,
}
--------------------------------------------------------------------------------------------------------