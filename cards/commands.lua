lia.command.add("cards", {
    desc = "cardsCommandDesc",
    onRun = function(client)
        local inv = client:getChar():getInv()
        if not inv:hasItem("carddeck") then
            client:notify("You don't have a deck of cards.")
            return
        end

        local ranks = {"Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"}
        local suits = {"of Spades", "of Diamonds", "of Hearts", "of Clubs"}
        local card = table.Random(ranks) .. " " .. table.Random(suits)
        lia.chat.send(client, "me", "draws" .. " " .. card)
    end
})
