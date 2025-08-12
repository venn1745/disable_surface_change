local ORIGINAL_SURFACE_PREFIX = "EE_TESTSURFACE_"
local RENAMED_SURFACE_NAME = "lonelylab"

local function rename_testing_lab_surface()
  for _, surface in pairs(game.surfaces) do
    if surface.name:find("^" .. ORIGINAL_SURFACE_PREFIX) then
      if not game.surfaces[RENAMED_SURFACE_NAME] then
        surface.name = RENAMED_SURFACE_NAME
      end
    end
  end
end

local function is_in_map_editor(player)
  return player and player.valid and player.controller_type == defines.controllers.editor
end

script.on_event(defines.events.on_tick, function(event)
  if event.tick % 60 ~= 0 then return end

  for _, player in pairs(game.connected_players) do
    if is_in_map_editor(player) and player.surface.name ~= RENAMED_SURFACE_NAME then
      player.teleport({0, 0}, RENAMED_SURFACE_NAME)
      player.print("You have been moved to the Testing Lab.")
    end
  end
end)

-- Rename surfaces on init/config change
script.on_init(rename_testing_lab_surface)
script.on_configuration_changed(function(_) rename_testing_lab_surface() end)
