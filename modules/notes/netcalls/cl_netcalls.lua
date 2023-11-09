--------------------------------------------------------------------------------------------------------
netstream.Hook(
    "receiveNote",
    function(id, contents, write)
        local note = vgui.Create("noteRead")
        note:allowEdit(write)
        note:setText(contents)
        note.id = id
    end
)
--------------------------------------------------------------------------------------------------------