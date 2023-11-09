-------------------------------------------------------------------------------------------
ITEM.name = "Drug Lab"
-------------------------------------------------------------------------------------------
ITEM.model = "models/props_wasteland/laundry_basket002.mdl"
-------------------------------------------------------------------------------------------
ITEM.desc = "A complex drug lab with all the tools required to process drugs."
-------------------------------------------------------------------------------------------
ITEM.width = 2
-------------------------------------------------------------------------------------------
ITEM.height = 2
-------------------------------------------------------------------------------------------
ITEM.category = "Drugs"
-------------------------------------------------------------------------------------------
ITEM.color = Color(255, 255, 255)
-------------------------------------------------------------------------------------------
ITEM.functions.Weed = {
    name = "Process Weed",
    icon = "icon16/cog.png",
    sound = "buttons/lightswitch2.wav",
    onRun = function(item)
        local client = item.player
        local inventory = client:getChar():getInv()
        if not IsValid(item.entity) then
            client:notify("The drug lab must be on the ground")

            return false
        end

        local requirement = inventory:getFirstItemOfType("unprocessedweed")
        if not requirement then
            client:notify("You need Unprocessed Weed!")

            return false
        end

        requirement:remove()
        item:setData("producing2", CurTime())
        client:notify("The drug is cooking.")
        timer.Simple(
            30 * 10,
            function()
                if item then
                    item:setData("producing2", nil)
                    client:notify("The Weed is Ready!")
                    timer.Create(
                        item.uniqueID .. "_druglab_" .. client:SteamID(),
                        1,
                        10,
                        function()
                            if not inventory:add("weed") then
                                lia.item.spawn("weed", item:getEntity():GetPos() + item:getEntity():GetUp() * 50)
                                client:notify("You lack space in your inventory! Dropping weed on the ground!")
                            end
                        end
                    )
                end
            end
        )

        return false
    end,
    onCanRun = function(item)
        if item:getData("producing2") ~= nil then
            local endTime = item:getData("producing2", 0) + 60 * 10
            if item:getData("producing2", 0) > CurTime() or CurTime() > endTime then return true end

            return false
        end

        return true
    end
}

-------------------------------------------------------------------------------------------
ITEM.functions.Heroin = {
    name = "Process Heroin",
    icon = "icon16/cog.png",
    sound = "buttons/lightswitch2.wav",
    onRun = function(item)
        local client = item.player
        local inventory = client:getChar():getInv()
        if not IsValid(item.entity) then
            client:notify("The drug lab must be on the ground")

            return false
        end

        local requirement = inventory:getFirstItemOfType("unprocessedheroin")
        if not requirement then
            client:notify("You need Unprocessed Heroin!")

            return false
        end

        requirement:remove()
        item:setData("producing2", CurTime())
        client:notify("The drug is cooking.")
        timer.Simple(
            30 * 10,
            function()
                if item then
                    item:setData("producing2", nil)
                    client:notify("The Heroin is Ready!")
                    timer.Create(
                        item.uniqueID .. "_druglab_" .. client:SteamID(),
                        1,
                        10,
                        function()
                            if not inventory:add("heroin") then
                                lia.item.spawn("heroin", item:getEntity():GetPos() + item:getEntity():GetUp() * 50)
                                client:notify("You lack space in your inventory! Dropping heroin on the ground!")
                            end
                        end
                    )
                end
            end
        )

        return false
    end,
    onCanRun = function(item)
        if item:getData("producing2") ~= nil then
            local endTime = item:getData("producing2", 0) + 60 * 10
            if item:getData("producing2", 0) > CurTime() or CurTime() > endTime then return true end

            return false
        end

        return true
    end
}

-------------------------------------------------------------------------------------------
ITEM.functions.Cocaine = {
    name = "Process Cocaine",
    icon = "icon16/cog.png",
    sound = "buttons/lightswitch2.wav",
    onRun = function(item)
        local client = item.player
        local inventory = client:getChar():getInv()
        if not IsValid(item.entity) then
            client:notify("The drug lab must be on the ground")

            return false
        end

        local requirement = inventory:getFirstItemOfType("unprocessedcocaine")
        if not requirement then
            client:notify("You need Unprocessed Cocaine!")

            return false
        end

        requirement:remove()
        item:setData("producing2", CurTime())
        client:notify("The drug is cooking.")
        timer.Simple(
            30 * 10,
            function()
                if item then
                    item:setData("producing2", nil)
                    client:notify("The Cocaine is Ready!")
                    timer.Create(
                        item.uniqueID .. "_druglab_" .. client:SteamID(),
                        1,
                        10,
                        function()
                            if not inventory:add("cocaine") then
                                lia.item.spawn("cocaine", item:getEntity():GetPos() + item:getEntity():GetUp() * 50)
                                client:notify("You lack space in your inventory! Dropping cocaine on the ground!")
                            end
                        end
                    )
                end
            end
        )

        return false
    end,
    onCanRun = function(item)
        if item:getData("producing2") ~= nil then
            local endTime = item:getData("producing2", 0) + 60 * 10
            if item:getData("producing2", 0) > CurTime() or CurTime() > endTime then return true end

            return false
        end

        return true
    end
}

-------------------------------------------------------------------------------------------
function ITEM:getDesc()
    local desc = self.desc
    if self:getData("producing2") ~= nil then
        desc = desc .. "\nIt is currently producing something."
    end

    return Format(desc)
end

-------------------------------------------------------------------------------------------
ITEM.functions.take.onCanRun = function(item) return IsValid(item.entity) and item:getData("producing2", 0) == 0 end
-------------------------------------------------------------------------------------------