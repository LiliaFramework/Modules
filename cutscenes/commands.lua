local MODULE = MODULE
lia.command.add("cutscene", {
    adminOnly = true,
    syntax = "[string target] <string cutscene>",
    onRun = function(ply, args)
        local target, id
        if #args == 1 then
            id = args[1]
        else
            target = lia.util.findPlayer(ply, args[1])
            id = args[2]
        end

        if not id then
            ply:notify("Missing cutscene ID.")
            return false
        end

        if not MODULE.cutscenes[id] then
            ply:notify("Invalid cutscene " .. id .. ".")
            return false
        end

        if target and (not IsValid(target) or not target:getChar()) then
            ply:notify("Invalid target.")
            return false
        end

        MODULE:runCutscene(target, id)
    end
})