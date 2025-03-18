lia.command.add("viewextdescription", {
    adminOnly = false,
    privilege = "Default User Commands",
    onRun = function(client)
        net.Start("OpenDetailedDescriptions")
        net.WriteEntity(client)
        net.WriteString(client:getChar():getData("textDetDescData", nil) or "No detailed description found.")
        net.WriteString(client:getChar():getData("textDetDescDataURL", nil) or "No detailed description found.")
        net.Send(client)
    end
})

lia.command.add("charsetextdescription", {
    adminOnly = true,
    privilege = "Change Description",
    onRun = function(client)
        net.Start("SetDetailedDescriptions")
        net.WriteString(client:steamName())
        net.Send(client)
    end
})
