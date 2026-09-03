function MODULE:InitializedModules()
    if not lia.config.get("MapCleanerEnabled", true) then return end
    local itemCleanupTime = lia.config.get("ItemCleanupTime", 7200)
    local mapCleanupTime = lia.config.get("MapCleanupTime", 21600)
    timer.Create("clearWorldItemsWarning", itemCleanupTime - 60, 0, function()
        for _, client in player.Iterator() do
            client:ChatPrint("World items will be cleaned up in 60 seconds!")
        end
    end)

    timer.Create("AutomaticMapCleanupWarning", mapCleanupTime - 60, 0, function()
        for _, client in player.Iterator() do
            client:ChatPrint("Map will be cleaned up in 60 seconds!")
        end
    end)

    timer.Create("clearWorldItems", itemCleanupTime, 0, function()
        for _, client in player.Iterator() do
            client:ChatPrint("World items have been cleaned up.")
        end

        for _, item in pairs(ents.FindByClass("lia_item")) do
            item:Remove()
        end
    end)

    timer.Create("AutomaticMapCleanup", mapCleanupTime, 0, function()
        for _, client in player.Iterator() do
            client:ChatPrint("Map cleanup complete.")
        end

        for _, ent in ents.Iterator() do
            if table.HasValue(self.MapCleanerEntitiesToRemove, ent:GetClass()) then ent:Remove() end
        end
    end)
end
