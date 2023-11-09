--------------------------------------------------------------------------------------------------------
local MODULE = MODULE
--------------------------------------------------------------------------------------------------------
function MODULE:Manage(panel, gr)
  gr.charSel = panel:Add("DPanel")
  gr.charSel:SetSize(panel:GetWide(), 200)
  gr.charSel:SetPos(0, panel:GetTall())
  function gr.charSel:Paint(w, h)
    lia.util.drawBlur(self, 2)
    draw.RoundedBox(0, 0, 0, w, h, panel.buttonColor)
  end

  function gr.charSel:SlideDown()
    gr.charSel:MoveTo(0, panel:GetTall(), 0.2, 0)
  end

  function gr.charSel:SlideUp()
    gr.charSel:MoveTo(0, panel:GetTall() - gr.charSel:GetTall(), 0.2, 0)
  end

  gr.charSel:SlideUp()
  local scroll = gr.charSel:Add("WScrollList")
  scroll:SetSize(200 * #lia.characters, gr.charSel:GetTall())
  scroll:Center()
  local list = scroll:GetList(5)
  list:SetSize(scroll:GetWide() - 20, scroll:GetTall() - 10)
  list:SetPos(10, 5)
  local function charPanel(list, pClass)
    local cp = list:Add(pClass or "DPanel")
    cp:SetSize(150, list:GetTall())
    cp.color = Color(50, 50, 50, 200)
    function cp:Paint(w, h)
      lia.util.drawBlur(self, 4)
      draw.RoundedBox(6, 0, 0, w, h, self.color)
    end

    return cp
  end

  local function updateCharList()
    list:Clear()
    for k, v in pairs(lia.characters) do
      local fadeTime, fadeDelay = 0.2, 0.1 * k
      local char = lia.char.loaded[v]
      local cp = charPanel(list)
      cp:SetAlpha(0)
      cp:AlphaTo(255, fadeTime, fadeDelay)
      cp.mdl = cp:Add("DModelPanel")
      cp.mdl:SetModel(char:getModel())
      cp.mdl:SetSize(cp:GetSize())
      cp.mdl:SetFOV(50)
      cp.mdl:SetAlpha(0)
      cp.mdl:AlphaTo(255, fadeTime, fadeDelay)
      function cp.mdl:OnCursorEntered()
        MODULE:PlaySound()
      end

      function cp.mdl:DoClick()
        MODULE:PlaySound(true)
        local Menu = DermaMenu()
        local del = Menu:AddOption("Delete Character")
        del:SetIcon("icon16/cross.png")
        function del:DoClick()
          if LocalPlayer().getChar and LocalPlayer():getChar() then end --Checks if player is currently using this character
          Choice_Request(
            "Are you sure you want to delete " .. char:getName() .. " ?",
            function()
              if IsValid(panel) then
                panel:Remove()
              end

              MainMenu:deleteCharacter(char.id)
            end, nil
          )
        end

        Menu:Open()
      end

      function cp.mdl:LayoutEntity(ent)
        ent:SetAngles(Angle(0, 45, 0))
      end

      function cp.mdl:Think()
        if self:IsHovered() then
          cp.color = Color(60, 60, 60, 200)
        else
          cp.color = Color(50, 50, 50, 200)
        end
      end

      cp.name = cp:Add("DLabel")
      cp.name:SetSize(cp:GetWide(), 30)
      cp.name:SetText(char:getName())
      cp.name:SetFont("WB_Medium")
      cp.name:SetColor(color_white)
      cp.name:Dock(BOTTOM)
      cp.name:SetContentAlignment(5)
      function cp.name:Paint(w, h)
        draw.RoundedBoxEx(6, 0, 0, w, h, Color(100, 100, 100, 80), false, false, true, true)
      end
    end

    list:AlphaTo(255, 0.3) --Fade in
    local maxChars = hook.Run("GetMaxPlayerCharacter", LocalPlayer()) or lia.config.get("maxChars", 5)
    if #lia.characters < maxChars then
      scroll:SetWide(scroll:GetWide() + 200)
      list:SetWide(scroll:GetWide())
      local cn = charPanel(list, "DButton")
      cn:SetText("")
      cn:SetAlpha(0)
      cn:AlphaTo(255, 0.2, 0.1 * #lia.characters)
      function cn:PaintOver(w, h)
        local lw = 2
        surface.SetDrawColor(color_white)
        surface.DrawRect(w / 2 - 1, h / 2 - 20, 2, 40)
        surface.DrawRect(w / 2 - 20, h / 2 - 1, 40, 2)
      end

      function cn:Think()
        if self:IsHovered() then
          self.color = Color(60, 60, 60, 200)
        else
          self.color = Color(50, 50, 50, 200)
        end
      end

      function cn:DoClick()
        MODULE:PlaySound(true)
        gr.charSel:SlideDown()
        MODULE:Create(panel, gr)
        gr:FadeIn()
      end
    end
  end

  updateCharList()
end
--------------------------------------------------------------------------------------------------------