class EnemySystem < System

  ENEMY_COUNT = 3

  def process_one_game_tick(delta, entity_mgr)
    enemy_entities = entity_mgr.get_all_entities_with_tag('enemy') || []
    if enemy_entities.size < ENEMY_COUNT
      create_enemy(delta, entity_mgr)
    end

    enemy_shuts(delta, entity_mgr, enemy_entities)
    #TODO temp! refactor needed!!
    enemy_search_player(delta, entity_mgr, enemy_entities)
  end

  def create_enemy(delta, entity_mgr)
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
      Engine.new(0.025, true, 0, false),
      Motion.new,
      Renderable.new(RELATIVE_ROOT + "res/images/enemy_tank.png"),
      Fire.new(fire_reload_time)
    ]
  end

  def enemy_shuts(delta, entity_mgr, enemy_entities)
    enemy_entities.each do |enemy|
      fire_component = entity_mgr.get_component_of_type(enemy, Fire)
      fire_component.fire!
    end
  end

  def enemy_search_player(delta, entity_mgr, enemy_entities)
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
        if dy < 0
          rotation += 180
        end

        engine_component.rotation = rotation
        renderable_component.rotation = rotation
    end
  end

end
