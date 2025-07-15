net.Receive("radioAdjust", function()
    local freq = net.ReadString()
    local id = net.ReadUInt(32)
    if id == 0 then id = nil end
    local adjust = vgui.Create("liaRadioMenu")
    if id then adjust.itemID = id end
    if freq then
        for i = 1, 5 do
            if i ~= 4 then adjust.dial[i].number = freq[i] end
        end
    end
end)
