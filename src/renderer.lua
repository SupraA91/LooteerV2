local Settings = require("src.settings")
local ItemManager = require("src.item_manager")
local Utils = require("utils.utils")

local Renderer = {}

function Renderer.draw_stuff()
    if not get_local_player() then return end

    local ppos = get_player_position()
    local settings = Settings.get()
    
    -- Handle "Draw Wanted Items" visual circles (independent of debug text)
    if settings.enabled and settings.draw_wanted_items then
        local items = actors_manager:get_all_items()
        local item_count = 0
        local wanted_count = 0
        
        for _, item in pairs(items) do
            item_count = item_count + 1
            if ItemManager.check_want_item(item, true) then
                wanted_count = wanted_count + 1
                graphics.circle_3d(item:get_position(), 0.5, color_pink(255), 3)
            end
        end
        
        -- Only show stats text if debug text is also enabled
        if settings.show_debug_text then
            local stats_text = "Items: " .. item_count .. " | Wanted: " .. wanted_count
            local stats_pos = vec3:new(ppos:x(), ppos:y(), ppos:z() + 5.0)
            graphics.text_3d(stats_text, stats_pos, 14, color_yellow(255))
        end
    end
    
    -- Only show ANY text if debug text is enabled
    if not settings.show_debug_text then
        return -- Exit early - show absolutely no text
    end
    
    -- Show main looter status
    local status_text = "LOOTER: " .. (settings.enabled and "ENABLED" or "DISABLED")
    local status_color = settings.enabled and color_green(255) or color_red(255)
    graphics.text_3d(status_text, ppos, 16, status_color)
    
    -- Enhanced GUI debug with better error checking
    local gui_toggle_state = "NOT_AVAILABLE"
    local gui_status = "GUI: MISSING"
    
    if gui then
        gui_status = "GUI: EXISTS"
        if gui.elements then
            gui_status = "GUI: ELEMENTS_EXIST"
            if gui.elements.main_toggle then
                gui_status = "GUI: MAIN_TOGGLE_EXISTS"
                gui_toggle_state = gui.elements.main_toggle:get() and "ON" or "OFF"
            else
                gui_status = "GUI: NO_MAIN_TOGGLE"
            end
        else
            gui_status = "GUI: NO_ELEMENTS"
        end
    end
    
    local gui_text = "Toggle: " .. gui_toggle_state
    local debug_text = gui_status
    
    local gui_pos = vec3:new(ppos:x(), ppos:y(), ppos:z() - 0.5)
    graphics.text_3d(gui_text, gui_pos, 12, color_cyan(255))
    local debug_pos = vec3:new(ppos:x(), ppos:y(), ppos:z() - 1.0)
    graphics.text_3d(debug_text, debug_pos, 10, color_yellow(255))
    
    -- Show additional debug info when enabled
    if settings.enabled then
        local px, py, pz = ppos:x(), ppos:y(), ppos:z()
        
        -- Show rune setting
        local rune_text = "Runes: " .. (settings.rune and "ON" or "OFF")
        local rune_pos = vec3:new(px, py, pz + 0.5)
        graphics.text_3d(rune_text, rune_pos, 12, settings.rune and color_green(255) or color_red(255))
        
        -- Show elixir setting  
        local elixir_text = "Elixirs: " .. (settings.elixir_items and "ON" or "OFF")
        local elixir_pos = vec3:new(px, py, pz + 1.0)
        graphics.text_3d(elixir_text, elixir_pos, 12, settings.elixir_items and color_green(255) or color_red(255))
        
        -- Show tribute setting
        local tribute_text = "Tribute: " .. (settings.tribute and "ON" or "OFF") 
        local tribute_pos = vec3:new(px, py, pz + 1.5)
        graphics.text_3d(tribute_text, tribute_pos, 12, settings.tribute and color_green(255) or color_red(255))
        
        -- Show distance setting
        local dist_text = "Distance: " .. tostring(settings.distance)
        local dist_pos = vec3:new(px, py, pz + 2.0)
        graphics.text_3d(dist_text, dist_pos, 12, color_white(255))
        
        -- Show behavior setting
        local behavior_text = "Behavior: " .. tostring(settings.behavior)
        local behavior_pos = vec3:new(px, py, pz + 2.5)
        graphics.text_3d(behavior_text, behavior_pos, 12, color_white(255))
        
        -- Inventory status messages
        if Utils.is_inventory_full() then
            local inv_pos = vec3:new(px, py, pz + 3.0)
            graphics.text_3d("Inventory Full", inv_pos, 20, color_red(255))
        end

        if Utils.is_consumable_inventory_full() then
            local cons_pos = vec3:new(px, py, pz + 3.5)
            graphics.text_3d("Consumable Inventory Full", cons_pos, 20, color_red(255))
        end

        if Utils.is_socketable_inventory_full() then
            local sock_pos = vec3:new(px, py, pz + 4.0)
            graphics.text_3d("Socketable Inventory Full", sock_pos, 20, color_red(255))
        end

        if Utils.is_sigil_inventory_full() then
            local sigil_pos = vec3:new(px, py, pz + 4.5)
            graphics.text_3d("Sigil Inventory Full", sigil_pos, 20, color_red(255))
        end
    end
end

return Renderer
