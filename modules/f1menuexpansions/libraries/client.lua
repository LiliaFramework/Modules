function MODULE:GenerateContentFromConfig(config)
    local body = "<h1>" .. config.title .. "</h1>"
    if config.introduction then body = body .. "<p>" .. config.introduction .. "</p>" end
    if config.rules then
        for _, rule in ipairs(config.rules) do
            body = body .. "<h2>" .. rule.title .. "</h2>"
            body = body .. "<p>" .. rule.content .. "</p>"
        end
    end

    if config.ingredients then
        body = body .. "<h2>Ingredients:</h2><ul>"
        for _, ingredient in ipairs(config.ingredients) do
            body = body .. "<li>" .. ingredient .. "</li>"
        end

        body = body .. "</ul>"
    end

    if config.tools then
        body = body .. "<h2>Tools:</h2><ul>"
        for _, tool in ipairs(config.tools) do
            body = body .. "<li>" .. tool .. "</li>"
        end

        body = body .. "</ul>"
    end

    if config.instructions then
        body = body .. "<h2>Instructions:</h2>"
        for _, instruction in ipairs(config.instructions) do
            body = body .. "<h3>" .. instruction.stepTitle .. "</h3>"
            body = body .. "<p>" .. instruction.stepContent .. "</p>"
        end
    end

    if config.conclusion and config.conclusion ~= "" then body = body .. "<p>" .. config.conclusion .. "</p>" end
    return body
end

function MODULE:BuildHelpMenu(tabs)
    if self.FAQEnabled then
        tabs["FAQ"] = function()
            local body = ""
            for title, text in SortedPairs(self.FAQQuestions) do
                body = body .. "<h2>" .. title .. "</h2>" .. text .. "<br /><br />"
            end
            return body
        end
    end

    if self.RulesEnabled then tabs["Rules"] = function() return self:GenerateContentFromConfig(self.RulesConfig) end end
    if self.TutorialEnabled then tabs["Tutorial"] = function() return self:GenerateContentFromConfig(self.TutorialConfig) end end
end