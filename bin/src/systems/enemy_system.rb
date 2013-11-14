class EnemySystem < System

  ENEMY_COUNT = 3

  def process_one_game_tick(delta, entity_mgr)
    enemy_entities = entity_mgr.get_all_entities_with_tag('enemy') || []
    if enemy_entities.size < ENEMY_COUNT
      create_enemy(entity_mgr)
    end

    enemy_shuts(entity_mgr, enemy_entities)
    # скорее всего, это должно быть не здесь
    enemy_search_player(entity_mgr, enemy_entities)
  end

  def create_enemy(entity_mgr)
    enemy = entity_mgr.create_tagged_entity('enemy')

    horizon = rand(4)
    case horizon
    when 0
      x = rand(10) * 64 
      y = 520
    when 1
      x = 680
      y = rand(10) * 48 
    when 2
      x = rand(10) * 64 
      y = -40
    when 3
      x = -40
      y = rand(10) * 48
    end

    fire_reload_time = rand(4)*10  + 100

    entity_mgr.add_components enemy, [
      SpatialState.new(x, y),
      Engine.new(0.015, true, 0, false),
      Motion.new,
      Renderable.new(RELATIVE_ROOT + "res/images/enemy_tank.png"),
      PolygonCollidable.new,
      Fire.new(fire_reload_time, 1),
      HealPoints.new
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
