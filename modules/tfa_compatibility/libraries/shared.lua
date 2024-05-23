function MODULE:TFA_PreCanAttach(weapon, attachment)
    local client = weapon:GetOwner()
    local character = client:getChar()
    local charHasAttachment = character:getInv():hasItem(attachment)
    return charHasAttachment
end

for name, _ in pairs(TFA.Attachments.Atts) do
    local model = "models/props_junk/cardboard_box004a.mdl"
    local desc = "An attachment that you can attach to a weapon."

    local ITEM = lia.item.register(name, nil, false, nil, true)
    ITEM.name = name
    ITEM.description = desc
    ITEM.model = model
    ITEM.width = 1
    ITEM.height = 1
    ITEM.category = "attachments"
end