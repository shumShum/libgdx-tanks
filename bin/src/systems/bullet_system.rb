class BulletSystem < System

  def process_one_game_tick(delta, entity_mgr, camera)
    shut_and_reload_bullets(entity_mgr)
    cleanup_bullets(entity_mgr, camera)
  end

  def shut_and_reload_bullets(entity_mgr)
    fire_entities = entity_mgr.get_all_entities_with_component_of_type(Fire)
    fire_entities.each do |entity|
      fire_component = entity_mgr.get_component_of_type(entity, Fire)

      if fire_component.pli
        spatial_component = entity_mgr.get_component_of_type(entity, SpatialState)
        engine_component = entity_mgr.get_component_of_type(entity, Engine)

        starting_x = spatial_component.x
        starting_y = spatial_component.y
        rotation = engine_component.rotation
        parent_type = entity_mgr.get_tag(entity)
        bullet = entity_mgr.create_tagged_entity('bullet')
        entity_mgr.add_components bullet, [
          SpatialState.new(starting_x, starting_y),
          Renderable.new(:bullet),
          PolygonCollidable.new,
          Motion.new,
          Engine.new(0.15, true, rotation),
          Sound.new([:fire]),
          Damage.new(fire_component.damage),
          Parent.new(parent_type)
        ]

        sound_component = entity_mgr.get_component_of_type(bullet, Sound)
        sound_component.put(:fire)

        fire_component.pli = false
      end

      if fire_component.bullet_reload > 0
        fire_component.bullet_reload -= 1
      end

    end
  end

  def cleanup_bullets(entity_mgr, camera)
    cam_x, cam_y = camera.position.x, camera.position.y
    bullet_entities = entity_mgr.get_all_entities_with_tag('bullet') || []

    bullet_entities.each do |b|
      spatial_component = entity_mgr.get_component_of_type(b, SpatialState)
      if spatial_component.screen_over?(cam_x, cam_y) 
        entity_mgr.kill_entity(b)
      end
    end
  end

end