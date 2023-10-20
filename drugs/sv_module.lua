-------------------------------------------------------------------------------------------
function MODULE:EntityTakeDamage(client, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if IsValid(attacker) and attacker:IsPlayer() then
        local attackDrug = attacker.drug
        if attackDrug then
            for k, v in pairs(attackDrug) do
                if v[1] == "attack" then
                    dmginfo:ScaleDamage(1 + v[2])
                end
            end
        end
    end

    if client:IsPlayer() then
        local drug = client.drug
        if drug then
            for k, v in pairs(drug) do
                if v[1] == "resist" then
                    dmginfo:ScaleDamage(1 - v[2])
                end
            end
        end
    end
end
-------------------------------------------------------------------------------------------