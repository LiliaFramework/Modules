net.Receive("SeeModelTable", function()
    local models = net.ReadTable()
    if not models or #models == 0 then return end
    local frame = vgui.Create("DFrame")
    frame:SetSize(700, 800)
    frame:Center()
    frame:SetTitle("Select Your Model")
    frame:MakePopup()
    local dropdown = vgui.Create("DComboBox", frame)
    dropdown:SetPos(100, 50)
    dropdown:SetSize(500, 50)
    dropdown:SetValue("Select a Model")
    for _, model in ipairs(models) do
        dropdown:AddChoice(model)
    end

    local modelPanel = vgui.Create("DModelPanel", frame)
    modelPanel:SetPos(100, 120)
    modelPanel:SetSize(500, 500)
    if #models > 0 then
        modelPanel:SetModel(models[1])
        local mdl = modelPanel.Entity
        if IsValid(mdl) then
            mdl:ResetSequence(mdl:LookupSequence("idle_all_01"))
            local min, max = mdl:GetRenderBounds()
            local size = max - min
            local dist = size:Length() * 1.2
            modelPanel:SetCamPos(Vector(dist, dist, dist))
            modelPanel:SetLookAt((min + max) / 2)
            modelPanel:SetFOV(30)
        end
    end

    dropdown.OnSelect = function(panel, index, value)
        modelPanel:SetModel(value)
        local mdl = modelPanel.Entity
        if IsValid(mdl) then
            mdl:ResetSequence(mdl:LookupSequence("idle_all_01"))
            local min, max = mdl:GetRenderBounds()
            local size = max - min
            local dist = size:Length() * 1.2
            modelPanel:SetCamPos(Vector(dist, dist, dist))
            modelPanel:SetLookAt((min + max) / 2)
            modelPanel:SetFOV(30)
        end
    end

    local confirmButton = vgui.Create("DButton", frame)
    confirmButton:SetText("Confirm")
    confirmButton:SetPos(100, 650)
    confirmButton:SetSize(500, 60)
    confirmButton:SetColor(Color(255, 255, 255))
    confirmButton:SetFont("DermaDefaultBold")
    confirmButton:SetContentAlignment(5)
    confirmButton.DoClick = function()
        local selectedModel = dropdown:GetSelected()
        if selectedModel and selectedModel ~= "Select a Model" then
            net.Start("WardrobeChangeModel")
            net.WriteString(selectedModel)
            net.SendToServer()
            frame:Close()
        else
            chat.AddText(Color(255, 0, 0), "Please select a valid model.")
        end
    end
end)