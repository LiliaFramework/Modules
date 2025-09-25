lia.command.add("viewBodygroups", {
    adminOnly = true,
    arguments = {
        {
            name = "target",
            type = "player"
        }
    },
    desc = "viewBodygroupsDesc",
    AdminStick = {
        Name = "viewBodygroupsDesc",
        Category = "characterManagement",
        SubCategory = "bodygrouper"
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
