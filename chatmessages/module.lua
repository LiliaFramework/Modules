MODULE.name = "Chat Messages"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0"
MODULE.desc = "Adds Simple Adverts."
MODULE.Public = true
lia.config.add( "ChatMessagesInterval", "Chat Messages Interval", 300, nil, {
	desc = "Time interval (in seconds) between each automatic chat message.",
	category = "Chat",
	type = "Int",
	min = 10,
	max = 3600
} )
