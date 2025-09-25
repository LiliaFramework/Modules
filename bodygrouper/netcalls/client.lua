local MODULE = MODULE
net.Receive("BodygrouperMenu", function()
    local client = LocalPlayer()
    if IsValid(MODULE.Menu) then MODULE.Menu:Remove() end
    local entity = net.ReadEntity()
    MODULE.Menu = vgui.Create("BodygrouperMenu")
    local target = IsValid(entity) and entity or client
    MODULE.Menu:SetTarget(target)
    hook.Run("BodygrouperMenuOpened", MODULE.Menu, target)
end)

net.Receive("BodygrouperMenuCloseClientside", function()
    if IsValid(MODULE.Menu) then
        MODULE.Menu:Remove()
        hook.Run("BodygrouperMenuClosed")
    end
end)
