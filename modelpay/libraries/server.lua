local ModelPay = {
    ["models/player/barney.mdl"] = 25,
}

function MODULE:GetSalaryAmount(client)
    if not IsValid(client) or not client:getChar() then return 0 end
    local playerModel = string.lower(client:GetModel())
    hook.Run("ModelPayModelChecked", client, playerModel)
    for model, pay in pairs(ModelPay) do
        if model:lower() == playerModel then
            hook.Run("ModelPayModelMatched", client, model, pay)
            hook.Run("ModelPaySalaryDetermined", client, pay)
            return pay
        end
    end
    hook.Run("ModelPayModelNotMatched", client, playerModel)
    hook.Run("ModelPaySalaryDetermined", client, 0)
    return 0
end

function MODULE:PlayerModelChanged(client, newModel)
    if ModelPay[newModel] then
        hook.Run("CreateSalaryTimer", client)
        hook.Run("ModelPayModelEligible", client, newModel)
    else
        hook.Run("ModelPayModelIneligible", client, newModel)
    end
end
