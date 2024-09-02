function MODULE:InitializedModules()
    timer.Create("clearWorldItemsWarning", self.ItemCleanupTime - 60, 0, function()
        for _, v in pairs(player.GetAll()) do
            v:SendMessage(L("itemCleanupWarning"))
        end
    end)

    timer.Create("AutomaticMapCleanupWarning", self.MapCleanupTime - 60, 0, function()
        for _, v in pairs(player.GetAll()) do
            v:SendMessage(L("mapCleanupWarning"))
        end
    end)

    timer.Create("clearWorldItems", self.ItemCleanupTime, 0, function()
        for _, v in pairs(player.GetAll()) do
            v:SendMessage(L("itemCleanupFinalWarning"))
        end

        for _, v in pairs(ents.FindByClass("lia_item")) do
            v:Remove()
        end
    end)

    timer.Create("AutomaticMapCleanup", self.MapCleanupTime, 0, function()
        for _, v in pairs(player.GetAll()) do
            v:SendMessage(L("mapCleanupFinalWarning"))
        end

        for _, v in pairs(ents.GetAll()) do
            if table.HasValue(self.MapCleanerEntitiesToRemove, v:GetClass()) then
                v:Remove()
            end
        end
    end)
end
