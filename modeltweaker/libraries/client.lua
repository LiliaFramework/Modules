net.Receive("SeeModelTable", function()
    local models = net.ReadTable()
    if not models or #models == 0 then return end
    local frame = vgui.Create("DFrame")
    frame:SetScaledSize(700, 800)
    frame:Center()
    frame:SetTitle("Select Your Model")
    frame:MakePopup()
    local dropdown = vgui.Create("DComboBox", frame)
    dropdown:SetPos(100, 50)
    dropdown:SetScaledSize(500, 50)
    dropdown:SetValue("Select a Model")
    for _, model in ipairs(models) do
        dropdown:AddChoice(model)
    end

    local modelPanel = vgui.Create("DModelPanel", frame)
    modelPanel:SetPos(100, 120)
    modelPanel:SetScaledSize(500, 500)
    modelPanel.yawSpeed = 0
    modelPanel.LayoutEntity = function(self, ent)
        ent:SetAngles(ent:GetAngles() + Angle(0, self.yawSpeed * FrameTime(), 0))
        self:RunAnimation()
    end

    local function setup(ent)
        ent:ResetSequence(ent:LookupSequence("idle_all_01"))
        local min, max = ent:GetRenderBounds()
        local size = max - min
        local dist = size:Length() * 1.2
        modelPanel:SetCamPos(Vector(dist, dist, dist))
        modelPanel:SetLookAt((min + max) / 2)
        modelPanel:SetFOV(30)
    end

    if #models > 0 then
        modelPanel:SetModel(models[1])
        local ent = modelPanel.Entity
        if IsValid(ent) then setup(ent) end
    end

    dropdown.OnSelect = function(_, _, value)
        modelPanel:SetModel(value)
        local ent = modelPanel.Entity
        if IsValid(ent) then setup(ent) end
    end

    frame.Think = function()
        if input.IsKeyDown(KEY_A) then
            modelPanel.yawSpeed = -50
        elseif input.IsKeyDown(KEY_D) then
            modelPanel.yawSpeed = 50
        else
            modelPanel.yawSpeed = 0
        end
    end

    local confirmButton = vgui.Create("DButton", frame)
    confirmButton:SetText("Confirm")
    confirmButton:SetPos(100, 650)
    confirmButton:SetScaledSize(500, 60)
    confirmButton:SetColor(Color(255, 255, 255))
    confirmButton:SetFont("DermaDefaultBold")
    confirmButton:SetContentAlignment(5)
    confirmButton.DoClick = function()
        local selected = dropdown:GetSelected()
        if selected and selected ~= "Select a Model" then
            net.Start("WardrobeChangeModel")
            net.WriteString(selected)
            net.SendToServer()
            frame:Close()
        else
            chat.AddText(Color(255, 0, 0), "Please select a valid model.")
        end
    end
end)