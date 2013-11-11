class EngineSystem < System

  def process_one_game_tick(delta, entity_mgr)
    engine_entities = entity_mgr.get_all_entities_with_component_of_type(Engine)
    engine_entities.each do |entity|
      engine_component = entity_mgr.get_component_of_type(entity, Engine)

      if engine_component.on
        location_component = entity_mgr.get_component_of_type(entity, SpatialState)

        amount = engine_component.speed * delta
        amount *= -1 unless engine_component.forward 
        current_rotation = engine_component.rotation

        x_vector = amount * -Math.sin(current_rotation * Math::PI / 180.0)
        y_vector = amount * Math.cos(current_rotation * Math::PI / 180.0)

        location_component.dy = y_vector
        location_component.dx = x_vector

        engine_component.on = !engine_component.control_move
      end
    end
  end
end
