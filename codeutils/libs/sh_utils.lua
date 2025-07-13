lia.utilities = lia.utilities or {}
--[[
lia.utilities.SpeedTest
Description:
    Measures the average execution time (in seconds) of a function over n runs.
Parameters:
    func (function) — The function to test.
    n    (number)   — Number of times to run func.
Returns:
    (number) Average time per call in seconds.
Realm:
    Shared
Example Usage:
    print(lia.utilities.SpeedTest(function() return math.sqrt(2) end, 1000))
]]
function lia.utilities.SpeedTest(func, n)
    local start = SysTime()
    for _ = 1, n do
        func()
    end
    return (SysTime() - start) / n
end

local function normalize(min, max, val)
    local delta = max - min
    return (val - min) / delta
end

--[[
lia.utilities.DaysBetween
Description:
    Calculates the number of whole days between two date/time strings.
Parameters:
    strTime1 (string) — First date/time, format "HH:MM:SS - DD/MM/YYYY".
    strTime2 (string) — Second date/time, same format.
Returns:
    (number|string) Number of days difference, or "Invalid dates" on error.
Realm:
    Shared
Example Usage:
    print(lia.utilities.DaysBetween("00:00:00 - 01/01/2025", "00:00:00 - 10/01/2025"))
]]
function lia.utilities.DaysBetween(strTime1, strTime2)
    local y1, mo1, d1 = lia.utilities.ParseTime(strTime1)
    local y2, mo2, d2 = lia.utilities.ParseTime(strTime2)
    if not (y1 and y2) then return L("invalidDates") end
    local t1 = os.time({
        year = y1,
        month = mo1,
        day = d1,
        hour = 0,
        min = 0,
        sec = 0
    })

    local t2 = os.time({
        year = y2,
        month = mo2,
        day = d2,
        hour = 0,
        min = 0,
        sec = 0
    })

    local diff = os.difftime(t2, t1)
    return math.floor(diff / 86400)
end

--[[
lia.utilities.LerpHSV
Description:
    Interpolates between two colors in HSV space based on where currentValue lies within [minValue, maxValue].
Parameters:
    start_color  (Color)  — Color at minValue (defaults to green).
    end_color    (Color)  — Color at maxValue (defaults to red).
    maxValue     (number) — Upper bound of the range.
    currentValue (number) — Value within the range to interpolate for.
    minValue     (number) — Lower bound of the range (defaults to 0).
Returns:
    (Color) Interpolated HSV color converted back to RGB.
Realm:
    Shared
Example Usage:
    local c = lia.utilities.LerpHSV(nil, nil, 100, 50)
]]
function lia.utilities.LerpHSV(start_color, end_color, maxValue, currentValue, minValue)
    start_color = start_color or Color("green")
    end_color = end_color or Color("red")
    minValue = minValue or 0
    local hsv_start = ColorToHSV(start_color)
    local hsv_end = ColorToHSV(end_color)
    local t = normalize(minValue, maxValue, currentValue)
    local linear = Lerp(t, hsv_start, hsv_end)
    return HSVToColor(linear, 1, 1)
end

--[[
lia.utilities.Darken
Description:
    Darkens a color by decreasing its lightness in HSL space.
Parameters:
    color  (Color) — Original color.
    amount (number) — Amount to subtract from lightness (0–1).
Returns:
    (Color) Darkened color.
Realm:
    Shared
Example Usage:
    local c2 = lia.utilities.Darken(Color(200,200,200), 0.1)
]]
function lia.utilities.Darken(color, amount)
    local h, s, l = ColorToHSL(color)
    l = math.Clamp(l / 255 - amount, 0, 1)
    return HSLToColor(h, s, l)
end

--[[
lia.utilities.LerpColor
Description:
    Linearly interpolates between two RGBA colors.
Parameters:
    frac (number) — Interpolation factor (0–1).
    from (Color) — Start color.
    to   (Color) — End color.
Returns:
    (Color) Resulting color.
Realm:
    Shared
Example Usage:
    local c = lia.utilities.LerpColor(0.5, Color(255,0,0), Color(0,0,255))
]]
function lia.utilities.LerpColor(frac, from, to)
    return Color(Lerp(frac, from.r, to.r), Lerp(frac, from.g, to.g), Lerp(frac, from.b, to.b), Lerp(frac, from.a, to.a))
end

--[[
lia.utilities.Blend
Description:
    Blends two RGB colors by a given ratio.
Parameters:
    color1 (Color) — First color.
    color2 (Color) — Second color.
    ratio  (number) — Blend ratio (0→all color1, 1→all color2).
Returns:
    (Color) Blended color.
Realm:
    Shared
Example Usage:
    local c = lia.utilities.Blend(Color(255,0,0), Color(0,0,255), 0.3)
]]
function lia.utilities.Blend(color1, color2, ratio)
    ratio = math.Clamp(ratio, 0, 1)
    return Color(Lerp(ratio, color1.r, color2.r), Lerp(ratio, color1.g, color2.g), Lerp(ratio, color1.b, color2.b))
end

--[[
lia.utilities.rgb
Description:
    Creates a Color from integer RGB 0–255.
Parameters:
    r (number) — Red component.
    g (number) — Green component.
    b (number) — Blue component.
Returns:
    (Color) New color.
Realm:
    Shared
Example Usage:
    local c = lia.utilities.rgb(128,64,255)
]]
function lia.utilities.rgb(r, g, b)
    return Color(r / 255, g / 255, b / 255)
end

--[[
lia.utilities.Rainbow
Description:
    Generates a cycling rainbow color over time.
Parameters:
    frequency (number) — Speed of hue rotation.
Returns:
    (Color) Rainbow color.
Realm:
    Shared
Example Usage:
    local c = lia.utilities.Rainbow(0.5)
]]
function lia.utilities.Rainbow(frequency)
    return HSVToColor((CurTime() * frequency) % 360, 1, 1)
end

--[[
lia.utilities.ColorCycle
Description:
    Cyclically blends between two colors using a sine wave.
Parameters:
    col1 (Color) — First color.
    col2 (Color) — Second color.
    freq (number) — Cycle frequency.
Returns:
    (Color) Cycling color.
Realm:
    Shared
Example Usage:
    local c = lia.utilities.ColorCycle(Color(255,0,0), Color(0,0,255), 1)
]]
function lia.utilities.ColorCycle(col1, col2, freq)
    freq = freq or 1
    local diff = Color(col1.r - col2.r, col1.g - col2.g, col1.b - col2.b)
    local t = CurTime()
    return Color(math.min(col1.r, col2.r) + math.abs(math.sin(t * freq) * diff.r), math.min(col1.g, col2.g) + math.abs(math.sin(t * freq + 2) * diff.g), math.min(col1.b, col2.b) + math.abs(math.sin(t * freq + 4) * diff.b))
end

--[[
lia.utilities.ColorToHex
Description:
    Converts a Color to a hex string.
Parameters:
    color (Color) — Color to convert.
Returns:
    (string) Hex representation like "0xFFA07A".
Realm:
    Shared
Example Usage:
    local h = lia.utilities.ColorToHex(Color(255,160,122))
]]
function lia.utilities.ColorToHex(color)
    return "0x" .. bit.tohex(color.r, 2) .. bit.tohex(color.g, 2) .. bit.tohex(color.b, 2)
end

--[[
lia.utilities.Lighten
Description:
    Lightens a color by increasing its HSL lightness.
Parameters:
    color  (Color) — Original color.
    amount (number) — Amount to add to lightness (0–1).
Returns:
    (Color) Lightened color.
Realm:
    Shared
Example Usage:
    local c = lia.utilities.Lighten(Color(50,50,50), 0.2)
]]
function lia.utilities.Lighten(color, amount)
    local h, s, l = ColorToHSL(color)
    l = math.Clamp(l / 255 + amount, 0, 1)
    return HSLToColor(h, s, l)
end

--[[
lia.utilities.toText
Description:
    Serializes a Color to "r,g,b,a".
Parameters:
    color (Color) — Color object.
Returns:
    (string) Comma-separated RGBA.
Realm:
    Shared
Example Usage:
    local s = lia.utilities.toText(Color(255,255,255,128))
]]
function lia.utilities.toText(color)
    if not IsColor(color) then return end
    return (color.r or 255) .. "," .. (color.g or 255) .. "," .. (color.b or 255) .. "," .. (color.a or 255)
end

--[[
lia.utilities.SerializeVector
Description:
    Converts a Vector to a JSON array string.
Parameters:
    vector (Vector) — Vector to serialize.
Returns:
    (string) JSON like "[x,y,z]".
Realm:
    Server
Example Usage:
    local j = lia.utilities.SerializeVector(Vector(1,2,3))
]]
function lia.utilities.SerializeVector(vector)
    return util.TableToJSON({vector.x, vector.y, vector.z})
end

--[[
lia.utilities.DeserializeVector
Description:
    Parses a JSON array string into a Vector.
Parameters:
    data (string) — JSON array "[x,y,z]".
Returns:
    (Vector) New vector.
Realm:
    Server
Example Usage:
    local v = lia.utilities.DeserializeVector('[1,2,3]')
]]
function lia.utilities.DeserializeVector(data)
    return Vector(unpack(util.JSONToTable(data)))
end

--[[
lia.utilities.SerializeAngle
Description:
    Converts an Angle to a JSON array string.
Parameters:
    ang (Angle) — Angle to serialize.
Returns:
    (string) JSON like "[p,y,r]".
Realm:
    Server
Example Usage:
    local j = lia.utilities.SerializeAngle(Angle(10,20,30))
]]
function lia.utilities.SerializeAngle(ang)
    return util.TableToJSON({ang.p, ang.y, ang.r})
end

--[[
lia.utilities.DeserializeAngle
Description:
    Parses a JSON array string into an Angle.
Parameters:
    data (string) — JSON array "[p,y,r]".
Returns:
    (Angle) New angle.
Realm:
    Server
Example Usage:
    local a = lia.utilities.DeserializeAngle('[10,20,30]')
]]
function lia.utilities.DeserializeAngle(data)
    return Angle(unpack(util.JSONToTable(data)))
end

--[[
lia.utilities.dprint
Description:
    Prints debug messages prefixed with "[DEBUG]".
Parameters:
    ... — Values to print.
Returns:
    nil
Realm:
    Server
Example Usage:
    lia.utilities.dprint("Value is", x)
]]
function lia.utilities.dprint(...)
    print("[DEBUG]", ...)
end

-- chance helper added to math
--[[
math.chance
Description:
    Returns true with given percent probability.
Parameters:
    chance (number) — 0–100 percent.
Returns:
    (boolean)
Realm:
    Server
Example Usage:
    if math.chance(25) then print("25% chance") end
]]
function math.chance(chance)
    return math.random(0, 100) <= chance
end

--[[
string.generateRandom
Description:
    Generates a random alphanumeric string.
Parameters:
    length (number) — Desired length (default 16).
Returns:
    (string)
Realm:
    Server
Example Usage:
    local s = string.generateRandom(8)
]]
function string.generateRandom(length)
    length = length or 16
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local ret = {}
    for _ = 1, length do
        ret[#ret + 1] = chars:sub(math.random(#chars), math.random(#chars))
    end
    return table.concat(ret)
end

--[[
string.quote
Description:
    Returns a Lua-quoted version of a string, escaping backslashes and quotes.
Parameters:
    str (string)
Returns:
    (string)
Realm:
    Server
Example Usage:
    local q = string.quote('He said "Hi"')
]]
function string.quote(str)
    local escaped = str:gsub("\\", "\\\\"):gsub('"', '\\"')
    return '"' .. escaped .. '"'
end

--[[
string.FirstToUpper
Description:
    Capitalizes the first letter of a string.
Parameters:
    str (string)
Returns:
    (string)
Realm:
    Server
Example Usage:
    print(string.FirstToUpper("hello"))
]]
function string.FirstToUpper(str)
    return str:gsub("^%l", string.upper)
end

--[[
string.CommaNumber
Description:
    Formats a number with commas every three digits.
Parameters:
    amount (number|string)
Returns:
    (string)
Realm:
    Server
Example Usage:
    print(string.CommaNumber(1234567)) -- "1,234,567"
]]
function string.CommaNumber(amount)
    local formatted = tostring(amount)
    while true do
        formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return formatted
end

--[[
string.Clean
Description:
    Removes non-printable ASCII characters.
Parameters:
    str (string)
Returns:
    (string)
Realm:
    Server
Example Usage:
    print(string.Clean("Hello\x01World"))
]]
function string.Clean(str)
    return str:gsub("[^\32-\127]", "")
end

--[[
string.Gibberish
Description:
    Randomly injects gibberish chars into a string.
Parameters:
    str  (string)
    prob (number) — 0–100 percent chance per character.
Returns:
    (string)
Realm:
    Server
Example Usage:
    print(string.Gibberish("test", 20))
]]
function string.Gibberish(str, prob)
    local ret = ""
    for c in str:gmatch(".") do
        if math.random(1, 100) < prob then
            for _ = 1, math.random(0, 2) do
                ret = ret .. table.Random{"#", "@", "&", "%", "$", "/", "<", ">", ";", "*"}
            end
        end

        ret = ret .. c
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

--[[
string.DigitToString
Description:
    Converts a single digit (0–9) to its English word.
Parameters:
    digit (string|number)
Returns:
    (string) e.g. "five" or "invalid"
Realm:
    Server
Example Usage:
    print(string.DigitToString(7))
]]
function string.DigitToString(digit)
    return digitToString[tostring(digit)] or "invalid"
end

--[[
table.Sum
Description:
    Recursively sums all numeric values in a table.
Parameters:
    tbl (table)
Returns:
    (number)
Realm:
    Server
Example Usage:
    print(table.Sum({1,2,{3,4}})) -- 10
]]
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

--[[
table.Lookupify
Description:
    Converts an array of values into a lookup table (value→true).
Parameters:
    tbl (table) — Array
Returns:
    (table)
Realm:
    Server
Example Usage:
    local l = table.Lookupify({"a","b"})
]]
function table.Lookupify(tbl)
    local lookup = {}
    for _, v in pairs(tbl) do
        lookup[v] = true
    end
    return lookup
end

--[[
table.MakeAssociative
Description:
    Alias of table.Lookupify.
Parameters:
    tab (table)
Returns:
    (table)
Realm:
    Server
Example Usage:
    local a = table.MakeAssociative({1,2,3})
]]
function table.MakeAssociative(tab)
    local ret = {}
    for _, v in pairs(tab) do
        ret[v] = true
    end
    return ret
end

--[[
table.Unique
Description:
    Returns the unique values of an array.
Parameters:
    tab (table)
Returns:
    (table) Array of unique entries.
Realm:
    Server
Example Usage:
    print(unpack(table.Unique({1,2,2,3}))) -- 1,2,3
]]
function table.Unique(tab)
    return table.GetKeys(table.MakeAssociative(tab))
end

--[[
table.FullCopy
Description:
    Deep-copies a table, including vectors and angles.
Parameters:
    tab (table)
Returns:
    (table)
Realm:
    Server
Example Usage:
    local c = table.FullCopy({a=1,b={2}})
]]
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

--[[
table.Filter
Description:
    In-place filters an array by a predicate.
Parameters:
    tab  (table)   — Array.
    func (function) — Returns truthy to keep element.
Returns:
    (table) Filtered array.
Realm:
    Server
Example Usage:
    lia.utilities.Filter({1,2,3}, function(x) return x>1 end) -- {2,3}
]]
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

--[[
table.FilterCopy
Description:
    Returns a new array of elements passing a predicate.
Parameters:
    tab  (table)
    func (function)
Returns:
    (table)
Realm:
    Server
Example Usage:
    local f = table.FilterCopy({1,2,3}, function(x) return x<3 end) -- {1,2}
]]
function table.FilterCopy(tab, func)
    local ret = {}
    for i = 1, #tab do
        if func(tab[i]) then ret[#ret + 1] = tab[i] end
    end
    return ret
end

--[[
math.UnitsToInches
Description:
    Converts game units to inches.
Parameters:
    units (number)
Returns:
    (number)
Realm:
    Server
Example Usage:
    print(math.UnitsToInches(64))
]]
function math.UnitsToInches(units)
    return units * 0.75
end

--[[
math.UnitsToCentimeters
Description:
    Converts game units to centimeters.
Parameters:
    units (number)
Returns:
    (number)
Realm:
    Server
Example Usage:
    print(math.UnitsToCentimeters(64))
]]
function math.UnitsToCentimeters(units)
    return math.UnitsToInches(units) * 2.54
end

--[[
math.UnitsToMeters
Description:
    Converts game units to meters.
Parameters:
    units (number)
Returns:
    (number)
Realm:
    Server
Example Usage:
    print(math.UnitsToMeters(64))
]]
function math.UnitsToMeters(units)
    return math.UnitsToInches(units) * 0.0254
end

--[[
math.Bias
Description:
    Applies a bias curve to x.
Parameters:
    x      (number)
    amount (number) — Bias amount ≠ -1.
Returns:
    (number)
Realm:
    Server
Example Usage:
    print(math.Bias(0.3, 2))
]]
function math.Bias(x, amount)
    local exp = amount ~= -1 and math.log(amount) * -1.4427 or 0
    return math.pow(x, exp)
end

--[[
math.Gain
Description:
    Applies a gain curve to x.
Parameters:
    x      (number)
    amount (number)
Returns:
    (number)
Realm:
    Server
Example Usage:
    print(math.Gain(0.6, 0.5))
]]
function math.Gain(x, amount)
    if x < 0.5 then
        return 0.5 * math.Bias(2 * x, 1 - amount)
    else
        return 1 - 0.5 * math.Bias(2 - 2 * x, 1 - amount)
    end
end

--[[
math.ApproachSpeed
Description:
    Moves start towards dest by distance proportionally to speed.
Parameters:
    start (number)
    dest  (number)
    speed (number)
Returns:
    (number)
Realm:
    Server
Example Usage:
    print(math.ApproachSpeed(0,10,5))
]]
function math.ApproachSpeed(start, dest, speed)
    return math.Approach(start, dest, math.abs(start - dest) / speed)
end

--[[
math.ApproachVectorSpeed
Description:
    Vector version of ApproachSpeed.
Parameters:
    start (Vector)
    dest  (Vector)
    speed (number)
Returns:
    (Vector)
Realm:
    Server
Example Usage:
    local v = math.ApproachVectorSpeed(Vector(0,0,0), Vector(10,0,0), 5)
]]
function math.ApproachVectorSpeed(start, dest, speed)
    local function ap(a, b)
        return math.ApproachSpeed(a, b, speed)
    end
    return Vector(ap(start.x, dest.x), ap(start.y, dest.y), ap(start.z, dest.z))
end

--[[
math.ApproachAngleSpeed
Description:
    Angle version of ApproachSpeed.
Parameters:
    start (Angle)
    dest  (Angle)
    speed (number)
Returns:
    (Angle)
Realm:
    Server
Example Usage:
    local a = math.ApproachAngleSpeed(Angle(0,0,0), Angle(90,0,0), 5)
]]
function math.ApproachAngleSpeed(start, dest, speed)
    local function ap(a, b)
        return math.ApproachSpeed(a, b, speed)
    end
    return Angle(ap(start.p, dest.p), ap(start.y, dest.y), ap(start.r, dest.r))
end

--[[
math.InRange
Description:
    Checks if val ∈ [min, max].
Parameters:
    val (number)
    min (number)
    max (number)
Returns:
    (boolean)
Realm:
    Server
Example Usage:
    print(math.InRange(5,1,10)) -- true
]]
function math.InRange(val, min, max)
    return val >= min and val <= max
end

--[[
math.ClampAngle
Description:
    Clamps each component of an Angle between min and max Angles.
Parameters:
    val (Angle)
    min (Angle)
    max (Angle)
Returns:
    (Angle)
Realm:
    Server
Example Usage:
    local a = math.ClampAngle(Angle(100,0,0), Angle(0,0,0), Angle(90,90,90))
]]
function math.ClampAngle(val, min, max)
    return Angle(math.Clamp(val.p, min.p, max.p), math.Clamp(val.y, min.y, max.y), math.Clamp(val.r, min.r, max.r))
end

--[[
math.ClampedRemap
Description:
    Remaps val from [fmin,fmax]→[tmin,tmax], then clamps to [min(tmin,tmax),max(tmin,tmax)].
Parameters:
    val  (number)
    fmin (number)
    fmax (number)
    tmin (number)
    tmax (number)
Returns:
    (number)
Realm:
    Server
Example Usage:
    print(math.ClampedRemap(5,0,10,100,200)) -- 150
]]
function math.ClampedRemap(val, fmin, fmax, tmin, tmax)
    return math.Clamp(math.Remap(val, fmin, fmax, tmin, tmax), math.min(tmin, tmax), math.max(tmin, tmax))
end

--[[
lia.utilities.TimeUntil
Description:
    Computes human-readable time remaining until a future timestamp.
Parameters:
    strTime (string) — "HH:MM:SS - DD/MM/YYYY".
Returns:
    (string) e.g. "0 years, 2 months, 3 days, 4 hours, 5 minutes, 6 seconds", or error.
Realm:
    Shared
Example Usage:
    print(lia.utilities.TimeUntil("14:30:00 - 28/03/2025"))
]]
function lia.utilities.TimeUntil(strTime)
    local pat = "(%d+):(%d+):(%d+)%s*%-%s*(%d+)/(%d+)/(%d+)"
    local h, m, s, d, mo, y = strTime:match(pat)
    if not (h and m and s and d and mo and y) then return L("invalidTimeFormat") end
    h, m, s = tonumber(h), tonumber(m), tonumber(s)
    d, mo, y = tonumber(d), tonumber(mo), tonumber(y)
    if h > 23 or m > 59 or s > 59 or d < 1 or d > 31 or mo < 1 or mo > 12 or y < 1970 then return L("invalidTimeValues") end
    local inputTs = os.time{
        year = y,
        month = mo,
        day = d,
        hour = h,
        min = m,
        sec = s
    }

    local currTs = os.time()
    if inputTs <= currTs then return L("timeIsPast") end
    local diff = inputTs - currTs
    local yrs = math.floor(diff / (365.25 * 24 * 3600))
    diff = diff % (365.25 * 24 * 3600)
    local mos = math.floor(diff / (30.44 * 24 * 3600))
    diff = diff % (30.44 * 24 * 3600)
    local days = math.floor(diff / 86400)
    diff = diff % 86400
    local hrs = math.floor(diff / 3600)
    diff = diff % 3600
    local mins = math.floor(diff / 60)
    local secs = diff % 60
    return string.format("%d years, %d months, %d days, %d hours, %d minutes, %d seconds", yrs, mos, days, hrs, mins, secs)
end

--[[
lia.utilities.CurrentLocalTime
Description:
    Returns current local time formatted as "HH:MM:SS - DD/MM/YYYY".
Returns:
    (string)
Realm:
    Shared
Example Usage:
    print(lia.utilities.CurrentLocalTime())
]]
function lia.utilities.CurrentLocalTime()
    local t = os.date("*t", os.time())
    return string.format("%02d:%02d:%02d - %02d/%02d/%04d", t.hour, t.min, t.sec, t.day, t.month, t.year)
end

--[[
lia.utilities.SecondsToDHMS
Description:
    Converts total seconds to days, hours, minutes, seconds.
Parameters:
    seconds (number)
Returns:
    (number,number,number,number) days, hours, minutes, seconds
Realm:
    Shared
Example Usage:
    local d,h,m,s = lia.utilities.SecondsToDHMS(98765)
]]
function lia.utilities.SecondsToDHMS(seconds)
    local days = math.floor(seconds / 86400)
    seconds = seconds % 86400
    local hours = math.floor(seconds / 3600)
    seconds = seconds % 3600
    local minutes = math.floor(seconds / 60)
    return days, hours, minutes, seconds % 60
end

--[[
lia.utilities.HMSToSeconds
Description:
    Converts hours, minutes, seconds to total seconds.
Parameters:
    hour   (number)
    minute (number)
    second (number)
Returns:
    (number)
Realm:
    Shared
Example Usage:
    print(lia.utilities.HMSToSeconds(2,30,15)) -- 9015
]]
function lia.utilities.HMSToSeconds(hour, minute, second)
    return hour * 3600 + minute * 60 + second
end

--[[
lia.utilities.FormatTimestamp
Description:
    Formats an epoch timestamp as "HH:MM:SS - DD/MM/YYYY".
Parameters:
    timestamp (number)
Returns:
    (string)
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
lia.utilities.WeekdayName
Description:
    Returns the weekday for a given date/time string.
Parameters:
    strTime (string) — "HH:MM:SS - DD/MM/YYYY".
Returns:
    (string) Weekday name or "Invalid date".
Realm:
    Shared
Example Usage:
    print(lia.utilities.WeekdayName("14:30:00 - 27/03/2025"))
]]
function lia.utilities.WeekdayName(strTime)
    local pat = "(%d+):(%d+):(%d+)%s*-%s*(%d+)/(%d+)/(%d+)"
    local h, m, s, d, mo, y = strTime:match(pat)
    if not h then return L("invalidDate") end
    local ts = os.time{
        year = y,
        month = mo,
        day = d,
        hour = tonumber(h),
        min = tonumber(m),
        sec = tonumber(s)
    }
    return os.date("%A", ts)
end

--[[
lia.utilities.TimeDifference
Description:
    Day difference between target datetime and now.
Parameters:
    strTime (string) — "HH:MM:SS - DD/MM/YYYY".
Returns:
    (number|nil) Days difference, or nil if invalid.
Realm:
    Shared
Example Usage:
    print(lia.utilities.TimeDifference("14:30:00 - 30/03/2025"))
]]
function lia.utilities.TimeDifference(strTime)
    local pat = "(%d+):(%d+):(%d+)%s*-%s*(%d+)/(%d+)/(%d+)"
    local h, m, s, d, mo, y = strTime:match(pat)
    if not (h and m and s and d and mo and y) then return end
    local target = os.time{
        year = tonumber(y),
        month = tonumber(mo),
        day = tonumber(d),
        hour = tonumber(h),
        min = tonumber(m),
        sec = tonumber(s)
    }
    return math.floor(os.difftime(target, os.time()) / 86400)
end

--[[
lia.utilities.spawnProp
Description:
    Spawns a physics prop with options.
Parameters:
    model     (string)
    position  (Vector|Player)
    force     (Vector|nil)
    lifetime  (number|nil)
    angles    (Angle|nil)
    collision (number|nil)
Returns:
    (Entity) The spawned prop.
Realm:
    Server
Example Usage:
    lia.utilities.spawnProp("models/props_c17/oildrum001.mdl", Vector(0,0,0), Vector(0,0,1000), 10)
]]
function lia.utilities.spawnProp(model, position, force, lifetime, angles, collision)
    if not SERVER then return end
    local ent = ents.Create("prop_physics")
    ent:SetModel(model)
    ent:Spawn()
    ent:SetCollisionGroup(collision or COLLISION_GROUP_WEAPON)
    ent:SetAngles(angles or angle_zero)
    if type(position) == "Player" then position = position:GetItemDropPos(ent) end
    ent:SetPos(position)
    if force then
        local phys = ent:GetPhysicsObject()
        if IsValid(phys) then phys:ApplyForceCenter(force) end
    end

    if (lifetime or 0) > 0 then timer.Simple(lifetime, function() if IsValid(ent) then ent:Remove() end end) end
    return ent
end

--[[
lia.utilities.spawnEntities
Description:
    Spawns multiple entities at given positions.
Parameters:
    entityTable (table) — Keys=class names, Values=Vector positions.
Returns:
    nil
Realm:
    Server
Example Usage:
    lia.utilities.spawnEntities({["npc_zombie"]=Vector(0,0,0)})
]]
function lia.utilities.spawnEntities(entityTable)
    if not SERVER then return end
    for class, pos in pairs(entityTable) do
        if isvector(pos) then
            local e = ents.Create(class)
            if IsValid(e) then
                e:SetPos(pos)
                e:Spawn()
            end
        else
            lia.information(L("invalidEntityPosition"), class)
        end
    end
end

if SERVER then
    local networkStrings = {"OpenPage", "OpenVGUI"}
    for _, netString in ipairs(networkStrings) do
        util.AddNetworkString(netString)
    end
end
