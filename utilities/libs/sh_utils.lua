lia.utilities = lia.utilities or {}
local function normalize(minVal, maxVal, val)
    return (val - minVal) / (maxVal - minVal)
end

function lia.utilities.SpeedTest(func, n)
    local start = SysTime()
    for _ = 1, n do
        func()
    end
    return (SysTime() - start) / n
end

function lia.utilities.DaysBetween(t1, t2)
    local y1, mo1, d1 = lia.utilities.ParseTime(t1)
    local y2, mo2, d2 = lia.utilities.ParseTime(t2)
    if not y1 or not y2 then return L("invalidDates") end
    local ts1 = os.time({
        year = y1,
        month = mo1,
        day = d1
    })

    local ts2 = os.time({
        year = y2,
        month = mo2,
        day = d2
    })
    return math.floor(os.difftime(ts2, ts1) / 86400)
end

function lia.utilities.LerpHSV(c1, c2, maxVal, curVal, minVal)
    c1 = c1 or Color(0, 255, 0)
    c2 = c2 or Color(255, 0, 0)
    minVal = minVal or 0
    local h1, s1, v1 = ColorToHSV(c1)
    local h2, s2, v2 = ColorToHSV(c2)
    local t = math.Clamp(normalize(minVal, maxVal, curVal), 0, 1)
    return HSVToColor(Lerp(t, h1, h2), Lerp(t, s1, s2), Lerp(t, v1, v2))
end

function lia.utilities.Darken(col, amt)
    local h, s, l = ColorToHSL(col)
    l = math.Clamp(l / 255 - amt, 0, 1)
    return HSLToColor(h, s, l)
end

function lia.utilities.LerpColor(f, from, to)
    return Color(Lerp(f, from.r, to.r), Lerp(f, from.g, to.g), Lerp(f, from.b, to.b), Lerp(f, from.a, to.a))
end

function lia.utilities.Blend(a, b, r)
    r = math.Clamp(r, 0, 1)
    return Color(Lerp(r, a.r, b.r), Lerp(r, a.g, b.g), Lerp(r, a.b, b.b))
end

function lia.utilities.rgb(r, g, b)
    return Color(r, g, b)
end

function lia.utilities.Rainbow(freq)
    return HSVToColor((CurTime() * freq) % 360, 1, 1)
end

function lia.utilities.ColorCycle(a, b, f)
    f = f or 1
    local d = Color(a.r - b.r, a.g - b.g, a.b - b.b)
    local t = CurTime()
    return Color(math.min(a.r, b.r) + math.abs(math.sin(t * f) * d.r), math.min(a.g, b.g) + math.abs(math.sin(t * f + 2) * d.g), math.min(a.b, b.b) + math.abs(math.sin(t * f + 4) * d.b))
end

function lia.utilities.ColorToHex(c)
    return "0x" .. bit.tohex(c.r, 2) .. bit.tohex(c.g, 2) .. bit.tohex(c.b, 2)
end

function lia.utilities.Lighten(col, amt)
    local h, s, l = ColorToHSL(col)
    l = math.Clamp(l / 255 + amt, 0, 1)
    return HSLToColor(h, s, l)
end

function lia.utilities.toText(c)
    if not IsColor(c) then return end
    return (c.r or 255) .. "," .. (c.g or 255) .. "," .. (c.b or 255) .. "," .. (c.a or 255)
end

function lia.utilities.SecondsToDHMS(sec)
    local d = math.floor(sec / 86400)
    sec = sec % 86400
    local h = math.floor(sec / 3600)
    sec = sec % 3600
    local m = math.floor(sec / 60)
    return d, h, m, sec % 60
end

function lia.utilities.HMSToSeconds(h, m, s)
    return h * 3600 + m * 60 + s
end

function lia.utilities.FormatTimestamp(ts)
    local t = os.date("*t", ts)
    return string.format("%02d:%02d:%02d - %02d/%02d/%04d", t.hour, t.min, t.sec, t.day, t.month, t.year)
end

function lia.utilities.WeekdayName(str)
    local h, m, s, d, mo, y = str:match("(%d+):(%d+):(%d+)%s*-%s*(%d+)/(%d+)/(%d+)")
    if not h then return L("invalidDate") end
    local ts = os.time({
        year = y,
        month = mo,
        day = d,
        hour = h,
        min = m,
        sec = s
    })
    return os.date("%A", ts)
end

function lia.utilities.TimeUntil(str)
    local h, m, s, d, mo, y = str:match("(%d+):(%d+):(%d+)%s*-%s*(%d+)/(%d+)/(%d+)")
    if not h then return L("invalidTimeFormat") end
    h, m, s, d, mo, y = tonumber(h), tonumber(m), tonumber(s), tonumber(d), tonumber(mo), tonumber(y)
    if h > 23 or m > 59 or s > 59 or d < 1 or d > 31 or mo < 1 or mo > 12 or y < 1970 then return L("invalidTimeValues") end
    local target = os.time({
        year = y,
        month = mo,
        day = d,
        hour = h,
        min = m,
        sec = s
    })

    local now = os.time()
    if target <= now then return L("timeIsPast") end
    local diff = target - now
    local ydiff = math.floor(diff / 31557600)
    diff = diff % 31557600
    local mdiff = math.floor(diff / 2629800)
    diff = diff % 2629800
    local ddiff = math.floor(diff / 86400)
    diff = diff % 86400
    local hdiff = math.floor(diff / 3600)
    diff = diff % 3600
    local mindiff = math.floor(diff / 60)
    return L("timeDifferenceFormat", ydiff, mdiff, ddiff, hdiff, mindiff, diff % 60)
end

function lia.utilities.CurrentLocalTime()
    local t = os.date("*t")
    return string.format("%02d:%02d:%02d - %02d/%02d/%04d", t.hour, t.min, t.sec, t.day, t.month, t.year)
end

function lia.utilities.TimeDifference(str)
    local h, m, s, d, mo, y = str:match("(%d+):(%d+):(%d+)%s*-%s*(%d+)/(%d+)/(%d+)")
    if not h then return end
    local target = os.time({
        year = y,
        month = mo,
        day = d,
        hour = h,
        min = m,
        sec = s
    })
    return math.floor(os.difftime(target, os.time()) / 86400)
end

function lia.utilities.SerializeVector(v)
    return util.TableToJSON{v.x, v.y, v.z}
end

function lia.utilities.DeserializeVector(data)
    return Vector(unpack(util.JSONToTable(data)))
end

function lia.utilities.SerializeAngle(a)
    return util.TableToJSON{a.p, a.y, a.r}
end

function lia.utilities.DeserializeAngle(data)
    return Angle(unpack(util.JSONToTable(data)))
end

function lia.utilities.dprint(...)
    print("[DEBUG]", ...)
end

function math.chance(p)
    return math.random(0, 100) <= p
end

function string.generateRandom(len)
    len = len or 16
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local out = {}
    for _ = 1, len do
        local i = math.random(#chars)
        out[#out + 1] = chars:sub(i, i)
    end
    return table.concat(out)
end

function string.quote(s)
    return '"' .. s:gsub("\\", "\\\\"):gsub('"', '\\"') .. '"'
end

function string.FirstToUpper(s)
    return s:gsub("^%l", string.upper)
end

function string.CommaNumber(num)
    local n = tostring(num)
    while true do
        local k
        n, k = n:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return n
end

function string.Clean(s)
    return s:gsub("[^\32-\127]", "")
end

function string.Gibberish(s, p)
    local out = ""
    for c in s:gmatch(".") do
        if math.random(100) < p then
            for _ = 1, math.random(0, 2) do
                out = out .. table.Random{"#", "@", "&", "%", "$", "/", "<", ">", ";", "*"}
            end
        end

        out = out .. c
    end
    return out
end

local digitMap = {
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

function string.DigitToString(d)
    return digitMap[tostring(d)] or "invalid"
end

function table.Sum(t)
    local sum = 0
    for _, v in pairs(t) do
        if isnumber(v) then
            sum = sum + v
        elseif istable(v) then
            sum = sum + table.Sum(v)
        end
    end
    return sum
end

function table.Lookupify(t)
    local out = {}
    for _, v in pairs(t) do
        out[v] = true
    end
    return out
end

function table.MakeAssociative(t)
    local out = {}
    for _, v in pairs(t) do
        out[v] = true
    end
    return out
end

function table.Unique(t)
    return table.GetKeys(table.MakeAssociative(t))
end

function table.FullCopy(t)
    local out = {}
    for k, v in pairs(t) do
        if istable(v) then
            out[k] = table.FullCopy(v)
        elseif isvector(v) then
            out[k] = Vector(v.x, v.y, v.z)
        elseif isangle(v) then
            out[k] = Angle(v.p, v.y, v.r)
        else
            out[k] = v
        end
    end
    return out
end

function table.Filter(t, f)
    local c = 1
    for i = 1, #t do
        if f(t[i]) then
            t[c] = t[i]
            c = c + 1
        end
    end

    for i = c, #t do
        t[i] = nil
    end
    return t
end

function table.FilterCopy(t, f)
    local out = {}
    for i = 1, #t do
        if f(t[i]) then out[#out + 1] = t[i] end
    end
    return out
end

function math.UnitsToInches(u)
    return u * 0.75
end

function math.UnitsToCentimeters(u)
    return math.UnitsToInches(u) * 2.54
end

function math.UnitsToMeters(u)
    return math.UnitsToInches(u) * 0.0254
end

function math.Bias(x, a)
    local e = a ~= -1 and -1.4427 * math.log(a) or 0
    return x ^ e
end

function math.Gain(x, a)
    if x < 0.5 then return 0.5 * math.Bias(2 * x, 1 - a) end
    return 1 - 0.5 * math.Bias(2 - 2 * x, 1 - a)
end

function math.ApproachSpeed(s, d, sp)
    return math.Approach(s, d, math.abs(s - d) / sp)
end

local function ap(a, b, sp)
    return math.Approach(a, b, math.abs(a - b) / sp)
end

function math.ApproachVectorSpeed(s, d, sp)
    return Vector(ap(s.x, d.x, sp), ap(s.y, d.y, sp), ap(s.z, d.z, sp))
end

function math.ApproachAngleSpeed(s, d, sp)
    return Angle(ap(s.p, d.p, sp), ap(s.y, d.y, sp), ap(s.r, d.r, sp))
end

function math.InRange(v, mi, ma)
    return v >= mi and v <= ma
end

function math.ClampAngle(v, mi, ma)
    return Angle(math.Clamp(v.p, mi.p, ma.p), math.Clamp(v.y, mi.y, ma.y), math.Clamp(v.r, mi.r, ma.r))
end

function math.ClampedRemap(v, fmi, fma, tmi, tma)
    return math.Clamp(math.Remap(v, fmi, fma, tmi, tma), math.min(tmi, tma), math.max(tmi, tma))
end

if SERVER then
    function lia.utilities.spawnProp(model, pos, force, life, ang, col)
        local e = ents.Create("prop_physics")
        e:SetModel(model)
        e:Spawn()
        hook.Run("UtilityPropSpawned", e, model, pos)
        e:SetCollisionGroup(col or COLLISION_GROUP_WEAPON)
        e:SetAngles(ang or angle_zero)
        if type(pos) == "Player" then pos = pos:GetItemDropPos(e) end
        e:SetPos(pos)
        if force then
            local phys = e:GetPhysicsObject()
            if IsValid(phys) then phys:ApplyForceCenter(force) end
        end

        if (life or 0) > 0 then timer.Simple(life, function() if IsValid(e) then e:Remove() end end) end
        return e
    end

    function lia.utilities.spawnEntities(tbl)
        for class, p in pairs(tbl) do
            if isvector(p) then
                local e = ents.Create(class)
                if IsValid(e) then
                    e:SetPos(p)
                    e:Spawn()
                    hook.Run("UtilityEntitySpawned", e, class, p)
                end
            else
                lia.information(L("invalidEntityPosition"), class)
            end
        end
    end
end