local ModelPay = {
    ["models/player/barney.mdl"] = 25,
}

function MODULE:GetSalaryAmount(client)
    if not IsValid(client) or not client:getChar() then return 0 end
    local playerModel = string.lower(client:GetModel())
    for model, pay in pairs(ModelPay) do
        if model:lower() == playerModel then return pay end
    end
    return 0
end

function MODULE:PlayerModelChanged(client, newModel)
    if ModelPay[newModel] then hook.Run("CreateSalaryTimer", client) end
end