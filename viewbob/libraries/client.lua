local stepvalue = 0
local function applyViewPunch(client, angleX, angleY, angleZ)
    if IsValid(client) then client:ViewPunch(Angle(angleX, angleY, angleZ)) end
end

function MODULE:PlayerFootstep(client)
    local enable = lia.option.get("viewbobEnable")
    if not enable then return end
    local multiplier_walk = lia.option.get("viewbobMultiplierWalk") or 0.25
    local multiplier_crouch = lia.option.get("viewbobMultiplierCrouch") or 0.1
    local multiplier_sprint = lia.option.get("viewbobMultiplierSprint") or 0.4
    stepvalue = stepvalue == 0 and 1 or -1
    if client:KeyDown(IN_DUCK) then
        if client:KeyDown(IN_FORWARD) then
            applyViewPunch(client, 1.5 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch)
        elseif client:KeyDown(IN_BACK) then
            applyViewPunch(client, -1.5 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch)
        elseif client:KeyDown(IN_MOVERIGHT) then
            applyViewPunch(client, stepvalue * 0.75 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch, 1.5 * multiplier_crouch)
        elseif client:KeyDown(IN_MOVELEFT) then
            applyViewPunch(client, stepvalue * 0.75 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch, -1.5 * multiplier_crouch)
        end
    elseif client:KeyDown(IN_SPEED) then
        if client:KeyDown(IN_FORWARD) then
            applyViewPunch(client, 2.5 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint)
        elseif client:KeyDown(IN_BACK) then
            applyViewPunch(client, -2.5 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint)
        elseif client:KeyDown(IN_MOVERIGHT) then
            applyViewPunch(client, stepvalue * 1.25 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint, 2.5 * multiplier_sprint)
        elseif client:KeyDown(IN_MOVELEFT) then
            applyViewPunch(client, stepvalue * 1.25 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint, -2.5 * multiplier_sprint)
        end
    else
        if client:KeyDown(IN_FORWARD) then
            applyViewPunch(client, 0.5 * multiplier_walk, stepvalue * 0.25 * multiplier_walk, stepvalue * 0.25 * multiplier_walk)
        elseif client:KeyDown(IN_BACK) then
            applyViewPunch(client, -0.5 * multiplier_walk, stepvalue * 0.25 * multiplier_walk, stepvalue * 0.25 * multiplier_walk)
        elseif client:KeyDown(IN_MOVERIGHT) then
            applyViewPunch(client, stepvalue * 0.25 * multiplier_walk, stepvalue * 0.25 * multiplier_walk, 0.5 * multiplier_walk)
        elseif client:KeyDown(IN_MOVELEFT) then
            applyViewPunch(client, stepvalue * 0.25 * multiplier_walk, stepvalue * 0.25 * multiplier_walk, -0.5 * multiplier_walk)
        end
    end

    if client:KeyPressed(IN_JUMP) then applyViewPunch(client, -5, stepvalue * 0.625, stepvalue * 0.625) end
end