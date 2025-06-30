--[[
    QUEST DATA MODULE - ALPHABETIZED (CLEANED)
    
    This module contains all quest item definitions with their IDs and names.
    Quest items are special items required for various quests and activities.
    
    CLEANED: Removed all placeholder items containing "[PH]" in their names.
--]]

local quest_data = {
    quest_items = {
        {id = 1057025, name = "A History of Scosglen"},
        {id = 1703700, name = "Account of Captain Kharov's Madness"},
        {id = 1071585, name = "Acid Flux"},
        {id = 1804430, name = "Alchemist Phial"},
        {id = 1276965, name = "Aldara's Journal"},
        {id = 1059762, name = "Alim's Belongings"},
        {id = 1171633, name = "Bag of Oats"},
        {id = 1259823, name = "Battered Shipment"},
        {id = 1051218, name = "Bloodied Note"},
        {id = 1325067, name = "Bloody Wooden Shard"},
        {id = 1096536, name = "Broken Bear Totem"},
        {id = 1081561, name = "Broken Carving"},
        {id = 1061653, name = "Broken Great Axe of Raekor"},
        {id = 1703702, name = "Burnt Letter"},
        {id = 1071589, name = "Charred Bone"},
        {id = 1325069, name = "Cracked Wooden Idol"},
        {id = 1171635, name = "Crumpled Missive"},
        {id = 1703704, name = "Decoded Letter"},
        {id = 1255333, name = "Faded Old Painting"},
        {id = 1037315, name = "Heirloom from Bottle"},
        {id = 1070034, name = "Hungering Necrolyte's Cache"},
        {id = 1033886, name = "Marsh Snake Venom"},
        {id = 1255579, name = "Merchant's Ledger"},
        {id = 678123, name = "Mordreth's Grimoire"},
        {id = 1036992, name = "Mother's Anguish Essence"},
        {id = 1033936, name = "Timue's Salve"},
        {id = 1266651, name = "Zealot's Blade"}
        -- Note: Removed all "[PH]" placeholder items for cleaner item list
        -- Original count was 75 items, cleaned count is 27 items
    }
}

-- Function to get all quest item IDs as a lookup table for performance
function quest_data.get_all_quest_ids()
    local all_ids = {}
    
    for _, quest_item in ipairs(quest_data.quest_items) do
        all_ids[quest_item.id] = true
    end
    
    return all_ids
end

-- Function to get quest item name by ID
function quest_data.get_quest_name(id)
    for _, quest_item in ipairs(quest_data.quest_items) do
        if quest_item.id == id then
            return quest_item.name
        end
    end
    
    return nil
end

return quest_data
