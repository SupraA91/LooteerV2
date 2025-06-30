--[[
JEWEL DATA MODULE - ALPHABETICALLY ORGANIZED

Create this file as: data/jewel_data.lua

15 high-quality jewels organized alphabetically in one group.
All jewels are Quality 6 (Legendary tier).
]]--

local jewel_data = {
    -- ALL JEWELS - ALPHABETICALLY SORTED
    jewels = {
        {id = 2329805, name = "Brilliant Sigil", quality = 6},
        {id = 2329814, name = "Elemental Brand", quality = 6},
        {id = 2329682, name = "Horadric Crest", quality = 6},
        {id = 2329750, name = "Idol From Below", quality = 6},
        {id = 2329732, name = "Liminal Echo", quality = 6},
        {id = 2329780, name = "Luminate Eye", quality = 6},
        {id = 2329770, name = "Myriad Stone", quality = 6},
        {id = 2329697, name = "Reverie Horn", quality = 6},
        {id = 2329725, name = "Scornful Light", quality = 6},
        {id = 2329621, name = "Seal of Control", quality = 6},
        {id = 2329679, name = "Seal of Denial", quality = 6},
        {id = 2329677, name = "Seal of Power", quality = 6},
        {id = 2329776, name = "Spark of Creation", quality = 6},
        {id = 2330723, name = "The Starflux", quality = 6},
        {id = 2329728, name = "Tyrant Bane", quality = 6}
    }
}

-- Function to get all jewel IDs as a lookup table for performance
function jewel_data.get_all_jewel_ids()
    local all_ids = {}
    
    for _, jewel in ipairs(jewel_data.jewels) do
        all_ids[jewel.id] = true
    end
    
    return all_ids
end

-- Function to get jewel quality by ID
function jewel_data.get_jewel_quality(id)
    for _, jewel in ipairs(jewel_data.jewels) do
        if jewel.id == id then return jewel.quality end
    end
    
    return nil
end

-- Function to get jewel name by ID
function jewel_data.get_jewel_name(id)
    for _, jewel in ipairs(jewel_data.jewels) do
        if jewel.id == id then return jewel.name end
    end
    
    return nil
end

return jewel_data
