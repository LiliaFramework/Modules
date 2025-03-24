﻿local MODULE = MODULE
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
        client:notify("Your model has been changed successfully.")
    else
        client:notify("Invalid model selected.")
    end
end)

util.AddNetworkString("SeeModelTable")
util.AddNetworkString("WardrobeChangeModel")
