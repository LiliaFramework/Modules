function MODULE:exitStorage()
    net.Start("liaStorageExit")
    net.SendToServer()
end

function MODULE:StorageUnlockPrompt()
    Derma_StringRequest(L("storPassWrite"), L("storPassWrite"), "", function(val)
        net.Start("liaStorageUnlock")
        net.WriteString(val)
        net.SendToServer()
    end)
end

function MODULE:StorageOpen(storage)
    if IsValid(storage) and storage:getStorageInfo().invType == "WeightInv" then vgui.Create("liaListStorage"):setStorage(storage) end
end

function MODULE:transferItem(itemID)
    if not lia.item.instances[itemID] then return end
    net.Start("liaStorageTransfer")
    net.WriteUInt(itemID, 32)
    net.SendToServer()
end