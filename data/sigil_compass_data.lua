--[[
    SIGIL COMPASS DATA MODULE - ALPHABETIZED
    
    This module contains all sigil and compass item definitions with their IDs and names.
    Includes Nightmare Sigils and Reputation Cache items (compass items).
--]]

local sigil_compass_data = {
    sigil_compass_items = {
        {id = 2235946, name = "Greater Lair Cache"},
        {id = 1960160, name = "Infernal Compass"},
        {id = 2235931, name = "Resplendent Cache"},
        {id = 2193985, name = "Sigil of the Seeker"},
        {id = 2125691, name = "Tribute of Harmony"},
        {id = 2090362, name = "Tribute of Ascendance (Resolute)"},
        {id = 2125049, name = "Tribute of Ascendance (United)"},
        {id = 2194038, name = "Tribute of Growth"},
        {id = 2077993, name = "Tribute of Heritage"},
        {id = 2090356, name = "Tribute of Mastery"},
        {id = 2090354, name = "Tribute of Power"},
        {id = 2077995, name = "Tribute of Refinement"},
        {id = 2090360, name = "Tribute of Resilience"},
        {id = 2090358, name = "Tribute of Titans"},
        {id = 2090364, name = "Tribute of Unity"},
        {id = 2194036, name = "Tribute of Wisdom"}
    }
}

-- Function to get all sigil/compass item IDs as a lookup table for performance
function sigil_compass_data.get_all_sigil_compass_ids()
    local all_ids = {}
    
    for _, item in ipairs(sigil_compass_data.sigil_compass_items) do
        all_ids[item.id] = true
    end
    
    return all_ids
end

-- Function to get sigil/compass item name by ID
function sigil_compass_data.get_sigil_compass_name(id)
    for _, item in ipairs(sigil_compass_data.sigil_compass_items) do
        if item.id == id then
            return item.name
        end
    end
    
    return nil
end

return sigil_compass_data
