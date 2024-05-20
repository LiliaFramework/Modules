
local PICTURE_WIDTH = MODULE.PICTURE_WIDTH

local PICTURE_HEIGHT = MODULE.PICTURE_HEIGHT

local PICTURE_WIDTH2 = PICTURE_WIDTH * 0.5

local PICTURE_HEIGHT2 = PICTURE_HEIGHT * 0.5

PHOTO_CACHE = PHOTO_CACHE or {}

function MODULE:takePicture()
    if (self.lastPic or 0) < CurTime() then
        self.lastPic = CurTime() + lia.config.PictureDelay
        net.Start("liaScannerPicture")
        net.SendToServer()
        timer.Simple(0.1, function() self.startPicture = true end)
    end
end


function MODULE:PostRender()
    if self.startPicture then
        local data = util.Compress(render.Capture({
            format = "jpeg",
            h = PICTURE_HEIGHT,
            w = PICTURE_WIDTH,
            quality = 35,
            x = ScrW() * 0.5 - PICTURE_WIDTH2,
            y = ScrH() * 0.5 - PICTURE_HEIGHT2
        }))

        net.Start("liaScannerData")
        net.WriteUInt(#data, 16)
        net.WriteData(data, #data)
        net.SendToServer()
        self.startPicture = false
    end
end


concommand.Add("lia_photocache", function()
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Photo Cache")
    frame:SetSize(480, 360)
    frame:MakePopup()
    frame:Center()
    frame.list = frame:Add("DScrollPanel")
    frame.list:Dock(FILL)
    frame.list:SetDrawBackground(true)
    for k, v in ipairs(PHOTO_CACHE) do
        local button = frame.list:Add("DButton")
        button:SetTall(28)
        button:Dock(TOP)
        button:DockMargin(4, 4, 4, 0)
        button:SetText(os.date("%X - %d/%m/%Y", v.time))
        button.DoClick = function()
            local frame2 = vgui.Create("DFrame")
            frame2:SetSize(PICTURE_WIDTH + 8, PICTURE_HEIGHT + 8)
            frame2:SetTitle(button:GetText())
            frame2:MakePopup()
            frame2:Center()
            frame2.body = frame2:Add("DHTML")
            frame2.body:SetHTML(v.data)
            frame2.body:Dock(FILL)
            frame2.body:DockMargin(4, 4, 4, 4)
        end
    end
end)

