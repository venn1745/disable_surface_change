local TEST_SURFACE_NAME = "EE_TESTSURFACE_player"

local function is_in_map_editor(player)
  return player and player.valid and player.controller_type == defines.controllers.editor
end

script.on_event(defines.events.on_tick, function(event)
  if event.tick % 60 ~= 0 then return end

  local test_surface = game.surfaces[TEST_SURFACE_NAME]
  if not test_surface then return end
  
  for _, player in pairs(game.connected_players) do
    if is_in_map_editor(player) and player.surface.name ~= TEST_SURFACE_NAME then
      player.teleport({0, 0}, TEST_SURFACE_NAME)
      player.print("Not allowed to switch surfaces in editor mode.")
    end
  end
end)
