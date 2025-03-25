PIM:AddOption("Open Detailed Description", {
    runServer = true,
    shouldShow = function(_, target) return IsValid(target) end,
    onRun = function(client, target)
        if not SERVER then return end
        net.Start("OpenDetailedDescriptions")
        net.WriteEntity(target)
        net.WriteString(target:getChar():getData("textDetDescData", nil) or "No detailed description found.")
        net.WriteString(target:getChar():getData("textDetDescDataURL", nil) or "No detailed description found.")
        net.Send(client)
    end
})
