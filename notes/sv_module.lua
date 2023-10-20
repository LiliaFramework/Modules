--------------------------------------------------------------------------------------------------------
function MODULE:LoadData()
    local savedTable = self:getData() or {}
    local noteItem = lia.item.list["note"]
    WRITINGDATA = savedTable.noteData
    if savedTable.noteEntities then
        for k, v in ipairs(savedTable.noteEntities) do
            local note = ents.Create("lia_note")
            note:SetPos(v.pos)
            note:SetAngles(v.ang)
            note:Spawn()
            note:Activate()
            note:setNetVar("ownerChar", v.owner)
            note.id = v.id
            hook.Run("OnNoteSpawned", note, noteItem, true)
        end
    end
end

--------------------------------------------------------------------------------------------------------
function MODULE:SaveData()
    local saveTable = {}
    local validNotes = {}
    saveTable.noteEntities = {}
    for _, v in ipairs(ents.GetAll()) do
        if v:GetClass() == "lia_note" then
            table.insert(
                saveTable.noteEntities,
                {
                    pos = v:GetPos(),
                    ang = v:GetAngles(),
                    id = v.id,
                    owner = v:getOwner()
                }
            )

            table.insert(validNotes, v.id)
        end
    end

    local validNoteData = {}
    for _, v in ipairs(validNotes) do
        validNoteData[v] = WRITINGDATA[v]
    end

    saveTable.noteData = validNoteData
    self:setData(saveTable)
end

--------------------------------------------------------------------------------------------------------
function FindNoteByID(id)
    for k, v in ipairs(ents.GetAll()) do
        if v:GetClass() == "lia_note" and v.id == id then return v end
    end
end

--------------------------------------------------------------------------------------------------------
function MODULE:EntityRemoved(entity)
    if not lia.shuttingDown and entity and IsValid(entity) and entity:GetClass() == "lia_note" and entity.id then
        if WRITINGDATA[entity.id] then
            WRITINGDATA[entity.id] = nil
        end
    end
end

--------------------------------------------------------------------------------------------------------
function MODULE:OnNoteSpawned(note, item, load)
    note:SetModel(item.model)
    note:PhysicsInit(SOLID_VPHYSICS)
    note:SetMoveType(MOVETYPE_VPHYSICS)
    note:SetUseType(SIMPLE_USE)
    local physicsObject = note:GetPhysicsObject()
    if IsValid(physicsObject) then
        physicsObject:Wake()
    end

    if item.player and IsValid(item.player) then
        note:setNetVar("ownerChar", item.player:getChar().id)
    end

    if load ~= true then
        note.id = os.time()
        WRITINGDATA[note.id] = ""
    end
end
--------------------------------------------------------------------------------------------------------