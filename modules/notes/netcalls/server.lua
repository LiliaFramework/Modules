local MODULE = MODULE

local function FindNoteByID(id)
    for _, v in ents.Iterator() do
        if v:GetClass() == "lia_note" and v.id == id then return v end
    end
end

netstream.Hook("noteSendText", function(client, id, contents)
    if string.len(contents) <= MODULE.NoteLimit then
        local note = FindNoteByID(id)
        if note:canWrite(client) == false then return client:notify("You do not own this note") end
        MODULE.WritingData[id] = contents
    end
end)
