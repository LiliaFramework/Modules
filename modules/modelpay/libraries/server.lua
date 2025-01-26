local ModelPay = {
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
    ["models/player/barney.mdl"] = 25,
}

function MODULE:GetSalaryAmount(client)
    local model = string.lower(client:GetModel() or "")
    if not client:getChar() then return end
    return ModelPay[model] or 0
end