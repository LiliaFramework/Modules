lia.command.add("viewBodygroups", {
    adminOnly = true,
    privilege = "Manage Bodygroups",
    syntax = "[player Target Player]",
    desc = L("viewBodygroupsDesc"),
    AdminStick = {
        Name = L("viewBodygroupsDesc"),
        Category = L("characterManagement"),
        SubCategory = L("bodygrouper")
    },
    onRun = function(client, arguments)
        local target = lia.util.findPlayer(client, arguments[1] or "")
        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        hook.Run("PreBodygrouperMenuOpen", client, target)
        net.Start("BodygrouperMenu")
        net.WriteEntity(target)
        net.Send(client)
    end
})
