return {
    ---@alias category ["npc"] | ["atm"] | ["car"] | ["house"] | ["fleeca"] | ["paleto"] | ["maze"] | ["vangelico"] | ["pacific"]
    ---@alias cooldownType "player" | "robbery"
    ---@type table<category, table<cooldownType, number>>

    ["npc"] = { robbery = 300, player = 300 },
    ["atm"] = { robbery = 900, player = 300 },
    ["car"] = { robbery = 900, player = 900 },
    ["house"] = { robbery = 1800, player = 3600 },
    ["fleeca"] = { robbery = 1800, player = 3600 },
    ["paleto"] = { robbery = 1800, player = 3600 },
    ["maze"] = { robbery = 1800, player = 3600 },
    ["vangelico"] = { robbery = 1800, player = 3600 },
    ["pacific"] = { robbery = 1800, player = 3600 },
}