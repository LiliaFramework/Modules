net.Receive("OpenVGUI", function()
    local panel = net.ReadString()
    LocalPlayer():openUI(panel)
end)

net.Receive("OpenPage", function() gui.OpenURL(net.ReadString()) end)