local MODULE = MODULE
lia.command.add("warrant", {
    adminOnly = false,
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if not client:getChar():hasFlags(MODULE.WarrantFlag) then
            client:notify("No permission to run this command!")
            return
        end

        if IsValid(target) and target:getChar() then
            if target:IsWanted() then
                target:ToggleWanted()
                client:notify("This person no longer has active warrants.")
            else
                target:ToggleWanted()
                client:notify("You have issued this person an active warrant.")
            end
        end
    end
})
