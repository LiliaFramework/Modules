AddInteraction(L("openDetDescLabel"), {
    runServer = true,
    shouldShow = function(_, target) return IsValid(target) end,
    onRun = function(client, target)
        if not SERVER then return end
        net.Start("OpenDetailedDescriptions")
        net.WriteEntity(target)
        local char = target:getChar()
        net.WriteString(char:getTextDetDescData() or L("openDetDescFallback"))
        net.WriteString(char:getTextDetDescDataURL() or L("openDetDescFallback"))
        net.Send(client)
    end
})
