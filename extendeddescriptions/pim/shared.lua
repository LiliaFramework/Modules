AddInteraction(L("openDetDescLabel"), {
    runServer = true,
    shouldShow = function(_, target) return IsValid(target) end,
    onRun = function(client, target)
        if not SERVER then return end
        net.Start("OpenDetailedDescriptions")
        net.WriteEntity(target)
        net.WriteString(target:getChar():getData("textDetDescData", nil) or L("openDetDescFallback"))
        net.WriteString(target:getChar():getData("textDetDescDataURL", nil) or L("openDetDescFallback"))
        net.Send(client)
    end
})