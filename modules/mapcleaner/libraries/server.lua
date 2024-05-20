------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:InitializedModules()
    timer.Create("clearWorldItems", self.ItemCleanupTime - 60, 0, function()
        for i, v in pairs(player.GetAll()) do
            v:SendMessage("[ WARNING ]  Item Cleanup Inbound in 60 seconds!")
        end
    end)

    timer.Create("AutomaticMapCleanup", self.MapCleanupTime - 60, 0, function()
        for i, v in pairs(player.GetAll()) do
            v:SendMessage("[ WARNING ]  Map Cleanup Inbound in 60 seconds!")
        end
    end)

    timer.Create("clearWorldItems", self.ItemCleanupTime, 0, function()
        for i, v in pairs(player.GetAll()) do
            v:SendMessage("[ WARNING ]  Item Cleanup Inbound! Brace for Impact!")
        end

        for i, v in pairs(ents.FindByClass("lia_item")) do
            v:Remove()
        end
    end)

    timer.Create("AutomaticMapCleanup", self.MapCleanupTime, 0, function()
        for i, v in pairs(player.GetAll()) do
            v:SendMessage("[ WARNING ]  Map Cleanup Inbound! Brace for Impact!")
        end

        for i, v in pairs(ents.GetAll()) do
            if table.HasValue(self.MapCleanerEntitiesToRemove, v:GetClass()) then v:Remove() end
        end
    end)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
