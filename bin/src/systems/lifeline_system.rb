class LifelineSystem < System

  def process_one_game_tick(delta, entity_mgr)
    hp_entities = entity_mgr.get_all_entities_with_component_of_type(HealPoints)
    hp_entities.each do |entity|
      hp_component = entity_mgr.get_component_of_type(entity, HealPoints)

      if hp_component.hp < 0
        entity_mgr.kill_entity(entity)
      end 
    end
  end
end
