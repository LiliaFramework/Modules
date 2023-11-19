----------------------------------------------------------------------------------------------
local function _SScale(size)
    return size * (ScrH() / 900) + 10
end

----------------------------------------------------------------------------------------------
function MODULE:LoadFonts(font)
    surface.CreateFont(
        'liaCharTitleFont',
        {
            font = font,
            weight = 200,
            size = _SScale(70),
            additive = true
        }
    )

    surface.CreateFont(
        'liaCharDescFont',
        {
            font = font,
            weight = 200,
            size = _SScale(24),
            additive = true
        }
    )

    surface.CreateFont(
        'liaCharSubTitleFont',
        {
            font = font,
            weight = 200,
            size = _SScale(12),
            additive = true
        }
    )

    surface.CreateFont(
        'liaCharButtonFont',
        {
            font = font,
            weight = 200,
            size = _SScale(24),
            additive = true
        }
    )

    surface.CreateFont(
        'liaCharSmallButtonFont',
        {
            font = font,
            weight = 200,
            size = _SScale(22),
            additive = true
        }
    )

    surface.CreateFont(
        'liaEgMainMenu',
        {
            font = 'Open Sans',
            extended = true,
            size = SScale(12),
            weight = 500,
            antialias = true
        }
    )
end

----------------------------------------------------------------------------------------------
function MODULE:LiliaLoaded()
    vgui.Create('liaNewCharacterMenu')
end

----------------------------------------------------------------------------------------------
function MODULE:KickedFromCharacter(id, isCurrentChar)
    if isCurrentChar then vgui.Create('liaNewCharacterMenu') end
end

----------------------------------------------------------------------------------------------
function MODULE:CreateMenuButtons(tabs)
    tabs['characters'] = function(panel)
        if IsValid(lia.gui.menu) then lia.gui.menu:Remove() end
        vgui.Create('liaNewCharacterMenu')
    end
end
----------------------------------------------------------------------------------------------
