local RuneData = require("data.rune_data")
local ElixirData = require("data.elixir_data")
local ScrollData = require("data.scroll_data")
local QuestData = require("data.quest_data")
local SigilCompassData = require("data.sigil_compass_data")
local BossData = require("data.boss_data")
local CraftingData = require("data.crafting_data")
local JewelData = require("data.jewel_data")

local Settings = {}

-- Settings table with default values
local settings = {
   enabled = false,
   
   -- General Settings
   behavior = 0,
   rarity = 0,
   distance = 2,
   skip_dropped = false,
   loot_priority = 0,
   
   ga_count = 0,
   unique_ga_count = 0,
   uber_unique_ga_count = 4,

   -- Custom toggle and GA settings
   custom_toggle = false,
   legendary_helm_ga_count = 2,
   legendary_chest_ga_count = 2,
   legendary_gloves_ga_count = 2,
   legendary_pants_ga_count = 2,
   legendary_boots_ga_count = 2,
   legendary_amulet_ga_count = 2,
   legendary_ring_ga_count = 2,
   unique_helm_ga_count = 0,
   unique_chest_ga_count = 0,
   unique_gloves_ga_count = 0,
   unique_pants_ga_count = 0,
   unique_boots_ga_count = 0,
   unique_amulet_ga_count = 0,
   unique_ring_ga_count = 0,
   legendary_1h_weapon_ga_count = 2,
   legendary_2h_weapon_ga_count = 2,
   legendary_offhand_ga_count = 2,
   unique_1h_weapon_ga_count = 0,
   unique_2h_weapon_ga_count = 0,
   unique_offhand_ga_count = 0,
   unique_1h_sword_ga_count = 0,
   unique_1h_axe_ga_count = 0,
   unique_1h_mace_ga_count = 0,
   unique_dagger_ga_count = 0,
   unique_wand_ga_count = 0,
   unique_scythe_ga_count = 0,
   unique_shield_ga_count = 0,
   unique_focus_ga_count = 0,
   unique_totem_ga_count = 0,
   unique_2h_sword_ga_count = 0,
   unique_2h_axe_ga_count = 0,
   unique_2h_polearm_ga_count = 0,
   unique_staff_ga_count = 0,
   unique_bow_ga_count = 0,
   unique_crossbow_ga_count = 0,
   unique_glaive_ga_count = 0,
   unique_quarterstaff_ga_count = 0,

   -- Item Types (FIXED: No duplicates)
   quest_items = false,
   crafting_items = false,
   boss_items = false,
   elixir_items = false,
   sigils = false,
   compass = false,
   rune = false,
   cinders = false,
   tribute = false,
   scroll = false,
   event_items = false,
   scroll_items = false,
   sigil_compass_items = false,
   jewel_items = false,

   -- Individual rune settings
   magic_rune_settings = {},
   rare_rune_settings = {},
   legendary_rune_settings = {},
   
   -- Individual elixir settings
   basic_elixir_settings = {},
   advanced_elixir_settings = {},
   rare_elixir_settings = {},
   seasonal_elixir_settings = {},

   -- Individual item type settings
   scroll_item_settings = {},
   quest_item_settings = {},
   sigil_compass_item_settings = {},
   boss_item_settings = {},
   crafting_item_settings = {},
   jewel_settings = {},

   -- Debug
   draw_wanted_items = false,
   show_debug_text = true
}

-- Initialize functions (FIXED: Define before use)
local function initialize_rune_settings()
   for _, rune in ipairs(RuneData.magic_runes) do
      if settings.magic_rune_settings[rune.id] == nil then
         settings.magic_rune_settings[rune.id] = false
      end
   end
   for _, rune in ipairs(RuneData.rare_runes) do
      if settings.rare_rune_settings[rune.id] == nil then
         settings.rare_rune_settings[rune.id] = false
      end
   end
   for _, rune in ipairs(RuneData.legendary_runes) do
      if settings.legendary_rune_settings[rune.id] == nil then
         settings.legendary_rune_settings[rune.id] = false
      end
   end
end

local function initialize_elixir_settings()
   for _, elixir in ipairs(ElixirData.basic_elixirs) do
      if settings.basic_elixir_settings[elixir.name] == nil then
         settings.basic_elixir_settings[elixir.name] = false
      end
   end
   for _, elixir in ipairs(ElixirData.advanced_elixirs) do
      if settings.advanced_elixir_settings[elixir.name] == nil then
         settings.advanced_elixir_settings[elixir.name] = false
      end
   end
   for _, elixir in ipairs(ElixirData.rare_elixirs) do
      if settings.rare_elixir_settings[elixir.name] == nil then
         settings.rare_elixir_settings[elixir.name] = false
      end
   end
   for _, elixir in ipairs(ElixirData.seasonal_elixirs) do
      if settings.seasonal_elixir_settings[elixir.name] == nil then
         settings.seasonal_elixir_settings[elixir.name] = false
      end
   end
end

local function initialize_scroll_settings()
   for _, scroll in ipairs(ScrollData.scrolls) do
      if settings.scroll_item_settings[scroll.id] == nil then
         settings.scroll_item_settings[scroll.id] = false
      end
   end
end

local function initialize_quest_settings()
   for _, quest_item in ipairs(QuestData.quest_items) do
      if settings.quest_item_settings[quest_item.id] == nil then
         settings.quest_item_settings[quest_item.id] = false
      end
   end
end

local function initialize_sigil_compass_settings()
   for _, item in ipairs(SigilCompassData.sigil_compass_items) do
      if settings.sigil_compass_item_settings[item.id] == nil then
         settings.sigil_compass_item_settings[item.id] = false
      end
   end
end

local function initialize_boss_settings()
   for _, boss_item in ipairs(BossData.boss_items) do
      if settings.boss_item_settings[boss_item.id] == nil then
         settings.boss_item_settings[boss_item.id] = false
      end
   end
end

local function initialize_crafting_settings()
   for _, crafting_item in ipairs(CraftingData.crafting_items) do
      if settings.crafting_item_settings[crafting_item.id] == nil then
         settings.crafting_item_settings[crafting_item.id] = false
      end
   end
end

local function initialize_jewel_settings()
   for _, jewel in ipairs(JewelData.jewels) do
       if settings.jewel_settings[jewel.id] == nil then
           settings.jewel_settings[jewel.id] = false
       end
   end
end

-- Update functions (FIXED: Define before use)
local function update_rune_settings()
   if not gui or not gui.elements or not gui.elements.rune_settings then
      return
   end

   initialize_rune_settings()

   for _, rune in ipairs(RuneData.magic_runes) do
      if gui.elements.rune_settings.magic_runes and gui.elements.rune_settings.magic_runes[rune.id] then
         settings.magic_rune_settings[rune.id] = gui.elements.rune_settings.magic_runes[rune.id]:get()
      end
   end
   
   for _, rune in ipairs(RuneData.rare_runes) do
      if gui.elements.rune_settings.rare_runes and gui.elements.rune_settings.rare_runes[rune.id] then
         settings.rare_rune_settings[rune.id] = gui.elements.rune_settings.rare_runes[rune.id]:get()
      end
   end
   
   for _, rune in ipairs(RuneData.legendary_runes) do
      if gui.elements.rune_settings.legendary_runes and gui.elements.rune_settings.legendary_runes[rune.id] then
         settings.legendary_rune_settings[rune.id] = gui.elements.rune_settings.legendary_runes[rune.id]:get()
      end
   end
end

local function update_elixir_settings()
   if not gui or not gui.elements or not gui.elements.elixir_settings then
      return
   end

   initialize_elixir_settings()

   for _, elixir in ipairs(ElixirData.basic_elixirs) do
      if gui.elements.elixir_settings.basic_elixirs and gui.elements.elixir_settings.basic_elixirs[elixir.name] then
         settings.basic_elixir_settings[elixir.name] = gui.elements.elixir_settings.basic_elixirs[elixir.name]:get()
      end
   end
   
   for _, elixir in ipairs(ElixirData.advanced_elixirs) do
      if gui.elements.elixir_settings.advanced_elixirs and gui.elements.elixir_settings.advanced_elixirs[elixir.name] then
         settings.advanced_elixir_settings[elixir.name] = gui.elements.elixir_settings.advanced_elixirs[elixir.name]:get()
      end
   end
   
   for _, elixir in ipairs(ElixirData.rare_elixirs) do
      if gui.elements.elixir_settings.rare_elixirs and gui.elements.elixir_settings.rare_elixirs[elixir.name] then
         settings.rare_elixir_settings[elixir.name] = gui.elements.elixir_settings.rare_elixirs[elixir.name]:get()
      end
   end
   
   for _, elixir in ipairs(ElixirData.seasonal_elixirs) do
      if gui.elements.elixir_settings.seasonal_elixirs and gui.elements.elixir_settings.seasonal_elixirs[elixir.name] then
         settings.seasonal_elixir_settings[elixir.name] = gui.elements.elixir_settings.seasonal_elixirs[elixir.name]:get()
      end
   end
end

local function update_scroll_settings()
   if not gui or not gui.elements or not gui.elements.scroll_settings then
      return
   end

   initialize_scroll_settings()

   for _, scroll in ipairs(ScrollData.scrolls) do
      if gui.elements.scroll_settings.scrolls and gui.elements.scroll_settings.scrolls[scroll.id] then
         settings.scroll_item_settings[scroll.id] = gui.elements.scroll_settings.scrolls[scroll.id]:get()
      end
   end
end

local function update_quest_settings()
   if not gui or not gui.elements or not gui.elements.quest_settings then
      return
   end

   initialize_quest_settings()

   for _, quest_item in ipairs(QuestData.quest_items) do
      if gui.elements.quest_settings.quest_items and gui.elements.quest_settings.quest_items[quest_item.id] then
         settings.quest_item_settings[quest_item.id] = gui.elements.quest_settings.quest_items[quest_item.id]:get()
      end
   end
end

local function update_sigil_compass_settings()
   if not gui or not gui.elements or not gui.elements.sigil_compass_settings then
      return
   end

   initialize_sigil_compass_settings()

   for _, item in ipairs(SigilCompassData.sigil_compass_items) do
      if gui.elements.sigil_compass_settings.sigil_compass_items and gui.elements.sigil_compass_settings.sigil_compass_items[item.id] then
         settings.sigil_compass_item_settings[item.id] = gui.elements.sigil_compass_settings.sigil_compass_items[item.id]:get()
      end
   end
end

local function update_boss_settings()
   if not gui or not gui.elements or not gui.elements.boss_settings then
      return
   end

   initialize_boss_settings()

   for _, boss_item in ipairs(BossData.boss_items) do
      if gui.elements.boss_settings.boss_items and gui.elements.boss_settings.boss_items[boss_item.id] then
         settings.boss_item_settings[boss_item.id] = gui.elements.boss_settings.boss_items[boss_item.id]:get()
      end
   end
end

local function update_crafting_settings()
   if not gui or not gui.elements or not gui.elements.crafting_settings then
      return
   end

   initialize_crafting_settings()

   for _, crafting_item in ipairs(CraftingData.crafting_items) do
      if gui.elements.crafting_settings.crafting_items and gui.elements.crafting_settings.crafting_items[crafting_item.id] then
         settings.crafting_item_settings[crafting_item.id] = gui.elements.crafting_settings.crafting_items[crafting_item.id]:get()
      end
   end
end

local function update_jewel_settings()
   if not gui or not gui.elements or not gui.elements.jewel_settings then
      return
   end

   initialize_jewel_settings()

   for _, jewel in ipairs(JewelData.jewels) do
      if gui.elements.jewel_settings.jewels and gui.elements.jewel_settings.jewels[jewel.id] then
         settings.jewel_settings[jewel.id] = gui.elements.jewel_settings.jewels[jewel.id]:get()
      end
   end
end

-- MAIN UPDATE FUNCTION - FIXED TO USE GLOBAL GUI
function Settings.update()
   -- Check if global GUI exists
   if not gui or not gui.elements then
      return
   end
   
   local gui_elements = gui.elements

   -- MAIN TOGGLE (most critical)
   if gui_elements.main_toggle then
      settings.enabled = gui_elements.main_toggle:get()
   else
      settings.enabled = false
   end
   
   -- General Settings - with safer access
   if gui_elements.general then
      settings.behavior = gui_elements.general.behavior_combo and gui_elements.general.behavior_combo:get() or 0
      settings.rarity = gui_elements.general.rarity_combo and gui_elements.general.rarity_combo:get() or 0
      settings.distance = gui_elements.general.distance_slider and gui_elements.general.distance_slider:get() or 2
      settings.skip_dropped = gui_elements.general.skip_dropped_toggle and gui_elements.general.skip_dropped_toggle:get() or false
      settings.loot_priority = gui_elements.general.loot_priority_combo and gui_elements.general.loot_priority_combo:get() or 0
   end
   
   -- Affix Settings
   if gui_elements.affix_settings then
      settings.ga_count = gui_elements.affix_settings.greater_affix_slider and gui_elements.affix_settings.greater_affix_slider:get() or 0
      settings.unique_ga_count = gui_elements.affix_settings.unique_greater_affix_slider and gui_elements.affix_settings.unique_greater_affix_slider:get() or 0
      settings.uber_unique_ga_count = gui_elements.affix_settings.uber_unique_greater_affix_slider and gui_elements.affix_settings.uber_unique_greater_affix_slider:get() or 4
   end
   
   -- Item Types - with safer access
   if gui_elements.item_types then
      settings.quest_items = gui_elements.item_types.quest_items_toggle and gui_elements.item_types.quest_items_toggle:get() or false
      settings.crafting_items = gui_elements.item_types.crafting_items_toggle and gui_elements.item_types.crafting_items_toggle:get() or false
      settings.boss_items = gui_elements.item_types.boss_items_toggle and gui_elements.item_types.boss_items_toggle:get() or false
      settings.elixir_items = gui_elements.item_types.elixir_items_toggle and gui_elements.item_types.elixir_items_toggle:get() or false
      settings.sigils = gui_elements.item_types.sigil_items_toggle and gui_elements.item_types.sigil_items_toggle:get() or false
      settings.compass = gui_elements.item_types.compass_items_toggle and gui_elements.item_types.compass_items_toggle:get() or false
      settings.rune = gui_elements.item_types.rune_items_toggle and gui_elements.item_types.rune_items_toggle:get() or false
      settings.cinders = gui_elements.item_types.cinders_toggle and gui_elements.item_types.cinders_toggle:get() or false
      settings.tribute = gui_elements.item_types.tribute_items_toggle and gui_elements.item_types.tribute_items_toggle:get() or false
      settings.scroll = gui_elements.item_types.scroll_items_toggle and gui_elements.item_types.scroll_items_toggle:get() or false
      settings.event_items = gui_elements.item_types.event_items_toggle and gui_elements.item_types.event_items_toggle:get() or false
      settings.jewel_items = gui_elements.item_types.jewel_items_toggle and gui_elements.item_types.jewel_items_toggle:get() or false

      -- NEW item types
      settings.scroll_items = gui_elements.item_types.scroll_items_toggle and gui_elements.item_types.scroll_items_toggle:get() or false
      settings.sigil_compass_items = gui_elements.item_types.sigil_compass_items_toggle and gui_elements.item_types.sigil_compass_items_toggle:get() or false
   end
   
   -- Debug
   if gui_elements.debug then
      settings.draw_wanted_items = gui_elements.debug.draw_wanted_toggle and gui_elements.debug.draw_wanted_toggle:get() or false
      if gui_elements.debug.show_debug_text_toggle then
         settings.show_debug_text = gui_elements.debug.show_debug_text_toggle:get()
      else
         settings.show_debug_text = true
      end
   end
   
   -- Update individual item settings with safer access
   if gui_elements.rune_settings then
      update_rune_settings()
   end
   if gui_elements.elixir_settings then
      update_elixir_settings()
   end
   if gui_elements.scroll_settings then
      update_scroll_settings()
   end
   if gui_elements.quest_settings then
      update_quest_settings()
   end
   if gui_elements.sigil_compass_settings then
      update_sigil_compass_settings()
   end
   if gui_elements.boss_settings then
      update_boss_settings()
   end
   if gui_elements.crafting_settings then
      update_crafting_settings()
   end
   if gui_elements.jewel_settings then
      update_jewel_settings()
   end
end

function Settings.get()
   return settings
end

function Settings.should_execute()
   return settings.behavior == 0 or
       (settings.behavior == 1 and orbwalker.get_orb_mode() == orb_mode.clear)
end

-- EXISTING RUNE FUNCTIONS
function Settings.is_rune_enabled(rune_id)
   local settings_table = Settings.get()
   
   if not settings_table.rune then
      return false
   end
   
   local quality = RuneData.get_rune_quality(rune_id)
   
   if quality == 1 then
      return settings_table.magic_rune_settings[rune_id] or false
   elseif quality == 3 then
      return settings_table.rare_rune_settings[rune_id] or false
   elseif quality == 5 then
      return settings_table.legendary_rune_settings[rune_id] or false
   end
   
   return false
end

-- EXISTING ELIXIR FUNCTIONS
function Settings.is_elixir_enabled(elixir_name)
   local settings_table = Settings.get()
   
   if not settings_table.elixir_items then
      return false
   end
   
   -- Check in each category
   if settings_table.basic_elixir_settings[elixir_name] then
      return true
   elseif settings_table.advanced_elixir_settings[elixir_name] then
      return true
   elseif settings_table.rare_elixir_settings[elixir_name] then
      return true
   elseif settings_table.seasonal_elixir_settings[elixir_name] then
      return true
   end
   
   return false
end

function Settings.is_elixir_enabled_by_id(id)
   local elixir_name = ElixirData.get_elixir_name(id)
   if elixir_name then
      return Settings.is_elixir_enabled(elixir_name)
   end
   return false
end

-- NEW ITEM TYPE FUNCTIONS
function Settings.is_scroll_enabled_by_id(id)
   local settings_table = Settings.get()
   
   if not settings_table.scroll_items then
      return false
   end
   
   return settings_table.scroll_item_settings[id] or false
end

function Settings.is_quest_enabled_by_id(id)
   local settings_table = Settings.get()
   
   if not settings_table.quest_items then
      return false
   end
   
   return settings_table.quest_item_settings[id] or false
end

function Settings.is_sigil_compass_enabled_by_id(id)
   local settings_table = Settings.get()
   
   if not settings_table.sigil_compass_items then
      return false
   end
   
   return settings_table.sigil_compass_item_settings[id] or false
end

function Settings.is_boss_enabled_by_id(id)
   local settings_table = Settings.get()
   
   if not settings_table.boss_items then
      return false
   end
   
   return settings_table.boss_item_settings[id] or false
end

function Settings.is_crafting_enabled_by_id(id)
   local settings_table = Settings.get()
   
   if not settings_table.crafting_items then
      return false
   end
   
   return settings_table.crafting_item_settings[id] or false
end

function Settings.is_jewel_enabled_by_id(id)
   local settings_table = Settings.get()
   
   if not settings_table.jewel_items then
      return false
   end
   
   return settings_table.jewel_settings[id] or false
end

return Settings
