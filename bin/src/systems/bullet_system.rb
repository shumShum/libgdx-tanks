require 'components/fire'

class BulletSystem < System

  def process_one_game_tick(delta, entity_mgr)
    shut_and_reload_bullets(delta, entity_mgr)
    cleanup_bullets(delta, entity_mgr)
  end

  def shut_and_reload_bullets(delta, entity_mgr)
    fire_entities = entity_mgr.get_all_entities_with_component_of_type(Fire)
    fire_entities.each do |entity|
      fire_component = entity_mgr.get_component_of_type(entity, Fire)

      if fire_component.pli
        spatial_component = entity_mgr.get_component_of_type(entity, SpatialState)
        engine_component = entity_mgr.get_component_of_type(entity, Engine)

        starting_x = spatial_component.x
        starting_y = spatial_component.y
        rotation = engine_component.rotation + 180
        bullet = entity_mgr.create_tagged_entity('bullet')
        entity_mgr.add_component bullet, SpatialState.new(starting_x, starting_y)
        entity_mgr.add_component bullet, Renderable.new(RELATIVE_ROOT + "res/images/bullet.png", 1.0, 0)
        entity_mgr.add_component bullet, Motion.new
        entity_mgr.add_component bullet, Engine.new(0.15, true, rotation)

        s = Gdx.audio.newSound(Gdx.files.internal(RELATIVE_ROOT + 'res/sounds/fire.wav'))
        s.play

        fire_component.pli = false
      end

      if fire_component.bullet_reload > 0
        fire_component.bullet_reload -= 1
      end

    end
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

  def self.bullet_exist?(entity_mgr)
    bullets = entity_mgr.get_all_entities_with_tag('bullet')
    bullets.nil? || bullets.empty?
  end

end