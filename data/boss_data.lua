--[[
    BOSS DATA MODULE - ALPHABETIZED
    
    This module contains all boss item definitions with their IDs and names.
    Boss items are Lair Boss Keys used to summon and fight various bosses.
--]]

local boss_data = {
    boss_items = {
        {id = 2194097, name = "Abhorrent Heart"},
        {id = 2194099, name = "Betrayer's Husk"},
        {id = 1489411, name = "Trembling Hand"},
        {id = 2193876, name = "Judicator's Mask"},
        {id = 1524917, name = "Mucus-Slick Egg"},
        {id = 1810144, name = "Sandscorched Shackles"},
        {id = 2193986, name = "Seeker's Head"},
        {id = 2193983, name = "Tormented Effigy"},
        {id = 2193984, name = "Twisted Horn"},
        {id = 2193878, name = "Vicious Fang"},
        {id = 2193877, name = "Wrathful Heart"},
        {id = 2193982, name = "Grotesque Deformity"},
        {id = 2193987, name = "Malformed Shadow"},
        {id = 2193881, name = "Skeletal Construct"},
        {id = 2193879, name = "Withered Branch"}
    }
}

-- Function to get all boss item IDs as a lookup table for performance
function boss_data.get_all_boss_ids()
    local all_ids = {}
    
    for _, boss_item in ipairs(boss_data.boss_items) do
        all_ids[boss_item.id] = true
    end
    
    return all_ids
end

-- Function to get boss item name by ID
function boss_data.get_boss_name(id)
    for _, boss_item in ipairs(boss_data.boss_items) do
        if boss_item.id == id then
            return boss_item.name
        end
    end
    
    return nil
end

return boss_data
