--- Helper library for managing voice lines.
-- @library lia.voice
lia.voice = {}
lia.voice.list = {}
lia.voice.chatTypes = {}
lia.voice.checks = lia.voice.checks or {}
--- Defines a voice class with specific callbacks.
-- @realm shared
-- @string  class The class identifier.
-- @func onCheck Callback to determine if the client belongs to this class.
-- @func onModify Callback to modify voice sounds based on the class.
-- @bool global Whether the class applies globally.
function lia.voice.defineClass(class, onCheck, onModify, global)
    lia.voice.checks[class] = {
        class = class:lower(),
        onCheck = onCheck,
        onModify = onModify,
        isGlobal = global or false
    }
end

--- Retrieves definitions of voice classes applicable to a client.
-- @realm shared
-- @client client The client to check.
-- @treturn table An array of class definitions.
function lia.voice.getClass(client)
    local definitions = {}
    for _, v in pairs(lia.voice.checks) do
        if v.onCheck(client) then definitions[#definitions + 1] = v end
    end
    return definitions
end

--- Registers a voice line replacement for a specific class and key.
-- @realm shared
-- @string class The voice class identifier.
-- @string key The key for the voice line.
-- @string replacement The replacement text or sound file.
-- @param source The source of the replacement (can be a string or table of strings).
function lia.voice.register(class, key, replacement, source)
    class = class:lower()
    lia.voice.list[class] = lia.voice.list[class] or {}
    lia.voice.list[class][key:lower()] = {
        replacement = replacement,
        source = source
    }
end

--- Retrieves voice line replacements for a specific class and text.
-- @realm shared
-- @string class The voice class identifier.
-- @string text The text to match for replacements.
-- @tparam number delay Optional delay before each replacement.
-- @treturn table|nil An array of replacements or nil if none found.
-- @treturn string|nil The modified text after replacements or nil if none found.
function lia.voice.getVoiceList(class, text, delay)
    local info = lia.voice.list[class]
    if not info then return end
    local output = {}
    local original = string.Explode(" ", text)
    local exploded = string.Explode(" ", text:lower())
    local phrase = ""
    local skip = 0
    local current = 0
    local max = 5
    for k, v in ipairs(exploded) do
        if k < skip then continue end
        if current < max then
            local i = k
            local key = v
            local nextValue, nextKey
            while true do
                i = i + 1
                nextValue = exploded[i]
                if not nextValue then break end
                nextKey = key .. " " .. nextValue
                if not info[nextKey] then
                    i = i + 1
                    local nextValue2 = exploded[i]
                    local nextKey2 = nextKey .. " " .. (nextValue2 or "")
                    if not nextValue2 or not info[nextKey2] then
                        i = i - 1
                        break
                    end

                    nextKey = nextKey2
                end

                key = nextKey
            end

            if info[key] then
                local source = info[key].source
                if type(source) == "table" then
                    source = table.Random(source)
                else
                    source = tostring(source)
                end

                output[#output + 1] = {source, delay or 0.1}
                phrase = phrase .. info[key].replacement .. " "
                skip = i
                current = current + 1
                continue
            else
                return nil
            end
        end

        phrase = phrase .. original[k] .. " "
    end

    if phrase:sub(#phrase, #phrase) == " " then phrase = phrase:sub(1, -2) end
    return #output > 0 and output or nil, phrase
end

lia.voice.defineClass("combine", function(client) return client:isCombine() end, function(client, sounds, chatType)
    if chatType == "dispatch" or client:isCombineRank("SCN") then return false end
    local beeps = SCHEMA.beepSounds[client:Team()] or SCHEMA.beepSounds[FACTION_CP]
    table.insert(sounds, 1, {table.Random(beeps.on), 0.25})
    sounds[#sounds + 1] = {table.Random(beeps.off), nil, 0.25}
end)

lia.voice.defineClass("dispatch", function(client) return SCHEMA:isDispatch(client) end, function(_, _, chatType) if chatType ~= "dispatch" then return false end end, true)