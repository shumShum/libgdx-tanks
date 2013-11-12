class SoundSystem < System

  def process_one_game_tick(delta, entity_mgr, sound_storage)
    sound_entities = entity_mgr.get_all_entities_with_component_of_type(Sound)
    sound_entities.each do |entity|
      sound_component = entity_mgr.get_component_of_type(entity, Sound)
      sound_component.queue.each do |sound|
        s = sound_storage.get_by_name(sound)
        s.play
      end
      sound_component.queue = [] 
    end
  end
end

