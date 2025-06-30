local Settings = require("src.settings")
local Utils = require("utils.utils")
local CustomItems = require("data.custom_items")
local ItemLogic = require("src.item_logic")
local RuneData = require("data.rune_data")
local ElixirData = require("data.elixir_data")
-- NEW DATA REQUIRES
local ScrollData = require("data.scroll_data")
local QuestData = require("data.quest_data")
local SigilCompassData = require("data.sigil_compass_data")
local BossData = require("data.boss_data")
local CraftingData = require("data.crafting_data")
local JewelData = require("data.jewel_data") -- JEWEL DATA REQUIRE

local ItemManager = {}

-- FIXED: Updated equipment patterns to match Diablo 4 naming conventions
local item_type_patterns = {
   sigil = { "Nightmare_Sigil", "S07_WitcherSigil", "S07_DRLG_Sigil" },
   compass = { "BSK_Sigil" },
   tribute = { "Undercity_Tribute" },
   equipment = { 
      -- Armor pieces
      "HLM",        -- Helms
      "TRS",        -- Torso/Chest
      "GLV",        -- Gloves
      "LEG",        -- Legs/Pants
      "BTS",        -- Boots
      -- Jewelry
      "Amulet", "Ring",
      -- Weapons - 1H
      "mace", "axe", "sword", "dagger", "wand",
      -- Weapons - 2H
      "Mace", "Axe", "Sword", "Polearm", "Staff", "Bow", "Crossbow", "Glaive", "Quarterstaff",
      -- Offhands - Enhanced focus patterns  
      "offHandsSorc", "offHandSorc", "offHandsDruid", "Shield", "Focus", "focus", "Totem",
      -- Generic patterns
      "Base"
   },
   item_cache = { "Item_Cache" },
   quest = { "Global", "Glyph", "QST", "DGN", "pvp_currency", "S07_Witch_Bonus", "GamblingCurrency_Key", "Experience_PowerUp_Actor" },
   crafting = { "CraftingMaterial", "Crafting_Legendary" },
   recipe = { "Tempering_Recipe", "Item_Book_Generic", "Item_Book_Horadrim", "Test_Mount", "mnt_amor", "MountReins" },
   cinders = { "Test_BloodMoon_Currency" },
   scroll = { "Scroll_Of" },
   rune = { "Generic_Rune", "S07_Socketable"}
}

-- FIXED: Generic function to check item type - removed hardcoded rarity check
function ItemManager.check_item_type(item, type_name)
   local item_info = item:get_item_info()
   local name = item_info:get_skin_name()

   -- REMOVED the problematic rarity check that was preventing equipment pickup
   -- Equipment detection should be based on patterns only, rarity is checked later
   
   for _, pattern in ipairs(item_type_patterns[type_name] or {}) do
      if name:find(pattern) then
         return true
      end
   end
   return false
end

-- Updated function to check if item is an elixir using ElixirData
function ItemManager.check_is_elixir(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   local all_elixir_ids = ElixirData.get_all_elixir_ids()
   return all_elixir_ids[id] ~= nil
end

-- Function to check if specific elixir should be picked up
function ItemManager.check_is_wanted_elixir(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   
   if not ItemManager.check_is_elixir(item) then
      return false
   end
   
   return Settings.is_elixir_enabled_by_id(id)
end

-- NEW: Function to check if item is a scroll using ScrollData
function ItemManager.check_is_scroll_new(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   local all_scroll_ids = ScrollData.get_all_scroll_ids()
   return all_scroll_ids[id] ~= nil
end

-- NEW: Function to check if specific scroll should be picked up
function ItemManager.check_is_wanted_scroll(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   
   if not ItemManager.check_is_scroll_new(item) then
      return false
   end
   
   return Settings.is_scroll_enabled_by_id(id)
end

-- NEW: Function to check if item is a quest item using QuestData
function ItemManager.check_is_quest_item_new(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   local all_quest_ids = QuestData.get_all_quest_ids()
   return all_quest_ids[id] ~= nil
end

-- NEW: Function to check if specific quest item should be picked up
function ItemManager.check_is_wanted_quest_item(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   
   if not ItemManager.check_is_quest_item_new(item) then
      return false
   end
   
   return Settings.is_quest_enabled_by_id(id)
end

-- NEW: Function to check if item is a sigil/compass item using SigilCompassData
function ItemManager.check_is_sigil_compass_item(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   local all_sigil_compass_ids = SigilCompassData.get_all_sigil_compass_ids()
   return all_sigil_compass_ids[id] ~= nil
end

-- NEW: Function to check if specific sigil/compass item should be picked up
function ItemManager.check_is_wanted_sigil_compass_item(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   
   if not ItemManager.check_is_sigil_compass_item(item) then
      return false
   end
   
   return Settings.is_sigil_compass_enabled_by_id(id)
end

-- NEW: Function to check if item is a boss item using BossData
function ItemManager.check_is_boss_item_new(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   local all_boss_ids = BossData.get_all_boss_ids()
   return all_boss_ids[id] ~= nil
end

-- NEW: Function to check if specific boss item should be picked up
function ItemManager.check_is_wanted_boss_item(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   
   if not ItemManager.check_is_boss_item_new(item) then
      return false
   end
   
   return Settings.is_boss_enabled_by_id(id)
end

-- NEW: Function to check if item is a crafting item using CraftingData
function ItemManager.check_is_crafting_item_new(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   local all_crafting_ids = CraftingData.get_all_crafting_ids()
   return all_crafting_ids[id] ~= nil
end

-- NEW: Function to check if specific crafting item should be picked up
function ItemManager.check_is_wanted_crafting_item(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   
   if not ItemManager.check_is_crafting_item_new(item) then
      return false
   end
   
   return Settings.is_crafting_enabled_by_id(id)
end

-- JEWEL FUNCTIONS - NEW
-- Function to check if item is a jewel using JewelData
function ItemManager.check_is_jewel(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   local all_jewel_ids = JewelData.get_all_jewel_ids()
   return all_jewel_ids[id] ~= nil
end

-- Function to check if specific jewel should be picked up
function ItemManager.check_is_wanted_jewel(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   
   if not ItemManager.check_is_jewel(item) then
      return false
   end
   
   return Settings.is_jewel_enabled_by_id(id)
end

-- UPDATED: check_item_stack function with new item types including jewels
function ItemManager.check_item_stack(item, id)
   local stack = 1
   
   -- Check if it's an elixir and get appropriate stack size
   if ItemManager.check_is_elixir(item) then
      stack = 99 -- All elixirs stack to 99
   elseif ItemManager.check_is_scroll_new(item) then
      stack = 20 -- Scrolls stack to 20
   elseif ItemManager.check_is_quest_item_new(item) then
      stack = 1 -- Quest items typically don't stack
   elseif ItemManager.check_is_sigil_compass_item(item) then
      stack = 99 -- Sigils and compass items stack to 99
   elseif ItemManager.check_is_boss_item_new(item) then
      stack = 99 -- Boss items stack to 99
   elseif ItemManager.check_is_crafting_item_new(item) then
      stack = 999 -- Crafting materials stack to 999
   elseif ItemManager.check_is_jewel(item) then
      stack = 1 -- Jewels don't stack
   elseif ItemManager.check_is_scroll(item) then
      stack = 20
   elseif CustomItems.boss_items[id] then
      stack = 99
   elseif ItemManager.check_is_rune(item) then
      stack = 100
   end

   return stack
end

function ItemManager.check_is_cinders(item)
   return ItemManager.check_item_type(item, "cinders")
end

function ItemManager.check_is_tribute(item)
   return ItemManager.check_item_type(item, "tribute")
end

function ItemManager.check_is_sigil(item)
   return ItemManager.check_item_type(item, "sigil")
end

function ItemManager.check_is_compass(item)
   return ItemManager.check_item_type(item, "compass")
end

function ItemManager.check_is_equipment(item)
   return ItemManager.check_item_type(item, "equipment")
end

function ItemManager.check_is_quest_item(item)
   return ItemManager.check_item_type(item, "quest")
end

function ItemManager.check_is_crafting(item)
   return ItemManager.check_item_type(item, "crafting")
end

function ItemManager.check_is_recipe(item)
   return ItemManager.check_item_type(item, "recipe")
end

function ItemManager.check_is_item_cache(item)
   return ItemManager.check_item_type(item, "item_cache")
end

function ItemManager.check_is_scroll(item)
   return ItemManager.check_item_type(item, "scroll")
end

function ItemManager.check_is_cache(item)
   return ItemManager.check_item_type(item, "cache")
end

function ItemManager.check_is_rune(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   local all_rune_ids = RuneData.get_all_rune_ids()
   return all_rune_ids[id] ~= nil
end

-- Function to check if specific rune should be picked up
function ItemManager.check_is_wanted_rune(item)
   local item_info = item:get_item_info()
   local id = item_info:get_sno_id()
   
   if not ItemManager.check_is_rune(item) then
      return false
   end
   
   return Settings.is_rune_enabled(id)
end

function ItemManager.check_is_opal(item)
   return ItemManager.check_item_type(item, "opal")
end

---@param item game.object Item to check
---@param ignore_distance boolean If we want to ignore the distance check
function ItemManager.check_want_item(item, ignore_distance)
   local item_info = item:get_item_info()
   if not item_info then 
      return false 
   end

   local settings = Settings.get()
   local id = item_info:get_sno_id()
   local display_name = item_info:get_display_name() or "Unknown"
   local rarity = item_info:get_rarity()
   local affixes = item_info:get_affixes()

   -- Early return checks
   if not ignore_distance and Utils.distance_to(item) >= settings.distance then 
      return false 
   end
   if settings.skip_dropped and #affixes > 0 then 
      return false 
   end
   if loot_manager.is_gold(item) or loot_manager.is_potion(item) then 
      return false 
   end
   
   -- RUNE CHECK (Priority check to prevent falling through to equipment logic)
   if ItemManager.check_is_rune(item) then
      if settings.rune and ItemManager.check_is_wanted_rune(item) then
         -- Socketable inventory check and existing stack check
         if not Utils.is_socketable_inventory_full() or
               Utils.is_lowest_stack_below(
                  get_local_player():get_socketable_items(),
                  id,
                  ItemManager.check_item_stack(item, id),
                  item_info:get_stack_count()
               ) then
            return true
         else
            return false
         end
      else
         return false
      end
   end
   
   -- JEWEL CHECK (Priority check to prevent falling through to equipment logic)
   if ItemManager.check_is_jewel(item) then
      if settings.jewel_items and ItemManager.check_is_wanted_jewel(item) then
         -- Socketable inventory check and existing stack check (same as runes)
         if not Utils.is_socketable_inventory_full() or
               Utils.is_lowest_stack_below(
                  get_local_player():get_socketable_items(),
                  id,
                  ItemManager.check_item_stack(item, id),
                  item_info:get_stack_count()
               ) then
            return true
         else
            return false
         end
      else
         return false
      end
   end
   
   -- ELIXIR CHECK
   if ItemManager.check_is_elixir(item) then
      if settings.elixir_items and ItemManager.check_is_wanted_elixir(item) then
         return true
      else
         return false
      end
   end

   -- TRIBUTE CHECK
   local is_tribute_item = settings.tribute and ItemManager.check_is_tribute(item)
   if is_tribute_item then
      return true
   end
      
   -- NEW ITEM TYPES CHECK
   local is_new_scroll = settings.scroll_items and ItemManager.check_is_wanted_scroll(item)
   local is_new_quest = settings.quest_items and ItemManager.check_is_wanted_quest_item(item)
   local is_new_sigil_compass = settings.sigil_compass_items and ItemManager.check_is_wanted_sigil_compass_item(item)
   local is_new_boss = settings.boss_items and ItemManager.check_is_wanted_boss_item(item)
   local is_new_crafting = settings.crafting_items and ItemManager.check_is_wanted_crafting_item(item)

   -- CONSUMABLE ITEMS
   local is_consumable_item = 
      (settings.boss_items and CustomItems.boss_items[id]) or
      (settings.elixir_items and ItemManager.check_is_wanted_elixir(item)) or
      (settings.scroll and ItemManager.check_is_scroll(item)) or -- Old scroll check
      is_new_scroll or -- New scroll check
      is_new_boss -- New boss items
      -- NOTE: jewels go to socketable inventory, not consumable

   -- SIGIL ITEMS
   local is_sigils = 
      (settings.sigils and ItemManager.check_is_sigil(item)) or
      (settings.tribute and ItemManager.check_is_tribute(item)) or
      (settings.compass and ItemManager.check_is_compass(item)) or
      is_new_sigil_compass -- New sigil/compass check

   local is_quest_item = settings.quest_items and ItemManager.check_is_quest_item(item) or is_new_quest
   local is_event_item = settings.event_items and CustomItems.event_items[id]
   local is_cinders = settings.cinders and ItemManager.check_is_cinders(item)
   local is_crafting_item = settings.crafting_items and ItemManager.check_is_crafting(item) or is_new_crafting
   local is_recipe = settings.crafting_items and ItemManager.check_is_recipe(item)
   local is_item_cache = ItemManager.check_is_item_cache(item)

   -- ITEM TYPE PROCESSING
   if is_event_item then
      if Utils.is_inventory_full() then
         return false 
      elseif Utils.is_consumable_inventory_full() then
         return true 
      end
   elseif is_crafting_item or is_cinders or is_new_crafting then
      return true
   elseif is_sigils then
      if not Utils.is_sigil_inventory_full() then
         return true
      end
   elseif is_consumable_item then
      if not Utils.is_consumable_inventory_full() or
            Utils.is_lowest_stack_below(
               get_local_player():get_consumable_items(),
               id,
               ItemManager.check_item_stack(item, id),
               item_info:get_stack_count()
            ) then
         return true
      end
   elseif is_recipe then
      if not Utils.is_inventory_full() then
         return true
      end
   elseif is_item_cache then
      if not Utils.is_inventory_full() then
         return true
      end
   elseif is_quest_item then
      return true
   end

   -- EQUIPMENT HANDLING - COMPLETELY REWRITTEN TO AVOID MISSING FUNCTION
   if ItemManager.check_is_equipment(item) then
      local inventory_full = Utils.is_inventory_full()
      
      if inventory_full then
         return false
      end

      -- Use the rarity setting from General Settings dropdown
      if rarity < settings.rarity then
         return false
      end

      -- INLINE EQUIPMENT LOGIC - No dependency on missing ItemLogic.check_item_logic
      -- For Common rarity (0), just return true since no GA requirements
      if rarity < 5 then
         -- Common, Magic, Rare items - no GA requirements
         return true
      end
      
      -- For Legendary (5) and higher - check GA requirements
      local greater_affix_count = Utils.get_greater_affix_count(display_name)
      local required_ga_count = 0
      
      if settings.custom_toggle then
         -- Custom GA requirements per item type
         if rarity == 5 then -- Legendary
            -- Check each item type and set required GA count
            if ItemLogic.is_legendary_amulet and ItemLogic.is_legendary_amulet(item) then
               required_ga_count = settings.legendary_amulet_ga_count or 2
            elseif ItemLogic.is_legendary_ring and ItemLogic.is_legendary_ring(item) then
               required_ga_count = settings.legendary_ring_ga_count or 2
            elseif ItemLogic.is_legendary_helm and ItemLogic.is_legendary_helm(item) then
               required_ga_count = settings.legendary_helm_ga_count or 2
            elseif ItemLogic.is_legendary_chest and ItemLogic.is_legendary_chest(item) then
               required_ga_count = settings.legendary_chest_ga_count or 2
            elseif ItemLogic.is_legendary_gloves and ItemLogic.is_legendary_gloves(item) then
               required_ga_count = settings.legendary_gloves_ga_count or 2
            elseif ItemLogic.is_legendary_pants and ItemLogic.is_legendary_pants(item) then
               required_ga_count = settings.legendary_pants_ga_count or 2
            elseif ItemLogic.is_legendary_boots and ItemLogic.is_legendary_boots(item) then
               required_ga_count = settings.legendary_boots_ga_count or 2
            else
               -- Default legendary GA count
               required_ga_count = settings.ga_count or 0
            end
         elseif rarity == 6 then -- Unique
            -- Check each item type and set required GA count
            if ItemLogic.is_unique_amulet and ItemLogic.is_unique_amulet(item) then
               required_ga_count = settings.unique_amulet_ga_count or 0
            elseif ItemLogic.is_unique_ring and ItemLogic.is_unique_ring(item) then
               required_ga_count = settings.unique_ring_ga_count or 0
            elseif ItemLogic.is_unique_helm and ItemLogic.is_unique_helm(item) then
               required_ga_count = settings.unique_helm_ga_count or 0
            elseif ItemLogic.is_unique_chest and ItemLogic.is_unique_chest(item) then
               required_ga_count = settings.unique_chest_ga_count or 0
            elseif ItemLogic.is_unique_gloves and ItemLogic.is_unique_gloves(item) then
               required_ga_count = settings.unique_gloves_ga_count or 0
            elseif ItemLogic.is_unique_pants and ItemLogic.is_unique_pants(item) then
               required_ga_count = settings.unique_pants_ga_count or 0
            elseif ItemLogic.is_unique_boots and ItemLogic.is_unique_boots(item) then
               required_ga_count = settings.unique_boots_ga_count or 0
            else
               -- Default unique GA count
               required_ga_count = settings.unique_ga_count or 0
            end
         elseif rarity == 8 then -- Uber Unique
            required_ga_count = CustomItems.ubers and CustomItems.ubers[id] and settings.uber_unique_ga_count or settings.unique_ga_count or 4
         else
            required_ga_count = 0
         end
      else
         -- Standard GA requirements
         if rarity == 5 then  -- Legendary
            required_ga_count = settings.ga_count or 0
         elseif rarity == 6 then  -- Unique
            required_ga_count = settings.unique_ga_count or 0
         elseif rarity == 8 then  -- Uber Unique
            required_ga_count = CustomItems.ubers and CustomItems.ubers[id] and settings.uber_unique_ga_count or settings.unique_ga_count or 4
         else
            required_ga_count = 0
         end
      end
      
      -- Check if item meets GA requirements
      if greater_affix_count >= required_ga_count then
         return true
      else
         return false
      end
   end

   return false
end

function ItemManager.get_nearby_item()
   local items = actors_manager:get_all_items()
   local fetched_items = {}

   for _, item in pairs(items) do
      if ItemManager.check_want_item(item, false) then
         table.insert(fetched_items, item)
      end
   end

   table.sort(fetched_items, function(x, y)
      return Utils.distance_to(x) < Utils.distance_to(y)
   end)

   return fetched_items[1]
end

function ItemManager.calculate_item_score(item)
   local score = 0
   local item_info = item:get_item_info()
   local item_id = item_info:get_sno_id()
   local display_name = item_info:get_display_name()
   local item_rarity = item_info:get_rarity()

   if CustomItems.ubers and CustomItems.ubers[item_id] then
      score = score + 1000
   elseif item_rarity >= 5 then
      score = score + 500
   elseif item_rarity >= 3 then
      score = score + 300
   elseif item_rarity >= 1 then
      score = score + 100
   else
      score = score + 10
   end

   local greater_affix_count = Utils.get_greater_affix_count(display_name)

   if greater_affix_count == 3 then
      score = score + 100
   elseif greater_affix_count == 2 then
      score = score + 75
   elseif greater_affix_count == 1 then
      score = score + 50
   end

   return score
end

function ItemManager.get_best_item()
   local items = actors_manager:get_all_items()
   local scored_items = {}

   for _, item in ipairs(items) do
      if ItemManager.check_want_item(item, false) then
         local item_object = { Item = item, Score = ItemManager.calculate_item_score(item) }
         table.insert(scored_items, item_object)
      end
   end

   table.sort(scored_items, function(x, y)
      return x.Score > y.Score
   end)

   return scored_items[1]
end

function ItemManager.get_item_based_on_priority()
   local settings = Settings.get()
   if settings.loot_priority == 0 then
      return ItemManager.get_nearby_item()
   else
      return ItemManager.get_best_item()
   end
end

-- ENHANCED DEBUG FUNCTION - Now shows equipment detection details
function ItemManager.debug_nearby_items()
   console.print("=== ITEM DETECTION DEBUG ===")
   local items = actors_manager:get_all_items()
   local count = 0
   
   for _, item in pairs(items) do
      count = count + 1
      if count <= 5 then -- Only check first 5 items to avoid spam
         local item_info = item:get_item_info()
         if item_info then
            local id = item_info:get_sno_id()
            local display_name = item_info:get_display_name()
            local skin_name = item_info:get_skin_name()
            local rarity = item_info:get_rarity()
            local distance = Utils.distance_to(item)
            
            console.print("ITEM " .. count .. ": " .. display_name .. " (ID: " .. id .. ")")
            console.print("  Skin: " .. skin_name .. " | Rarity: " .. rarity .. " | Distance: " .. string.format("%.1f", distance))
            
            -- Test if it's equipment
            local is_equipment = ItemManager.check_is_equipment(item)
            console.print("  is_equipment: " .. tostring(is_equipment))
            
            if is_equipment then
               local settings = Settings.get()
               console.print("  settings.rarity: " .. tostring(settings.rarity))
               console.print("  rarity >= settings.rarity: " .. tostring(rarity >= settings.rarity))
               
               if rarity >= settings.rarity then
                  if rarity >= 5 then
                     local greater_affix_count = Utils.get_greater_affix_count(display_name)
                     console.print("  Greater Affix Count: " .. tostring(greater_affix_count))
                     console.print("  Required GA Count: " .. tostring(settings.ga_count or 0))
                  else
                     console.print("  No GA requirements (rarity < 5)")
                  end
               end
            end
            
            -- Test overall want item
            local want_item = ItemManager.check_want_item(item, true)
            console.print("  WANT_ITEM: " .. tostring(want_item))
            console.print("")
         end
      end
   end
   
   console.print("Total items found: " .. count)
   console.print("=== END ITEM DEBUG ===")
end

function ItemManager.debug_new_item_types()
   console.print("=== NEW ITEM TYPES DEBUG ===")
   local items = actors_manager:get_all_items()
   local count = 0
   local settings = Settings.get()
   
   console.print("Settings Check:")
   console.print("  scroll_items: " .. tostring(settings.scroll_items))
   console.print("  quest_items: " .. tostring(settings.quest_items))
   console.print("  sigil_compass_items: " .. tostring(settings.sigil_compass_items))
   console.print("  boss_items: " .. tostring(settings.boss_items))
   console.print("  crafting_items: " .. tostring(settings.crafting_items))
   console.print("  jewel_items: " .. tostring(settings.jewel_items))
   console.print("")
   
   for _, item in pairs(items) do
      count = count + 1
      if count <= 10 then -- Check first 10 items
         local item_info = item:get_item_info()
         if item_info then
            local id = item_info:get_sno_id()
            local display_name = item_info:get_display_name()
            
            console.print("ITEM " .. count .. ": " .. display_name .. " (ID: " .. id .. ")")
            
            -- Test new item type checks
            local is_scroll = ItemManager.check_is_scroll_new(item)
            local is_quest = ItemManager.check_is_quest_item_new(item)
            local is_sigil_compass = ItemManager.check_is_sigil_compass_item(item)
            local is_boss = ItemManager.check_is_boss_item_new(item)
            local is_crafting = ItemManager.check_is_crafting_item_new(item)
            local is_jewel = ItemManager.check_is_jewel(item)
            
            console.print("  is_scroll_new: " .. tostring(is_scroll))
            console.print("  is_quest_new: " .. tostring(is_quest))
            console.print("  is_sigil_compass: " .. tostring(is_sigil_compass))
            console.print("  is_boss_new: " .. tostring(is_boss))
            console.print("  is_crafting_new: " .. tostring(is_crafting))
            console.print("  is_jewel: " .. tostring(is_jewel))
            
            -- Test overall want item
            local want_item = ItemManager.check_want_item(item, true)
            console.print("  WANT_ITEM: " .. tostring(want_item))
            console.print("")
         end
      end
   end
   
   console.print("Total items found: " .. count)
   console.print("=== END NEW ITEM TYPES DEBUG ===")
end

return ItemManager
