function MODULE:LoadFonts()
    surface.CreateFont("liaDialFont", {
        font = "Arial",
        size = 20,
        weight = 500,
        antialias = true,
        shadow = false
    })

    surface.CreateFont("liaRadioFont", {
        font = "Lucida Sans Typewriter",
        size = math.max(ScreenScale(7), 17),
        weight = 100
    })
end