lia.command.add("viewextdescription", {
    adminOnly = false,
    desc = L("viewExtDescCommand"),
    onRun = function(client)
        net.Start("OpenDetailedDescriptions")
        net.WriteEntity(client)
        net.WriteString(client:getChar():getData("textDetDescData", nil) or L("openDetDescFallback"))
        net.WriteString(client:getChar():getData("textDetDescDataURL", nil) or L("openDetDescFallback"))
        net.Send(client)
    end
})

lia.command.add("charsetextdescription", {
    adminOnly = true,
    privilege = "Change Description",
    desc = L("setExtDescCommand"),
    onRun = function(client)
        net.Start("SetDetailedDescriptions")
        net.WriteString(client:steamName())
        net.Send(client)
    end
})
