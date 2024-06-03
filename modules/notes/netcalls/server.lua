local MODULE = MODULE
netstream.Hook("noteSendText", function(client, id, contents)
    if string.len(contents) <= MODULE.NoteLimit then
        local note = FindNoteByID(id)
        if note:canWrite(client) == false then return client:notify("You do not own this note") end
        MODULE.WritingData[id] = contents
    end
end)
