local plugin_label = "Looter (Pirated Edition) "
local gui = {}
local options = require("data.gui_options")

gui.elements = {
   main_tree = tree_node:new(0),
   main_toggle = checkbox:new(false, get_hash(plugin_label .. "_main_toggle")),
   
   general = {
      tree = tree_node:new(1),
      behavior_combo = combo_box:new(0, get_hash(plugin_label .. "_behavior_combo")),
      loot_priority_combo = combo_box:new(0, get_hash(plugin_label .. "_loot_priority_combo")), 
      rarity_combo = combo_box:new(0, get_hash(plugin_label .. "_rarity_combo")),
      distance_slider = slider_int:new(1, 30, 2, get_hash(plugin_label .. "_distance_slider")),
      skip_dropped_toggle = checkbox:new(false, get_hash(plugin_label .. "_skipped_dropped_toggle")),
   },

   affix_settings = {
      tree = tree_node:new(1),
      greater_affix_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_greater_affix_slider")),
      unique_greater_affix_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_greater_affix_slider")),
      innerTree = tree_node:new(1),
      custom_toggle = checkbox:new(false, get_hash(plugin_label .. "_costum_toggle")),
      armorsTree = tree_node:new(1),
      jewerlyTree = tree_node:new(1),
      wepeonsTree = tree_node:new(1),
      oneHandedTree = tree_node:new(1),
      twoHandedTree = tree_node:new(1),
      --armors
         legendary_helm_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_helm_slider")),
         legendary_chest_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_chest_slider")),
         legendary_gloves_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_gloves_slider")),
         legendary_pants_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_pants_slider")),
         legendary_boots_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_boots_slider")),
      --jewerly
         legendary_amulet_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_amulet_slider")),
         unique_amulet_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_amulet_slider")),
         legendary_ring_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_ring_slider")),
         unique_ring_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_unique_ring_slider")),
      --wepeons
         --1h
         legendary_1h_mace_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_1h_mace_slider")),
         legendary_1h_sword_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_1h_sword_slider")),
         legendary_1h_axe_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_1h_axe_slider")),
         legendary_dagger_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_dagger_slider")),
         legendary_wand_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_wand_slider")),
         --2h
         legendary_2h_mace_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_2h_mace_slider")),
         legendary_2h_sword_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_2h_sword_slider")),
         legendary_2h_axe_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_2h_axe_slider")),
         legendary_2h_polearm_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_2h_polearm_slider")),
         legendary_staff_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_staff_slider")),
         legendary_bow_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_bow_slider")),
         legendary_crossbow_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_legendary_crossbow_slider")),
         
      --ubers
      uber_unique_greater_affix_slider = slider_int:new(0, 3, 0,get_hash(plugin_label .. "_uber_unique_greater_affix_slider")),
   },

   item_types = {
      tree = tree_node:new(1),
      event_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_event_items_toggle")),
      quest_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_quest_items_toggle")),
      crafting_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_crafting_items_toggle")),
      boss_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_boss_items_toggle")),
      rare_elixir_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_rare_elixir_items_toggle")),
      advanced_elixir_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_advanced_elixir_items_toggle")),
      sigil_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_sigil_items_toggle")),
      cinders_toggle = checkbox:new(false, get_hash(plugin_label .. "_cinders_toggle")),
   },

   debug = {
      tree = tree_node:new(1),
      draw_wanted_toggle = checkbox:new(false, get_hash(plugin_label .. "_draw_wanted_toggle")),
   },
}

function gui:render()
   if not gui.elements.main_tree:push("Looter (Pirated Edition)") then
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
         gui.elements.general.rarity_combo:render("Rarity", options.rarities,
         "Minimum Rarity for bot to consider picking up.")
         gui.elements.general.distance_slider:render("Distance", "Distance from the loot to execute pickup")
         gui.elements.general.skip_dropped_toggle:render("Skip Self Dropped",
         "Do you want the bot to not loot items that you dropped yourself?")
         gui.elements.general.loot_priority_combo:render("Loot Priority", {"Closest First", "Best First"},
         "Select the priority for looting items")
         gui.elements.general.tree:pop()
      end
      
      if gui.elements.affix_settings.tree:push("Affix Settings") then
         gui.elements.affix_settings.greater_affix_slider:render("Legendary GA Count",
         "Minimum GA's to consider picking up legendary")
         gui.elements.affix_settings.unique_greater_affix_slider:render("Unique GA Count",
         "Minimum GA's to consider picking up unique")
         gui.elements.affix_settings.uber_unique_greater_affix_slider:render("Uber GA Count",
         "Minimum GA's to consider picking up Uber unique")
         if gui.elements.affix_settings.innerTree:push("Advanced Settings") then
            gui.elements.affix_settings.custom_toggle:render("Force settings", "Force settings to override Legendary Ga Count")
            if gui.elements.affix_settings.armorsTree:push("Armors Settings") then
               gui.elements.affix_settings.legendary_helm_slider:render("Legendary Helm GA Count",
               "Minimum GA's to consider picking up legendary helms")
               gui.elements.affix_settings.legendary_chest_slider:render("Legendary Chest GA Count",
               "Minimum GA's to consider picking up legendary chests")
               gui.elements.affix_settings.legendary_gloves_slider:render("Legendary Gloves GA Count",
               "Minimum GA's to consider picking up legendary gloves")
               gui.elements.affix_settings.legendary_pants_slider:render("Legendary Pants GA Count",
               "Minimum GA's to consider picking up legendary Pants")
               gui.elements.affix_settings.legendary_boots_slider:render("Legendary Boots GA Count",
               "Minimum GA's to consider picking up legendary Boots")
            end
            if gui.elements.affix_settings.jewerlyTree:push("Jewerly Settings") then
               gui.elements.affix_settings.legendary_amulet_slider:render("Legendary Amulet GA Count",
               "Minimum GA's to consider picking up legendary amulets")
               gui.elements.affix_settings.unique_amulet_slider:render("Unique Amulet GA Count",
               "Minimum GA's to consider picking up unique amulets")
               gui.elements.affix_settings.legendary_ring_slider:render("Legendary Ring GA Count",
               "Minimum GA's to consider picking up legendary rings")
               gui.elements.affix_settings.unique_ring_slider:render("Unique Ring GA Count",
               "Minimum GA's to consider picking up unique rings")
            end
            if gui.elements.affix_settings.wepeonsTree:push("Wepeons Settings") then
               if gui.elements.affix_settings.oneHandedTree:push("1Handed") then

                     gui.elements.affix_settings.legendary_1h_mace_slider:render("Legendary 1H Mace GA Count",
                     "Minimum GA's to consider picking up legendary 1H maces")
                     gui.elements.affix_settings.legendary_1h_axe_slider:render("Legendary 1H Axe GA Count",
                     "Minimum GA's to consider picking up legendary 1H axes")
                     gui.elements.affix_settings.legendary_1h_sword_slider:render("Legendary 1H Sword GA Count",
                     "Minimum GA's to consider picking up legendary 1H swords")
                     gui.elements.affix_settings.legendary_dagger_slider:render("Legendary Dagger GA Count",
                     "Minimum GA's to consider picking up legendary Dagger")
                     gui.elements.affix_settings.legendary_wand_slider:render("Legendary wand GA Count",
                     "Minimum GA's to consider picking up legendary wand")
                  end
                  if gui.elements.affix_settings.twoHandedTree:push("2Handed") then
                     gui.elements.affix_settings.legendary_2h_mace_slider:render("Legendary 2H Mace GA Count",
                     "Minimum GA's to consider picking up legendary 2H maces")
                     gui.elements.affix_settings.legendary_2h_axe_slider:render("Legendary 2H Axe GA Count",
                     "Minimum GA's to consider picking up legendary 2H axes")
                     gui.elements.affix_settings.legendary_2h_sword_slider:render("Legendary 2H Sword GA Count",
                     "Minimum GA's to consider picking up legendary 2H swords")
                     gui.elements.affix_settings.legendary_2h_polearm_slider:render("Legendary 2H Polearm GA Count",
                     "Minimum GA's to consider picking up legendary 2H polearms")
                     gui.elements.affix_settings.legendary_staff_slider:render("Legendary Staff GA Count",
                     "Minimum GA's to consider picking up legendary staffs")
                     gui.elements.affix_settings.legendary_bow_slider:render("Legendary Bow GA Count",
                     "Minimum GA's to consider picking up legendary bows")
                     gui.elements.affix_settings.legendary_crossbow_slider:render("Legendary Crossbow GA Count",
                     "Minimum GA's to consider picking up legendary crossbows")
               
               end
            end
         end
      gui.elements.affix_settings.tree:pop()
   end

   if gui.elements.item_types.tree:push("Item Types") then
      gui.elements.item_types.quest_items_toggle:render("Quest Items",
         "Do you want to pickup Quest items, this includes Objectives in dungeons.")
      gui.elements.item_types.crafting_items_toggle:render("Crafting Items", "Do you want to pickup Crafting Items?")
      gui.elements.item_types.boss_items_toggle:render("Boss Items", "Do you want to pickup Boss summon items?")
      gui.elements.item_types.rare_elixir_items_toggle:render("Rare Elixirs",
         "Do you wanna pickup Rare Elixirs? (Momentum, Holy Bolts)")
      gui.elements.item_types.advanced_elixir_items_toggle:render("Advanced Elixirs",
         "Do you wanna pickup Advanced Elixirs II?")
      gui.elements.item_types.sigil_items_toggle:render("Sigils", "Do you want to loot dungeon sigils?")
      gui.elements.item_types.event_items_toggle:render("Event", "Do you want to pickup Treasure Bags?")     
      gui.elements.item_types.cinders_toggle:render("Cinders", "Do you want to pickup Cinders?")
      gui.elements.item_types.tree:pop()
   end

   if gui.elements.debug.tree:push("Debug") then
      gui.elements.debug.draw_wanted_toggle:render("Draw Wanted",
         "Do you want to draw the items that the bot considers picking up? (Debug)")
      gui.elements.debug.tree:pop()
   end

   gui.elements.main_tree:pop()
end

return gui