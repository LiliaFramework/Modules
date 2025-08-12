MODULE.fadeDelay = 2
MODULE.cutscenes = {
    ["Mistery Info"] = {
        {
            image = "https://i.imgur.com/JKLmnO1.png",
            sound = "ambient/forest_day.mp3",
            subtitles = {
                {
                    text = "The forest lies silent...",
                    font = "liaSubtitleFont",
                    duration = 3
                },
                {
                    text = "Mist curls around ancient trunks",
                    font = "liaSubtitleFont",
                    duration = 4
                },
                {
                    text = "You feel a presence watching.",
                    color = Color(200, 200, 255),
                    font = "liaSubtitleFont",
                    duration = 4
                }
            }
        },
        {
            image = "https://i.imgur.com/OpQrSt2.png",
            sound = "ambient/wind_loop.mp3",
            subtitles = {
                {
                    text = "A distant howl breaks the hush",
                    font = "liaSubtitleFont",
                    duration = 3
                },
                {
                    text = "Something moves between the shadows",
                    font = "liaSubtitleFont",
                    duration = 3
                }
            },
            songFade = true
        }
    },
    ["Battle Intro"] = {
        {
            image = "https://i.imgur.com/UvyZ7X3.png",
            sound = "music/epic_battle_start.mp3",
            subtitles = {
                {
                    text = "Armies clash on the field of valor",
                    font = "liaTitleFont",
                    duration = 4
                },
                {
                    text = "Steel meets steel, banners writhe in blood",
                    font = "liaTitleFont",
                    duration = 5
                }
            }
        },
        {
            image = "https://i.imgur.com/VwX9Yz4.png",
            subtitles = {
                {
                    text = "A hero emerges from the fray",
                    color = Color(255, 215, 0),
                    font = "liaTitleFont",
                    duration = 4
                },
                {
                    text = "Their roar turns the tide of war",
                    font = "liaTitleFont",
                    duration = 4
                }
            },
            songFade = true
        }
    },
    ["Victory Celebration"] = {
        {
            image = "https://i.imgur.com/WmNOpQ5.png",
            sound = "music/victory_fanfare.mp3",
            subtitles = {
                {
                    text = "The battle won, the banners rise",
                    font = "liaSubtitleFont",
                    duration = 3
                },
                {
                    text = "Cheers fill the air",
                    font = "liaSubtitleFont",
                    duration = 2
                }
            }
        },
        {
            image = "https://i.imgur.com/AbCdEf6.png",
            subtitles = {
                {
                    text = "Heroes gather beneath the setting sun",
                    font = "liaSubtitleFont",
                    duration = 5
                },
                {
                    text = "Their legacy will echo through ages",
                    color = Color(150, 255, 150),
                    font = "liaSubtitleFont",
                    duration = 5
                }
            }
        }
    },
}