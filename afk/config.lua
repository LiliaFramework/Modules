lia.config.add("AFKTime", L("afkTime"), 180, nil, {
    desc = L("afkTimeDesc"),
    category = L("afkProtection"),
    type = "Int",
    min = 30,
    max = 600
})

lia.config.add("AFKProtectionEnabled", L("afkProtectionEnabled"), true, nil, {
    desc = L("afkProtectionEnabledDesc"),
    category = L("afkProtection"),
    type = "Boolean"
})