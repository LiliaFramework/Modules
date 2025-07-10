AddInteraction(L("openDetDescLabel"), {
    runServer = false,
    shouldShow = function(_, target) return IsValid(target) end,
    onRun = function(client, target)
        net.Start("OpenDetailedDescriptions")
        net.WriteEntity(target)
        net.WriteString(target:getChar():getData("textDetDescData", nil) or L("openDetDescFallback"))
        net.WriteString(target:getChar():getData("textDetDescDataURL", nil) or L("openDetDescFallback"))
        net.Send(client)
    end
})
