lia.command.add("cards", {
    desc = L("cardsCommandDesc"),
    onRun = function(client)
        local inv = client:getChar():getInv()
        if not inv:hasItem("carddeck") then
            client:notify(L("noCardDeck"))
            return
        end

        local ranks = {L("rankAce"), L("rankTwo"), L("rankThree"), L("rankFour"), L("rankFive"), L("rankSix"), L("rankSeven"), L("rankEight"), L("rankNine"), L("rankTen"), L("rankJack"), L("rankQueen"), L("rankKing")}
        local suits = {L("suitSpades"), L("suitDiamonds"), L("suitHearts"), L("suitClubs")}
        local card = table.Random(ranks) .. " " .. table.Random(suits)
        lia.chat.send(client, "me", L("cardDrawAction") .. " " .. card)
    end
})
