class CameraSystem < System

  def process_one_game_tick(delta, entity_mgr)
    player_tank = entity_mgr.get_all_entities_with_tag('p1_tank').first
    camera = entity_mgr.get_all_entities_with_tag('camera').first

    spatial_component = entity_mgr.get_component_of_type(player_tank, SpatialState)
    camera_component = entity_mgr.get_component_of_type(camera, Camera)

    x, y = spatial_component.x, spatial_component.y
    camera_component.set_camera(x, y, 0)
  end

end
