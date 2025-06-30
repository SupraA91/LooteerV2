local elixir_data = {
    -- ALPHABETIZED: Organized by unique names with arrays of IDs for duplicates
    basic_elixirs = {
        {name = "Elixir of Advantage", ids = {1841186}},
        {name = "Elixir of Cold Resistance", ids = {1066488, 1066604}},
        {name = "Elixir of Destruction", ids = {1841277}},
        {name = "Elixir of Fire Resistance", ids = {1066694, 1066492}},
        {name = "Elixir of Fortitude", ids = {413331, 1841344}},
        {name = "Elixir of Iron Barbs", ids = {1060592}},
        {name = "Elixir of Lightning Resistance", ids = {1066495, 1066706}},
        {name = "Elixir of Poison Resistance", ids = {1066720, 1066497}},
        {name = "Elixir of Precision", ids = {1066499}},
        {name = "Elixir of Resourcefulness", ids = {701382, 1841174}},
        {name = "Elixir of Shadow Resistance", ids = {1066501, 1067052}}
    },
    
    advanced_elixirs = {
        {name = "Elixir of Advantage II", ids = {1841197}},
        {name = "Elixir of Cold Resistance II", ids = {1066668}},
        {name = "Elixir of Destruction II", ids = {1841287}},
        {name = "Elixir of Fire Resistance II", ids = {1066704}},
        {name = "Elixir of Fortitude II", ids = {1841327}},
        {name = "Elixir of Hollow Unmaking", ids = {1991376}},
        {name = "Elixir of Iron Barbs II", ids = {1060634}},
        {name = "Elixir of Lightning Resistance II", ids = {1066718}},
        {name = "Elixir of Poison Resistance II", ids = {1066727}},
        {name = "Elixir of Precision II", ids = {1066737}},
        {name = "Elixir of Resourcefulness II", ids = {1841178}},
        {name = "Elixir of Shadow Resistance II", ids = {1067122}}
    },
    
    rare_elixirs = {
        {name = "Elixir of Aggression", ids = {1909700}},
        {name = "Elixir of Holy Bolts", ids = {1856350}},
        {name = "Elixir of Momentum", ids = {1856252}},
        {name = "Elixir of Sacrifice", ids = {1908277}},
        {name = "Elixir of Swift Revival", ids = {1952998}},
        {name = "Elixir of Tailwind", ids = {1910431}},
        {name = "Profane Mindcage", ids = {1882910}}
    },
    
    seasonal_elixirs = {
        -- All seasonal elixirs removed as they don't start with "Elixir"
        -- Keep this structure for future seasonal elixirs
    }
}

-- Function to get all elixir IDs as a lookup table for performance
function elixir_data.get_all_elixir_ids()
    local all_ids = {}
    
    for _, elixir in ipairs(elixir_data.basic_elixirs) do
        for _, id in ipairs(elixir.ids) do
            all_ids[id] = true
        end
    end
    
    for _, elixir in ipairs(elixir_data.advanced_elixirs) do
        for _, id in ipairs(elixir.ids) do
            all_ids[id] = true
        end
    end
    
    for _, elixir in ipairs(elixir_data.rare_elixirs) do
        for _, id in ipairs(elixir.ids) do
            all_ids[id] = true
        end
    end
    
    for _, elixir in ipairs(elixir_data.seasonal_elixirs) do
        for _, id in ipairs(elixir.ids) do
            all_ids[id] = true
        end
    end
    
    return all_ids
end

-- Function to get elixir quality by ID
function elixir_data.get_elixir_quality(id)
    for _, elixir in ipairs(elixir_data.basic_elixirs) do
        for _, elixir_id in ipairs(elixir.ids) do
            if elixir_id == id then return 0 end
        end
    end
    
    for _, elixir in ipairs(elixir_data.advanced_elixirs) do
        for _, elixir_id in ipairs(elixir.ids) do
            if elixir_id == id then return 1 end
        end
    end
    
    for _, elixir in ipairs(elixir_data.rare_elixirs) do
        for _, elixir_id in ipairs(elixir.ids) do
            if elixir_id == id then return 3 end
        end
    end
    
    for _, elixir in ipairs(elixir_data.seasonal_elixirs) do
        for _, elixir_id in ipairs(elixir.ids) do
            if elixir_id == id then return 4 end
        end
    end
    
    return nil
end

-- Function to get elixir name by ID
function elixir_data.get_elixir_name(id)
    for _, elixir in ipairs(elixir_data.basic_elixirs) do
        for _, elixir_id in ipairs(elixir.ids) do
            if elixir_id == id then return elixir.name end
        end
    end
    
    for _, elixir in ipairs(elixir_data.advanced_elixirs) do
        for _, elixir_id in ipairs(elixir.ids) do
            if elixir_id == id then return elixir.name end
        end
    end
    
    for _, elixir in ipairs(elixir_data.rare_elixirs) do
        for _, elixir_id in ipairs(elixir.ids) do
            if elixir_id == id then return elixir.name end
        end
    end
    
    for _, elixir in ipairs(elixir_data.seasonal_elixirs) do
        for _, elixir_id in ipairs(elixir.ids) do
            if elixir_id == id then return elixir.name end
        end
    end
    
    return nil
end

return elixir_data
