﻿lia.command.add("charWarn", {
    adminOnly = true,
    privilege = "Warn Players",
    syntax = "<string name>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        local tCharID = target:getChar():getID()
        net.Start("WarnReasonUI")
        net.WriteInt(tCharID, 32)
        net.Send(client)
    end
})