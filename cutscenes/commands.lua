local MODULE = MODULE
lia.command.add("cutscene", {
    adminOnly = true,
    privilege = "Use Cutscenes",
    syntax = "[player Target?]",
    desc = L("cutsceneCommandDesc"),
    AdminStick = {
        Name = L("cutsceneCommandDesc"),
        Category = L("moderationTools"),
        SubCategory = L("cutscenes")
    },
    onRun = function(ply, args)
        local target
        if args[1] then
            target = lia.util.findPlayer(ply, args[1])
            if not IsValid(target) or not target:getChar() then
                ply:notify(L("invalidTarget"))
                return false
            end
        end

        local options = {}
        for id in pairs(MODULE.cutscenes) do
            table.insert(options, id)
        end

        client:requestDropdown(L("selectCutsceneTitle"), L("selectCutscenePrompt"), options, function(selection)
            if not MODULE.cutscenes[selection] then
                client:notify(L("invalidCutscene"))
                return
            end

            MODULE:runCutscene(target, selection)
        end)
    end
})

lia.command.add("globalcutscene", {
    adminOnly = true,
    privilege = "Use Cutscenes",
    desc = L("globalCutsceneCommandDesc"),
    onRun = function()
        local options = {}
        for id in pairs(MODULE.cutscenes) do
            table.insert(options, id)
        end

        client:requestDropdown(L("selectCutsceneTitle"), L("globalCutscenePrompt"), options, function(selection)
            if not MODULE.cutscenes[selection] then
                client:notify(L("invalidCutscene"))
                return
            end

            MODULE:runCutscene(nil, selection)
        end)
    end
})
