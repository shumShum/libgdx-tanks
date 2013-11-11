class BulletSystem < System

  def process_one_game_tick(delta, entity_mgr)
    cleanup_bullets(delta, entity_mgr)
  end

  def cleanup_bullets(delta, entity_mgr)
    bullet_entities = entity_mgr.get_all_entities_with_tag('bullet') || []

    bullet_entities.each do |b|
      spatial_component = entity_mgr.get_component_of_type(b, SpatialState)
      if spatial_component.screen_over? 
        entity_mgr.kill_entity(b)
      end
    end

  end

end