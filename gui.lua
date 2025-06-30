local options = require("data.gui_options")
local RuneData = require("data.rune_data")
local ElixirData = require("data.elixir_data")
-- NEW DATA IMPORTS
local ScrollData = require("data.scroll_data")
local QuestData = require("data.quest_data")
local SigilCompassData = require("data.sigil_compass_data")
local BossData = require("data.boss_data")
local CraftingData = require("data.crafting_data")
local JewelData = require("data.jewel_data")
local plugin_label = "Looter (Pirated Edition) "
local gui = {}
local version = "v2.0.1 (Supra)"

gui.elements = {
  main_tree = tree_node:new(0),
  main_toggle = checkbox:new(false, get_hash(plugin_label .. "_main_toggle")),
  
  general = {
     tree = tree_node:new(1),
     behavior_combo = combo_box:new(0, get_hash(plugin_label .. "_behavior_combo")),
     loot_priority_combo = combo_box:new(0, get_hash(plugin_label .. "_loot_priority_combo")), 
     rarity_combo = combo_box:new(0, get_hash(plugin_label .. "_rarity_combo")),
     distance_slider = slider_int:new(1, 30, 2, get_hash(plugin_label .. "_distance_slider")),
     skip_dropped_toggle = checkbox:new(false, get_hash(plugin_label .. "_skip_dropped_toggle")),
  },

  affix_settings = {
     tree = tree_node:new(1),
     greater_affix_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_greater_affix_slider")),
     unique_greater_affix_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_greater_affix_slider")),
     uber_unique_greater_affix_slider = slider_int:new(0, 4, 4, get_hash(plugin_label .. "_uber_unique_greater_affix_slider")),
     custom_toggle = checkbox:new(false, get_hash(plugin_label .. "_custom_toggle")),
     armorsTree = tree_node:new(1),
     jewerlyTree = tree_node:new(1),
     weaponsTree = tree_node:new(1),
     legendary_helm_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_helm_slider")),
     legendary_chest_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_chest_slider")),
     legendary_gloves_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_gloves_slider")),
     legendary_pants_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_pants_slider")),
     legendary_boots_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_boots_slider")),
     legendary_amulet_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_amulet_slider")),
     legendary_ring_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_ring_slider")),
     unique_helm_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_helm_slider")),
     unique_chest_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_chest_slider")),
     unique_gloves_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_gloves_slider")),
     unique_pants_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_pants_slider")),
     unique_boots_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_boots_slider")),
     unique_amulet_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_amulet_slider")),
     unique_ring_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_ring_slider")),
     legendary_1h_weapon_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_1h_weapon_slider")),
     legendary_2h_weapon_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_2h_weapon_slider")),
     legendary_offhand_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_offhand_slider")),
     unique_1h_weapon_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_1h_weapon_slider")),
     unique_2h_weapon_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_2h_weapon_slider")),
     unique_offhand_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_offhand_slider")),
  },

  item_types = {
     tree = tree_node:new(1),
     event_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_event_items_toggle")),
     quest_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_quest_items_toggle")),
     crafting_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_crafting_items_toggle")),
     boss_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_boss_items_toggle")),
     
     -- NEW ITEM TYPE TOGGLES
     scroll_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_scroll_items_toggle")),
     sigil_compass_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_sigil_compass_items_toggle")),
     
     -- Replaced individual elixir toggles with main elixir toggle
     elixir_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_elixir_items_toggle")),
     
     -- Keep existing toggles for backward compatibility
     sigil_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_sigil_items_toggle")),
     compass_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_compass_items_toggle")),
     rune_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_rune_items_toggle")),
     tribute_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_tribute_items_toggle")),
     scroll_items_toggle_old = checkbox:new(false, get_hash(plugin_label .. "_scroll_items_toggle_old")),
     cinders_toggle = checkbox:new(false, get_hash(plugin_label .. "_cinders_toggle")),
     jewel_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_jewel_items_toggle")),
  },

  rune_settings = {
     tree = tree_node:new(1),
     search_combo = combo_box:new(0, get_hash(plugin_label .. "_rune_search")),
     search_text = input_text:new(get_hash(plugin_label .. "_rune_search_text")),
     magic_tree = tree_node:new(1), 
     rare_tree = tree_node:new(1),
     legendary_tree = tree_node:new(1),
     magic_runes = {},
     rare_runes = {},
     legendary_runes = {},
     -- Enable/Disable All buttons
     magic_enable_all = checkbox:new(false, get_hash(plugin_label .. "_magic_enable_all")),
     magic_disable_all = checkbox:new(false, get_hash(plugin_label .. "_magic_disable_all")),
     rare_enable_all = checkbox:new(false, get_hash(plugin_label .. "_rare_enable_all")),
     rare_disable_all = checkbox:new(false, get_hash(plugin_label .. "_rare_disable_all")),
     legendary_enable_all = checkbox:new(false, get_hash(plugin_label .. "_legendary_enable_all")),
     legendary_disable_all = checkbox:new(false, get_hash(plugin_label .. "_legendary_disable_all"))
  },

  elixir_settings = {
     tree = tree_node:new(1),
     search_combo = combo_box:new(0, get_hash(plugin_label .. "_elixir_search")),
     search_text = input_text:new(get_hash(plugin_label .. "_elixir_search_text")),
     basic_tree = tree_node:new(1),
     advanced_tree = tree_node:new(1),
     rare_tree = tree_node:new(1),
     seasonal_tree = tree_node:new(1),
     basic_elixirs = {},
     advanced_elixirs = {},
     rare_elixirs = {},
     seasonal_elixirs = {},
     -- Enable/Disable All buttons
     basic_enable_all = checkbox:new(false, get_hash(plugin_label .. "_basic_enable_all")),
     basic_disable_all = checkbox:new(false, get_hash(plugin_label .. "_basic_disable_all")),
     advanced_enable_all = checkbox:new(false, get_hash(plugin_label .. "_advanced_enable_all")),
     advanced_disable_all = checkbox:new(false, get_hash(plugin_label .. "_advanced_disable_all")),
     rare_enable_all = checkbox:new(false, get_hash(plugin_label .. "_rare_enable_all")),
     rare_disable_all = checkbox:new(false, get_hash(plugin_label .. "_rare_disable_all")),
     seasonal_enable_all = checkbox:new(false, get_hash(plugin_label .. "_seasonal_enable_all")),
     seasonal_disable_all = checkbox:new(false, get_hash(plugin_label .. "_seasonal_disable_all"))
  },

  jewel_settings = {
   tree = tree_node:new(1),
   search_combo = combo_box:new(0, get_hash(plugin_label .. "_jewel_search")),
   search_text = input_text:new(get_hash(plugin_label .. "_jewel_search_text")),
   jewels = {},
   -- Enable/Disable All buttons
   enable_all = checkbox:new(false, get_hash(plugin_label .. "_jewel_enable_all")),
   disable_all = checkbox:new(false, get_hash(plugin_label .. "_jewel_disable_all"))
},

  -- NEW ITEM TYPE SETTINGS
  scroll_settings = {
     tree = tree_node:new(1),
     search_combo = combo_box:new(0, get_hash(plugin_label .. "_scroll_search")),
     search_text = input_text:new(get_hash(plugin_label .. "_scroll_search_text")),
     scrolls = {},
     enable_all = checkbox:new(false, get_hash(plugin_label .. "_scroll_enable_all")),
     disable_all = checkbox:new(false, get_hash(plugin_label .. "_scroll_disable_all"))
  },

  quest_settings = {
     tree = tree_node:new(1),
     search_combo = combo_box:new(0, get_hash(plugin_label .. "_quest_search")),
     search_text = input_text:new(get_hash(plugin_label .. "_quest_search_text")),
     quest_items = {},
     enable_all = checkbox:new(false, get_hash(plugin_label .. "_quest_enable_all")),
     disable_all = checkbox:new(false, get_hash(plugin_label .. "_quest_disable_all"))
  },

  sigil_compass_settings = {
     tree = tree_node:new(1),
     search_combo = combo_box:new(0, get_hash(plugin_label .. "_sigil_compass_search")),
     search_text = input_text:new(get_hash(plugin_label .. "_sigil_compass_search_text")),
     sigil_compass_items = {},
     enable_all = checkbox:new(false, get_hash(plugin_label .. "_sigil_compass_enable_all")),
     disable_all = checkbox:new(false, get_hash(plugin_label .. "_sigil_compass_disable_all"))
  },

  boss_settings = {
     tree = tree_node:new(1),
     search_combo = combo_box:new(0, get_hash(plugin_label .. "_boss_search")),
     search_text = input_text:new(get_hash(plugin_label .. "_boss_search_text")),
     boss_items = {},
     enable_all = checkbox:new(false, get_hash(plugin_label .. "_boss_enable_all")),
     disable_all = checkbox:new(false, get_hash(plugin_label .. "_boss_disable_all"))
  },

  crafting_settings = {
     tree = tree_node:new(1),
     search_combo = combo_box:new(0, get_hash(plugin_label .. "_crafting_search")),
     search_text = input_text:new(get_hash(plugin_label .. "_crafting_search_text")),
     crafting_items = {},
     enable_all = checkbox:new(false, get_hash(plugin_label .. "_crafting_enable_all")),
     disable_all = checkbox:new(false, get_hash(plugin_label .. "_crafting_disable_all"))
  },

  debug = {
   tree = tree_node:new(1),
   draw_wanted_toggle = checkbox:new(false, get_hash(plugin_label .. "_draw_wanted_toggle")),
   show_debug_text_toggle = checkbox:new(true, get_hash(plugin_label .. "_show_debug_text_toggle")),
},
}

-- INITIALIZE RUNE TOGGLES
local function initialize_rune_toggles()
   -- Magic runes
   for _, rune in ipairs(RuneData.magic_runes) do
       gui.elements.rune_settings.magic_runes[rune.id] = checkbox:new(false, get_hash(plugin_label .. "_magic_rune_" .. rune.id))
   end

   -- Rare runes
   for _, rune in ipairs(RuneData.rare_runes) do
       gui.elements.rune_settings.rare_runes[rune.id] = checkbox:new(false, get_hash(plugin_label .. "_rare_rune_" .. rune.id))
   end
   
   -- Legendary runes
   for _, rune in ipairs(RuneData.legendary_runes) do
       gui.elements.rune_settings.legendary_runes[rune.id] = checkbox:new(false, get_hash(plugin_label .. "_legendary_rune_" .. rune.id))
   end
end

-- INITIALIZE ELIXIR TOGGLES
local function initialize_elixir_toggles()
   -- Basic elixirs
   for _, elixir in ipairs(ElixirData.basic_elixirs) do
       gui.elements.elixir_settings.basic_elixirs[elixir.name] = checkbox:new(false, get_hash(plugin_label .. "_basic_elixir_" .. elixir.name))
   end
   
   -- Advanced elixirs
   for _, elixir in ipairs(ElixirData.advanced_elixirs) do
       gui.elements.elixir_settings.advanced_elixirs[elixir.name] = checkbox:new(false, get_hash(plugin_label .. "_advanced_elixir_" .. elixir.name))
   end
   
   -- Rare elixirs
   for _, elixir in ipairs(ElixirData.rare_elixirs) do
       gui.elements.elixir_settings.rare_elixirs[elixir.name] = checkbox:new(false, get_hash(plugin_label .. "_rare_elixir_" .. elixir.name))
   end
   
   -- Seasonal elixirs
   for _, elixir in ipairs(ElixirData.seasonal_elixirs) do
      gui.elements.elixir_settings.seasonal_elixirs[elixir.name] = checkbox:new(false, get_hash(plugin_label .. "_seasonal_elixir_" .. elixir.name))
   end
end

-- NEW: INITIALIZE SCROLL TOGGLES
local function initialize_scroll_toggles()
   for _, scroll in ipairs(ScrollData.scrolls) do
       gui.elements.scroll_settings.scrolls[scroll.id] = checkbox:new(false, get_hash(plugin_label .. "_scroll_" .. scroll.id))
   end
end

-- NEW: INITIALIZE QUEST ITEM TOGGLES
local function initialize_quest_toggles()
   for _, quest_item in ipairs(QuestData.quest_items) do
       gui.elements.quest_settings.quest_items[quest_item.id] = checkbox:new(false, get_hash(plugin_label .. "_quest_" .. quest_item.id))
   end
end

-- NEW: INITIALIZE SIGIL/COMPASS TOGGLES
local function initialize_sigil_compass_toggles()
   for _, item in ipairs(SigilCompassData.sigil_compass_items) do
       gui.elements.sigil_compass_settings.sigil_compass_items[item.id] = checkbox:new(false, get_hash(plugin_label .. "_sigil_compass_" .. item.id))
   end
end

-- NEW: INITIALIZE BOSS ITEM TOGGLES
local function initialize_boss_toggles()
   for _, boss_item in ipairs(BossData.boss_items) do
       gui.elements.boss_settings.boss_items[boss_item.id] = checkbox:new(false, get_hash(plugin_label .. "_boss_" .. boss_item.id))
   end
end

-- NEW: INITIALIZE CRAFTING ITEM TOGGLES
local function initialize_crafting_toggles()
   for _, crafting_item in ipairs(CraftingData.crafting_items) do
       gui.elements.crafting_settings.crafting_items[crafting_item.id] = checkbox:new(false, get_hash(plugin_label .. "_crafting_" .. crafting_item.id))
   end
end

-- NEW: INITIALIZE JEWEL ITEM TOGGLES
local function initialize_jewel_toggles()
   for _, jewel in ipairs(JewelData.jewels) do
       gui.elements.jewel_settings.jewels[jewel.id] = checkbox:new(false, get_hash(plugin_label .. "_jewel_" .. jewel.id))
   end
end

-- Call initialization functions
initialize_rune_toggles()
initialize_elixir_toggles()
initialize_scroll_toggles()
initialize_quest_toggles()
initialize_sigil_compass_toggles()
initialize_boss_toggles()
initialize_crafting_toggles()
initialize_jewel_toggles()

-- CREATE SEARCH OPTIONS FOR RUNES
local rune_search_options = {"All Runes"}
local all_rune_names = {}
for _, rune in ipairs(RuneData.magic_runes) do
    table.insert(all_rune_names, rune.name)
end
for _, rune in ipairs(RuneData.rare_runes) do
    table.insert(all_rune_names, rune.name)
end
for _, rune in ipairs(RuneData.legendary_runes) do
    table.insert(all_rune_names, rune.name)
end
table.sort(all_rune_names)
for _, name in ipairs(all_rune_names) do
    table.insert(rune_search_options, name)
end

-- CREATE SEARCH OPTIONS FOR ELIXIRS
local elixir_search_options = {"All Elixirs"}
local all_elixir_names = {}
for _, elixir in ipairs(ElixirData.basic_elixirs) do
    table.insert(all_elixir_names, elixir.name)
end
for _, elixir in ipairs(ElixirData.advanced_elixirs) do
    table.insert(all_elixir_names, elixir.name)
end
for _, elixir in ipairs(ElixirData.rare_elixirs) do
    table.insert(all_elixir_names, elixir.name)
end
for _, elixir in ipairs(ElixirData.seasonal_elixirs) do
    table.insert(all_elixir_names, elixir.name)
end
table.sort(all_elixir_names)
for _, name in ipairs(all_elixir_names) do
    table.insert(elixir_search_options, name)
end

-- NEW: CREATE SEARCH OPTIONS FOR SCROLLS
local scroll_search_options = {"All Scrolls"}
local all_scroll_names = {}
for _, scroll in ipairs(ScrollData.scrolls) do
    table.insert(all_scroll_names, scroll.name)
end
table.sort(all_scroll_names)
for _, name in ipairs(all_scroll_names) do
    table.insert(scroll_search_options, name)
end

-- NEW: CREATE SEARCH OPTIONS FOR QUEST ITEMS
local quest_search_options = {"All Quest Items"}
local all_quest_names = {}
for _, quest_item in ipairs(QuestData.quest_items) do
    table.insert(all_quest_names, quest_item.name)
end
table.sort(all_quest_names)
for _, name in ipairs(all_quest_names) do
    table.insert(quest_search_options, name)
end

-- NEW: CREATE SEARCH OPTIONS FOR SIGIL/COMPASS ITEMS
local sigil_compass_search_options = {"All Sigils & Compass"}
local all_sigil_compass_names = {}
for _, item in ipairs(SigilCompassData.sigil_compass_items) do
    table.insert(all_sigil_compass_names, item.name)
end
table.sort(all_sigil_compass_names)
for _, name in ipairs(all_sigil_compass_names) do
    table.insert(sigil_compass_search_options, name)
end

-- NEW: CREATE SEARCH OPTIONS FOR BOSS ITEMS
local boss_search_options = {"All Boss Items"}
local all_boss_names = {}
for _, boss_item in ipairs(BossData.boss_items) do
    table.insert(all_boss_names, boss_item.name)
end
table.sort(all_boss_names)
for _, name in ipairs(all_boss_names) do
    table.insert(boss_search_options, name)
end

-- NEW: CREATE SEARCH OPTIONS FOR CRAFTING ITEMS
local crafting_search_options = {"All Crafting Items"}
local all_crafting_names = {}
for _, crafting_item in ipairs(CraftingData.crafting_items) do
    table.insert(all_crafting_names, crafting_item.name)
end
table.sort(all_crafting_names)
for _, name in ipairs(all_crafting_names) do
    table.insert(crafting_search_options, name)
end

-- NEW: CREATE SEARCH OPTIONS FOR JEWELS
local jewel_search_options = {"All Jewels"}
local all_jewel_names = {}
for _, jewel in ipairs(JewelData.jewels) do
    table.insert(all_jewel_names, jewel.name)
end
-- Note: jewels are already alphabetically sorted in the data file
for _, name in ipairs(all_jewel_names) do
    table.insert(jewel_search_options, name)
end

-- HELPER FUNCTIONS FOR ENABLING/DISABLING ALL RUNES
local function enable_all_runes(runes, toggles)
   for _, rune in ipairs(runes) do
       if toggles[rune.id] then
           toggles[rune.id]:set(true)
       end
   end
end

local function disable_all_runes(runes, toggles)
   for _, rune in ipairs(runes) do
       if toggles[rune.id] then
           toggles[rune.id]:set(false)
       end
   end
end

-- HELPER FUNCTIONS FOR ENABLING/DISABLING ALL ELIXIRS
local function enable_all_elixirs(elixirs, toggles)
   for _, elixir in ipairs(elixirs) do
       if toggles[elixir.name] then
           toggles[elixir.name]:set(true)
       end
   end
end

local function disable_all_elixirs(elixirs, toggles)
   for _, elixir in ipairs(elixirs) do
       if toggles[elixir.name] then
           toggles[elixir.name]:set(false)
       end
   end
end

-- NEW: HELPER FUNCTIONS FOR ENABLING/DISABLING ALL SCROLLS
local function enable_all_scrolls(scrolls, toggles)
   for _, scroll in ipairs(scrolls) do
       if toggles[scroll.id] then
           toggles[scroll.id]:set(true)
       end
   end
end

local function disable_all_scrolls(scrolls, toggles)
   for _, scroll in ipairs(scrolls) do
       if toggles[scroll.id] then
           toggles[scroll.id]:set(false)
       end
   end
end

-- NEW: HELPER FUNCTIONS FOR ENABLING/DISABLING ALL QUEST ITEMS
local function enable_all_quest_items(quest_items, toggles)
   for _, quest_item in ipairs(quest_items) do
       if toggles[quest_item.id] then
           toggles[quest_item.id]:set(true)
       end
   end
end

local function disable_all_quest_items(quest_items, toggles)
   for _, quest_item in ipairs(quest_items) do
       if toggles[quest_item.id] then
           toggles[quest_item.id]:set(false)
       end
   end
end

-- NEW: HELPER FUNCTIONS FOR ENABLING/DISABLING ALL SIGIL/COMPASS ITEMS
local function enable_all_sigil_compass_items(items, toggles)
   for _, item in ipairs(items) do
       if toggles[item.id] then
           toggles[item.id]:set(true)
       end
   end
end

local function disable_all_sigil_compass_items(items, toggles)
   for _, item in ipairs(items) do
       if toggles[item.id] then
           toggles[item.id]:set(false)
       end
   end
end

-- NEW: HELPER FUNCTIONS FOR ENABLING/DISABLING ALL BOSS ITEMS
local function enable_all_boss_items(boss_items, toggles)
   for _, boss_item in ipairs(boss_items) do
       if toggles[boss_item.id] then
           toggles[boss_item.id]:set(true)
       end
   end
end

local function disable_all_boss_items(boss_items, toggles)
   for _, boss_item in ipairs(boss_items) do
       if toggles[boss_item.id] then
           toggles[boss_item.id]:set(false)
       end
   end
end

-- NEW: HELPER FUNCTIONS FOR ENABLING/DISABLING ALL CRAFTING ITEMS
local function enable_all_crafting_items(crafting_items, toggles)
   for _, crafting_item in ipairs(crafting_items) do
       if toggles[crafting_item.id] then
           toggles[crafting_item.id]:set(true)
       end
   end
end

local function disable_all_crafting_items(crafting_items, toggles)
   for _, crafting_item in ipairs(crafting_items) do
       if toggles[crafting_item.id] then
           toggles[crafting_item.id]:set(false)
       end
   end
end

-- NEW: HELPER FUNCTIONS FOR ENABLING/DISABLING ALL JEWELS
local function enable_all_jewels(jewels, toggles)
   for _, jewel in ipairs(jewels) do
       if toggles[jewel.id] then
           toggles[jewel.id]:set(true)
       end
   end
end

local function disable_all_jewels(jewels, toggles)
   for _, jewel in ipairs(jewels) do
       if toggles[jewel.id] then
           toggles[jewel.id]:set(false)
       end
   end
end

-- HELPER FUNCTION TO CHECK IF RUNE CATEGORY HAS MATCHES
local function rune_category_has_matches(runes, search_index, text_search)
   local combo_search_term = ""
   if search_index > 0 then
       combo_search_term = rune_search_options[search_index + 1] or ""
   end
   
   local text_search_term = (text_search or ""):lower():gsub("^%s*(.-)%s*$", "%1")
   
   for _, rune in ipairs(runes) do
       local rune_name_lower = rune.name:lower()
       local matches_combo = combo_search_term == "" or combo_search_term == "All Runes" or 
                            rune_name_lower:find(combo_search_term:lower(), 1, true)
       local matches_text = text_search_term == "" or 
                           rune_name_lower:find(text_search_term, 1, true)
       
       if matches_combo and matches_text then
           return true
       end
   end
   return false
end

-- HELPER FUNCTION TO CHECK IF ELIXIR CATEGORY HAS MATCHES
local function elixir_category_has_matches(elixirs, search_index, text_search)
   if not elixir_search_options then
       return true
   end
   
   local combo_search_term = ""
   if search_index and search_index > 0 and search_index < #elixir_search_options then
       combo_search_term = elixir_search_options[search_index + 1] or ""
   end
   
   local text_search_term = (text_search or ""):lower():gsub("^%s*(.-)%s*$", "%1")
   
   if combo_search_term == "" and text_search_term == "" then
       return true
   end
   
   if combo_search_term == "All Elixirs" then
       return true
   end
   
   for _, elixir in ipairs(elixirs) do
       local elixir_name_lower = elixir.name:lower()
       local matches_combo = combo_search_term == "" or combo_search_term == "All Elixirs" or 
                            elixir_name_lower:find(combo_search_term:lower(), 1, true)
       local matches_text = text_search_term == "" or 
                           elixir_name_lower:find(text_search_term, 1, true)
       
       if matches_combo and matches_text then
           return true
       end
   end
   return false
end

-- GENERIC RENDER FUNCTION FOR FILTERED ITEMS
local function render_filtered_items(items, toggles, search_index, text_search, search_options)
   local combo_search_term = ""
   if search_index and search_index > 0 and search_index < #search_options then
       combo_search_term = search_options[search_index + 1] or ""
   end
   
   local text_search_term = (text_search or ""):lower():gsub("^%s*(.-)%s*$", "%1")
   
   for _, item in ipairs(items) do
       local item_name_lower = item.name:lower()
       local matches_combo = combo_search_term == "" or combo_search_term:find("All") or 
                            item_name_lower:find(combo_search_term:lower(), 1, true)
       local matches_text = text_search_term == "" or 
                           item_name_lower:find(text_search_term, 1, true)
       
       if matches_combo and matches_text then
           local toggle_key = item.id or item.name
           if toggles[toggle_key] then
               toggles[toggle_key]:render(item.name, "Enable/disable looting of " .. item.name)
           end
       end
   end
end

-- EXISTING RENDER FUNCTIONS FOR RUNES AND ELIXIRS
local function render_filtered_runes(runes, toggles, search_index, text_search)
   local combo_search_term = ""
   if search_index > 0 then
       combo_search_term = rune_search_options[search_index + 1] or ""
   end
   
   local text_search_term = (text_search or ""):lower():gsub("^%s*(.-)%s*$", "%1")
   
   for _, rune in ipairs(runes) do
       local rune_name_lower = rune.name:lower()
       local matches_combo = combo_search_term == "" or combo_search_term == "All Runes" or 
                            rune_name_lower:find(combo_search_term:lower(), 1, true)
       local matches_text = text_search_term == "" or 
                           rune_name_lower:find(text_search_term, 1, true)
       
       if matches_combo and matches_text then
           if toggles[rune.id] then
               toggles[rune.id]:render(rune.name, "Enable/disable looting of " .. rune.name .. " runes")
           end
       end
   end
end

local function render_filtered_elixirs(elixirs, toggles, search_index, text_search)
   if not elixir_search_options then
       for _, elixir in ipairs(elixirs) do
           if toggles[elixir.name] then
               toggles[elixir.name]:render(elixir.name, "Enable/disable looting of " .. elixir.name)
           end
       end
       return
   end
   
   local combo_search_term = ""
   if search_index and search_index > 0 and search_index < #elixir_search_options then
       combo_search_term = elixir_search_options[search_index + 1] or ""
   end
   
   local text_search_term = (text_search or ""):lower():gsub("^%s*(.-)%s*$", "%1")
   
   for _, elixir in ipairs(elixirs) do
       local elixir_name_lower = elixir.name:lower()
       local matches_combo = combo_search_term == "" or combo_search_term == "All Elixirs" or
                            elixir_name_lower:find(combo_search_term:lower(), 1, true)
       local matches_text = text_search_term == "" or 
                           elixir_name_lower:find(text_search_term, 1, true)
       
       if matches_combo and matches_text then
           if toggles[elixir.name] then
               toggles[elixir.name]:render(elixir.name, "Enable/disable looting of " .. elixir.name)
           end
       end
   end
end

local function render_filtered_jewels(jewels, toggles, search_index, text_search)
   if not jewel_search_options then
       for _, jewel in ipairs(jewels) do
           if toggles[jewel.id] then
               toggles[jewel.id]:render(jewel.name, "Enable/disable looting of " .. jewel.name)
           end
       end
       return
   end
   
   local combo_search_term = ""
   if search_index and search_index > 0 and search_index < #jewel_search_options then
       combo_search_term = jewel_search_options[search_index + 1] or ""
   end
   
   local text_search_term = (text_search or ""):lower():gsub("^%s*(.-)%s*$", "%1")
   
   for _, jewel in ipairs(jewels) do
       local jewel_name_lower = jewel.name:lower()
       local matches_combo = combo_search_term == "" or combo_search_term == "All Jewels" or 
                            jewel_name_lower:find(combo_search_term:lower(), 1, true)
       local matches_text = text_search_term == "" or 
                           jewel_name_lower:find(text_search_term, 1, true)
       
       if matches_combo and matches_text then
           if toggles[jewel.id] then
               toggles[jewel.id]:render(jewel.name, "Enable/disable looting of " .. jewel.name)
           end
       end
   end
end

-- MAIN RENDER FUNCTION
function gui.render()
  if not gui.elements.main_tree:push("Looter | Letrico | " .. version) then
     return
  end

  gui.elements.main_toggle:render("Enable", "Toggles the main module on/off")
   
  if not gui.elements.main_toggle:get() then
     gui.elements.main_tree:pop()
     return
  end
   
  if gui.elements.general.tree:push("General Settings") then
   gui.elements.general.behavior_combo:render("Behavior", options.behaviors,
      "When do you want the autolooter to execute?")
   gui.elements.general.loot_priority_combo:render("Loot Priority", options.loot_priorities, 
      "Priority system for item selection")  -- ⬅️ ADD THIS LINE IF MISSING
   gui.elements.general.rarity_combo:render("Rarity", options.rarities,
      "Minimum Rarity for bot to consider picking up.")
   gui.elements.general.distance_slider:render("Distance", "Distance from the loot to execute pick up")
   gui.elements.general.skip_dropped_toggle:render("Skip Self Dropped (Equipment only)",
      "Do you want the bot to not loot items that you dropped yourself?")
   gui.elements.general.tree:pop()
end

  if gui.elements.affix_settings.tree:push("Affix Settings") then
     gui.elements.affix_settings.greater_affix_slider:render("Greater Affix Count",
        "Minimum GA's to consider picking up Legendary Items")
     gui.elements.affix_settings.unique_greater_affix_slider:render("Unique Greater Affix Count",
        "Minimum GA's to consider picking up Unique Items")
     gui.elements.affix_settings.uber_unique_greater_affix_slider:render("Uber Unique Greater Affix Count",
        "Minimum GA's to consider picking up Uber Unique Items")
     gui.elements.affix_settings.custom_toggle:render("Enable Custom GA Settings",
        "Enable custom GA settings for different item types")
     
     if gui.elements.affix_settings.custom_toggle:get() then
        if gui.elements.affix_settings.armorsTree:push("Armor Settings") then
           gui.elements.affix_settings.legendary_helm_slider:render("Legendary Helm GA Count",
              "Minimum GA's to consider picking up legendary Helms")
           gui.elements.affix_settings.legendary_chest_slider:render("Legendary Chest GA Count",
              "Minimum GA's to consider picking up legendary Chests")
           gui.elements.affix_settings.legendary_gloves_slider:render("Legendary Gloves GA Count",
              "Minimum GA's to consider picking up legendary Gloves")
           gui.elements.affix_settings.legendary_pants_slider:render("Legendary Pants GA Count",
              "Minimum GA's to consider picking up legendary Pants")
           gui.elements.affix_settings.legendary_boots_slider:render("Legendary Boots GA Count",
              "Minimum GA's to consider picking up legendary Boots")
           gui.elements.affix_settings.unique_helm_slider:render("Unique Helm GA Count",
              "Minimum GA's to consider picking up unique Helms")
           gui.elements.affix_settings.unique_chest_slider:render("Unique Chest GA Count",
              "Minimum GA's to consider picking up unique Chests")
           gui.elements.affix_settings.unique_gloves_slider:render("Unique Gloves GA Count",
              "Minimum GA's to consider picking up unique Gloves")
           gui.elements.affix_settings.unique_pants_slider:render("Unique Pants GA Count",
              "Minimum GA's to consider picking up unique Pants")
           gui.elements.affix_settings.unique_boots_slider:render("Unique Boots GA Count",
              "Minimum GA's to consider picking up unique Boots")
           gui.elements.affix_settings.armorsTree:pop()
        end
        
        if gui.elements.affix_settings.jewerlyTree:push("Jewelry Settings") then
           gui.elements.affix_settings.legendary_amulet_slider:render("Legendary Amulet GA Count",
              "Minimum GA's to consider picking up legendary Amulets")
           gui.elements.affix_settings.legendary_ring_slider:render("Legendary Ring GA Count",
              "Minimum GA's to consider picking up legendary Rings")
           gui.elements.affix_settings.unique_amulet_slider:render("Unique Amulet GA Count",
              "Minimum GA's to consider picking up unique Amulets")
           gui.elements.affix_settings.unique_ring_slider:render("Unique Ring GA Count",
              "Minimum GA's to consider picking up unique Rings")
           gui.elements.affix_settings.jewerlyTree:pop()
        end
        
        if gui.elements.affix_settings.weaponsTree:push("Weapons Settings") then
           gui.elements.affix_settings.legendary_1h_weapon_slider:render("Legendary 1H Weapon GA Count",
              "Minimum GA's to consider picking up legendary 1H Weapons")
           gui.elements.affix_settings.legendary_2h_weapon_slider:render("Legendary 2H Weapon GA Count",
              "Minimum GA's to consider picking up legendary 2H Weapons")
           gui.elements.affix_settings.legendary_offhand_slider:render("Legendary Offhand GA Count",
              "Minimum GA's to consider picking up legendary Offhands")
           gui.elements.affix_settings.unique_1h_weapon_slider:render("Unique 1H Weapon GA Count",
              "Minimum GA's to consider picking up unique 1H Weapons")
           gui.elements.affix_settings.unique_2h_weapon_slider:render("Unique 2H Weapon GA Count",
              "Minimum GA's to consider picking up unique 2H Weapons")
           gui.elements.affix_settings.unique_offhand_slider:render("Unique Offhand GA Count",
              "Minimum GA's to consider picking up unique Offhands")
           gui.elements.affix_settings.weaponsTree:pop()
        end
     end
     gui.elements.affix_settings.tree:pop()
  end

  -- ALPHABETICALLY ORDERED ITEM TYPES SECTION
  if gui.elements.item_types.tree:push("Item Types") then
     
     -- A: Boss Items
     gui.elements.item_types.boss_items_toggle:render("Boss Items", "Do you want to pick up Boss summon items?")
     if gui.elements.item_types.boss_items_toggle:get() then
        if gui.elements.boss_settings.tree:push("Boss Item Settings") then
           gui.elements.boss_settings.search_combo:render("Filter Boss Items", boss_search_options, "Filter boss items by name")
           gui.elements.boss_settings.search_text:render("Search", "Type to search boss item names in real-time", false, "", "")
           
           local search_index = gui.elements.boss_settings.search_combo:get() or 0
           local text_search = gui.elements.boss_settings.search_text:get()
           
           gui.elements.boss_settings.enable_all:render("Enable All", "Enable all boss items")
           if gui.elements.boss_settings.enable_all:get() then
              enable_all_boss_items(BossData.boss_items, gui.elements.boss_settings.boss_items)
              gui.elements.boss_settings.enable_all:set(false)
           end
           
           gui.elements.boss_settings.disable_all:render("Disable All", "Disable all boss items")
           if gui.elements.boss_settings.disable_all:get() then
              disable_all_boss_items(BossData.boss_items, gui.elements.boss_settings.boss_items)
              gui.elements.boss_settings.disable_all:set(false)
           end
           
           render_filtered_items(BossData.boss_items, gui.elements.boss_settings.boss_items, search_index, text_search, boss_search_options)
           gui.elements.boss_settings.tree:pop()
        end
     end
     
     -- C: Cinders
     gui.elements.item_types.cinders_toggle:render("Cinders", "Do you want to loot cinders?")
     
     -- C: Compasses, Sigils, Tributes
     gui.elements.item_types.sigil_compass_items_toggle:render("Compasses, Sigils, Tributes", "Do you want to loot sigils and compasses?")
     if gui.elements.item_types.sigil_compass_items_toggle:get() then
        if gui.elements.sigil_compass_settings.tree:push("Sigil & Compass Settings") then
           gui.elements.sigil_compass_settings.search_combo:render("Filter Sigils & Compass", sigil_compass_search_options, "Filter sigils and compass items by name")
           gui.elements.sigil_compass_settings.search_text:render("Search", "Type to search item names in real-time", false, "", "")
           
           local search_index = gui.elements.sigil_compass_settings.search_combo:get() or 0
           local text_search = gui.elements.sigil_compass_settings.search_text:get()
           
           gui.elements.sigil_compass_settings.enable_all:render("Enable All", "Enable all sigils and compass items")
           if gui.elements.sigil_compass_settings.enable_all:get() then
              enable_all_sigil_compass_items(SigilCompassData.sigil_compass_items, gui.elements.sigil_compass_settings.sigil_compass_items)
              gui.elements.sigil_compass_settings.enable_all:set(false)
           end
           
           gui.elements.sigil_compass_settings.disable_all:render("Disable All", "Disable all sigils and compass items")
           if gui.elements.sigil_compass_settings.disable_all:get() then
              disable_all_sigil_compass_items(SigilCompassData.sigil_compass_items, gui.elements.sigil_compass_settings.sigil_compass_items)
              gui.elements.sigil_compass_settings.disable_all:set(false)
           end
           
           render_filtered_items(SigilCompassData.sigil_compass_items, gui.elements.sigil_compass_settings.sigil_compass_items, search_index, text_search, sigil_compass_search_options)
           gui.elements.sigil_compass_settings.tree:pop()
        end
     end
     
     -- C: Crafting Items
     gui.elements.item_types.crafting_items_toggle:render("Crafting Items", "Do you want to pick up Crafting Items?")
     if gui.elements.item_types.crafting_items_toggle:get() then
        if gui.elements.crafting_settings.tree:push("Crafting Item Settings") then
           gui.elements.crafting_settings.search_combo:render("Filter Crafting Items", crafting_search_options, "Filter crafting items by name")
           gui.elements.crafting_settings.search_text:render("Search", "Type to search crafting item names in real-time", false, "", "")
           
           local search_index = gui.elements.crafting_settings.search_combo:get() or 0
           local text_search = gui.elements.crafting_settings.search_text:get()
           
           gui.elements.crafting_settings.enable_all:render("Enable All", "Enable all crafting items")
           if gui.elements.crafting_settings.enable_all:get() then
              enable_all_crafting_items(CraftingData.crafting_items, gui.elements.crafting_settings.crafting_items)
              gui.elements.crafting_settings.enable_all:set(false)
           end
           
           gui.elements.crafting_settings.disable_all:render("Disable All", "Disable all crafting items")
           if gui.elements.crafting_settings.disable_all:get() then
              disable_all_crafting_items(CraftingData.crafting_items, gui.elements.crafting_settings.crafting_items)
              gui.elements.crafting_settings.disable_all:set(false)
           end
           
           render_filtered_items(CraftingData.crafting_items, gui.elements.crafting_settings.crafting_items, search_index, text_search, crafting_search_options)
           gui.elements.crafting_settings.tree:pop()
        end
     end
     
     -- E: Elixirs
     gui.elements.item_types.elixir_items_toggle:render("Elixirs", "Do you want to loot elixirs?")
     if gui.elements.item_types.elixir_items_toggle:get() then
        if gui.elements.elixir_settings.tree:push("Elixir Settings") then
           
           gui.elements.elixir_settings.search_combo:render("Filter Elixirs", elixir_search_options, "Filter elixirs by name")
           gui.elements.elixir_settings.search_text:render("Search", "Type to search elixir names in real-time", false, "", "")
           
           local search_index = gui.elements.elixir_settings.search_combo:get()
           local text_search = gui.elements.elixir_settings.search_text:get()
           
           search_index = search_index or 0
           
           local basic_has_matches = true
           local advanced_has_matches = true
           local rare_has_matches = true
           local seasonal_has_matches = true
           
           pcall(function()
               basic_has_matches = elixir_category_has_matches(ElixirData.basic_elixirs, search_index, text_search)
               advanced_has_matches = elixir_category_has_matches(ElixirData.advanced_elixirs, search_index, text_search)
               rare_has_matches = elixir_category_has_matches(ElixirData.rare_elixirs, search_index, text_search)
               seasonal_has_matches = elixir_category_has_matches(ElixirData.seasonal_elixirs, search_index, text_search)
           end)
           
           if gui.elements.elixir_settings.basic_tree:push("Basic Elixirs") then
              gui.elements.elixir_settings.basic_enable_all:render("Enable All", "Enable all Basic elixirs")
              if gui.elements.elixir_settings.basic_enable_all:get() then
                 enable_all_elixirs(ElixirData.basic_elixirs, gui.elements.elixir_settings.basic_elixirs)
                 gui.elements.elixir_settings.basic_enable_all:set(false)
              end
              
              gui.elements.elixir_settings.basic_disable_all:render("Disable All", "Disable all Basic elixirs")
              if gui.elements.elixir_settings.basic_disable_all:get() then
                 disable_all_elixirs(ElixirData.basic_elixirs, gui.elements.elixir_settings.basic_elixirs)
                 gui.elements.elixir_settings.basic_disable_all:set(false)
              end
              
              if basic_has_matches or (search_index == 0 and (text_search == nil or text_search == "")) then
                 render_filtered_elixirs(ElixirData.basic_elixirs, gui.elements.elixir_settings.basic_elixirs, search_index, text_search)
              end
              gui.elements.elixir_settings.basic_tree:pop()
           end
           
           if gui.elements.elixir_settings.advanced_tree:push("Advanced Elixirs") then
              gui.elements.elixir_settings.advanced_enable_all:render("Enable All", "Enable all Advanced elixirs")
              if gui.elements.elixir_settings.advanced_enable_all:get() then
                 enable_all_elixirs(ElixirData.advanced_elixirs, gui.elements.elixir_settings.advanced_elixirs)
                 gui.elements.elixir_settings.advanced_enable_all:set(false)
              end
              
              gui.elements.elixir_settings.advanced_disable_all:render("Disable All", "Disable all Advanced elixirs")
              if gui.elements.elixir_settings.advanced_disable_all:get() then
                 disable_all_elixirs(ElixirData.advanced_elixirs, gui.elements.elixir_settings.advanced_elixirs)
                 gui.elements.elixir_settings.advanced_disable_all:set(false)
              end
              
              if advanced_has_matches or (search_index == 0 and (text_search == nil or text_search == "")) then
                 render_filtered_elixirs(ElixirData.advanced_elixirs, gui.elements.elixir_settings.advanced_elixirs, search_index, text_search)
              end
              gui.elements.elixir_settings.advanced_tree:pop()
           end
           
           if gui.elements.elixir_settings.rare_tree:push("Rare Elixirs") then
              gui.elements.elixir_settings.rare_enable_all:render("Enable All", "Enable all Rare elixirs")
              if gui.elements.elixir_settings.rare_enable_all:get() then
                 enable_all_elixirs(ElixirData.rare_elixirs, gui.elements.elixir_settings.rare_elixirs)
                 gui.elements.elixir_settings.rare_enable_all:set(false)
              end
              
              gui.elements.elixir_settings.rare_disable_all:render("Disable All", "Disable all Rare elixirs")
              if gui.elements.elixir_settings.rare_disable_all:get() then
                 disable_all_elixirs(ElixirData.rare_elixirs, gui.elements.elixir_settings.rare_elixirs)
                 gui.elements.elixir_settings.rare_disable_all:set(false)
              end
              
              if rare_has_matches or (search_index == 0 and (text_search == nil or text_search == "")) then
                 render_filtered_elixirs(ElixirData.rare_elixirs, gui.elements.elixir_settings.rare_elixirs, search_index, text_search)
              end
              gui.elements.elixir_settings.rare_tree:pop()
           end
           
           if gui.elements.elixir_settings.seasonal_tree:push("Seasonal Elixirs") then
              gui.elements.elixir_settings.seasonal_enable_all:render("Enable All", "Enable all Seasonal elixirs")
              if gui.elements.elixir_settings.seasonal_enable_all:get() then
                 enable_all_elixirs(ElixirData.seasonal_elixirs, gui.elements.elixir_settings.seasonal_elixirs)
                 gui.elements.elixir_settings.seasonal_enable_all:set(false)
              end
              
              gui.elements.elixir_settings.seasonal_disable_all:render("Disable All", "Disable all Seasonal elixirs")
              if gui.elements.elixir_settings.seasonal_disable_all:get() then
                 disable_all_elixirs(ElixirData.seasonal_elixirs, gui.elements.elixir_settings.seasonal_elixirs)
                 gui.elements.elixir_settings.seasonal_disable_all:set(false)
              end
              
              if seasonal_has_matches or (search_index == 0 and (text_search == nil or text_search == "")) then
                 render_filtered_elixirs(ElixirData.seasonal_elixirs, gui.elements.elixir_settings.seasonal_elixirs, search_index, text_search)
              end
              gui.elements.elixir_settings.seasonal_tree:pop()
           end
           
           gui.elements.elixir_settings.tree:pop()
        end
     end
     
     -- E: Event Items
     gui.elements.item_types.event_items_toggle:render("Event Items", "Do you want to pick up Event Items?")
     
     -- J: Jewels
     gui.elements.item_types.jewel_items_toggle:render("Jewels", "Do you want to loot jewels?")
     if gui.elements.item_types.jewel_items_toggle:get() then
        if gui.elements.jewel_settings.tree:push("Jewel Item Settings") then
            gui.elements.jewel_settings.search_combo:render("Filter Jewel Items", jewel_search_options, "Filter jewel items by name")
            gui.elements.jewel_settings.search_text:render("Search", "Type to search jewel item names in real-time", false, "", "")
            
            local search_index = gui.elements.jewel_settings.search_combo:get() or 0
            local text_search = gui.elements.jewel_settings.search_text:get()
            
            gui.elements.jewel_settings.enable_all:render("Enable All", "Enable all jewel items")
            if gui.elements.jewel_settings.enable_all:get() then
                enable_all_jewels(JewelData.jewels, gui.elements.jewel_settings.jewels)
                gui.elements.jewel_settings.enable_all:set(false)
            end
            
            gui.elements.jewel_settings.disable_all:render("Disable All", "Disable all jewel items")
            if gui.elements.jewel_settings.disable_all:get() then
                disable_all_jewels(JewelData.jewels, gui.elements.jewel_settings.jewels)
                gui.elements.jewel_settings.disable_all:set(false)
            end
            
            render_filtered_jewels(JewelData.jewels, gui.elements.jewel_settings.jewels, search_index, text_search)
            gui.elements.jewel_settings.tree:pop()
        end
     end
     
     -- Q: Quest Items
     gui.elements.item_types.quest_items_toggle:render("Quest Items", "Do you want to pick up Quest Items?")
     if gui.elements.item_types.quest_items_toggle:get() then
        if gui.elements.quest_settings.tree:push("Quest Item Settings") then
           gui.elements.quest_settings.search_combo:render("Filter Quest Items", quest_search_options, "Filter quest items by name")
           gui.elements.quest_settings.search_text:render("Search", "Type to search quest item names in real-time", false, "", "")
           
           local search_index = gui.elements.quest_settings.search_combo:get() or 0
           local text_search = gui.elements.quest_settings.search_text:get()
           
           gui.elements.quest_settings.enable_all:render("Enable All", "Enable all quest items")
           if gui.elements.quest_settings.enable_all:get() then
              enable_all_quest_items(QuestData.quest_items, gui.elements.quest_settings.quest_items)
              gui.elements.quest_settings.enable_all:set(false)
           end
           
           gui.elements.quest_settings.disable_all:render("Disable All", "Disable all quest items")
           if gui.elements.quest_settings.disable_all:get() then
              disable_all_quest_items(QuestData.quest_items, gui.elements.quest_settings.quest_items)
              gui.elements.quest_settings.disable_all:set(false)
           end
           
           render_filtered_items(QuestData.quest_items, gui.elements.quest_settings.quest_items, search_index, text_search, quest_search_options)
           gui.elements.quest_settings.tree:pop()
        end
     end
     
     -- R: Runes
     gui.elements.item_types.rune_items_toggle:render("Runes", "Do you want to loot runes?")
     if gui.elements.item_types.rune_items_toggle:get() then
        if gui.elements.rune_settings.tree:push("Rune Settings") then
           
           gui.elements.rune_settings.search_combo:render("Filter Runes", rune_search_options, "Filter runes by name")
           gui.elements.rune_settings.search_text:render("Search", "Type to search rune names in real-time", false, "", "")
           
           local search_index = gui.elements.rune_settings.search_combo:get() or 0
           local text_search = gui.elements.rune_settings.search_text:get()
           
           local magic_has_matches = rune_category_has_matches(RuneData.magic_runes, search_index, text_search)
           local rare_has_matches = rune_category_has_matches(RuneData.rare_runes, search_index, text_search)
           local legendary_has_matches = rune_category_has_matches(RuneData.legendary_runes, search_index, text_search)
           
           if gui.elements.rune_settings.magic_tree:push("Magic Runes") then
              gui.elements.rune_settings.magic_enable_all:render("Enable All", "Enable all Magic runes")
              if gui.elements.rune_settings.magic_enable_all:get() then
                 enable_all_runes(RuneData.magic_runes, gui.elements.rune_settings.magic_runes)
                 gui.elements.rune_settings.magic_enable_all:set(false)
              end
              
              gui.elements.rune_settings.magic_disable_all:render("Disable All", "Disable all Magic runes")
              if gui.elements.rune_settings.magic_disable_all:get() then
                 disable_all_runes(RuneData.magic_runes, gui.elements.rune_settings.magic_runes)
                 gui.elements.rune_settings.magic_disable_all:set(false)
              end
              
              if magic_has_matches or (search_index == 0 and (text_search == nil or text_search == "")) then
                 render_filtered_runes(RuneData.magic_runes, gui.elements.rune_settings.magic_runes, search_index, text_search)
              end
              gui.elements.rune_settings.magic_tree:pop()
           end
           
           if gui.elements.rune_settings.rare_tree:push("Rare Runes") then
              gui.elements.rune_settings.rare_enable_all:render("Enable All", "Enable all Rare runes")
              if gui.elements.rune_settings.rare_enable_all:get() then
                 enable_all_runes(RuneData.rare_runes, gui.elements.rune_settings.rare_runes)
                 gui.elements.rune_settings.rare_enable_all:set(false)
              end
              
              gui.elements.rune_settings.rare_disable_all:render("Disable All", "Disable all Rare runes")
              if gui.elements.rune_settings.rare_disable_all:get() then
                 disable_all_runes(RuneData.rare_runes, gui.elements.rune_settings.rare_runes)
                 gui.elements.rune_settings.rare_disable_all:set(false)
              end
              
              if rare_has_matches or (search_index == 0 and (text_search == nil or text_search == "")) then
                 render_filtered_runes(RuneData.rare_runes, gui.elements.rune_settings.rare_runes, search_index, text_search)
              end
              gui.elements.rune_settings.rare_tree:pop()
           end
           
           if gui.elements.rune_settings.legendary_tree:push("Legendary Runes") then
              gui.elements.rune_settings.legendary_enable_all:render("Enable All", "Enable all Legendary runes")
              if gui.elements.rune_settings.legendary_enable_all:get() then
                 enable_all_runes(RuneData.legendary_runes, gui.elements.rune_settings.legendary_runes)
                 gui.elements.rune_settings.legendary_enable_all:set(false)
              end
              
              gui.elements.rune_settings.legendary_disable_all:render("Disable All", "Disable all Legendary runes")
              if gui.elements.rune_settings.legendary_disable_all:get() then
                 disable_all_runes(RuneData.legendary_runes, gui.elements.rune_settings.legendary_runes)
                 gui.elements.rune_settings.legendary_disable_all:set(false)
              end
              
              if legendary_has_matches or (search_index == 0 and (text_search == nil or text_search == "")) then
                 render_filtered_runes(RuneData.legendary_runes, gui.elements.rune_settings.legendary_runes, search_index, text_search)
              end
              gui.elements.rune_settings.legendary_tree:pop()
           end
           
           gui.elements.rune_settings.tree:pop()
        end
     end
     
     -- S: Scrolls
     gui.elements.item_types.scroll_items_toggle:render("Scrolls", "Do you want to loot scrolls?")
     if gui.elements.item_types.scroll_items_toggle:get() then
        if gui.elements.scroll_settings.tree:push("Scroll Settings") then
           gui.elements.scroll_settings.search_combo:render("Filter Scrolls", scroll_search_options, "Filter scrolls by name")
           gui.elements.scroll_settings.search_text:render("Search", "Type to search scroll names in real-time", false, "", "")
           
           local search_index = gui.elements.scroll_settings.search_combo:get() or 0
           local text_search = gui.elements.scroll_settings.search_text:get()
           
           gui.elements.scroll_settings.enable_all:render("Enable All", "Enable all scrolls")
           if gui.elements.scroll_settings.enable_all:get() then
              enable_all_scrolls(ScrollData.scrolls, gui.elements.scroll_settings.scrolls)
              gui.elements.scroll_settings.enable_all:set(false)
           end
           
           gui.elements.scroll_settings.disable_all:render("Disable All", "Disable all scrolls")
           if gui.elements.scroll_settings.disable_all:get() then
              disable_all_scrolls(ScrollData.scrolls, gui.elements.scroll_settings.scrolls)
              gui.elements.scroll_settings.disable_all:set(false)
           end
           
           render_filtered_items(ScrollData.scrolls, gui.elements.scroll_settings.scrolls, search_index, text_search, scroll_search_options)
           gui.elements.scroll_settings.tree:pop()
        end
     end
     
     gui.elements.item_types.tree:pop()
  end

  if gui.elements.debug.tree:push("Debug") then
   gui.elements.debug.draw_wanted_toggle:render("Draw Wanted Items", "Draw pink circles around wanted items for debugging")
   gui.elements.debug.show_debug_text_toggle:render("Show Debug Text", "Show/hide all debug text around character")
   gui.elements.debug.tree:pop()
end

  gui.elements.main_tree:pop()
end

return gui
