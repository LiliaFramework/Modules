local MODULE = MODULE
util.AddNetworkString("liaScannerData")
util.AddNetworkString("liaScannerPicture")
util.AddNetworkString("liaScannerClearPicture")
net.Receive("liaScannerData", function(_, client)
    if IsValid(client.liaScn) and client:GetViewEntity() == client.liaScn and (client.liaNextPic or 0) < CurTime() then
        local delay = MODULE.PictureDelay
        client.liaNextPic = CurTime() + delay - 1
        local length = net.ReadUInt(16)
        local data = net.ReadData(length)
        if length ~= #data then return end
        local receivers = {}
        for _, v in ipairs(player.GetAll()) do
            if hook.Run("CanPlayerReceiveScan", v, client) then
                receivers[#receivers + 1] = v
                v:EmitSound("npc/overwatch/radiovoice/preparevisualdownload.wav")
            end
        end

        if #receivers > 0 then
            net.Start("liaScannerData")
            net.WriteUInt(#data, 16)
            net.WriteData(data, #data)
            net.Send(receivers)
            if SCHEMA.addDisplay then SCHEMA:addDisplay("Prepare to receive visual download...") end
        end
    end
end)

net.Receive("liaScannerPicture", function(_, client)
    if not IsValid(client.liaScn) then return end
    if client:GetViewEntity() ~= client.liaScn then return end
    if (client.liaNextFlash or 0) >= CurTime() then return end
    client.liaNextFlash = CurTime() + 1
    client.liaScn:flash()
end)
