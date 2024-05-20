net.Receive("liaScannerData", function()
    local data = net.ReadData(net.ReadUInt(16))
    data = util.Base64Encode(util.Decompress(data))
    if not data then return end
    if IsValid(CURRENT_PHOTO) then
        local panel = CURRENT_PHOTO
        CURRENT_PHOTO:AlphaTo(0, 0.25, 0, function() if IsValid(panel) then panel:Remove() end end)
    end

    local html = Format([[
        <html>
            <body style="background: black; overflow: hidden; margin: 0; padding: 0;">
                <img src="data:image/jpeg;base64,%s" width="%s" height="%s" />
            </body>
        </html>
    ]], data, PICTURE_WIDTH, PICTURE_HEIGHT)
    local panel = vgui.Create("DPanel")
    panel:SetSize(PICTURE_WIDTH + 8, PICTURE_HEIGHT + 8)
    panel:SetPos(ScrW(), 8)
    panel:SetDrawBackground(true)
    panel:SetAlpha(150)
    panel.body = panel:Add("DHTML")
    panel.body:Dock(FILL)
    panel.body:DockMargin(4, 4, 4, 4)
    panel.body:SetHTML(html)
    panel:MoveTo(ScrW() - (panel:GetWide() + 8), 8, 0.5)
    timer.Simple(15, function() if IsValid(panel) then panel:MoveTo(ScrW(), 8, 0.5, 0, -1, function() panel:Remove() end) end end)
    PHOTO_CACHE[#PHOTO_CACHE + 1] = {
        data = html,
        time = os.time()
    }

    CURRENT_PHOTO = panel
end)

net.Receive("liaScannerClearPicture", function() if IsValid(CURRENT_PHOTO) then CURRENT_PHOTO:Remove() end end)
