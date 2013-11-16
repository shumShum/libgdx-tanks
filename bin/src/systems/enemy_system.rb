class EnemySystem < System

  ENEMY_COUNT = 3

  def process_one_game_tick(delta, entity_mgr, camera)
    enemy_entities = entity_mgr.get_all_entities_with_tag('enemy') || []
    if enemy_entities.size < ENEMY_COUNT
      create_enemy(entity_mgr, camera)
    end

    enemy_shuts(entity_mgr, enemy_entities)
    # скорее всего, это должно быть не здесь
    enemy_search_player(entity_mgr, enemy_entities)
  end

  def create_enemy(entity_mgr, camera)
    enemy = entity_mgr.create_tagged_entity('enemy')
    cam_x, cam_y = camera.position.x, camera.position.y

    horizon = rand(4)
    case horizon
    when 0
      x = cam_x + (rand(10) - 5) * 64 
      y = cam_y + 240 + 40 
    when 1
      x = cam_x + 320 + 40
      y = cam_y + (rand(10) - 5) * 48 
    when 2
      x = cam_x + (rand(10) - 5) * 64 
      y = cam_y - 240 - 40
    when 3
      x = cam_x - 320 - 40
      y = cam_y + (rand(10) -5 ) * 48
    end

    fire_reload_time = rand(4)*10  + 100

    entity_mgr.add_components enemy, [
      SpatialState.new(x, y),
      Engine.new(0.015, true, 0, false),
      Motion.new,
      Renderable.new(:enemy_tank),
      PolygonCollidable.new,
      Fire.new(fire_reload_time, 1, 200),
      HealPoints.new,
      Sound.new([:damage])
    ]
  end

  def enemy_shuts(entity_mgr, enemy_entities)
    enemy_entities.each do |enemy|
      fire_component = entity_mgr.get_component_of_type(enemy, Fire)
      fire_component.fire!
    end
  end

  def enemy_search_player(entity_mgr, enemy_entities)
    player_tank = entity_mgr.get_all_entities_with_tag('p1_tank')[0]
    p1_spatial_component = entity_mgr.get_component_of_type(player_tank, SpatialState)
    p1_x = p1_spatial_component.x
    p1_y = p1_spatial_component.y

    enemy_entities.each do |enemy|
      engine_component = entity_mgr.get_component_of_type(enemy, Engine)
      renderable_component = entity_mgr.get_component_of_type(enemy, Renderable)
      spatial_component = entity_mgr.get_component_of_type(enemy, SpatialState)

      dx = spatial_component.x - p1_x
      dy = p1_y - spatial_component.y
      rotation = Math.atan( dx / dy ) * (180.0/Math::PI)
      rotation += 180 if dy < 0

      engine_component.rotation = rotation
      renderable_component.rotation = rotation

      s = Math.sqrt(dx*dx + dy*dy)
      if s < 150
        engine_component.stop 
      else
        engine_component.move
      end
    end
  end

end
