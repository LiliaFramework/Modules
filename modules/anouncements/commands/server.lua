lia.command.add("announce", {
    superAdminOnly = true,
    syntax = "<string factions> <string text>",
    privilege = "Make Announcements",
    onRun = function(client, arguments)
        if not arguments[1] then return "Invalid argument (#1)" end
        local message = table.concat(arguments, " ", 1)
        net.Start("announcement_client")
        net.WriteString(message)
        net.Broadcast()
        client:notify("Announcement sent.")
    end
})