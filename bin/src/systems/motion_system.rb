class MotionSystem < System

  def process_one_game_tick(delta, entity_mgr)
    moving_entities = entity_mgr.get_all_entities_with_component_of_type(Motion)
    moving_entities.each do |e|
      spatial_component = entity_mgr.get_component_of_type(e, SpatialState)

      amount = 0.1 * delta * spatial_component.dx
      spatial_component.x += amount

      amount = 0.1 * delta * spatial_component.dy
      spatial_component.y += amount

      spatial_component.dx = 0
      spatial_component.dy = 0 
    end
  end

end