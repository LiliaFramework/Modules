local stepvalue = 0
local enable = CreateClientConVar("viewbob", 0, {FCVAR_CLIENTCMD_CAN_EXECUTE, FCVAR_ARCHIVE})
local MultiplierWalk = CreateClientConVar("viewbob_mp_walk", 0.25, {FCVAR_CLIENTCMD_CAN_EXECUTE, FCVAR_ARCHIVE})
local MultiplierCrouch = CreateClientConVar("viewbob_mp_crouch", 0.1, {FCVAR_CLIENTCMD_CAN_EXECUTE, FCVAR_ARCHIVE})
local MultiplierSprint = CreateClientConVar("viewbob_mp_sprint", 0.4, {FCVAR_CLIENTCMD_CAN_EXECUTE, FCVAR_ARCHIVE})
function MODULE:SetupQuickMenu(menu)
    menu:addCheck("Viewbob", function(_, state)
        if state then
            RunConsoleCommand("viewbob", "1")
        else
            RunConsoleCommand("viewbob", "0")
        end
    end, enable:GetBool())
end

function MODULE:PlayerFootstep(client)
    local multiplier_walk = MultiplierWalk:GetFloat()
    local multiplier_crouch = MultiplierCrouch:GetFloat()
    local multiplier_sprint = MultiplierSprint:GetFloat()
    if enable:GetFloat() >= 1 then
        if step == 0 then
            step = 1
        else
            step = 0
        end

        if stepvalue == 0 then
            stepvalue = -1
        else
            stepvalue = 1
        end

        if client:KeyDown(IN_DUCK) then
            if client:KeyDown(IN_FORWARD) then client:ViewPunch(Angle(1.5 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch)) end
            if client:KeyDown(IN_BACK) then client:ViewPunch(Angle(-1.5 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch)) end
            if client:KeyDown(IN_MOVERIGHT) then client:ViewPunch(Angle(stepvalue * 0.75 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch, 1.5 * multiplier_crouch)) end
            if client:KeyDown(IN_MOVELEFT) then client:ViewPunch(Angle(stepvalue * 0.75 * multiplier_crouch, stepvalue * 0.75 * multiplier_crouch, -1.5 * multiplier_crouch)) end
        elseif client:KeyDown(IN_SPEED) then
            if client:KeyDown(IN_FORWARD) then client:ViewPunch(Angle(2.5 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint)) end
            if client:KeyDown(IN_BACK) then client:ViewPunch(Angle(-2.5 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint)) end
            if client:KeyDown(IN_MOVERIGHT) then client:ViewPunch(Angle(stepvalue * 1.25 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint, 2.5 * multiplier_sprint)) end
            if client:KeyDown(IN_MOVELEFT) then client:ViewPunch(Angle(stepvalue * 1.25 * multiplier_sprint, stepvalue * 1.25 * multiplier_sprint, -2.5 * multiplier_sprint)) end
        else
            if client:KeyDown(IN_FORWARD) then client:ViewPunch(Angle(0.5 * multiplier_walk, stepvalue * 0.25 * multiplier_walk, stepvalue * 0.25 * multiplier_walk)) end
            if client:KeyDown(IN_BACK) then client:ViewPunch(Angle(-0.5 * multiplier_walk, stepvalue * 0.25 * multiplier_walk, stepvalue * 0.25 * multiplier_walk)) end
            if client:KeyDown(IN_MOVERIGHT) then client:ViewPunch(Angle(stepvalue * 0.25 * multiplier_walk, stepvalue * 0.25 * multiplier_walk, 0.5 * multiplier_walk)) end
            if client:KeyDown(IN_MOVELEFT) then client:ViewPunch(Angle(stepvalue * 0.25 * multiplier_walk, stepvalue * 0.25 * multiplier_walk, -0.5 * multiplier_walk)) end
        end

        if client:KeyPressed(IN_JUMP) then client:ViewPunch(Angle(-5, stepvalue * 0.625, stepvalue * 0.625)) end
    end
end