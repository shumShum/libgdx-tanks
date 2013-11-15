class CameraSystem < System

  def process_one_game_tick(delta, entity_mgr, camera)
    player_tank = entity_mgr.get_all_entities_with_tag('p1_tank').first
    spatial_component = entity_mgr.get_component_of_type(player_tank, SpatialState)

    x, y = spatial_component.x, spatial_component.y
    camera.position.set(x, y, 0)
  end

end
