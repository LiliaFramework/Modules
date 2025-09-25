lia.command.add("viewextdescription", {
    adminOnly = false,
    desc = "viewExtDescCommand",
    onRun = function(client)
        net.Start("OpenDetailedDescriptions")
        net.WriteEntity(client)
        local char = client:getChar()
        net.WriteString(char:getTextDetDescData() or L("openDetDescFallback"))
        net.WriteString(char:getTextDetDescDataURL() or L("openDetDescFallback"))
        net.Send(client)
    end
})

lia.command.add("charsetextdescription", {
    adminOnly = true,
    desc = "setExtDescCommand",
    onRun = function(client)
        net.Start("SetDetailedDescriptions")
        net.WriteString(client:steamName())
        net.Send(client)
    end
})
