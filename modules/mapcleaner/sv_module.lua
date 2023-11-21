------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:InitializedModules()
    timer.Create(
        "clearWorldItems",
        lia.config.ItemCleanupTime - 60,
        0,
        function()
            for i, v in pairs(player.GetAll()) do
                v:SendMessage("[ WARNING ]  Item Cleanup Inbound in 60 seconds!")
            end
        end
    )

    timer.Create(
        "AutomaticMapCleanup",
        lia.config.MapCleanupTime - 60,
        0,
        function()
            for i, v in pairs(player.GetAll()) do
                v:SendMessage("[ WARNING ]  Map Cleanup Inbound in 60 seconds!")
            end
        end
    )

    timer.Create(
        "clearWorldItems",
        lia.config.ItemCleanupTime,
        0,
        function()
            for i, v in pairs(player.GetAll()) do
                v:SendMessage("[ WARNING ]  Item Cleanup Inbound! Brace for Impact!")
            end

            for i, v in pairs(ents.FindByClass("lia_item")) do
                v:Remove()
            end
        end
    )

    timer.Create(
        "AutomaticMapCleanup",
        lia.config.MapCleanupTime,
        0,
        function()
            for i, v in pairs(player.GetAll()) do
                v:SendMessage("[ WARNING ]  Map Cleanup Inbound! Brace for Impact!")
            end

            for i, v in pairs(ents.GetAll()) do
                if table.HasValue(lia.config.MapCleanerEntitiesToRemove, v:GetClass()) then v:Remove() end
            end
        end
    )
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
