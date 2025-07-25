﻿local MODULE = MODULE
function MODULE:SetupInventorySearch(client, target)
    local function searcherCanAccess(_, _, context)
        if context.client == client then return true end
    end

    target:getChar():getInv():addAccessRule(searcherCanAccess)
    target.liaSearchAccessRule = searcherCanAccess
    target:getChar():getInv():sync(client)
    target:getChar():getInv().isExternalInventory = true
end

function MODULE:RemoveInventorySearchPermissions(_, target)
    local rule = target.liaSearchAccessRule
    if rule then target:getChar():getInv():removeAccessRule(rule) end
end

function MODULE:searchPlayer(client, target)
    if IsValid(target:getNetVar("searcher")) or IsValid(client.liaSearchTarget) then
        client:notifyLocalized("alreadyBeingSearched")
        return false
    end

    if not target:getChar() or not target:getChar():getInv() then
        client:notifyLocalized("invalidPly")
        return false
    end

    self:SetupInventorySearch(client, target)
    net.Start("searchPly")
    net.WriteEntity(target)
    net.WriteUInt(target:getChar():getInv():getID(), 32)
    net.Send(client)
    client.liaSearchTarget = target
    target:setNetVar("searcher", client)
    return true
end

function MODULE:CanPlayerInteractItem(client)
    if IsValid(client:getNetVar("searcher")) then return false end
end

function MODULE:stopSearching(client)
    local target = client.liaSearchTarget
    if IsValid(target) and target:getNetVar("searcher") == client then
        MODULE:RemoveInventorySearchPermissions(client, target)
        target:setNetVar("searcher", nil)
        client.liaSearchTarget = nil
        net.Start("searchExit")
        net.Send(client)
    end
end

function MODULE:OnPlayerUnRestricted(client)
    local searcher = client:getNetVar("searcher")
    if IsValid(searcher) then self:stopSearching(searcher) end
end

local networkStrings = {"searchPly", "searchExit"}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
