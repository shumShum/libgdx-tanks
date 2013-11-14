java_import com.badlogic.gdx.math.Polygon
java_import com.badlogic.gdx.math.Intersector

class CollisionSystem < System

  def process_one_game_tick(delta, entity_mgr)
    collidable_entities=[]

    polygon_entities = entity_mgr.get_all_entities_with_component_of_type(PolygonCollidable)
    update_bounding_polygons(entity_mgr, polygon_entities)
    collidable_entities += polygon_entities

    bounding_areas={}
    collidable_entities.each do |e| 
      bounding_areas[e]=entity_mgr.get_component_of_type(e, PolygonCollidable).bounding_polygon
    end

    intersections = []
    bounding_areas.each_key do |entity1|
      bounding_areas.each_key do |entity2|
        next if entity1 == entity2

        if Intersector.overlapConvexPolygons(bounding_areas[entity1], bounding_areas[entity2]) 
          intersections << [entity1, entity2]
        end
      end
    end

    resolved_intersections(entity_mgr, intersections)
  end

  def update_bounding_polygons(entity_mgr, entities)
    entities.each do |e|
      spatial_component    = entity_mgr.get_component_of_type(e, SpatialState)
      renderable_component = entity_mgr.get_component_of_type(e, Renderable)
      collidable_component = entity_mgr.get_component_of_type(e, PolygonCollidable)

      collidable_component.bounding_polygon = 
                   make_polygon(spatial_component.x, 
                                renderable_component.width,
                                spatial_component.y, 
                                renderable_component.height, 
                                renderable_component.rotation, 
                                renderable_component.scale)
    end
  end

  def make_polygon(position_x, width, position_y, height, rotation, scale)
    polygon = Polygon.new(
      [0, 0, 
      width, 0,  
      width, height,
      0, height])

    polygon.setPosition(position_x, position_y)
    polygon.setRotation(rotation)

    return polygon
  end

  def resolved_intersections(entity_mgr, intersections)
    intersections.each do |entity1, entity2|
      entity1_type = entity_mgr.get_tag(entity1)
      entity2_type = entity_mgr.get_tag(entity2)

      # хуйня какая-то, переписать
      if (entity1_type == 'bullet' || entity2_type == 'bullet') &&
          (entity1_type != entity2_type)
        if entity1_type == 'bullet'
          bullet_found_target(entity1, entity2, entity_mgr)
        else
          bullet_found_target(entity2, entity1, entity_mgr)
        end
      end

    end
  end

  def bullet_found_target(bullet, target, entity_mgr)
    if entity_mgr.has_component_of_type(target, HealPoints)
      parent_component = entity_mgr.get_component_of_type(bullet, Parent)
      target_type = entity_mgr.get_tag(target)

      if parent_component.parent_type != target_type
        damage_component = entity_mgr.get_component_of_type(bullet, Damage)
        hp_component = entity_mgr.get_component_of_type(target, HealPoints)
        hp_component.damaged(damage_component.damage)
        entity_mgr.kill_entity(bullet)
      end
    end
  end

end
