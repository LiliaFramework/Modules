local MODULE = MODULE

lia.command.add("group", {
    desc = "Opens the Steam group page for joining",
    onRun = function() end
})

lia.command.add("claim", {
    desc = "Claim Steam group rewards",
    onRun = function() end
})

net.Receive("sgrMenuCheck", function()
    local group = MODULE.GroupID
    if MODULE.GroupID ~= "" then gui.OpenURL("https://steamcommunity.com/groups/" .. group) end
end)