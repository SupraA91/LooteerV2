--[[
    SCROLL DATA MODULE - ALPHABETIZED
    
    This module contains all scroll definitions with their IDs and names.
    Scrolls are consumable items that provide various effects.
--]]

local scroll_data = {
    scrolls = {
        {id = 1971857, name = "Abyssal Scroll"},
        {id = 1893929, name = "Scroll of Abundance"},
        {id = 1903744, name = "Scroll of Contained Goblins"},
        {id = 1921699, name = "Scroll of Generosity"},
        {id = 1983728, name = "Scroll of Restoration"}
    }
}

-- Function to get all scroll IDs as a lookup table for performance
function scroll_data.get_all_scroll_ids()
    local all_ids = {}
    
    for _, scroll in ipairs(scroll_data.scrolls) do
        all_ids[scroll.id] = true
    end
    
    return all_ids
end

-- Function to get scroll name by ID
function scroll_data.get_scroll_name(id)
    for _, scroll in ipairs(scroll_data.scrolls) do
        if scroll.id == id then
            return scroll.name
        end
    end
    
    return nil
end

return scroll_data
