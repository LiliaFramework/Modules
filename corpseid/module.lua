MODULE.name = "Corpse ID"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0"
MODULE.desc = "Adds a corpse identification mechanic."
MODULE.Public = true
lia.config.add( "IdentificationTime", "Identification Time", 5, nil, {
	desc = "The time (in seconds) required to identify a corpse.",
	category = "Identification",
	type = "Int",
	min = 1,
	max = 60
} )