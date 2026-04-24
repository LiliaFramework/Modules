local MODULE = MODULE
local fileFind = file.Find
local stringGetExtensionFromFilename = string.GetExtensionFromFilename
local stringFind = string.find
local stringLower = string.lower
local tableInsert = table.insert
lia.anim = lia.anim or {}
lia.anim.classes = lia.anim.classes or {}
lia.anim.playerAnimationModels = lia.anim.playerAnimationModels or {}
lia.anim.holdTypeTranslator = lia.anim.holdTypeTranslator or {
    [""] = "normal",
    ar2 = "smg",
    camera = "smg",
    crossbow = "shotgun",
    duel = "pistol",
    grenade = "grenade",
    knife = "melee",
    magic = "normal",
    melee2 = "melee",
    passive = "smg",
    physgun = "smg",
    revolver = "pistol",
    rpg = "shotgun",
    slam = "normal"
}

lia.anim.playerHoldTypeTranslator = lia.anim.playerHoldTypeTranslator or {
    [""] = "normal",
    bugbait = "normal",
    duel = "normal",
    fist = "normal",
    grenade = "normal",
    knife = "normal",
    melee = "normal",
    melee2 = "normal",
    normal = "normal",
    pistol = "normal",
    revolver = "normal",
    slam = "normal"
}

function MODULE:SetAnimationModelClass(model, className)
    lia.anim.setModelClass(model, className)
end

function MODULE:GetAnimationClass(model)
    return lia.anim.getModelClass(model)
end

function MODULE:GetWeaponHoldType(weapon, usePlayerTranslator)
    return lia.anim.getWeaponHoldType(weapon, usePlayerTranslator)
end

local function addModelsFromDirectory(directory)
    local files, directories = fileFind(directory .. "/*", "GAME")
    for _, fileName in ipairs(files) do
        if stringGetExtensionFromFilename(fileName) == "mdl" then
            local modelPath = stringLower(directory .. "/" .. fileName)
            tableInsert(lia.anim.playerAnimationModels, modelPath)
        end
    end

    for _, subDirectory in ipairs(directories) do
        addModelsFromDirectory(directory .. "/" .. subDirectory)
    end
end

function MODULE:RegisterPlayerModelDirectories(directories)
    if not istable(directories) then return end
    lia.anim.playerAnimationModels = {}
    for _, directory in ipairs(directories) do
        addModelsFromDirectory(directory)
    end

    for _, modelPath in ipairs(lia.anim.playerAnimationModels) do
        lia.anim.setModelClass(modelPath, "player")
    end
end

lia.anim.citizen_male = {
    normal = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_COVER_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN}
    },
    fist = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_ANGRY_SMG1},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_COVER_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK_AIM_RIFLE_STIMULATED},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN_AIM_RIFLE_STIMULATED}
    },
    pistol = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_RANGE_ATTACK_PISTOL},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_RANGE_ATTACK_PISTOL_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK_AIM_RIFLE_STIMULATED},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN_AIM_RIFLE_STIMULATED},
        attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
        reload = ACT_RELOAD_PISTOL
    },
    smg = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1_RELAXED, ACT_IDLE_ANGRY_SMG1},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_RANGE_AIM_SMG1_LOW},
        [ACT_MP_WALK] = {ACT_WALK_RIFLE_RELAXED, ACT_WALK_AIM_RIFLE_STIMULATED},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_AIM_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_RIFLE_RELAXED, ACT_RUN_AIM_RIFLE_STIMULATED},
        attack = ACT_GESTURE_RANGE_ATTACK_SMG1,
        reload = ACT_GESTURE_RELOAD_SMG1
    },
    shotgun = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE_SHOTGUN_RELAXED, ACT_IDLE_ANGRY_SMG1},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_RANGE_AIM_SMG1_LOW},
        [ACT_MP_WALK] = {ACT_WALK_RIFLE_RELAXED, ACT_WALK_AIM_RIFLE_STIMULATED},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_RIFLE_RELAXED, ACT_RUN_AIM_RIFLE_STIMULATED},
        attack = ACT_GESTURE_RANGE_ATTACK_SHOTGUN
    },
    grenade = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_MANNEDGUN},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_RANGE_AIM_SMG1_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK_AIM_RIFLE_STIMULATED},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN_RIFLE_STIMULATED},
        attack = ACT_RANGE_ATTACK_THROW
    },
    melee = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_ANGRY_MELEE},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_COVER_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK_AIM_RIFLE},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
        attack = ACT_MELEE_ATTACK_SWING
    },
    glide = ACT_GLIDE,
    vehicle = {
        ["prop_vehicle_prisoner_pod"] = {"podpose", Vector(-3, 0, 0)},
        ["prop_vehicle_jeep"] = {ACT_BUSY_SIT_CHAIR, Vector(14, 0, -14)},
        ["prop_vehicle_airboat"] = {ACT_BUSY_SIT_CHAIR, Vector(8, 0, -20)},
        chair = {ACT_BUSY_SIT_CHAIR, Vector(1, 0, -23)}
    }
}

lia.anim.citizen_female = {
    normal = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_COVER_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN}
    },
    fist = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_MANNEDGUN},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_COVER_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_RANGE_AIM_SMG1_LOW},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN_AIM_RIFLE_STIMULATED}
    },
    pistol = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE_PISTOL, ACT_IDLE_ANGRY_PISTOL},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_RANGE_AIM_SMG1_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK_AIM_PISTOL},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN_AIM_PISTOL},
        attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
        reload = ACT_RELOAD_PISTOL
    },
    smg = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1_RELAXED, ACT_IDLE_ANGRY_SMG1},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_RANGE_AIM_SMG1_LOW},
        [ACT_MP_WALK] = {ACT_WALK_RIFLE_RELAXED, ACT_WALK_AIM_RIFLE_STIMULATED},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_AIM_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_RIFLE_RELAXED, ACT_RUN_AIM_RIFLE_STIMULATED},
        attack = ACT_GESTURE_RANGE_ATTACK_SMG1,
        reload = ACT_GESTURE_RELOAD_SMG1
    },
    shotgun = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE_SHOTGUN_RELAXED, ACT_IDLE_ANGRY_SMG1},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_RANGE_AIM_SMG1_LOW},
        [ACT_MP_WALK] = {ACT_WALK_RIFLE_RELAXED, ACT_WALK_AIM_RIFLE_STIMULATED},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_AIM_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_RIFLE_RELAXED, ACT_RUN_AIM_RIFLE_STIMULATED},
        attack = ACT_GESTURE_RANGE_ATTACK_SHOTGUN
    },
    grenade = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_MANNEDGUN},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_RANGE_AIM_SMG1_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK_AIM_PISTOL},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN_AIM_PISTOL},
        attack = ACT_RANGE_ATTACK_THROW
    },
    melee = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_MANNEDGUN},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_LOW, ACT_COVER_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK_AIM_RIFLE},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
        attack = ACT_MELEE_ATTACK_SWING
    },
    glide = ACT_GLIDE,
    vehicle = lia.anim.citizen_male.vehicle
}

lia.anim.metrocop = {
    normal = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_PISTOL_LOW, ACT_COVER_PISTOL_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN}
    },
    fist = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_ANGRY_SMG1},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_PISTOL_LOW, ACT_COVER_SMG1_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK_AIM_RIFLE},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN}
    },
    pistol = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE_PISTOL, ACT_IDLE_ANGRY_PISTOL},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_PISTOL_LOW, ACT_COVER_PISTOL_LOW},
        [ACT_MP_WALK] = {ACT_WALK_PISTOL, ACT_WALK_AIM_PISTOL},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN_PISTOL, ACT_RUN_AIM_PISTOL},
        attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
        reload = ACT_GESTURE_RELOAD_PISTOL
    },
    smg = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1, ACT_IDLE_ANGRY_SMG1},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_SMG1_LOW, ACT_COVER_SMG1_LOW},
        [ACT_MP_WALK] = {ACT_WALK_RIFLE, ACT_WALK_AIM_RIFLE},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN_RIFLE, ACT_RUN_AIM_RIFLE}
    },
    shotgun = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1, ACT_IDLE_ANGRY_SMG1},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_SMG1_LOW, ACT_COVER_SMG1_LOW},
        [ACT_MP_WALK] = {ACT_WALK_RIFLE, ACT_WALK_AIM_RIFLE},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN_RIFLE, ACT_RUN_AIM_RIFLE}
    },
    grenade = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_ANGRY_MELEE},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_PISTOL_LOW, ACT_COVER_PISTOL_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK_ANGRY},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
        attack = ACT_COMBINE_THROW_GRENADE
    },
    melee = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_ANGRY_MELEE},
        [ACT_MP_CROUCH_IDLE] = {ACT_COVER_PISTOL_LOW, ACT_COVER_PISTOL_LOW},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK_ANGRY},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
        attack = ACT_MELEE_ATTACK_SWING_GESTURE
    },
    glide = ACT_GLIDE,
    vehicle = {
        chair = {ACT_COVER_PISTOL_LOW, Vector(5, 0, -5)},
        ["prop_vehicle_airboat"] = {ACT_COVER_PISTOL_LOW, Vector(10, 0, 0)},
        ["prop_vehicle_jeep"] = {ACT_COVER_PISTOL_LOW, Vector(18, -2, 4)},
        ["prop_vehicle_prisoner_pod"] = {ACT_IDLE, Vector(-4, -0.5, 0)}
    }
}

lia.anim.overwatch = {
    normal = {
        [ACT_MP_STAND_IDLE] = {"idle_unarmed", "idle_unarmed"},
        [ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
        [ACT_MP_WALK] = {"walkunarmed_all", "walkunarmed_all"},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_AIM_RIFLE, ACT_RUN_AIM_RIFLE}
    },
    fist = {
        [ACT_MP_STAND_IDLE] = {"idle_unarmed", ACT_IDLE_ANGRY},
        [ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
        [ACT_MP_WALK] = {"walkunarmed_all", ACT_WALK_RIFLE},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_AIM_RIFLE, ACT_RUN_AIM_RIFLE}
    },
    pistol = {
        [ACT_MP_STAND_IDLE] = {"idle_unarmed", ACT_IDLE_ANGRY_SMG1},
        [ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
        [ACT_MP_WALK] = {"walkunarmed_all", ACT_WALK_RIFLE},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_AIM_RIFLE, ACT_RUN_AIM_RIFLE}
    },
    smg = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1, ACT_IDLE_ANGRY_SMG1},
        [ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
        [ACT_MP_WALK] = {ACT_WALK_RIFLE, ACT_WALK_AIM_RIFLE},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_RIFLE, ACT_RUN_AIM_RIFLE}
    },
    shotgun = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1, ACT_IDLE_ANGRY_SHOTGUN},
        [ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
        [ACT_MP_WALK] = {ACT_WALK_RIFLE, ACT_WALK_AIM_SHOTGUN},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_RIFLE, ACT_RUN_AIM_SHOTGUN}
    },
    grenade = {
        [ACT_MP_STAND_IDLE] = {"idle_unarmed", ACT_IDLE_ANGRY},
        [ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
        [ACT_MP_WALK] = {"walkunarmed_all", ACT_WALK_RIFLE},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_AIM_RIFLE, ACT_RUN_AIM_RIFLE}
    },
    melee = {
        [ACT_MP_STAND_IDLE] = {"idle_unarmed", ACT_IDLE_ANGRY},
        [ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
        [ACT_MP_WALK] = {"walkunarmed_all", ACT_WALK_RIFLE},
        [ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
        [ACT_MP_RUN] = {ACT_RUN_AIM_RIFLE, ACT_RUN_AIM_RIFLE},
        attack = ACT_MELEE_ATTACK_SWING_GESTURE
    },
    glide = ACT_GLIDE
}

lia.anim.vort = {
    normal = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
        [ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
        [ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN}
    },
    fist = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, "actionidle"},
        [ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
        [ACT_MP_WALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_CROUCHWALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN}
    },
    pistol = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, "tcidle"},
        [ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
        [ACT_MP_WALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_CROUCHWALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_RUN] = {ACT_RUN, "run_all_tc"}
    },
    smg = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, "tcidle"},
        [ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
        [ACT_MP_WALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_CROUCHWALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_RUN] = {ACT_RUN, "run_all_tc"}
    },
    shotgun = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, "tcidle"},
        [ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
        [ACT_MP_WALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_CROUCHWALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_RUN] = {ACT_RUN, "run_all_tc"}
    },
    grenade = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, "tcidle"},
        [ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
        [ACT_MP_WALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_CROUCHWALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_RUN] = {ACT_RUN, "run_all_tc"}
    },
    melee = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, "tcidle"},
        [ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
        [ACT_MP_WALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_CROUCHWALK] = {ACT_WALK, "walk_all_holdgun"},
        [ACT_MP_RUN] = {ACT_RUN, "run_all_tc"}
    },
    glide = ACT_GLIDE
}

lia.anim.player = {
    normal = {
        [ACT_MP_STAND_IDLE] = ACT_HL2MP_IDLE,
        [ACT_MP_CROUCH_IDLE] = ACT_HL2MP_IDLE_CROUCH,
        [ACT_MP_WALK] = ACT_HL2MP_WALK,
        [ACT_MP_RUN] = ACT_HL2MP_RUN
    },
    passive = {
        [ACT_MP_STAND_IDLE] = ACT_HL2MP_IDLE_PASSIVE,
        [ACT_MP_WALK] = ACT_HL2MP_WALK_PASSIVE,
        [ACT_MP_CROUCHWALK] = ACT_HL2MP_WALK_CROUCH_PASSIVE,
        [ACT_MP_RUN] = ACT_HL2MP_RUN_PASSIVE
    }
}

lia.anim.zombie = {
    [ACT_MP_STAND_IDLE] = ACT_HL2MP_IDLE_ZOMBIE,
    [ACT_MP_CROUCH_IDLE] = ACT_HL2MP_IDLE_CROUCH_ZOMBIE,
    [ACT_MP_CROUCHWALK] = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01,
    [ACT_MP_WALK] = ACT_HL2MP_WALK_ZOMBIE_02,
    [ACT_MP_RUN] = ACT_HL2MP_RUN_ZOMBIE
}

lia.anim.fastZombie = {
    [ACT_MP_STAND_IDLE] = ACT_HL2MP_WALK_ZOMBIE,
    [ACT_MP_CROUCH_IDLE] = ACT_HL2MP_IDLE_CROUCH_ZOMBIE,
    [ACT_MP_CROUCHWALK] = ACT_HL2MP_WALK_CROUCH_ZOMBIE_05,
    [ACT_MP_WALK] = ACT_HL2MP_WALK_ZOMBIE_06,
    [ACT_MP_RUN] = ACT_HL2MP_RUN_ZOMBIE_FAST
}

function MODULE:RegisterDefaultAnimationTranslations()
    lia.anim.setModelClass("", "player")
    lia.anim.setModelClass("models/police.mdl", "metrocop")
    lia.anim.setModelClass("models/combine_super_soldier.mdl", "overwatch")
    lia.anim.setModelClass("models/combine_soldier_prisonguard.mdl", "overwatch")
    lia.anim.setModelClass("models/combine_soldier.mdl", "overwatch")
    lia.anim.setModelClass("models/vortigaunt.mdl", "vort")
    lia.anim.setModelClass("models/vortigaunt_blue.mdl", "vort")
    lia.anim.setModelClass("models/vortigaunt_doctor.mdl", "vort")
    lia.anim.setModelClass("models/vortigaunt_slave.mdl", "vort")
    lia.anim.setModelClass("models/alyx.mdl", "citizen_female")
    lia.anim.setModelClass("models/mossman.mdl", "citizen_female")
end

function lia.anim.setModelClass(model, className)
    model = stringLower(model or "")
    className = tostring(className or "")
    if not lia.anim[className] then error("'" .. className .. "' is not a valid animation class!") end
    lia.anim.classes[model] = className
end

function lia.anim.getModelClass(model)
    model = stringLower(model or "")
    local className = lia.anim.classes[model]
    if className then return className end
    if stringFind(model, "/player", 1, true) or stringFind(model, "/playermodel", 1, true) then
        return "player"
    elseif stringFind(model, "female", 1, true) then
        return "citizen_female"
    end
    return "citizen_male"
end

function lia.anim.getWeaponHoldType(weapon, usePlayerTranslator)
    local holdType = "normal"
    if IsValid(weapon) then holdType = weapon.HoldType or (weapon.GetHoldType and weapon:GetHoldType()) or "normal" end
    if usePlayerTranslator then return lia.anim.playerHoldTypeTranslator[holdType] or "passive" end
    return lia.anim.holdTypeTranslator[holdType] or holdType
end

function lia.anim.getModelGender(model)
    model = stringLower(model or "")
    if lia.anim.getModelClass(model) == "citizen_female" then return "female" end
    if model:find("alyx", 1, true) or model:find("mossman", 1, true) or model:find("female", 1, true) then return "female" end
    return "male"
end

local MODULE = MODULE
local normalizeAngle = math.NormalizeAngle
local stringFind = string.find
local stringLower = string.lower
local vectorAngle = FindMetaTable("Vector").Angle
local oldCalcSeqOverride
function MODULE:GetModelGender(model)
    return lia.anim.getModelGender(model)
end

function MODULE:TranslateActivity(client, act)
    local anim = lia.anim
    if not anim.getModelClass or not anim.getWeaponHoldType then return end
    local model = stringLower(client:GetModel() or "")
    local className = lia.anim.getModelClass(model) or "player"
    local weapon = client:GetActiveWeapon()
    local alwaysRaised = lia.config.get("wepAlwaysRaised", false)
    if className == "player" then
        if not alwaysRaised and IsValid(weapon) and client.isWepRaised and not client:isWepRaised() and client:OnGround() then
            if stringFind(model, "zombie", 1, true) then
                local tree = anim.zombie
                if stringFind(model, "fast", 1, true) then tree = anim.fastZombie end
                if tree[act] then return tree[act] end
            end

            local tree = anim.player.passive
            if tree and tree[act] then
                if isstring(tree[act]) then
                    client.CalcSeqOverride = client:LookupSequence(tree[act])
                    return
                end
                return tree[act]
            end
        end
        return
    end

    local tree = anim[className]
    if not tree then return end
    local subClass = "normal"
    if client:InVehicle() then
        local vehicle = client:GetVehicle()
        local vehicleClass = vehicle.isChair and vehicle:isChair() and "chair" or vehicle:GetClass()
        if tree.vehicle and tree.vehicle[vehicleClass] then
            local vehicleAnim = tree.vehicle[vehicleClass][1]
            local fixVec = tree.vehicle[vehicleClass][2]
            if fixVec then client:SetLocalPos(fixVec) end
            if isstring(vehicleAnim) then
                client.CalcSeqOverride = client:LookupSequence(vehicleAnim)
                return
            end
            return vehicleAnim
        end

        local fallback = tree.normal[ACT_MP_CROUCH_IDLE][1]
        if isstring(fallback) then client.CalcSeqOverride = client:LookupSequence(fallback) end
        return
    elseif client:OnGround() then
        client:ManipulateBonePosition(0, vector_origin)
        if IsValid(weapon) then subClass = lia.anim.getWeaponHoldType(weapon, false) end
        if tree[subClass] and tree[subClass][act] then
            local index = (not client.isWepRaised or client:isWepRaised()) and 2 or 1
            local activity = tree[subClass][act][index]
            if isstring(activity) then
                client.CalcSeqOverride = client:LookupSequence(activity)
                return
            end
            return activity
        end
    elseif tree.glide then
        return tree.glide
    end
end

function MODULE:DoAnimationEvent(client, event, data)
    local anim = lia.anim
    if not anim.getModelClass or not anim.getWeaponHoldType then return end
    local className = lia.anim.getModelClass(client:GetModel())
    if className == "player" then return end
    local weapon = client:GetActiveWeapon()
    if not IsValid(weapon) then return ACT_INVALID end
    local holdType = lia.anim.getWeaponHoldType(weapon, false)
    local animation = anim[className] and anim[className][holdType]
    if not animation then return ACT_INVALID end
    if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
        client:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, animation.attack or ACT_GESTURE_RANGE_ATTACK_SMG1, true)
        return ACT_VM_PRIMARYATTACK
    elseif event == PLAYERANIMEVENT_ATTACK_SECONDARY then
        client:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, animation.attack or ACT_GESTURE_RANGE_ATTACK_SMG1, true)
        return ACT_VM_SECONDARYATTACK
    elseif event == PLAYERANIMEVENT_RELOAD then
        client:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, animation.reload or ACT_GESTURE_RELOAD_SMG1, true)
        return ACT_INVALID
    elseif event == PLAYERANIMEVENT_JUMP then
        client.m_bJumping = true
        client.m_bFistJumpFrame = true
        client.m_flJumpStartTime = CurTime()
        client:AnimRestartMainSequence()
        return ACT_INVALID
    elseif event == PLAYERANIMEVENT_CANCEL_RELOAD then
        client:AnimResetGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD)
        return ACT_INVALID
    end
    return ACT_INVALID
end

function MODULE:EntityEmitSound(data)
    local entity = data.Entity
    if IsValid(entity) and entity.liaIsMuted then return false end
end

function MODULE:HandlePlayerLanding(client, velocity, wasOnGround)
    if client:GetMoveType() == MOVETYPE_NOCLIP then return end
    if client:IsOnGround() and not wasOnGround then
        local length = (client.lastVelocity or velocity):LengthSqr()
        local className = lia.anim.getModelClass(client:GetModel())
        if className ~= "player" and length < 100000 then return end
        client:AnimRestartGesture(GESTURE_SLOT_JUMP, ACT_LAND, true)
        return true
    end
end

function MODULE:CalcMainActivity(client, velocity)
    if not lia.anim.getModelClass then return end
    client.CalcIdeal = ACT_MP_STAND_IDLE
    oldCalcSeqOverride = client.CalcSeqOverride
    client.CalcSeqOverride = -1
    local className = lia.anim.getModelClass(client:GetModel())
    if className ~= "player" then client:SetPoseParameter("move_yaw", normalizeAngle(vectorAngle(velocity)[2] - client:EyeAngles()[2])) end
    if self:HandlePlayerLanding(client, velocity, client.m_bWasOnGround) or GAMEMODE:HandlePlayerNoClipping(client, velocity) or GAMEMODE:HandlePlayerDriving(client) or GAMEMODE:HandlePlayerVaulting(client, velocity) or GAMEMODE:HandlePlayerJumping(client, velocity) or GAMEMODE:HandlePlayerSwimming(client, velocity) or GAMEMODE:HandlePlayerDucking(client, velocity) then
    else
        local len2D = velocity:Length2DSqr()
        if len2D > 22500 then
            client.CalcIdeal = ACT_MP_RUN
        elseif len2D > 0.25 then
            client.CalcIdeal = ACT_MP_WALK
        end
    end

    client.m_bWasOnGround = client:IsOnGround()
    client.m_bWasNoclipping = client:GetMoveType() == MOVETYPE_NOCLIP and not client:InVehicle()
    client.lastVelocity = velocity
    if CLIENT then client:SetIK(false) end
    return client.CalcIdeal, client.liaForceSeq or oldCalcSeqOverride
end
