lia.utilities = lia.utilities or {}
function lia.utilities.SpeedTest(func, n)
    local start = SysTime()
    for _ = 1, n do
        func()
    end
    return (SysTime() - start) / n
end

function lia.utilities.SerializeVector(vector)
    return util.TableToJSON({vector.x, vector.y, vector.z})
end

function lia.utilities.DeserializeVector(data)
    return Vector(unpack(util.JSONToTable(data)))
end

function lia.utilities.SerializeAngle(ang)
    return util.TableToJSON({ang.p, ang.y, ang.r})
end

function lia.utilities.DeserializeAngle(data)
    return Angle(unpack(util.JSONToTable(data)))
end

function dprint(...)
    print("[DEBUG]", ...)
end

function math.chance(chance)
    local rand = math.random(0, 100)
    if rand <= chance then return true end
    return false
end

function string.generateRandom(length)
    length = length or 16
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local randomString = {}
    for _ = 1, length do
        local rand = math.random(1, #chars)
        table.insert(randomString, chars:sub(rand, rand))
    end
    return table.concat(randomString)
end

function string.quote(str)
    local escapedStr = string.gsub(str, "\\", "\\\\")
    escapedStr = string.gsub(escapedStr, '"', '\\"')
    return '"' .. escapedStr .. '"'
end

function string.FirstToUpper(str)
    return str:gsub("^%l", string.upper)
end

function string.CommaNumber(amount)
    local formatted = tostring(amount)
    while true do
        local k
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return formatted
end

function string.Clean(str)
    return string.gsub(str, "[^\32-\127]", "")
end

function string.Gibberish(str, prob)
    local ret = ""
    for _, v in pairs(string.Explode("", str)) do
        if math.random(1, 100) < prob then
            v = ""
            for _ = 1, math.random(0, 2) do
                ret = ret .. table.Random({"#", "@", "&", "%", "$", "/", "<", ">", ";", "*", "*", "*", "*", "*", "*", "*", "*"})
            end
        end

        ret = ret .. v
    end
    return ret
end

local digitToString = {
    ["0"] = "zero",
    ["1"] = "one",
    ["2"] = "two",
    ["3"] = "three",
    ["4"] = "four",
    ["5"] = "five",
    ["6"] = "six",
    ["7"] = "seven",
    ["8"] = "eight",
    ["9"] = "nine"
}

function string.DigitToString(digit)
    return digitToString[tostring(digit)] or "invalid"
end

function table.Sum(tbl)
    local sum = 0
    for _, v in pairs(tbl) do
        if isnumber(v) then
            sum = sum + v
        elseif istable(v) then
            sum = sum + table.Sum(v)
        end
    end
    return sum
end

function table.Lookupify(tbl)
    local lookup = {}
    for _, v in pairs(tbl) do
        lookup[v] = true
    end
    return lookup
end

function table.MakeAssociative(tab)
    local ret = {}
    for _, v in pairs(tab) do
        ret[v] = true
    end
    return ret
end

function table.Unique(tab)
    return table.GetKeys(table.MakeAssociative(tab))
end

function table.FullCopy(tab)
    local res = {}
    for k, v in pairs(tab) do
        if istable(v) then
            res[k] = table.FullCopy(v)
        elseif isvector(v) then
            res[k] = Vector(v.x, v.y, v.z)
        elseif isangle(v) then
            res[k] = Angle(v.p, v.y, v.r)
        else
            res[k] = v
        end
    end
    return res
end

function table.Filter(tab, func)
    local c = 1
    for i = 1, #tab do
        if func(tab[i]) then
            tab[c] = tab[i]
            c = c + 1
        end
    end

    for i = c, #tab do
        tab[i] = nil
    end
    return tab
end

function table.FilterCopy(tab, func)
    local ret = {}
    for i = 1, #tab do
        if func(tab[i]) then ret[#ret + 1] = tab[i] end
    end
    return ret
end

function math.UnitsToInches(units)
    return units * 0.75
end

function math.UnitsToCentimeters(units)
    return math.UnitsToInches(units) * 2.54
end

function math.UnitsToMeters(units)
    return math.UnitsToInches(units) * 0.0254
end

function math.Bias(x, amount)
    local exp = 0
    if amount ~= -1 then exp = math.log(amount) * -1.4427 end
    return math.pow(x, exp)
end

function math.Gain(x, amount)
    if x < 0.5 then
        return 0.5 * math.Bias(2 * x, 1 - amount)
    else
        return 1 - 0.5 * math.Bias(2 - 2 * x, 1 - amount)
    end
end

function math.ApproachSpeed(start, dest, speed)
    return math.Approach(start, dest, math.abs(start - dest) / speed)
end

function math.ApproachVectorSpeed(start, dest, speed)
    return Vector(math.ApproachSpeed(start.x, dest.x, speed), math.ApproachSpeed(start.y, dest.y, speed), math.ApproachSpeed(start.z, dest.z, speed))
end

function math.ApproachAngleSpeed(start, dest, speed)
    return Angle(math.ApproachSpeed(start.p, dest.p, speed), math.ApproachSpeed(start.y, dest.y, speed), math.ApproachSpeed(start.r, dest.r, speed))
end

function math.InRange(val, min, max)
    return val >= min and val <= max
end

function math.ClampAngle(val, min, max)
    return Angle(math.Clamp(val.p, min.p, max.p), math.Clamp(val.y, min.y, max.y), math.Clamp(val.r, min.r, max.r))
end

function math.ClampedRemap(val, frommin, frommax, tomin, tomax)
    return math.Clamp(math.Remap(val, frommin, frommax, tomin, tomax), math.min(tomin, tomax), math.max(tomin, tomax))
end

--[[
    Function: lia.utilities.TimeUntil
 
    Description:
       Returns the time remaining until a specified future date/time, in a readable format.
 
    Parameters:
       strTime (string) — The time string in the format "HH:MM:SS - DD/MM/YYYY".
 
    Returns:
       (string) A human-readable duration until the specified time, or an error message if invalid.
 
    Realm:
       Shared
 
    Example Usage:
       print(lia.utilities.TimeUntil("14:30:00 - 28/03/2025"))
 ]]
function lia.utilities.TimeUntil(strTime)
    local pattern = "(%d+):(%d+):(%d+)%s*%-%s*(%d+)/(%d+)/(%d+)"
    local hour, minute, second, day, month, year = strTime:match(pattern)
    if not (hour and minute and second and day and month and year) then return "Invalid time format. Expected 'HH:MM:SS - DD/MM/YYYY'." end
    hour, minute, second, day, month, year = tonumber(hour), tonumber(minute), tonumber(second), tonumber(day), tonumber(month), tonumber(year)
    if hour < 0 or hour > 23 or minute < 0 or minute > 59 or second < 0 or second > 59 or day < 1 or day > 31 or month < 1 or month > 12 or year < 1970 then return "Invalid time values." end
    local inputTimestamp = os.time({
        year = year,
        month = month,
        day = day,
        hour = hour,
        min = minute,
        sec = second
    })

    local currentTimestamp = os.time()
    if inputTimestamp <= currentTimestamp then return "The specified time is in the past." end
    local diffSeconds = inputTimestamp - currentTimestamp
    local years = math.floor(diffSeconds / (365.25 * 24 * 3600))
    diffSeconds = diffSeconds % (365.25 * 24 * 3600)
    local months = math.floor(diffSeconds / (30.44 * 24 * 3600))
    diffSeconds = diffSeconds % (30.44 * 24 * 3600)
    local days = math.floor(diffSeconds / (24 * 3600))
    diffSeconds = diffSeconds % (24 * 3600)
    local hours = math.floor(diffSeconds / 3600)
    diffSeconds = diffSeconds % 3600
    local minutes = math.floor(diffSeconds / 60)
    local seconds = diffSeconds % 60
    return string.format("%d years, %d months, %d days, %d hours, %d minutes, %d seconds", years, months, days, hours, minutes, seconds)
end

--[[
    Function: lia.utilities.CurrentLocalTime
 
    Description:
       Returns the current local system time as a formatted string "HH:MM:SS - DD/MM/YYYY".
 
    Parameters:
       None
 
    Returns:
       (string) The formatted current local time.
 
    Realm:
       Shared
 
    Example Usage:
       print(lia.utilities.CurrentLocalTime())
 ]]
function lia.utilities.CurrentLocalTime()
    local now = os.time()
    local t = os.date("*t", now)
    return string.format("%02d:%02d:%02d - %02d/%02d/%04d", t.hour, t.min, t.sec, t.day, t.month, t.year)
end

--[[
    Function: lia.utilities.SecondsToDHMS
 
    Description:
       Converts a total number of seconds into days, hours, minutes, and seconds.
 
    Parameters:
       seconds (number) — The total number of seconds.
 
    Returns:
       (number, number, number, number) days, hours, minutes, and seconds.
 
    Realm:
       Shared
 
    Example Usage:
       local d, h, m, s = lia.utilities.SecondsToDHMS(98765)
       print(d, "days,", h, "hours,", m, "minutes,", s, "seconds")
 ]]
function lia.utilities.SecondsToDHMS(seconds)
    local days = math.floor(seconds / 86400)
    seconds = seconds % 86400
    local hours = math.floor(seconds / 3600)
    seconds = seconds % 3600
    local minutes = math.floor(seconds / 60)
    local secs = seconds % 60
    return days, hours, minutes, secs
end

--[[
    Function: lia.utilities.HMSToSeconds
 
    Description:
       Converts hours, minutes, and seconds to total seconds.
 
    Parameters:
       hour (number) — The hour component.
       minute (number) — The minute component.
       second (number) — The second component.
 
    Returns:
       (number) The total number of seconds.
 
    Realm:
       Shared
 
    Example Usage:
       local totalSeconds = lia.utilities.HMSToSeconds(2, 30, 15)
       print(totalSeconds) -- 9015
 ]]
function lia.utilities.HMSToSeconds(hour, minute, second)
    return hour * 3600 + minute * 60 + second
end

--[[
    Function: lia.utilities.FormatTimestamp
 
    Description:
       Formats an epoch timestamp into "HH:MM:SS - DD/MM/YYYY".
 
    Parameters:
       timestamp (number) — The epoch timestamp to format.
 
    Returns:
       (string) A formatted date/time string.
 
    Realm:
       Shared
 
    Example Usage:
       print(lia.utilities.FormatTimestamp(os.time()))
 ]]
function lia.utilities.FormatTimestamp(timestamp)
    local t = os.date("*t", timestamp)
    return string.format("%02d:%02d:%02d - %02d/%02d/%04d", t.hour, t.min, t.sec, t.day, t.month, t.year)
end

--[[
    Function: lia.utilities.WeekdayName
 
    Description:
       Returns the weekday name for a given date/time string in "HH:MM:SS - DD/MM/YYYY" format.
 
    Parameters:
       strTime (string) — The date/time string.
 
    Returns:
       (string) The weekday name, or "Invalid date" on error.
 
    Realm:
       Shared
 
    Example Usage:
       print(lia.utilities.WeekdayName("14:30:00 - 27/03/2025"))
 ]]
function lia.utilities.WeekdayName(strTime)
    local y, mo, d, h, mi, s = lia.utilities.ParseTime(strTime)
    if not y then return "Invalid date" end
    local t = os.time({
        year = y,
        month = mo,
        day = d,
        hour = h,
        min = mi,
        sec = s
    })
    return os.date("%A", t)
end

--[[
    Function: lia.utilities.TimeDifference
 
    Description:
       Calculates the difference in days between a specified target date/time (in "HH:MM:SS - DD/MM/YYYY" format) and the current date/time.
 
    Parameters:
       strTime (string) — The target date/time string.
 
    Returns:
       (number) The day difference as an integer, or nil if invalid.
 
    Realm:
       Shared
 
    Example Usage:
       print(lia.utilities.TimeDifference("14:30:00 - 30/03/2025"))
 ]]
function lia.utilities.TimeDifference(strTime)
    local pattern = "(%d+):(%d+):(%d+)%s*-%s*(%d+)/(%d+)/(%d+)"
    local hour, minute, second, day, month, year = strTime:match(pattern)
    if not (hour and minute and second and day and month and year) then return nil end
    hour, minute, second, day, month, year = tonumber(hour), tonumber(minute), tonumber(second), tonumber(day), tonumber(month), tonumber(year)
    local targetDate = os.time({
        year = year,
        month = month,
        day = day,
        hour = hour,
        min = minute,
        sec = second
    })

    local currentDate = os.time()
    local differenceInDays = math.floor(os.difftime(targetDate, currentDate) / (24 * 60 * 60))
    return differenceInDays
end

if SERVER then
    function lia.utilities.spawnProp(model, position, force, lifetime, angles, collision)
        local entity = ents.Create("prop_physics")
        entity:SetModel(model)
        entity:Spawn()
        entity:SetCollisionGroup(collision or COLLISION_GROUP_WEAPON)
        entity:SetAngles(angles or angle_zero)
        if type(position) == "Player" then position = position:GetItemDropPos(entity) end
        entity:SetPos(position)
        if force then
            local phys = entity:GetPhysicsObject()
            if IsValid(phys) then phys:ApplyForceCenter(force) end
        end

        if (lifetime or 0) > 0 then timer.Simple(lifetime, function() if IsValid(entity) then entity:Remove() end end) end
        return entity
    end

    function lia.utilities.spawnEntities(entityTable)
        for entity, position in pairs(entityTable) do
            if isvector(position) then
                local newEnt = ents.Create(entity)
                if IsValid(newEnt) then
                    newEnt:SetPos(position)
                    newEnt:Spawn()
                end
            else
                lia.information("Invalid position for entity", entity)
            end
        end
    end
end