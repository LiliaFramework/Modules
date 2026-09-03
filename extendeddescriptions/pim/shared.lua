lia.playerinteract.addInteraction("openDetDescLabel", {
    serverOnly = true,
    shouldShow = function(_, target) return IsValid(target) end,
    onRun = function(client, target)
        if not SERVER then return end
        net.Start("OpenDetailedDescriptions")
        net.WriteEntity(target)
        local char = target:getChar()
        net.WriteString(char:getTextDetDescData() or "No description available.")
        net.WriteString(char:getTextDetDescDataURL() or "No description available.")
        net.Send(client)
    end
})
