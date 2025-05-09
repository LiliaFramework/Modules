local MODULE = MODULE
net.Receive("WardrobeChangeModel", function(_, client)
    local newModel = net.ReadString()
    local char = client:getChar()
    if not char then return end
    local faction = char:getFaction()
    local validModels = MODULE.ModelList[faction] or {}
    local isValid = false
    for _, model in ipairs(validModels) do
        if model == newModel then
            isValid = true
            break
        end
    end

    if isValid then
        char:setModel(newModel)
        client:SetModel(newModel)
        client:notify(L("wardrobeModelChanged"))
    else
        client:notify(L("wardrobeModelInvalid"))
    end
end)