NOATTACHMENT_SIGHT = 1
ATTACHMENT_BARREL = 2
ATTACHMENT_ALTSIGHT = 3
ATTACHMENT_MAGAZINE = 4
ATTACHMENT_GRIP = 5
ATTACHMENT_ACCESSORY = 6
ATTACHMENT_STOCK = 7
ATTACHMENT_BIPOD = 8
ATTACHMENT_CONVERSION = 9
local attItems = {}
attItems.att_flechette = {
    name = "Flechette Conversion",
    desc = "Allows shotguns to fire flechettes.",
    price = 100,
    slot = ATTACHMENT_CONVERSION,
    attSearch = {"am_flechettem37",}
}

attItems.att_slugrounds = {
    name = "Slug Conversion",
    desc = "Allows shotguns to fire slugs.",
    price = 100,
    slot = ATTACHMENT_CONVERSION,
    attSearch = {"am_slugroundsm37",}
}

attItems.att_50rndbelt = {
    name = "50 Round Belt",
    desc = "Low capacity belt that decreases weight and reload time.",
    price = 100,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_50rndbelt",}
}

attItems.att_150rndbelt = {
    name = "150 Round Belt",
    desc = "Medium capacity belt that slightly decreases weight and reload time.",
    price = 100,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_150rndbelt",}
}

attItems.att_1917ext = {
    name = "Extended Barrel (S&W M1917)",
    desc = "Improves effective range and accuracy, but slightly increases weight.",
    price = 100,
    slot = ATTACHMENT_BARREL,
    attSearch = {"doi_atow_1917ext",}
}

attItems.att_altsight = {
    name = "Alternate Iron Sight",
    desc = "Modified iron sight that may improve aiming.",
    price = 50,
    slot = ATTACHMENT_ALTSIGHT,
    attSearch = {"doi_atow_altsight",}
}

attItems.att_altsightmk5 = {
    name = "Mk. V Iron Sight",
    desc = "Modified iron sight designed specifically for the Sten gun.",
    price = 100,
    slot = ATTACHMENT_ALTSIGHT,
    attSearch = {"doi_atow_altsightmk5",}
}

attItems.att_barcarry = {
    name = "Carry Handle",
    desc = "Heavy duty carrying handle that increases unholstering speed.",
    price = 100,
    slot = ATTACHMENT_ACCESSORY,
    attSearch = {"doi_atow_barcarry",}
}

attItems.att_barhandguard = {
    name = "M1918 Handguard",
    desc = "Slimmed down grip that improves handling.",
    price = 100,
    slot = ATTACHMENT_GRIP,
    attSearch = {"doi_atow_barhandguard",}
}

attItems.att_bhpcomp = {
    name = "Compensator (Browning Hi-Power)",
    desc = "Decreases recoil and improves accuracy.",
    price = 110,
    slot = ATTACHMENT_BARREL,
    attSearch = {"doi_atow_bhpcomp",}
}

attItems.att_bhpextmag = {
    name = "20 Round Magazine (Browning Hi-Power)",
    desc = "Increases ammo capacity by 8.",
    price = 80,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_bhpextmag",}
}

attItems.att_woodenstock = {
    name = "Wooden Stock",
    desc = "Significantly decreases recoil, but slightly increases weight.",
    price = 100,
    slot = ATTACHMENT_STOCK,
    attSearch = {"doi_atow_bhpstock", "doi_atow_c96stock",}
}

attItems.att_bipod = {
    name = "Heavy Bipod",
    desc = "Greatly increases accuracy when deployed, but slightly increases weight and unholstering time.",
    price = 100,
    slot = ATTACHMENT_BIPOD,
    attSearch = {"doi_atow_bipod",}
}

attItems.att_c96cextmag = {
    name = "40 Round Magazine (Mauser C96 M1932)",
    desc = "Increases ammo capacity by 20.",
    price = 100,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_c96cextmag",}
}

attItems.att_c96cshortbarrel = {
    name = "Short Barrel (Mauser C96 M1932)",
    desc = "Decreases weight, but increases recoil.",
    price = 100,
    slot = ATTACHMENT_BARREL,
    attSearch = {"doi_atow_c96cshortbarrel",}
}

attItems.att_c96longbarrel = {
    name = "Extended Barrel (Mauser C96)",
    desc = "Improves effective range and accuracy, but increases recoil and weight.",
    price = 120,
    slot = ATTACHMENT_BARREL,
    attSearch = {"doi_atow_c96longbarrel",}
}

attItems.att_greasedbolt = {
    name = "Greased Bolt",
    desc = "Increases bolt cycling rate.",
    price = 100,
    slot = ATTACHMENT_BARREL,
    attSearch = {"doi_atow_greasedbolt", "doi_atow_greasedboltwelrod",}
}

attItems.att_lugerlongbarrel = {
    name = "Extended Barrel (Luger P08)",
    desc = "Improves effective range and accuracy, but slightly increases weight.",
    price = 130,
    slot = ATTACHMENT_BARREL,
    attSearch = {"doi_atow_lugerlongbarrel",}
}

attItems.att_lymanm82 = {
    name = "Lyman M82 4x",
    desc = "American scope that provides 4x magnification.",
    price = 100,
    slot = ATTACHMENT_SIGHT,
    attSearch = {"doi_atow_lymanm82",}
}

attItems.att_m1carbine30rnd = {
    name = "30 Round Magazine (M1 Carbine)",
    desc = "Increases ammo capacity by 15.",
    price = 100,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_m1carbine30rnd",}
}

attItems.att_m2carbineconv = {
    name = "Automatic Conversion",
    desc = "Enables fully automatic fire.",
    price = 100,
    slot = ATTACHMENT_CONVERSION,
    attSearch = {"doi_atow_m2carbineconv",}
}

attItems.att_m3a1suppressor = {
    name = "Suppressor (M3 Submachine Gun)",
    desc = "Greatly reduces firing signature, but decreases effective range.",
    price = 100,
    slot = ATTACHMENT_BARREL,
    attSearch = {"doi_atow_m3a1suppressor",}
}

attItems.att_m3carbine = {
    name = "Extended Barrel (M3 Submachine Gun)",
    desc = "Improves effective range and accuracy, but slightly increases weight.",
    price = 100,
    slot = ATTACHMENT_BARREL,
    attSearch = {"doi_atow_m3carbine",}
}

attItems.att_m3flashhider = {
    name = "Flash Cone (M3 Submachine Gun)",
    desc = "Eliminates muzzle flash, but slightly decreases accuracy.",
    price = 100,
    slot = ATTACHMENT_ACCESSORY,
    attSearch = {"doi_atow_m3flashhider",}
}

attItems.att_m73 = {
    name = "Weaver M73 4x",
    desc = "American scope that provides 4x magnification.",
    price = 100,
    slot = ATTACHMENT_SIGHT,
    attSearch = {"doi_atow_m73",}
}

attItems.att_m1928grip = {
    name = "Wooden Foregrip",
    desc = "Improves accuracy, but slightly increases unholstering time.",
    price = 100,
    slot = ATTACHMENT_GRIP,
    attSearch = {"doi_atow_m1928grip",}
}

attItems.att_mp3430rnd = {
    name = "32 Round Magazine (MP 34)",
    desc = "Increases ammo capacity by 12.",
    price = 100,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_mp3430rnd",}
}

attItems.att_no32 = {
    name = "No. 32 3.5x",
    desc = "British scope that provides 3.5x magnification.",
    price = 100,
    slot = ATTACHMENT_SIGHT,
    attSearch = {"doi_atow_no32",}
}

attItems.att_pistolextmag = {
    name = "14 Round Magazine (Colt M1911A1)",
    desc = "Increases ammo capacity by 7.",
    price = 90,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_pistolextmag",}
}

attItems.att_revspeedloader = {
    name = "6 Round Speedloader",
    desc = "Provides revolvers with a hasty reload.",
    price = 100,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_revspeedloader",}
}

attItems.att_sling = {
    name = "Firearm Sling",
    desc = "Heavy duty strap that increases unholstering speed.",
    price = 100,
    slot = ATTACHMENT_ACCESSORY,
    attSearch = {"doi_atow_sling",}
}

attItems.att_stensuppressor = {
    name = "Suppressor (Sten)",
    desc = "Greatly reduces firing signature, but decreases effective range.",
    price = 100,
    slot = ATTACHMENT_ALTSIGHT,
    attSearch = {"doi_atow_stensuppressor",}
}

attItems.att_stripperclips = {
    name = "Stripper Clip",
    desc = "Provides bolt-action rifles with a hasty reload.",
    price = 100,
    slot = ATTACHMENT_SIGHT,
    attSearch = {"doi_atow_stripperclips",}
}

attItems.att_suomi71rnd = {
    name = "71 Round Drum Magazine (Suomi KP/-31)",
    desc = "Increases ammo capacity by 41.",
    price = 100,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_suomi71rnd",}
}

attItems.att_thompson30rnd = {
    name = "30 Round Magazine (Thompson)",
    desc = "Increases ammo capacity by 10.",
    price = 100,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_thompson30rnd",}
}

attItems.att_thompson50rnd = {
    name = "50 Round Drum Magazine (Thompson M1928A1)",
    desc = "Increases ammo capacity by 30.",
    price = 100,
    slot = ATTACHMENT_MAGAZINE,
    attSearch = {"doi_atow_thompson50rnd",}
}

attItems.att_thompsonnostock = {
    name = "Stock Removal (Thompson M1928A1)",
    desc = "Decreases weight and unholstering time, but increases recoil.",
    price = 100,
    slot = ATTACHMENT_STOCK,
    attSearch = {"doi_atow_thompsonnostock",}
}

attItems.att_thompsonrc = {
    name = "Compensator (Thompson M1A1)",
    desc = "Decreases recoil and improves accuracy.",
    price = 100,
    slot = ATTACHMENT_BARREL,
    attSearch = {"doi_atow_thompsonrc",}
}

attItems.att_unertl = {
    name = "Unertl 7.8x",
    desc = "American scope that provides 7.8x magnification.",
    price = 100,
    slot = ATTACHMENT_SIGHT,
    attSearch = {"doi_atow_unertl",}
}

attItems.att_unisuppressor = {
    name = "Suppressor",
    desc = "Greatly reduces firing signature, but decreases effective range.",
    price = 150,
    slot = ATTACHMENT_BARREL,
    attSearch = {"doi_atow_unisuppressor",}
}

attItems.att_wina5 = {
    name = "Winchester A5 7x",
    desc = "American scope that provides 7x magnification.",
    price = 100,
    slot = ATTACHMENT_SIGHT,
    attSearch = {"doi_atow_wina5",}
}

attItems.att_zf4 = {
    name = "ZF-4 4x",
    desc = "German scope that provides 4x magnification.",
    price = 100,
    slot = ATTACHMENT_SIGHT,
    attSearch = {"doi_atow_zf4",}
}

attItems.att_zf39 = {
    name = "ZF-39 7x",
    desc = "German scope that provides 7x magnification.",
    price = 100,
    slot = ATTACHMENT_SIGHT,
    attSearch = {"doi_atow_zf39",}
}

attItems.att_zf41 = {
    name = "ZF-41 1.5x",
    desc = "German scope that provides 1.5x magnification.",
    price = 100,
    slot = ATTACHMENT_SIGHT,
    attSearch = {"doi_atow_zf41",}
}

attItems.att_zfg42 = {
    name = "ZFG-42 4x",
    desc = "German scope that provides 4x magnification.",
    price = 100,
    slot = ATTACHMENT_SIGHT,
    attSearch = {"doi_atow_zfg42",}
}

--[[
attItems.att_rdot = {
    name = "Red Dot Sight",
    desc = "attRDotDesc",
    slot = ATTACHMENT_SIGHT,
    attSearch = {"md_aimpoint", "md_microt1", "md_rmr",}
}

attItems.att_holo = {
    name = "Holographic Sight",
    desc = "attHoloDesc",
    slot = ATTACHMENT_SIGHT,
    attSearch = {"md_kobra", "md_cobram2", "md_eotech",}
}

attItems.att_scope4 = {
    name = "4x Scope",
    desc = "attScope4Desc",
    slot = ATTACHMENT_SIGHT,
    attSearch = {"md_schmidt_shortdot", "md_acog",}
}

attItems.att_scope8 = {
    name = "8x Scope",
    desc = "attScope8Desc",
    slot = ATTACHMENT_SIGHT,
    attSearch = {"md_pso1", "bg_sg1scope", "md_nightforce_nxs",}
}

attItems.att_muzsup = {
    name = "Suppressor",
    desc = "attSupDesc",
    slot = ATTACHMENT_BARREL,
    attSearch = {"md_saker", "md_tundra9mm", "md_pbs1",},
}

attItems.att_foregrip = {
    name = "Foregrip",
    desc = "attForeDesc",
    slot = ATTACHMENT_GRIP,
    attSearch = {"md_foregrip",}
}

attItems.att_laser = {
    name = "Laser Sight",
    desc = "attLaserDesc",
    slot = ATTACHMENT_LASER,
    attSearch = {"md_anpeq15", "md_insight_x2",}
}

attItems.att_bipod = {
    name = "Bipod",
    desc = "attBipodDesc",
    slot = ATTACHMENT_GRIP,
    attSearch = {"bg_bipod", "md_bipod",}
}]]
local function attachment(item, data, combine)
    local client = item.player
    local char = client:getChar()
    local inv = char:getInv()
    local items = inv:getItems()
    local target = data
    -- This is the only way, ffagot
    for k, invItem in pairs(items) do
        if data then
            if invItem:getID() == data then
                target = invItem
                break
            end
        else
            if invItem.isWeapon and invItem.isCW then
                target = invItem
                break
            end
        end
    end

    if not target then
        client:notifyLocalized("noWeapon")

        return false
    else
        local class = target.class
        local SWEP = weapons.Get(class)
        if target.isCW then
            -- Insert Weapon Filter here if you just want to create weapon specific shit. 
            local atts = SWEP.Attachments
            local mods = target:getData("mod", {})
            if atts then
                -- Is the Weapon Slot Filled?
                if mods[item.slot] then
                    client:notifyLocalized("alreadyAttached")

                    return false
                end

                local pokemon
                for atcat, data in pairs(atts) do
                    if pokemon then break end
                    for k, name in pairs(data.atts) do
                        if pokemon then break end
                        for _, doAtt in pairs(item.attSearch) do
                            if name == doAtt then
                                pokemon = doAtt
                                break
                            end
                        end
                    end
                end

                if not pokemon then
                    client:notifyLocalized("cantAttached")

                    return false
                end

                mods[item.slot] = {item.uniqueID, pokemon}
                target:setData("mod", mods)
                local wepon = client:GetActiveWeapon()
                -- If you're holding right weapon, just mod it out.
                if IsValid(wepon) and wepon:GetClass() == target.class then
                    wepon:attachSpecificAttachment(pokemon)
                end

                -- Yeah let them know you did something with your dildo
                client:EmitSound("cw/holster4.wav")

                return true
            else
                client:notifyLocalized("notCW")
            end
        end
    end

    client:notifyLocalized("noWeapon")

    return false
end

for className, v in pairs(attItems) do
    local ITEM = lia.item.register(className, nil, nil, nil, true)
    ITEM.name = v.name
    ITEM.desc = v.desc
    ITEM.price = v.price
    ITEM.model = "models/props_c17/briefcase001a.mdl"
    ITEM.width = 1
    ITEM.height = 1
    ITEM.isAttachment = true
    ITEM.category = "Attachments"
    ITEM.attSearch = v.attSearch
    ITEM.slot = v.slot
    ITEM.functions.use = {
        name = "Attach",
        tip = "useTip",
        icon = "icon16/wrench.png",
        isMulti = true,
        multiOptions = function(item, client)
            local targets = {}
            local char = client:getChar()
            if char then
                local inv = char:getInv()
                if inv then
                    local items = inv:getItems()
                    for k, v in pairs(items) do
                        if v.isWeapon and v.isCW then
                            table.insert(
                                targets,
                                {
                                    name = L(v.name),
                                    data = v:getID(),
                                }
                            )
                        else
                            continue
                        end
                    end
                end
            end

            return targets
        end,
        onCanRun = function(item) return not IsValid(item.entity) end,
        onRun = function(item, data) return attachment(item, data, false) end,
    }

    ITEM.functions.combine = {
        onCanRun = function(item, data)
            local targetItem = lia.item.instances[data]
            if data and targetItem then
                if not IsValid(item.entity) and targetItem.isWeapon and targetItem.isCW then
                    return true
                else
                    return false
                end
            end
        end,
        onRun = function(item, data) return attachment(item, data, true) end,
    }
end

local conversionKits = {}
-- planned feature
-- make a package of weapon converter.
-- like MP5 to MP5SD (yeah seriously)