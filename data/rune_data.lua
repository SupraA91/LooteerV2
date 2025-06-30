--[[
    RUNE DATA MODULE - ALPHABETIZED
    
    REMOVED RUNES (16 total):
    Legendary: Ehe, Ura
    Rare: Cha, Cip, Ixt, Kaa, May, Nam, Pac, Tza  
    Magic: Hak, Ixk, Met, Ono, Thar, Ur
    
    This module contains all remaining rune definitions with their IDs and names.
--]]

local rune_data = {
    magic_runes = {
        {id = 1968097, name = "Cem"},
        {id = 2057116, name = "Ceh"},
        {id = 2060618, name = "Cir"},
        {id = 1969099, name = "Gar"},
        {id = 1968586, name = "Lum"},
        {id = 2063887, name = "Moni"},
        {id = 2043182, name = "Qua"},
        {id = 2040871, name = "Tal"},
        {id = 2088917, name = "Teb"},
        {id = 1983345, name = "Tec"},
        {id = 2004876, name = "Ton"},
        {id = 2004782, name = "Tun"},
        {id = 1969054, name = "Yax"},
        {id = 1968550, name = "Zan"}
    },
    
    rare_runes = {
        {id = 2166985, name = "Chac"},
        {id = 2006748, name = "Feo"},
        {id = 2039679, name = "Kry"},
        {id = 2090245, name = "Lac"},
        {id = 2089935, name = "Mot"},
        {id = 2063988, name = "Neo"},
        {id = 2039603, name = "Ner"},
        {id = 2089875, name = "Noc"},
        {id = 2004454, name = "Poc"},
        {id = 2059627, name = "Qax"},
        {id = 2004805, name = "Que"},
        {id = 1969846, name = "Thul"},
        {id = 2093514, name = "Tzic"},
        {id = 2004863, name = "Wat"},
        {id = 2021641, name = "Xal"},
        {id = 1968672, name = "Zec"}
    },
    
    legendary_runes = {
        {id = 2080568, name = "Ahu"},
        {id = 1999352, name = "Bac"},
        {id = 2060652, name = "Eom"},
        {id = 2165977, name = "Igni"},
        {id = 2039543, name = "Jah"},
        {id = 2060482, name = "Lith"},
        {id = 2155997, name = "Nagu"},
        {id = 1969851, name = "Ohm"},
        {id = 1968107, name = "Tam"},
        {id = 2024157, name = "Vex"},
        {id = 2047114, name = "Xan"},
        {id = 2040700, name = "Xol"},
        {id = 2090794, name = "Yom"},
        {id = 2004498, name = "Yul"}
    }
}

-- Function to get all rune IDs as a lookup table for performance
function rune_data.get_all_rune_ids()
    local all_ids = {}
    
    for _, rune in ipairs(rune_data.magic_runes) do
        all_ids[rune.id] = true
    end
    
    for _, rune in ipairs(rune_data.rare_runes) do
        all_ids[rune.id] = true
    end
    
    for _, rune in ipairs(rune_data.legendary_runes) do
        all_ids[rune.id] = true
    end
    
    return all_ids
end

-- Function to get rune quality by ID
function rune_data.get_rune_quality(id)
    for _, rune in ipairs(rune_data.magic_runes) do
        if rune.id == id then return 1 end
    end
    
    for _, rune in ipairs(rune_data.rare_runes) do
        if rune.id == id then return 3 end
    end
    
    for _, rune in ipairs(rune_data.legendary_runes) do
        if rune.id == id then return 5 end
    end
    
    return nil
end

return rune_data
