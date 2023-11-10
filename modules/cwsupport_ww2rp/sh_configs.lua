MODULE.gunData = {}
MODULE.modelCam = {}
MODULE.slotCategory = {
    [1] = "primary",
    [2] = "secondary",
    [3] = "melee",
    [4] = "binoculars",
}

-- I don't want to make them to buy 50 different kind of ammo
--[[MODULE.changeAmmo = {
	["7.92x33mm Kurz"] = "ar2",
	["300 AAC Blackout"] = "ar2",
	["5.7x28mm"] = "ar2",
	["7.62x25mm Tokarev"] = "smg1",
	[".50 BMG"] = "ar2",
	["5.56x45mm"] = "ar2",
	["7.62x51mm"] = "ar2",
	["7.62x31mm"] = "ar2",
	["Frag Grenades"] = "grenade",
	["Flash Grenades"] = "grenade",
	["Smoke Grenades"] = "grenade",
	["9x17MM"] = "pistol",
	["9x19MM"] = "pistol",
	["9x19mm"] = "pistol",
	[".45 ACP"] = "pistol",
	["9x18MM"] = "pistol",
	["9x39MM"] = "pistol",
	[".40 S&W"] = "pistol",
	[".44 Magnum"] = "357",
	[".50 AE"] = "357",
	["5.45x39MM"] = "ar2",
	["5.56x45MM"] = "ar2",
	["5.7x28MM"] = "ar2",
	["7.62x51MM"] = "ar2",
	["7.62x54mmR"] = "ar2",
	["12 Gauge"] = "buckshot",
	[".338 Lapua"] = "sniperround",
}--]]
local AMMO_BOX = "models/Items/BoxSRounds.mdl"
local AMMO_CASE = "models/Items/357ammo.mdl"
local AMMO_FLARE = "models/Items/BoxFlares.mdl"
local AMMO_BIGBOX = "models/Items/BoxMRounds.mdl"
local AMMO_BUCKSHOT = "models/Items/BoxBuckshot.mdl"
local AMMO_GREN = "models/Items/AR2_Grenade.mdl"
MODULE.ammoInfo = {}
MODULE.ammoInfo[".45 ACP"] = {
    name = ".45 ACP",
    desc = "Designed by John Browning in 1905, this small arms cartridge combines accuracy and stopping power.",
    amount = 100,
    price = 15,
    model = AMMO_BOX,
}

MODULE.ammoInfo["9x19MM"] = {
    name = "9x19mm Parabellum",
    desc = "Designed by Georg Luger in 1901, this cartridge is among the most popular for pistols and submachine guns.",
    amount = 100,
    price = 10,
    model = AMMO_BOX,
}

MODULE.ammoInfo["12 Gauge"] = {
    name = "12 Gauge",
    desc = "Common for hunting, military and home defense applications, this is the most popular shotgun shell.",
    amount = 30,
    price = 20,
    model = AMMO_BUCKSHOT,
}

MODULE.ammoInfo["12 Gauge Flechette"] = {
    name = "12 Gauge Flechette",
    desc = "Shotgun flechettes provide increased hit chance at range, but deal less damage.",
    amount = 30,
    price = 20,
    model = AMMO_BUCKSHOT,
}

MODULE.ammoInfo["12 Gauge Slug"] = {
    name = "12 Gauge Slug",
    desc = "Shotgun slugs provide accurate damage at range, but only fire a single projectile per shot.",
    amount = 30,
    price = 20,
    model = AMMO_BUCKSHOT,
}

MODULE.ammoInfo[".30 Carbine"] = {
    name = ".30 Carbine",
    desc = "Introduced in the 1940s, this light rifle cartridge proved itself during World War II.",
    amount = 60,
    price = 30,
    model = AMMO_BIGBOX,
}

MODULE.ammoInfo[".30 06"] = {
    name = ".30-06 Springfield",
    desc = "Introduced in 1906, this big game cartridge strikes an ideal balance between power and recoil.",
    amount = 60,
    price = 30,
    model = AMMO_BIGBOX,
}

MODULE.ammoInfo[".32 ACP"] = {
    name = ".32 ACP",
    desc = "Designed by John Browning at the turn of the century, this light and compact cartridge is nonetheless effective.",
    amount = 100,
    price = 10,
    model = AMMO_BOX,
}

MODULE.ammoInfo["7.63x25MM"] = {
    name = "7.63x25mm Mauser",
    desc = "Developed around 1896 and based on the 7.65x25mm Borchardt of 1893, this light yet speedy cartridge caught the attention of Soviet weapon designers.",
    amount = 100,
    price = 15,
    model = AMMO_BOX,
}

MODULE.ammoInfo["7.92x57MM"] = {
    name = "7.92x57mm Mauser",
    desc = "Adopted by the German Empire in 1905, this versatile rifle cartridge served in both World War I and II.",
    amount = 60,
    price = 30,
    model = AMMO_BIGBOX,
}

MODULE.ammoInfo["7.92x33MM"] = {
    name = "7.92x33mm Kurz",
    desc = "Developed in Nazi Germany prior to and during World War II, this intermediate cartridge was designed for the world's first assault rifle.",
    amount = 60,
    price = 30,
    model = AMMO_BIGBOX,
}

MODULE.ammoInfo["9x25MM"] = {
    name = "9x25mm Mauser",
    desc = "Developed around 1904 and based on the 7.63x25mm Mauser, this relatively powerful cartridge was primarily intended for export.",
    amount = 100,
    price = 15,
    model = AMMO_BOX,
}

MODULE.ammoInfo[".303"] = {
    name = ".303 British",
    desc = "Put into service in 1889, this rifle cartridge is the standard for British and Commonwealth militaries.",
    amount = 60,
    price = 30,
    model = AMMO_BIGBOX,
}

MODULE.ammoInfo[".38 200"] = {
    name = ".38 S&W",
    desc = "Developed by Smith & Wesson in 1877, this revolver cartridge is the standard for the British military.",
    amount = 100,
    price = 20,
    model = AMMO_CASE,
}

MODULE.ammoInfo["pistol"] = {
    name = "Pistol Ammo",
    amount = 30,
    price = 200,
    model = AMMO_CASE,
}

MODULE.ammoInfo["357"] = {
    name = "Magnum Ammo",
    amount = 10,
    price = 350,
    model = AMMO_CASE,
}

MODULE.ammoInfo["smg1"] = {
    name = "Sub Machine Gun Ammo",
    amount = 30,
    price = 400,
    model = AMMO_BOX,
}

MODULE.ammoInfo["ar2"] = {
    name = "Rifle Ammo",
    amount = 30,
    price = 400,
    model = AMMO_BIGBOX,
}

MODULE.ammoInfo["buckshot"] = {
    name = "Shotgun Shells",
    amount = 10,
    price = 300,
    model = AMMO_BUCKSHOT,
}

MODULE.ammoInfo["sniperround"] = {
    name = "Sniper Rounds",
    amount = 10,
    price = 500,
    model = AMMO_FLARE,
    iconCam = {
        ang = Angle(8.4998140335083, 170.05499267578, 0),
        fov = 2.1218640972135,
        pos = Vector(281.19021606445, -49.330429077148, 45.772754669189)
    }
}

--lia.util.include("presets/sh_defcw.lua")
lia.util.include("presets/sh_customweapons.lua")
lia.util.include("presets/sh_atow.lua")
