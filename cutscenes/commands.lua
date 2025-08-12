local MODULE = MODULE
lia.command.add("cutscene", {
    adminOnly = true,
    arguments = {
        {
            name = "target",
            type = "player",
            optional = true
        }
    },
    desc = "cutsceneCommandDesc",
    AdminStick = {
        Name = "cutsceneCommandDesc",
        Category = "moderationTools",
        SubCategory = "cutscenes"
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
    desc = "globalCutsceneCommandDesc",
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